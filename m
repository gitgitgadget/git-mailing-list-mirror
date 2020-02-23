Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B97DC35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CFD206E0
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idpcMxkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgBWItZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 03:49:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41877 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWItY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 03:49:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so6658590ljc.8
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vrJjnWwz7OIZGek+kkNzIAiJYjZcEmNeVAs6b+aOEeI=;
        b=idpcMxkkwh/DkUxaWzO5Lr+QfOH1dhO/eRhb10/tuXU5CGcPp0Snb8NtaRh/OZwEy8
         tiv6+gSPVUcD71/l6BDXYD9QaTAZp825m87yNd97rXb2OodOiypa3RF4mgqk6cfpXl/l
         t8yN7n6mqOn73fnlnU1KvX5mwnTZJHB2KCfylfQoUwPjZD1Va9wZ8mkfhf/p1x60CqYY
         1bCtsG8tRCL8antbBkkmZ72FDC6LsWWrfnZKyaqtFs8A/geyL+kvtNNu4AahNy79MA6W
         vaXPV5aM6svgGjbjRkqglb7c2m7ighEbFWNonkUw8trT99JRVrj4Z9wvhyU3PZ4Hdg5s
         8Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrJjnWwz7OIZGek+kkNzIAiJYjZcEmNeVAs6b+aOEeI=;
        b=AI/1fzCGKhM7vAP/DPHyWw7DREZsypTpPThPG02tHvvD/X88VRbx7B/JA8XeDosU1Z
         TfdbPIpVgv4CbOgLZetlV2k7cgwlXpazkpOTkWVFE55xXw4GgHp8InYbkbEDMr/90dox
         WnLnP2XeKyS+TIikUYuiO0JcDNlKY5Vlur4utCLffhTmW9zgf7gDaTqkyCNt5RpeHAUs
         gdnSksd2VtTx4DGjUo8eh0PwPKrA8ugWaUwoNzItXfnTquXk3B8Y0Be2YSVpK9K5HLr2
         D0bF1sXiNmAK+zTjmM8jn14GjJpA3N43oWATUrohQsVJpRbo47C8ZP8FNsEOLSOqVzhJ
         2Gvg==
X-Gm-Message-State: APjAAAWBU9p+C1fbhKQZMgy1gZPcG6Gr8IMLo0lohx5UHA10XZz24fZp
        kkqzdfGoz5YJRlB4/NGiRyj29BTQ
X-Google-Smtp-Source: APXvYqyR7Hop633YfdQ4zYTggTY/fqtCHf9Erd5o9t55v7ygmJ9NiO+xzimvIhRLzZQPO4pOeFl4Kg==
X-Received: by 2002:a2e:90d1:: with SMTP id o17mr7524507ljg.155.1582447760913;
        Sun, 23 Feb 2020 00:49:20 -0800 (PST)
Received: from localhost.localdomain (c83-248-175-94.bredband.comhem.se. [83.248.175.94])
        by smtp.gmail.com with ESMTPSA id t29sm4108692lfg.84.2020.02.23.00.49.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 00:49:20 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] t: drop debug `cat` calls
Date:   Sun, 23 Feb 2020 09:48:36 +0100
Message-Id: <179c67caec0f8123d09455cb78532419166e1b9e.1582447606.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We `cat` files, but don't inspect or grab the contents in any way.
Unlike in an earlier commit, there is no reason to suspect that these
files could be missing, so `cat`-ing them is just wasted effort.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t0021-conversion.sh                  | 1 -
 t/t1406-submodule-ref-store.sh         | 2 +-
 t/t1450-fsck.sh                        | 1 -
 t/t2107-update-index-basic.sh          | 1 -
 t/t3007-ls-files-recurse-submodules.sh | 1 -
 t/t5150-request-pull.sh                | 2 --
 t/t5409-colorize-remote-messages.sh    | 3 +--
 t/t5510-fetch.sh                       | 1 -
 t/t8003-blame-corner-cases.sh          | 1 -
 t/t9300-fast-import.sh                 | 1 -
 t/t9800-git-p4-basic.sh                | 1 -
 11 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6c6d77b51a..dc664da551 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -795,7 +795,6 @@ test_expect_success PERL 'missing file in delayed checkout' '
 
 	rm -rf repo-cloned &&
 	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
-	cat git-stderr.log &&
 	grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index d199d872fb..36b7ef5046 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -75,7 +75,7 @@ test_expect_success 'for_each_reflog()' '
 '
 
 test_expect_success 'for_each_reflog_ent()' '
-	$RUN for-each-reflog-ent HEAD >actual && cat actual &&
+	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
 	tail -n2 actual | head -n1 | grep master.to.new
 '
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 02478bc4ec..d09eff503c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -141,7 +141,6 @@ test_expect_success 'email without @ is okay' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	git fsck 2>out &&
-	cat out &&
 	! grep "commit $new" out
 '
 
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 2242cd098e..a30b7ca6bc 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -9,7 +9,6 @@ Tests for command-line parsing and basic operation.
 
 test_expect_success 'update-index --nonsense fails' '
 	test_must_fail git update-index --nonsense 2>msg &&
-	cat msg &&
 	test -s msg
 '
 
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index 318b5bce7e..4a08000713 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -130,7 +130,6 @@ test_expect_success '--recurse-submodules and pathspecs setup' '
 
 	git ls-files --recurse-submodules >actual &&
 	test_cmp expect actual &&
-	cat actual &&
 	git ls-files --recurse-submodules "*" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 1ad4ecc29a..c1811ea0f4 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -150,7 +150,6 @@ test_expect_success 'pull request after push' '
 		git request-pull initial origin master:for-upstream >../request
 	) &&
 	sed -nf read-request.sed <request >digest &&
-	cat digest &&
 	{
 		read task &&
 		read repository &&
@@ -179,7 +178,6 @@ test_expect_success 'request asks HEAD to be pulled' '
 		git request-pull initial "$downstream_url" >../request
 	) &&
 	sed -nf read-request.sed <request >digest &&
-	cat digest &&
 	{
 		read task &&
 		read repository &&
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 2a8c449661..5d8f401d8e 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -56,14 +56,13 @@ test_expect_success 'short line' '
 
 test_expect_success 'case-insensitive' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/case-insensitive 2>output &&
-	cat output &&
 	test_decode_color <output >decoded &&
 	grep "<BOLD;RED>error<RESET>: error" decoded &&
 	grep "<BOLD;RED>ERROR<RESET>: also highlighted" decoded
 '
 
 test_expect_success 'leading space' '
-	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/leading-space 2>output &&        cat output &&
+	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/leading-space 2>output &&
 	test_decode_color <output >decoded &&
 	grep "  <BOLD;RED>error<RESET>: leading space" decoded
 '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5f8f1c287f..4d3a55caaf 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -378,7 +378,6 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
 	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
-	cat result &&
 	grep "fatal: '\''a\\\\!'\''b'\''" result
 '
 
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 1c5fb1d1f8..9130b887d2 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -173,7 +173,6 @@ test_expect_success 'blame during cherry-pick with file rename conflict' '
 	git show HEAD@{1}:rodent > rodent &&
 	git add rodent &&
 	git blame -f -C -C1 rodent | sed -e "$pick_fc" >current &&
-	cat current &&
 	cat >expected <<-\EOF &&
 	mouse-Initial
 	mouse-Second
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ae9950a9c2..3e41c58a13 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1047,7 +1047,6 @@ test_expect_success 'M: rename root to subdirectory' '
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M4^ M4 >actual &&
-	cat actual &&
 	compare_diff_raw expect actual
 '
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 5856563068..c98c1dfc23 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -202,7 +202,6 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 		export PATH &&
 		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
 	) &&
-	cat errs &&
 	test_i18ngrep ! Traceback errs
 '
 
-- 
2.25.0

