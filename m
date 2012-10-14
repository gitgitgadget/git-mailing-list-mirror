From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: add format-patch options to send-email
Date: Sun, 14 Oct 2012 18:14:03 +0200
Message-ID: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 18:14:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQpa-0005gl-LA
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 18:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab2JNQOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 12:14:12 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40182 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2JNQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 12:14:11 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2607396wey.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nJqh3PfdHbzh6oauKp4PKc03CJ9qdJyB+o2PWLlUQeo=;
        b=vb+hVOYIGAWbWzNkHvA88K7agAJR3GXajpK3hnMHzwVjUFePO7UxuC+pXjkC6I5Ymn
         maqjZ2aebZ5JmRDFLCduVHxUD9IIkRGMHF5JW10glv4v6Bo0/n6K/DyUDorVNkdpBi/H
         dCdpXzTT5nyUjdXnwozfdlLRfGEx9E5+n/DBJZhy0eEb85FFoFr3JNzeqduitBUuo01N
         j96LXVDrbx23unt2wxm49t9ZJwXHw6Ba/LnxyMb6nAbOPyMSGS0R9cinFEDi7zSYy98B
         wQV7A5f2w6bzWpUuKKARMhWy9e1qRoRBQ8f0OHu1osYw+Jx2EXtmO+WPrfs+zWxnUJzK
         Q5rA==
Received: by 10.180.91.71 with SMTP id cc7mr18099822wib.2.1350231250259;
        Sun, 14 Oct 2012 09:14:10 -0700 (PDT)
Received: from localhost (ip-109-43-0-56.web.vodafone.de. [109.43.0.56])
        by mx.google.com with ESMTPS id j8sm9330233wiy.9.2012.10.14.09.14.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 09:14:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207673>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 35 +++++++++++++++++-----------------
 t/t9902-completion.sh                  | 21 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d743e56..2a83504 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1112,6 +1112,14 @@ _git_fetch ()
 	__git_complete_remote_or_refspec
 }
 
+__git_format_patch_options="
+	--stdout --attach --no-attach --thread --thread= --output-directory
+	--numbered --start-number --numbered-files --keep-subject --signoff
+	--signature --no-signature --in-reply-to= --cc= --full-index --binary
+	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
+	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
+"
+
 _git_format_patch ()
 {
 	case "$cur" in
@@ -1122,21 +1130,7 @@ _git_format_patch ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--stdout --attach --no-attach --thread --thread=
-			--output-directory
-			--numbered --start-number
-			--numbered-files
-			--keep-subject
-			--signoff --signature --no-signature
-			--in-reply-to= --cc=
-			--full-index --binary
-			--not --all
-			--cover-letter
-			--no-prefix --src-prefix= --dst-prefix=
-			--inline --suffix= --ignore-if-in-upstream
-			--subject-prefix=
-			"
+		__gitcomp "$__git_format_patch_options"
 		return
 		;;
 	esac
@@ -1550,6 +1544,12 @@ _git_send_email ()
 		__gitcomp "ssl tls" "" "${cur##--smtp-encryption=}"
 		return
 		;;
+	--thread=*)
+		__gitcomp "
+			deep shallow
+			" "" "${cur##--thread=}"
+		return
+		;;
 	--*)
 		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
 			--compose --confirm= --dry-run --envelope-sender
@@ -1559,11 +1559,12 @@ _git_send_email ()
 			--signed-off-by-cc --smtp-pass --smtp-server
 			--smtp-server-port --smtp-encryption= --smtp-user
 			--subject --suppress-cc= --suppress-from --thread --to
-			--validate --no-validate"
+			--validate --no-validate
+			$__git_format_patch_options"
 		return
 		;;
 	esac
-	COMPREPLY=()
+	__git_complete_revlist_file
 }
 
 _git_stage ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 92d7eb4..c4b6c13 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -146,6 +146,22 @@ test_expect_success '__gitcomp - suffix' '
 	test_cmp expected out
 '
 
+setup_repository ()
+{
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	test_tick &&
+	git commit --allow-empty -m "Initial"
+	)
+}
+
+test_expect_success 'prepare' '
+	setup_repository one &&
+	git clone one test &&
+	cd test
+'
+
 test_expect_success 'basic' '
 	run_completion "git \"\"" &&
 	# built-in
@@ -228,4 +244,9 @@ test_expect_success 'general options plus command' '
 	test_completion "git --no-replace-objects check" "checkout "
 '
 
+test_expect_success 'send-email' '
+	test_completion "git send-email --cov" "--cover-letter " &&
+	test_completion "git send-email ma" "master "
+'
+
 test_done
-- 
1.7.12.1
