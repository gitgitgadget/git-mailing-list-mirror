From: Aaron Harnly <git@lists.harnly.net>
Subject: Buggy (or undocumented) handling of terminal \r in .gitignore patterns
Date: Wed, 3 Dec 2008 15:46:31 +0000 (UTC)
Message-ID: <loom.20081203T152511-351@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 16:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7u0i-0001HP-57
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 16:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYLCPuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 10:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbYLCPuG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 10:50:06 -0500
Received: from main.gmane.org ([80.91.229.2]:51829 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbYLCPuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 10:50:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L7tzG-00028Q-Gl
	for git@vger.kernel.org; Wed, 03 Dec 2008 15:50:02 +0000
Received: from exchange.wgen.net ([38.117.159.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 15:50:02 +0000
Received: from git by exchange.wgen.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 15:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 38.117.159.162 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/2008111318 Ubuntu/8.10 (intrepid) Firefox/3.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102266>

This is with git 1.5.6.3 on Ubuntu and Mac OS X.

Overview: .gitignore patterns ending in \r do not work as expected, apparently
because the terminal \r is assumed to be part of the newline.

Steps to Reproduce:
(NB ^M is the control-M sequence, not a literal caret-M)

1. Create an empty repository.
2. Create a file named Icon\r (aka Icon^M).
3. Add the following pattern to the .gitignore:

Icon^M

Expected behavior:

The file is ignored.

Actual behavior:

The file is not ignored.

Discussion:

It appears that the parsing of .gitignore files tries to be graceful in allowing
the file to have CRLF endings, or indeed mixed LF / CRLF endings.

This is well and good, but poses a bit of a problem for ignoring files whose
name ends in \r. In particular, Mac OS X's icon files are named Icon\r. Yes,
this is sick and annoying on the part of Apple.

I understand the rationale for this behavior, but it probably should be
documented somewhere. In the meantime, a workaround that does allow the ignoring
of these files is the pattern:

Icon^M^M

where again, the terminal \r seems to be ignored as part of the newline, but the
penultimate \r gets picked up as part of the pattern.

Any thoughts on whether:
1. this behavior should be left as it is
2. there is actually documentation somewhere that I didn't see
3. terminal \r in an otherwise all-LF file should be assumed to be part of the
pattern
4. some other alternative?

cheers,
~aaron
