From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] stash: accept -k as a shortcut for --keep-index
Date: Tue, 18 Aug 2009 23:38:41 +0200
Message-ID: <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 18 23:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWPJ-0002NI-UL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZHRVjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZHRVjo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:39:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46717 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbZHRVjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:39:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7ILcE4h003577
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 23:38:14 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdWP4-0005Li-SX; Tue, 18 Aug 2009 23:39:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdWP4-0002mF-RI; Tue, 18 Aug 2009 23:39:38 +0200
X-Mailer: git-send-email 1.6.4.rc2.31.g2d7d7
In-Reply-To: <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Aug 2009 23:38:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7ILcE4h003577
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251236294.56522@h0NGj35Uhflc3ZWrenWfEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126462>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-stash.txt |    4 ++--
 git-stash.sh                |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4b15459..1b5392a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [--patch] [--[no-]keep-index|-k] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -42,7 +42,7 @@ is also possible).
 OPTIONS
 -------
 
-save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
+save [--patch] [--[no-]keep-index|-k] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  This is the default action when no
diff --git a/git-stash.sh b/git-stash.sh
index 567aa5d..856a2d5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save [-k|--keep-index] [-q|--quiet] [<message>]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -132,7 +132,7 @@ save_stash () {
 	while test $# != 0
 	do
 		case "$1" in
-		--keep-index)
+		-k|--keep-index)
 			keep_index=t
 			;;
 		--no-keep-index)
-- 
1.6.4.rc2.31.g2d7d7
