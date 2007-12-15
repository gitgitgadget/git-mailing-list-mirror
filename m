From: Jeff King <peff@peff.net>
Subject: trim_common_tail bug?
Date: Sat, 15 Dec 2007 06:16:22 -0500
Message-ID: <20071215111621.GA8139@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 12:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3V0h-00083s-VK
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 12:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbXLOLQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 06:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbXLOLQZ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 06:16:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3873 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831AbXLOLQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 06:16:24 -0500
Received: (qmail 12074 invoked by uid 111); 15 Dec 2007 11:16:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 15 Dec 2007 06:16:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2007 06:16:22 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68385>

Something seems to be not quite right with the trim_common_tail code in
xdiff-interface.c. The diff I just sent for contrib/completion looks
fine (as I sent it) when I comment out trim_common_tail. But using
the current master, it looks like this:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 58e0e53..2fd32db 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -291,7 +291,7 @@ __git_commands ()
 	for i in $(git help -a|egrep '^ ')
 	do
 		case $i in
-		add--interactive) : plumbing;;
+		*--*)             : plumbing pattern;;
 		applymbox)        : ask gittus;;
 		applypatch)       : ask gittus;;
 		archimport)       : import;;
@@ -307,5 +307,4 @@ __git_commands ()
 		diff-index)       : plumbing;;
 		diff-tree)        : plumbing;;
 		fast-import)      : import;;
-		fsck-objects)     : plumbing;;
-		fetch--tool)      : plumbing;;
\ No newline at end of file
+		fsck-objects)     : plumbing;;
\ No newline at end of file

-Peff
