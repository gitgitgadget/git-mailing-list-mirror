Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0286C20986
	for <e@80x24.org>; Sat,  8 Oct 2016 00:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbcJHABf (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 20:01:35 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34361 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbcJHABd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 20:01:33 -0400
Received: by mail-pa0-f66.google.com with SMTP id r9so3370545paz.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=x0Ce8bPBcakzP8zSOFVl8OsiSkUOClUPR0qaw1p0ONc=;
        b=oiKykKgHeLiwvgWv1h05J80g1F8G0P0sv0EK52gJ5wally9D0whMQDNt5s+qwrRq6k
         5isCEbPtLW9RtQSbGBe1EDXgEzGwtp8kNrSSPaF6jNwqrESRjVcorcA+cUo0EicI5L2b
         ryt+JkifoiXeXZNa8H1p7lD2HPQBhhCr5coNTCZiAJEjUyi5AFKF0m3fJlPfqaSCH8cA
         Zj8GAsGb1YKFCP196GPB3pozZ5q5jVEaYN2e9eM7rkDhoZQPYh2wXHNKlEO/RGoExq37
         S9UbCLesUzPilYvi9P4zLlyfItI+gjw7AXr7tvsvK+wOcGFln+1Fl18GWuSB6rit4N9+
         Shxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x0Ce8bPBcakzP8zSOFVl8OsiSkUOClUPR0qaw1p0ONc=;
        b=jjfzPzgiQwgk4RXpm4jAtH006xntn7jYAtzD0VVqF/ahX4oINWEVXZ1+/kX1EpX0Th
         L+ZQRTa4ZGjPmaCUNJo8W0Iqf7CQfsFaaziKv1qAgyC49h3dJgdos0YklOoo2z3DeDT/
         OR9JMbQUBEiekCRf/CXpDnQ3eVcZq/7LUoV5f/u/j2a0E7c12bB6qKUK+0UhOmrxO1/j
         B7k+K+D+2B4kR94sAErKq+jwu1xtCDskzP7pNMpFCwZVIUVeKWx/siROtkREsGdZzY1O
         vsgSaquMciVQbrJsSjVUEcF1jjIMSJo3Nyq/cAdB6zqAZAM9/REbfBTalx07b/bn2+x4
         24BQ==
X-Gm-Message-State: AA6/9Rljuj39pp0KnOpa5A5wGVcozCp93uX68WH/FbezJWJtUf2gs+sjEp+R+K7UZ6MUew==
X-Received: by 10.66.190.4 with SMTP id gm4mr34212585pac.210.1475884892981;
        Fri, 07 Oct 2016 17:01:32 -0700 (PDT)
Received: from raptor.fas.fa.disney.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id ps2sm33694463pab.31.2016.10.07.17.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 17:01:32 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v4 4/4] mergetool: honor -O<orderfile>
Date:   Fri,  7 Oct 2016 17:01:30 -0700
Message-Id: <20161008000130.22858-1-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g8ee99a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach mergetool to pass "-O<orderfile>" down to `git diff` when
specified on the command-line.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Since v3:

I missed one last piped invocation of "git mergetool" in the tests,
which has been fixed.

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
index 38c1e4d..6d9f215 100755
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
+	git mergetool -O/dev/null --no-prompt --tool myecho >output &&
+	git grep --no-index -h -A2 Merging: output >actual &&
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

