Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB9C20987
	for <e@80x24.org>; Thu,  6 Oct 2016 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935974AbcJFXsQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 19:48:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34763 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935110AbcJFXsO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 19:48:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id 190so1838036pfv.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gps2YZQjlYlhhGpDye5cHTVjkVyf81D7KZ28lvn8ZG0=;
        b=iFubEDBqQZ9tJm7lwDt96FCgVgi7fbg9jdj4/8e1P3QIx35TcFUJARfUEV26fMWfeu
         1oiWrmCrhegkWKAK9WLXK1NbBcCxp/DWMPA5y2L1RvSwkHBADkjtX34jOOWVRtRHNo8o
         rAf73CXtihvjxRSXyacD/qB+PGLhfd2GtTVZ5wM8zBndZqXMuXIED7Wr8wjMYpKklim3
         D95M3mtzn2wnrkAvw2uBIfYgjYrarCXtXZz2fOdsPgYXRmnRsqiynXwRY+I8uBFP8DZ2
         oC48U1b+2smLnywTjj8xD01nPduyrCA1Wmz97vuT7qRmoyCI11VWLGQpHeS/0EX4/32g
         2ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gps2YZQjlYlhhGpDye5cHTVjkVyf81D7KZ28lvn8ZG0=;
        b=TSIM/sbEyCeaMR6M7GZ445+ZTnI4rB9kobQ+gN4oNvC0dVV/w9aY/g0qLQGhDww/xz
         8BYEYtvOA5IgpIfyhS6Qo6DCa8XKq3BmcOLI6hk9avjTNOMcevrgtqdMQXm+0D0808kt
         c5UXcQXirn/QPzZmboKaFBq7eW2Tj+iylEmUVIPt1LjQ0Chwdd/SBNADSbOCmbuNb7YU
         j48zz4GmjeEijVKTTLtLvb5crcX3vXXopDqznSkKefTrLx5wJG2cg6rQOsIhdcyhDzFB
         AW4Ygne6gbPZkj5sIdpmA8ynqoHsVwl3aCBsmKfhCBvSQKVH/F83yTu4Aw9YVq2o+Q2d
         FpSQ==
X-Gm-Message-State: AA6/9RlM3puVrKj093X1fB85XyjiH/dPvzZPa9GDFUKnosXvXOvegzCtQJxBQvunlwzWZA==
X-Received: by 10.98.214.71 with SMTP id r68mr30838050pfg.64.1475797693095;
        Thu, 06 Oct 2016 16:48:13 -0700 (PDT)
Received: from localhost.localdomain ([107.72.96.123])
        by smtp.gmail.com with ESMTPSA id m83sm8490726pfg.48.2016.10.06.16.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 16:48:12 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH 4/4] mergetool: honor -O<order-file>
Date:   Thu,  6 Oct 2016 16:47:59 -0700
Message-Id: <1475797679-32712-4-git-send-email-davvid@gmail.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1475797679-32712-1-git-send-email-davvid@gmail.com>
References: <1475797679-32712-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach mergetool to pass "-O<order-file>" down to `git diff` when
specified on the command-line.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool.txt | 10 ++++++----
 git-mergetool.sh                | 14 ++++++++++++--
 t/t7610-mergetool.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index c4c1a9b..3622d66 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -79,10 +79,12 @@ success of the resolution after the custom tool has exited.
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
-DIFF ORDER FILES
-----------------
-`git mergetool` honors the `diff.orderFile` configuration variable
-used by `git diff`.  See linkgit:git-config[1] for more details.
+-O<orderfile>::
+	Process files in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
+	This overrides the `diff.orderFile` configuration variable
+	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
+	use `-O/dev/null`.
 
 TEMPORARY FILES
 ---------------
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 65696d8..9dca58b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -9,7 +9,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-O<order-file>] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 NONGIT_OK=Yes
 OPTIONS_SPEC=
@@ -390,6 +390,7 @@ print_noop_and_exit () {
 main () {
 	prompt=$(git config --bool mergetool.prompt)
 	guessed_merge_tool=false
+	order_file=
 
 	while test $# != 0
 	do
@@ -419,6 +420,9 @@ main () {
 		--prompt)
 			prompt=true
 			;;
+		-O*)
+			order_file="$1"
+			;;
 		--)
 			shift
 			break
@@ -459,8 +463,14 @@ main () {
 		fi
 	fi
 
+	if test -n "$order_file"
+	then
+		set -- "$order_file" -- "$@"
+	else
+		set -- -- "$@"
+	fi
 	files=$(git -c core.quotePath=false \
-		diff --name-only --diff-filter=U -- "$@")
+		diff --name-only --diff-filter=U "$@")
 
 	cd_to_toplevel
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index fb2aeef..0f9869a 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -637,6 +637,33 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	test_cmp expect actual &&
 	git reset --hard >/dev/null
 '
+
+test_expect_success 'mergetool -Oorder-file is honored' '
+	test_config diff.orderFile order-file &&
+	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
+	test_config mergetool.myecho.trustExitCode true &&
+	test_must_fail git merge order-file-side1 &&
+	cat >expect <<-\EOF &&
+		Merging:
+		a
+		b
+	EOF
+	git mergetool -O/dev/null --no-prompt --tool myecho |
+	grep -A 2 Merging: >actual &&
+	test_cmp expect actual &&
+	git reset --hard >/dev/null 2>&1 &&
+
+	git config --unset diff.orderFile &&
+	test_must_fail git merge order-file-side1 &&
+	cat >expect <<-\EOF &&
+		Merging:
+		b
+		a
+	EOF
+	git mergetool -Oorder-file --no-prompt --tool myecho |
+	grep -A 2 Merging: >actual &&
+	test_cmp expect actual &&
+	git reset --hard >/dev/null 2>&1
 '
 
 test_done
-- 
2.10.1.355.g33afd83.dirty

