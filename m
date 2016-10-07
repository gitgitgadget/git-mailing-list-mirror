Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4E220986
	for <e@80x24.org>; Fri,  7 Oct 2016 23:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932872AbcJGX6R (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 19:58:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34691 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932848AbcJGX6N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 19:58:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id 190so3552891pfv.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJYW3A5WeKHWy00rAU2XbtegUMkdhMbA+7A3M8rhnJI=;
        b=nYRsnebmFmfZC9qKDfyZh0HPVZqEXvhnztDN2yNIuZtgYz19E8X1EnL5D85egbt6Gw
         wiDBPxyN1pKK0g8ML1j65dWSxAUg13U/iIP/vXRRH/Vz8qN/QdFYtp061GjyPDGZioRn
         /V2POxvs2aF9S74C/O2dy34YwGZLON7HXrEy/T2Diw9XFm9idqDwceR5iyvtbv/JioEl
         Y1Y/7y1YGLL1lvirfODnTtIn9/QXYh4k0rnvyZHHYC0Geg5PAHN9BnIhsLEI6Q5pSFhp
         wmiDgJlj4tefta4kQnHHkqWFTw4avCbyOKyVXmuCu+/2st5Mlykgi6FaPyRayifUS8hi
         wlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJYW3A5WeKHWy00rAU2XbtegUMkdhMbA+7A3M8rhnJI=;
        b=BYMmiFfMv5zZz+p4rAYaDhEx5CLxi0gk1jZUqXTHbd6MX1Nhs+Rs5Wx4nrS2f0ozIx
         QoVK8tnep4jvws8RGW46TrN4yTDQxXDX6K1kAnoEBpPx8nus8hoohViLdm70BS7XrLUX
         Y8eZ4vZTN9IVXlbHpv/cg1QCdTl0EQW4dkmaLFOl8giU5mqGjZNMvoy8eYvoN2sus40e
         2rG8MV+AZ7Kha20YSAVrRoX+zKz6dmY/L+kDtnfqUSjpJSmxfKM/7kmiVsNuNkwtKHOr
         DKZ9bvCQyNQmjQhvHVyDUZhI25qXnTP4XLb8gbnG/RUkNeEv7M1NIg93C8nbqIqRT/T4
         YTEA==
X-Gm-Message-State: AA6/9RnrV0WeljShHvJhRIoLMCXXr7+w9M1pNJOtOXRy2QC8RJXNCDX4tEPYsXzv73Abuw==
X-Received: by 10.98.55.71 with SMTP id e68mr40645922pfa.147.1475884692805;
        Fri, 07 Oct 2016 16:58:12 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id c27sm16662890pfe.6.2016.10.07.16.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 16:58:11 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v3 3/4] mergetool: honor diff.orderFile
Date:   Fri,  7 Oct 2016 16:58:05 -0700
Message-Id: <20161007235806.22247-3-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g8ee99a0
In-Reply-To: <20161007235806.22247-1-davvid@gmail.com>
References: <20161007235806.22247-1-davvid@gmail.com>
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
Changes since v2:

The tests no longer rely on "grep -A" and instead use "git grep"
for portability.  The mergetool output in the test is redirected
to a file so that we can catch its exit code.

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
index 7217f39..38c1e4d 100755
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
+	git mergetool --no-prompt --tool myecho >output &&
+	git grep --no-index -h -A2 Merging: output >actual &&
+	test_cmp expect actual &&
+	git reset --hard >/dev/null
+'
+
 test_done
-- 
2.10.1.386.g8ee99a0

