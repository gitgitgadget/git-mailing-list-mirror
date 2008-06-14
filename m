From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: Mercurial to git converter.
Date: Sat, 14 Jun 2008 10:23:37 +0000 (UTC)
Message-ID: <loom.20080614T101342-542@post.gmane.org>
References: <1168537766.22649.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 12:31:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7T2D-0007aP-L6
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 12:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYFNKaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 06:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbYFNKaH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 06:30:07 -0400
Received: from main.gmane.org ([80.91.229.2]:53497 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbYFNKaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 06:30:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K7T1H-0007nD-5c
	for git@vger.kernel.org; Sat, 14 Jun 2008 10:30:03 +0000
Received: from 124-171-245-169.dyn.iinet.net.au ([124.171.245.169])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 10:30:03 +0000
Received: from nick by 124-171-245-169.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 10:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 124.171.245.169 (Mozilla/5.0 (compatible; Konqueror/3.5; Linux) KHTML/3.5.9 (like Gecko) (Debian))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85010>

Stelian Pop <stelian <at> popies.net> writes:

> I switched recently from Mercurial to git for some of my projects, and
> needed a conversion tool with branch support (unlike tailor). I didn't
> find any, so I ended up writing my own one. 
> 
> hg-to-git.py can probably be greatly improved (it's a rather crude
> combination of shell and python) but it does already work quite well for
> me. [...]

Thanks for that. One small problem is that it does not get the changelog right 
if a commit is made on a local branch. It thinks the "branch:" line is part of 
the changelog.

Here's a patch to fix that:

diff -u -r1.1 hg-to-git.py
--- hg-to-git.py
+++ hg-to-git.py
@@ -151,7 +151,7 @@
         mparent = None

     (fdcomment, filecomment) = tempfile.mkstemp()
-    csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v 
^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v 
^description: | grep -v ^tag:' % cset).read().strip()
+    csetcomment = os.popen('hg log -r %d -v | egrep -v "^(changeset|parent|
user|date|files|description|tag|branch):" ' % cset).read().strip()
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)


Nick.
