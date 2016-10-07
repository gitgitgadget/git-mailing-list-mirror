Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726D6207EC
	for <e@80x24.org>; Fri,  7 Oct 2016 04:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbcJGEFL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 00:05:11 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34369 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbcJGEFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 00:05:10 -0400
Received: by mail-pa0-f67.google.com with SMTP id r9so2063697paz.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Zqh/wDDbaYU3bYiUy6CjT9a8Yi34d686YKzUZ7PF1LU=;
        b=R+hxbjNOpw3qsmPkcbCgNwXgLRYmI3KNnDvpO4pex6kRKeXOs1P8Gia6j2Q0T+cSmM
         2T6oOq1zj9C5mgRGWp4SLxGE/hQ09ILEOhixsDRdMebYL8p07FF+nagubkq6KJwt8R+S
         9b+oNWm3ZS0ANTKkh3xPu7uCF1p9Z23jMHcoeOowGxNaxcFf+5iZMaWO2SrxB2kmBUTT
         OdN9YxDet6lScY66ptetuXnwjCwdRGkcp4y8MqC50Gv60SRaFqqrDRzwSQGCXJBXiVjk
         ubyroS22Mtzr2FX8BStglfbA4gQ0wGCiUh7xnvRAc9YCuQ1zQiAZm7KmU54oLUl0okNS
         yNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zqh/wDDbaYU3bYiUy6CjT9a8Yi34d686YKzUZ7PF1LU=;
        b=Y8pcNvd23z4GJ4DGzXwWokuvk3GgaJboq/y3Ru417T/7fAgJNw2tgDqsrVykyyo/KD
         l+dPX/NtT4X53BdZUWkF6GB31bfMOkqqSRW4O4mqbvVGxN8sv+e6zW16aEYO1DbcAXNu
         SvqF/Yq6XEJOi/eaKa4ZL1bFeM+YYuSGymvwnGno9vUqymdWGbwQ0l/BWqUa7KkmYmCW
         /h2Lq/rErtyCl+LMuL6/Jtk2DtkgN1ka2UhDst2NaASwQKFd1q2YQVJOYxEoAP5UM2E1
         1vCiEZMFEKXJK57nE9iuzmjfn4L7nFR0nu6v93/1+Vg/rg5rblDxXK62ToT+ZfytBZBS
         KCRg==
X-Gm-Message-State: AA6/9Rm8waQk8TotzIp5HIjjhlHgLn91aXKbjfV5hp+OTce4p6dmgXl6o8xbxkubDbkgAw==
X-Received: by 10.66.10.132 with SMTP id i4mr27401898pab.101.1475813108615;
        Thu, 06 Oct 2016 21:05:08 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id v24sm9404117pfd.1.2016.10.06.21.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 21:05:06 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: [PATCH v2 4/4] mergetool: honor -O<orderfile>
Date:   Thu,  6 Oct 2016 21:05:02 -0700
Message-Id: <20161007040502.16801-1-davvid@gmail.com>
X-Mailer: git-send-email 2.10.1.386.g42aabb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach mergetool to pass "-O<orderfile>" down to `git diff` when
specified on the command-line.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a replacement patch for 4/4 from the original series.

The changes are stylistic -- the "order_file" variable name and
"-O<order-file>" in the usage were changed to "orderfile" and
"-O<orderfile>" for consistency with the documentation.

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
index 65696d8..1a0fe7a 100755
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
@@ -459,8 +463,14 @@ main () {
 		fi
 	fi
 
+	if test -n "$orderfile"
+	then
+		set -- "$orderfile" -- "$@"
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
2.10.1.386.g42aabb0

