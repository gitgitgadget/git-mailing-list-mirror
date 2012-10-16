From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] completion: add format-patch options to send-email
Date: Tue, 16 Oct 2012 02:21:50 +0200
Message-ID: <1350346910-29853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 02:22:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNuvB-0007gj-2f
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 02:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab2JPAV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 20:21:58 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46923 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2JPAV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 20:21:57 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so2780803wib.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=oDwfvJEJ32pR6o8BGWig+vw9Z4JZ/xSSxlRobFmaF2M=;
        b=TGu4BbDMNdlC9D9C4QuGvgTlzwMHRgOeEFnxtLSW6xOZuQzuMBu7d5X2B8YLhg7+ya
         RN+TpU/0M/UOsiCA1GfIJBihLK6H3ctK9IleRYXwPcPKtb9UZLPKCWhhYtEGfdC7ZTXY
         dMUSCsexkWxsLl2jLVuPtlE+7Iwi6/8NsBqbXrvTIbc1C6x08VjBhU7HdprGSeC8ypvy
         vFR5KRaOEAQJlNTkbqTiOsqtYJxepD1bdHOlFjW+I48SoAQvfmgbGEvRJtlxAzMACgS1
         ofPGZMCC2t0mSHb697lcw/Lv44mUf2d1Ss0rF3GjZNfvHWmPV+yWIHb+Qh/1RV8S/sRt
         Yxfg==
Received: by 10.180.82.34 with SMTP id f2mr27405128wiy.17.1350346916357;
        Mon, 15 Oct 2012 17:21:56 -0700 (PDT)
Received: from localhost (ip-109-43-0-77.web.vodafone.de. [109.43.0.77])
        by mx.google.com with ESMTPS id b3sm16469012wie.0.2012.10.15.17.21.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 17:21:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207790>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

v2: Fix comments by SZEDER Gabor

 contrib/completion/git-completion.bash | 35 +++++++++++++++++-----------------
 t/t9902-completion.sh                  |  5 +++++
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..bc0657a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1116,6 +1116,14 @@ _git_fetch ()
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
@@ -1126,21 +1134,7 @@ _git_format_patch ()
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
@@ -1554,6 +1548,12 @@ _git_send_email ()
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
@@ -1563,11 +1563,12 @@ _git_send_email ()
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
+	__git_complete_revlist
 }
 
 _git_stage ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cbd0fb6..8fa025f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -288,4 +288,9 @@ test_expect_failure 'complete tree filename with metacharacters' '
 	EOF
 '
 
+test_expect_success 'send-email' '
+	test_completion "git send-email --cov" "--cover-letter " &&
+	test_completion "git send-email ma" "master "
+'
+
 test_done
-- 
1.7.12.1
