From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] stash: accept options also when subcommand 'save' is omitted
Date: Tue, 18 Aug 2009 23:38:42 +0200
Message-ID: <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 18 23:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWPK-0002NI-LW
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbZHRVjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbZHRVjp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:39:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37562 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbZHRVjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:39:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7ILatwV021026
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 23:36:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdWP5-0005Ll-Kb; Tue, 18 Aug 2009 23:39:39 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdWP5-0002mJ-JM; Tue, 18 Aug 2009 23:39:39 +0200
X-Mailer: git-send-email 1.6.4.rc2.31.g2d7d7
In-Reply-To: <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Aug 2009 23:36:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7ILatwV021026
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251236215.71167@7G2SxrKFwKl1oi3Fs2FcfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126463>

This allows in particular 'git stash -k which is shorter than
'git stash save -k', and not ambiguous.

Testcase taken from Johannes Schindelin <johannes.schindelin@gmx.de>.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-stash.txt |    2 +-
 git-stash.sh                |    8 +++++++-
 t/t3903-stash.sh            |    8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1b5392a..7e515ce 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--patch] [--[no-]keep-index|-k] [-q|--quiet] [<message>]]
+'git stash' [save] [--patch] [--[no-]keep-index|-k] [-q|--quiet] [<message>]
 'git stash' clear
 'git stash' create
 
diff --git a/git-stash.sh b/git-stash.sh
index 856a2d5..bb36bc7 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [-k|--keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save] [-k|--keep-index] [-q|--quiet] [<message>]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -354,6 +354,12 @@ apply_to_branch () {
 	drop_stash $stash
 }
 
+case "$1" in
+    -*)
+	set "save" "$@"
+	;;
+esac
+
 # Main command set
 case "$1" in
 list)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7a3fb67..0e831e0 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -200,4 +200,12 @@ test_expect_success 'drop -q is quiet' '
 	test ! -s output.out
 '
 
+test_expect_success 'stash -k' '
+       echo bar3 > file &&
+       echo bar4 > file2 &&
+       git add file2 &&
+       git stash -k &&
+       test bar,bar4 = $(cat file),$(cat file2)
+'
+
 test_done
-- 
1.6.4.rc2.31.g2d7d7
