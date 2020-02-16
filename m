Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812ECC76199
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36622522
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QngFbvME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgBPNsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:48:53 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:37183 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgBPNsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:48:53 -0500
Received: by mail-pj1-f51.google.com with SMTP id m13so6045381pjb.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj3ZtAaKjuh5f9SqEwGaI4zuWboa1Ku3MPN06Z2LMoY=;
        b=QngFbvMExCv4tOq9OMHUrkEUvGGyqtkMsaMG+hp/JsFQ3vAFhfixPSL3qGVO+D8rMz
         qww1+6BBA0sadevJZGr/zdy0cOtjcn/LiXXPAcEDgeoQfuqzqnWdscPiNJVNgGzEAv2Y
         2qMc/BFQUp5whKCHnkYtai60scZ9wH1AHu+wZmCDHD/sVTAOczqNpgTZkyuWpPl4tw8P
         lMllj2yZ7grdncgfAlDmZnfwh2nBsYY3RoRG3Gcvu9hAY4xrTvaBywM/w802FgUVsU0/
         QE9wPHApBgeoowQjjogSpaxMNTDfvavsAYs2WhCsk20h62DpUWzU/rXoMo7AEH9j7BHc
         LqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj3ZtAaKjuh5f9SqEwGaI4zuWboa1Ku3MPN06Z2LMoY=;
        b=OpKFKrE0mZAQK85ggYxyaJl3TcY23Dpbf5qwEI/aFbtmi6ycdHUJdtKQ5jclgDFLbJ
         yt+ViijPKDaMnBfW8VQLU/luR/dy514MpomE0FAVsicLdwBFd22MMf6iYnXyz2vh6YLO
         Ryp99Yac99UFZXFIj2wR0x0AV4nH1QWE6qIE/io4vf8OsO3EUK+7ml+yNtf10RWKQ4AG
         FC/WNvq08FP38apF2+6zesC7DArLo84N41M60iHie7MTN5q401CAr/IBgONahpirKFXX
         vVOblQHhD2XCWLZY1OkM7IJZrwxOiZSx4EhbwC2GlG3w5eNMb/8hoDxOZTbNWDgvpzIv
         muhQ==
X-Gm-Message-State: APjAAAXi6Ac3m5F3KB97dX7oU3ZILji7Tb+5Fxuo4UvlEJDj271tqY3N
        ZRtaqOA68DQuNkI52fXklufPjKKTKkc=
X-Google-Smtp-Source: APXvYqyUBJLM8jvHXH7ScMo6S4t/ccyNCcEsq0NZPjwaVIVUqhcoX6QSni3yPYma0bV+tGIgcLgJrA==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr14781455pja.143.1581860930491;
        Sun, 16 Feb 2020 05:48:50 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id m12sm13302006pjf.25.2020.02.16.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:48:50 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC Patch 5/5] t4202: use lib-log-graph functions
Date:   Sun, 16 Feb 2020 19:17:50 +0530
Message-Id: <20200216134750.18947-5-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/t4202-log.sh | 49 ++++++++++---------------------------------------
 1 file changed, 10 insertions(+), 39 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 192347a3e1..403d88bb33 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -5,6 +5,7 @@ test_description='git log'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
+. "$TEST_DIRECTORY/lib-log-graph.sh"
 
 test_expect_success setup '
 
@@ -452,8 +453,7 @@ cat > expect <<EOF
 EOF
 
 test_expect_success 'simple log --graph' '
-	git log --graph --pretty=tformat:%s >actual &&
-	test_cmp expect actual
+	test_cmp_graph_file --pretty=tformat:%s
 '
 
 cat > expect <<EOF
@@ -467,8 +467,7 @@ cat > expect <<EOF
 EOF
 
 test_expect_success 'simple log --graph --line-prefix="123 "' '
-	git log --graph --line-prefix="123 " --pretty=tformat:%s >actual &&
-	test_cmp expect actual
+	test_cmp_graph_file --line-prefix="123 " --pretty=tformat:%s
 '
 
 test_expect_success 'set up merge history' '
@@ -495,9 +494,7 @@ cat > expect <<\EOF
 EOF
 
 test_expect_success 'log --graph with merge' '
-	git log --graph --date-order --pretty=tformat:%s |
-		sed "s/ *\$//" >actual &&
-	test_cmp expect actual
+	test_cmp_graph_file --date-order --pretty=tformat:%s
 '
 
 cat > expect <<\EOF
@@ -516,9 +513,7 @@ cat > expect <<\EOF
 EOF
 
 test_expect_success 'log --graph --line-prefix="| | | " with merge' '
-	git log --line-prefix="| | | " --graph --date-order --pretty=tformat:%s |
-		sed "s/ *\$//" >actual &&
-	test_cmp expect actual
+	test_cmp_graph_file --line-prefix="| | | " --date-order --pretty=tformat:%s
 '
 
 cat > expect.colors <<\EOF
@@ -538,9 +533,7 @@ EOF
 
 test_expect_success 'log --graph with merge with log.graphColors' '
 	test_config log.graphColors " blue,invalid-color, cyan, red  , " &&
-	git log --color=always --graph --date-order --pretty=tformat:%s |
-		test_decode_color | sed "s/ *\$//" >actual &&
-	test_cmp expect.colors actual
+	test_cmp_colored_graph_file --date-order --pretty=tformat:%s
 '
 
 test_expect_success 'log --raw --graph -m with merge' '
@@ -1213,24 +1206,8 @@ cat >expect <<\EOF
   +one
 EOF
 
-sanitize_output () {
-	sed -e 's/ *$//' \
-	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
-	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
-	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
-	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
-	    -e 's/, 0 deletions(-)//' \
-	    -e 's/, 0 insertions(+)//' \
-	    -e 's/ 1 files changed, / 1 file changed, /' \
-	    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
-	    -e 's/, 1 insertions(+)/, 1 insertion(+)/' \
-	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
-}
-
 test_expect_success 'log --graph with diff and stats' '
-	git log --no-renames --graph --pretty=short --stat -p >actual &&
-	sanitize_output >actual.sanitized <actual &&
-	test_i18ncmp expect actual.sanitized
+	test_cmp_graph_file --no-renames --graph --pretty=short --stat -p
 '
 
 cat >expect <<\EOF
@@ -1505,9 +1482,7 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success 'log --line-prefix="*** " --graph with diff and stats' '
-	git log --line-prefix="*** " --no-renames --graph --pretty=short --stat -p >actual &&
-	sanitize_output >actual.sanitized <actual &&
-	test_i18ncmp expect actual.sanitized
+	test_cmp_graph_file --line-prefix="*** " --no-renames --graph --pretty=short --stat -p
 '
 
 cat >expect <<-\EOF
@@ -1529,9 +1504,7 @@ cat >expect <<-\EOF
 EOF
 
 test_expect_success 'log --graph with --name-status' '
-	git log --graph --format=%s --name-status tangle..reach >actual &&
-	sanitize_output <actual >actual.sanitized &&
-	test_cmp expect actual.sanitized
+	test_cmp_graph_file --pretty=tformat:%s --name-status tangle..reach
 '
 
 cat >expect <<-\EOF
@@ -1553,9 +1526,7 @@ cat >expect <<-\EOF
 EOF
 
 test_expect_success 'log --graph with --name-only' '
-	git log --graph --format=%s --name-only tangle..reach >actual &&
-	sanitize_output <actual >actual.sanitized &&
-	test_cmp expect actual.sanitized
+	test_cmp_graph_file --pretty=tformat:%s --name-only tangle..reach
 '
 
 test_expect_success 'dotdot is a parent directory' '
-- 
2.25.0

