Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89AEC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15E764EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhBXTyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhBXTxV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8CC0617A9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k66so2910872wmf.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnTVyCm1E81e8pQqNWVBhz318SyFao3a8UZxmQjUzAg=;
        b=TEf6yZ6vEsZIdhHk8QUPuN4kFTJ+ZagK+bjOjv/4FmhTCtd7exixtSCrAVJXWfCgp4
         5YtXCEEw8cVCrT7tUKk5WD7s1Iw/yW/c0mLQQwxOtr6ddbfSVW4ulHmXKASs5jFcV7mK
         hVlurwuKrzUUtIgWhvLz2zx8K6stx18xyPDaQjRBnWUcQ1Y7c4udS5M4TjM1ze8t4xui
         QVrk1Kft9YpuAL8s2jvRpA+DwIj/Ff8Bcnp478LWYqfnDQutjMpM2WrDOLOyDhrsBj5i
         +gmF6jI4gJxXwgwJZ++7CvdPrBo9l94vJuLYhQ7983oVKugaqh69G6hL95C7JIwBNlZ7
         b6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnTVyCm1E81e8pQqNWVBhz318SyFao3a8UZxmQjUzAg=;
        b=ZA1O9HiK3IL8Kq/m0ItsDyjZbi1ZbxD4E4Y9zKnI7azbY0r4yjBk8oSgm51aJk8wuG
         l24xFUhKdVN3/6w46Vu+IOJvwQur6YduJUUtc1oRLWfhYBnjHkt13zgKDl5eFg17uOQu
         fkqBlm19DNWw0o4np7HVEJGlGf78q3b7vFbQD1ybx1WF8sjWWyJvdkb/F9X95D5TFATn
         qKu2nmMnicF9aucvR9zACeNy53lxSRbWHGEs70whbQ9qgksi8xnI7WpjdfJIvrF0DFRO
         lscqKzNNOgFsMC4nUlinfP2BbGUen2ZV34G9PVqkE4igJxomd0Ms7X94bKXGWO3HiALd
         1axQ==
X-Gm-Message-State: AOAM530zA7k8Rn2p1XN/LJpmzI7BuYHLOQlxukyqS0+XTaAMZxUdQkYP
        AyI4Yo9kRQhXTCyKOZNBtEufz2G2QN66lQ==
X-Google-Smtp-Source: ABdhPJxIbA+HUL4DQjyQCFV8vbh/AFGToM8SvHFl2h3Fwm2PefY9OGq8FuK8Hcsdt4p9eN2I/nGuUA==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr5213075wmq.77.1614196322419;
        Wed, 24 Feb 2021 11:52:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/35] userdiff tests: change setup loop to individual test setup
Date:   Wed, 24 Feb 2021 20:51:06 +0100
Message-Id: <20210224195129.4004-13-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the recently amended setup loop in "setup hunk header tests" to
instead set up the test data as we test each individual hunk header
test.

This means we can get rid of the "|| return 1" case and the previous
for-loop, and won't spend time on setting up all the data only to
e.g. fail on the 1st test when running under "-i".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 15dcbe735ca..2365f0e361e 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -72,24 +72,23 @@ test_expect_success 'setup hunk header tests' '
 
 	cp -R "$TEST_DIRECTORY"/t4018 . &&
 	git init t4018 &&
-	git -C t4018 add . &&
+	git -C t4018 add .
+'
 
-	for i in $(git -C t4018 ls-files)
-	do
-		grep -v "^t4018" "t4018/$i" >"t4018/$i.content" &&
-		sed -n -e "s/^t4018 header: //p" <"t4018/$i" >"t4018/$i.header" &&
-		cp "t4018/$i.content" "$i" &&
+# check each individual file
+for i in $(git -C t4018 ls-files)
+do
+	test_expect_success "setup hunk header: $i" "
+		grep -v '^t4018' \"t4018/$i\" >\"t4018/$i.content\" &&
+		sed -n -e 's/^t4018 header: //p' <\"t4018/$i\" >\"t4018/$i.header\" &&
+		cp \"t4018/$i.content\" \"$i\" &&
 
 		# add test file to the index
-		git add "$i" &&
+		git add \"$i\" &&
 		# place modified file in the worktree
-		sed -e "s/ChangeMe/IWasChanged/" <"t4018/$i.content" >"$i" || return 1
-	done
-'
+		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
+	"
 
-# check each individual file
-for i in $(git ls-files)
-do
 	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >diff &&
 		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
-- 
2.30.0.284.gd98b1dd5eaa7

