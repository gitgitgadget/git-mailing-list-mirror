Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ACB3207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935071AbcJFXsN (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 19:48:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34981 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbcJFXsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 19:48:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id t25so1835027pfg.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXg3lT73e98IeeJxumq24FAERsG67ZQGZcK7M6eYV74=;
        b=SjT8/N1qYYsqivyMWo4Ai9h7gWlHkNGptSRENqi/4x8DVpIZggEBAMl3zdTp/d5WXw
         tdnLkW7BFTDEyackeGB3FblLKptcSRbMlvlS3wrXao5yhEnBACC7b9zJ03fpQfdOB5gJ
         6fJQqWvBWpHp+BHI7uBwvZgiOEGEd3gvSP6wudc4onaqIPszWbNhpj1fi4XbpnQt0yra
         Wv+pDUYoUkRF+g+bGIcBXbZgBDT1OT+CBvDN0GdntbhmAOtRw2uS58Rl9UsN5GrzqzKD
         om6HMH7jaZMEM2dy9855nuO95Sq+YO7zEuli6z3uFxMoF+QPDXkTOgne5YwVK0441GXn
         p1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXg3lT73e98IeeJxumq24FAERsG67ZQGZcK7M6eYV74=;
        b=Lnb6Xsh6XgLCtdWSv+YtUX83xdQ/Ty5pWGs9b7fbkLryq6HpKOnNaeuBDk7uYLDUBa
         jDap71B63FsMIhG0cqCuky3mmrgYmZvyn2EJS64LCplwYD4UPJpsgXANuWxNJgThjIJO
         bUCnVtN+95S1sWDeVqaISFmDKMgugVS4p70rqG+LQiQx5Mnq95Fa1OPmFQOwWyLxbf4p
         /5fddretkoVpD2Eu95eTq5lmJ5jmDkdxYtqp3diKA2PxH0rlcSEntBSHweFCMxF1zmsQ
         AuUOs8evHZASe1YIzjHl0esy+QB/g58O+fhxYPhr6QXw89BQct9VCTWqhDt4b47bpsTb
         pvDg==
X-Gm-Message-State: AA6/9Rnv8mrcybJ7Q7H01yanVxGqwetGn78fwrQzFHD68VH32b8g7m2NmW7sqVYK8mrLAA==
X-Received: by 10.98.60.142 with SMTP id b14mr12908695pfk.93.1475797690676;
        Thu, 06 Oct 2016 16:48:10 -0700 (PDT)
Received: from localhost.localdomain ([107.72.96.123])
        by smtp.gmail.com with ESMTPSA id m83sm8490726pfg.48.2016.10.06.16.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 16:48:09 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH 3/4] mergetool: honor diff.orderFile
Date:   Thu,  6 Oct 2016 16:47:58 -0700
Message-Id: <1475797679-32712-3-git-send-email-davvid@gmail.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1475797679-32712-1-git-send-email-davvid@gmail.com>
References: <1475797679-32712-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach mergetool to get the list of files to edit via `diff` so that we
gain support for diff.orderFile.

Suggested-by: Luis Gutierrez <luisgutz@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool.txt |  5 +++++
 git-mergetool.sh                | 30 +++++++++++++++---------------
 t/t7610-mergetool.sh            | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e846c2e..c4c1a9b 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -79,6 +79,11 @@ success of the resolution after the custom tool has exited.
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
+DIFF ORDER FILES
+----------------
+`git mergetool` honors the `diff.orderFile` configuration variable
+used by `git diff`.  See linkgit:git-config[1] for more details.
+
 TEMPORARY FILES
 ---------------
 `git mergetool` creates `*.orig` backup files while resolving merges.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index b2cd0a4..65696d8 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -382,6 +382,11 @@ prompt_after_failed_merge () {
 	done
 }
 
+print_noop_and_exit () {
+	echo "No files need merging"
+	exit 0
+}
+
 main () {
 	prompt=$(git config --bool mergetool.prompt)
 	guessed_merge_tool=false
@@ -445,28 +450,23 @@ main () {
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
-	files=
-
-	if test $# -eq 0
+	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
 	then
-		cd_to_toplevel
-
-		if test -e "$GIT_DIR/MERGE_RR"
+		set -- $(git rerere remaining)
+		if test $# -eq 0
 		then
-			files=$(git rerere remaining)
-		else
-			files=$(git ls-files -u |
-				sed -e 's/^[^	]*	//' | sort -u)
+			print_noop_and_exit
 		fi
-	else
-		files=$(git ls-files -u -- "$@" |
-			sed -e 's/^[^	]*	//' | sort -u)
 	fi
 
+	files=$(git -c core.quotePath=false \
+		diff --name-only --diff-filter=U -- "$@")
+
+	cd_to_toplevel
+
 	if test -z "$files"
 	then
-		echo "No files need merging"
-		exit 0
+		print_noop_and_exit
 	fi
 
 	printf "Merging:\n"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 7217f39..fb2aeef 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -606,4 +606,37 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	git reset --hard master >/dev/null 2>&1
 '
 
+test_expect_success 'diff.orderFile configuration is honored' '
+	test_config diff.orderFile order-file &&
+	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
+	test_config mergetool.myecho.trustExitCode true &&
+	echo b >order-file &&
+	echo a >>order-file &&
+	git checkout -b order-file-start master &&
+	echo start >a &&
+	echo start >b &&
+	git add a b &&
+	git commit -m start &&
+	git checkout -b order-file-side1 order-file-start &&
+	echo side1 >a &&
+	echo side1 >b &&
+	git add a b &&
+	git commit -m side1 &&
+	git checkout -b order-file-side2 order-file-start &&
+	echo side2 >a &&
+	echo side2 >b &&
+	git add a b &&
+	git commit -m side2 &&
+	test_must_fail git merge order-file-side1 &&
+	cat >expect <<-\EOF &&
+		Merging:
+		b
+		a
+	EOF
+	git mergetool --no-prompt --tool myecho | grep -A 2 Merging: >actual &&
+	test_cmp expect actual &&
+	git reset --hard >/dev/null
+'
+'
+
 test_done
-- 
2.10.1.355.g33afd83.dirty

