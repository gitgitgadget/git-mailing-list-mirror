Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A647C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD4624672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7GXeVM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLSWV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44793 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfLSWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so3862843pgl.11
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qlewRPUKbEN1Zgr/qeYy3s0HiHn2CrbEOGdInUgm+g=;
        b=P7GXeVM1XtyDByWl/xt69wL27hJVBkbZKrW+b2C8lgKMKlwnYRomYuOcjjGltdkFFl
         rzEYlECr6wy0+RC/sz138XAbdnnqNyEdLjjL+9Zoze8EB4c2y09Tbwl1y4vnxwl77Qm2
         Vxyr4EN7N3N2YFoiWVvAzbiG9TcevCCPT4ZjIAkGuIxbTxS5DfUWFjDdiGF2FmgZ4bGc
         GSM2v6ojdvWlKzAqglVKXpqq7iLh5qHJ8DlU9ec938eyx6ZxFvzQ+ebYGXb22yk/D1WT
         yAyWl61ko0QrGwFqy8UsKkIMTxcK6G3DNhNOz0Zar3ijmDUhEMs1AfqyuxxjTXdPkEXs
         E2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qlewRPUKbEN1Zgr/qeYy3s0HiHn2CrbEOGdInUgm+g=;
        b=nWRgM8JyfbuYV8jamGN4Dl1K98V9ZCoakrsbdKyvr7V5113h60v335ZaZb7Z8LYH2g
         WB+S4aReO7WVaB3XdO6zB5xlxnBYsJIAuuOLXHnXuDuxTgv2m59fp/WqUW5/5rak5wi0
         kDru0nlVY1bIbbPpwYxyXjZOV7qJpCVxsb6qzW91HI0/Ha5SmVR9kJK/SCbfegSgIoVJ
         nh/CkYKyCU3jM8BtPOeqvsNcYiqzqTKnpdJRJW1K6J7dOozwJyLUqNNWcjLdZQFyEkL2
         xrFL6t2UZ68f2doOaAZYa8HTXdelNEe/69dcYpfvr9ZMU9uCoYz2r6iOmX4VKNvab+uN
         VNgQ==
X-Gm-Message-State: APjAAAXysEaMVgrh+QaL1ADmgrm6r5bi+RCKfQnfi9hDxklb7RjiNR1T
        m3Albg3Hj4E3Bqi7buR8viXwxNBd
X-Google-Smtp-Source: APXvYqxIjSTwoGyE5FE3GS631hZZrd4Zq8NxkEr+tyfzldQDX5HecwPPSwKnW9uA8o5svyp/Do215A==
X-Received: by 2002:a63:1322:: with SMTP id i34mr11659498pgl.163.1576794106183;
        Thu, 19 Dec 2019 14:21:46 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:45 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/16] t1501: remove use of `test_might_fail cp`
Date:   Thu, 19 Dec 2019 14:22:48 -0800
Message-Id: <83e47748bc9c541c725f6c42c553b1a69fd717ac.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace test_might_fail() with
test_non_git_might_fail().

The `test_might_fail cp` line was introduced in 466e8d5d66 (t1501: fix
test with split index, 2015-03-24). It is necessary because there might
exist some index files in `repo.git/sharedindex.*` and, if they exist,
we want to copy them over. However, if they don't exist, we don't want
to error out because we expect that possibility. As a result, we want to
keep the "might fail" semantics so we use test_non_git_might_fail().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1501-work-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 3498d3d55e..067301a5ab 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -350,7 +350,7 @@ test_expect_success 'Multi-worktree setup' '
 	mkdir work &&
 	mkdir -p repo.git/repos/foo &&
 	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
-	test_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
+	test_non_git_might_fail cp repo.git/sharedindex.* repo.git/repos/foo &&
 	sane_unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
 '
 
-- 
2.24.1.703.g2f499f1283

