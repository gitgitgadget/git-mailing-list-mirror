Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C1F20986
	for <e@80x24.org>; Fri,  7 Oct 2016 23:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbcJGX6V (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 19:58:21 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35217 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932857AbcJGX6P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 19:58:15 -0400
Received: by mail-pa0-f67.google.com with SMTP id qn10so3349530pac.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ogn81q5jUVjVcZr32TiPljY2K5NcpLJzqv6zpxHi0Y=;
        b=RzFwq1t1dvJJ+M6B17UeP5mxEUkKy/CrWUaFrxcvj16mkBc5hnlAvRX7SYblvDtmEU
         +nBqSP1L5e590qZ7vcwDztCsYLoIeKZw84ShSMTBLGCV1MdF8IlyI1VBQLG2bHNpv5NM
         zMu+gYnvdr5StYEVcoMeSeiFDKI+yIy9LkVOmLfpJJajR6ftsF324Z4WGyXvo18YBcGe
         dkbzSNwCyduBcvr50k+0qal/yGpEeLrh0FKI+P1RnRC0Vdo1gqFj4GljrRpG9hZ0PqHd
         ClZDwaHW3cfeZ2EO84ZWnca9ZWmAIgnNMycW+jA/MS2aFfs92VA1Ww8h3c6IsAcS9Sww
         bzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ogn81q5jUVjVcZr32TiPljY2K5NcpLJzqv6zpxHi0Y=;
        b=kDsfZ1efOIW408r129AKAyvN6Tc98B3A2JivZWjnBy1zum+LR9POnxRHK2jGWnAaoZ
         K46myp8sn818PgNp4Phjv+Z2gLUirdppzlFynKIDP1XKg743o4xbU9wOMcQdZHA50LgO
         oxA1I5TnAK7+/2z44boayn2my+GwVKHdNYXv2I9CHvXCQeEjs8ZcTYoJvPvA7nlL+i8G
         cvvFhpDCZqjVDJVN9ev4uy69Cm0YkmwOXwzZ6iUZOn+yFxk4YX3mEysxmAPjauuPmfwm
         2j1MSTsliCixRYR5Lrql7oyvJ0lmuZKTzuWQ1H30+ArfmfdisdBPLcC6lKXPjATBsKsK
         kUww==
X-Gm-Message-State: AA6/9Rl2GzJvZJRTTzf+/4xIds4bW9K9/2gQeTStcr6f15tCuIBKIxO82L3n8PjdCmLhlA==
X-Received: by 10.66.26.209 with SMTP id n17mr34253961pag.69.1475884694261;
        Fri, 07 Oct 2016 16:58:14 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id c27sm16662890pfe.6.2016.10.07.16.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 16:58:13 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v3 4/4] mergetool: honor -O<orderfile>
Date:   Fri,  7 Oct 2016 16:58:06 -0700
Message-Id: <20161007235806.22247-4-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g8ee99a0
In-Reply-To: <20161007235806.22247-1-davvid@gmail.com>
References: <20161007235806.22247-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach mergetool to pass "-O<orderfile>" down to `git diff` when
specified on the command-line.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v2:

The tests no longer rely on "grep -A" and instead use "git grep"
for portability.  The mergetool output in the test is redirected
to a file so that we can catch its exit code.

The $orderfile variable is now passed using ${xxx:+"$xxx"}
to avoid conditional logic.

 Documentation/git-mergetool.txt | 10 ++++++----
 git-mergetool.sh                |  9 +++++++--
 t/t7610-mergetool.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

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
index 65696d8..e52b4e4 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -9,7 +9,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-O<orderfile>] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 NONGIT_OK=Yes
 OPTIONS_SPEC=
@@ -390,6 +390,7 @@ print_noop_and_exit () {
 main () {
 	prompt=$(git config --bool mergetool.prompt)
 	guessed_merge_tool=false
+	orderfile=
 
 	while test $# != 0
 	do
@@ -419,6 +420,9 @@ main () {
 		--prompt)
 			prompt=true
 			;;
+		-O*)
+			orderfile="$1"
+			;;
 		--)
 			shift
 			break
@@ -460,7 +464,8 @@ main () {
 	fi
 
 	files=$(git -c core.quotePath=false \
-		diff --name-only --diff-filter=U -- "$@")
+		diff --name-only --diff-filter=U \
+		${orderfile:+"$orderfile"} -- "$@")
 
 	cd_to_toplevel
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 38c1e4d..5cfad76 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -638,5 +638,32 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	test_cmp expect actual &&
 	git reset --hard >/dev/null
 '
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
+	git mergetool -Oorder-file --no-prompt --tool myecho >output &&
+	git grep --no-index -h -A2 Merging: output >actual &&
+	test_cmp expect actual &&
+	git reset --hard >/dev/null 2>&1
+'
 
 test_done
-- 
2.10.1.386.g8ee99a0

