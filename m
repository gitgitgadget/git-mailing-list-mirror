From: Andreas Gruenbacher <agruen@suse.de>
Subject: Filename quoting / parsing problem
Date: Fri, 1 Jan 2010 18:44:23 +0100
Organization: SUSE Labs
Message-ID: <201001011844.23571.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 01 18:47:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQlaZ-00027H-61
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 18:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab0AARq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 12:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581Ab0AARq6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 12:46:58 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33558 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab0AARq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 12:46:58 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 53BAC89471
	for <git@vger.kernel.org>; Fri,  1 Jan 2010 18:46:57 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136008>

Git quotes file names as documented in the git-diff manual page:

  TAB, LF, double quote and backslash characters in pathnames are represented
  as \t, \n, \" and \\, respectively.  If there is need for such substitution
  then the whole pathname is put in double quotes.

Spaces in file names currently do not trigger quoting.  (And \r triggers 
quoting even though the man page doesn't say so).  When there are no "---" and 
"+++" lines, this can lead to a parsing problem: only the "diff --git" line 
contains the file names, sometimes with insufficient quoting.  The following 
examples show the problem:

Parseable:
    diff --git "a/foo \r" "b/foo \r"
    new file mode 100644
    index 0000000..257cc56
    --- /dev/null
    +++ "b/foo \r"
    @@ -0,0 +1 @@
   +foo

Parseable:
    diff --git a/bar  b/bar 
    new file mode 100644
    index 0000000..5716ca5
    --- /dev/null
    +++ b/bar 
    @@ -0,0 +1 @@
    +bar

Not parseable:
    diff --git a/baz  b/baz 
    new file mode 100644
    index 0000000..e69de29


Could this please be changed so that filenames with spaces are also quoted, at 
least in the "diff --git" line, and possibly also in the "---" and "+++" 
lines?  Alternatively, how about a new extended header with the file name in 
this particular case?

Thanks,
Andreas
