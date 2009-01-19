From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] contrib/difftool: change trap condition from SIGINT to INT
Date: Tue, 20 Jan 2009 00:38:16 +0100
Message-ID: <200901200038.17548.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3ic-0004sb-SY
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbZASXiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZASXiT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:38:19 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:53750 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbZASXiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:38:18 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8CE18F6C39DB;
	Tue, 20 Jan 2009 00:38:17 +0100 (CET)
Received: from [89.59.93.106] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LP3hB-0004qS-00; Tue, 20 Jan 2009 00:38:17 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18hT4nbuopD2CxdXs+wJr68/JMQutbirHjYtfjb
	aiICLRzZJlI263dYnFswR9b39jYOJINslKXtc9g3zrvKB6agPg
	K4xFJpUPfuJIFxmsYlYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106405>

git-difftool worked for me on an up-to-date Gentoo Linux at home, but
didn't work on a somewhat older Ubuntu Linux 7.10 at work and failed
with the following error, where 'Makefile' was locally modified:

    trap: 244: SIGINT: bad trap
    external diff died, stopping at Makefile.

In 'man 1p trap' there is written:

    "The condition can be EXIT, 0 (equivalent to EXIT), or a signal
    specified using a symbolic name, without the SIG prefix, [...]"

    "Implementations may permit names with the SIG prefix or ignore case
    in signal names as an extension."

So now we do it the POSIX compliant way instead of using an extension.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/difftool/git-difftool-helper |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index f013726..a2eb59b 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -53,7 +53,7 @@ launch_merge_tool () {
 
 	# Create and ensure that we clean up $BACKUP
 	test -f "$MERGED" && cp -- "$MERGED" "$BACKUP"
-	trap sigint_handler SIGINT
+	trap sigint_handler INT
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
-- 
1.6.1.216.g3acd
