From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/12] completion: add missing global options
Date: Sun,  8 Apr 2012 06:07:52 +0300
Message-ID: <1333854479-23260-6-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiVQ-0007R6-Dh
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab2DHDIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab2DHDI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:27 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uOxk+TsX+grD7wPlvs0hFCB+AtppQGvuNaWPsE9GQ50=;
        b=y87ud/+P9QM3ZA6BFWB6U2SnRVA+bUV6sEgwTD8xQlEAZmxBVvq1aWBZCbZuuv9E1b
         MCx3C3oRgjA4MhPKRUaR8Q9mdJGGFGDgMpRafionmtR2XmTYxd9YWMneYie4+Jj+tjyi
         5Ob654SaE7oCbNTOlIfb+ulNTtGfrD1fZySG263FQ330u9vrUF/xeImq9soqpcqvD1fa
         njm4u1khJENn/i/eNH0zCygn/RNdaEaIOKZ5/hPPDL5JIud132VdDzxmKLQ6oLQOOEPV
         QR6zooqqegbccpFbPHmYG7ZF+m6L+yGHFHNc+3qhkJx0UVL9LG1JMUdwjXRvcXivFVet
         l46A==
Received: by 10.152.105.19 with SMTP id gi19mr4784237lab.11.1333854506649;
        Sat, 07 Apr 2012 20:08:26 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id u4sm11395374lad.5.2012.04.07.20.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194966>

Otherwise 'git --foo bar<tab>' fails, also, other options are completely
missing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    9 +++++++--
 t/t9902-completion.sh                  |   31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3bc8d85..c9672b2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2621,7 +2621,10 @@ _git ()
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
-		--version|-p|--paginate) ;;
+		--version) ;;
+		-p|--paginate|--no-pager) ;;
+		--exec-path=*|--html-path|--info-path) ;;
+		--work-tree=*|--namespace=*|--no-replace-objects) ;;
 		--help) command="help"; break ;;
 		*) command="$i"; break ;;
 		esac
@@ -2636,10 +2639,12 @@ _git ()
 			--git-dir=
 			--bare
 			--version
-			--exec-path
+			--exec-path=
 			--html-path
+			--info-path
 			--work-tree=
 			--namespace=
+			--no-replace-objects
 			--help
 			"
 			;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7eb80dd..ee5654d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -198,4 +198,35 @@ test_expect_success 'double dash' '
 	test_completion "git checkout --"
 '
 
+test_expect_success 'general options' '
+	test_completion "git --ver" "--version " &&
+	test_completion "git --hel" "--help " &&
+	test_completion "git --exe" "--exec-path=" &&
+	test_completion "git --htm" "--html-path " &&
+	test_completion "git --pag" "--paginate " &&
+	test_completion "git --no-p" "--no-pager " &&
+	test_completion "git --git" "--git-dir=" &&
+	test_completion "git --wor" "--work-tree=" &&
+	test_completion "git --nam" "--namespace=" &&
+	test_completion "git --bar" "--bare " &&
+	test_completion "git --inf" "--info-path " &&
+	test_completion "git --no-r" "--no-replace-objects "
+'
+
+test_expect_success 'general options plus command' '
+	test_completion "git --version check" "checkout " &&
+	test_completion "git --paginate check" "checkout " &&
+	test_completion "git --git-dir=foo check" "checkout " &&
+	test_completion "git --bare check" "checkout " &&
+	test_completion "git --help des" "describe " &&
+	test_completion "git --exec-path=foo check" "checkout " &&
+	test_completion "git --html-path check" "checkout " &&
+	test_completion "git --no-pager check" "checkout " &&
+	test_completion "git --work-tree=foo check" "checkout " &&
+	test_completion "git --namespace=foo check" "checkout " &&
+	test_completion "git --paginate check" "checkout " &&
+	test_completion "git --info-path check" "checkout " &&
+	test_completion "git --no-replace-objects check" "checkout "
+'
+
 test_done
-- 
1.7.10.3.g5a738d
