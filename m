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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37782C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F36C61050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhIUWm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhIUWmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF0FC061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t7so1003616wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pOj3cmXzXSstQDwCkAlZHAFcR4XdNjIEQJAiWZ52F8=;
        b=LN9ttv9jk/9N+GWLMLX/e49ZfYCmddXhTJqN8yh3v+0mzGtLzL0h6969mqeKWypeJx
         7n5vtyMnvklFn2eh62Z/WxqFl2B1aX6VgM6XwaXrFRXG6I2lfUQI6yOYT3y1aSXMgkG3
         kkrx31CxtbnAVAxtpf0Mc7iu+cWdb9IWzAXgo2UpuloZqoB/HDJwfqMGoXuRfHUMydvf
         vGC+9qEBynGd9sW8oOvO52aIdgZXTMw9jEprriFSwpJJrB5myhO28CKbb6sUlbSygKeu
         pEuKykb5FZXci5tGbluHaG8/fpv9B6eqLMEpK/EzYtHSkQv/bL/fW4uaG77fBH7iuo5b
         lRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pOj3cmXzXSstQDwCkAlZHAFcR4XdNjIEQJAiWZ52F8=;
        b=AJFzAqpqeaW4GRswxplvT2VbjfcVCxLnRctCmYpzkyITbg9dMzlJQWCvJBDlXeIn9h
         fmsyHOQgQHVy+SjgXiAxs4T6DCxT00GOZMA0aTw+lwySzhznwOO/qHEXPBQfRzeXIgJd
         hQve+RzCwaOFq+gWQMa7eMJhRwyhGrhOqDh0Ex52V00v1doXQGIdx73x7bRLw2m0iIsA
         aIsCMGSwPO2laJnXuEnl6GZ9EuWN4SWG6ISBIQADSAmDjYilw6lSY6cmh/ZQm/teEaLR
         l/jOVIdMW2yiSTC/kZq/Vm/KIYBaY5W1f1y/mCUcu1miq/TtIjey/cSnZ2EaikiTK2ZG
         qsew==
X-Gm-Message-State: AOAM532jHGWIZHEFJ0++TbK1ruzmCBESjCDIrb26AmtKeCwv9r7xB64m
        HU0xtEJzwX8NQP2XDdWxoJGExW5Jd8H5mw==
X-Google-Smtp-Source: ABdhPJw+R4AnFERUwwJgB189yLFt8SjtZhmvxz1D0/4MTDN0Jjl1khkTtk96AgE9PSelUkEZ0aC8mA==
X-Received: by 2002:a05:600c:b47:: with SMTP id k7mr7109119wmr.103.1632264051363;
        Tue, 21 Sep 2021 15:40:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] help tests: test --config-for-completion option & output
Date:   Wed, 22 Sep 2021 00:40:37 +0200
Message-Id: <patch-v3-7.9-cc031c8d339-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a regression test for the --config-for-completion option, this was
tested for indirectly with the test added in 7a09a8f093e (completion:
add tests for 'git config' completion, 2019-08-13), but let's do it
directly here as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0012-help.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 69e385d3b66..25bbaf0d586 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -41,7 +41,8 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -g add &&
 	test_expect_code 129 git help -a -g &&
 
-	test_expect_code 129 git help -g -c
+	test_expect_code 129 git help -g -c &&
+	test_expect_code 0 git help --config-for-completion add
 '
 
 test_expect_success "works for commands and guides by default" '
@@ -96,6 +97,20 @@ test_expect_success 'git help -c' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git help --config-for-completion' '
+	git help -c >human &&
+	grep -E \
+	     -e "^[^.]+\.[^.]+$" \
+	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
+	     sed -e "s/\*.*//" -e "s/<.*//" |
+	     sort -u >human.munged &&
+
+	git help --config-for-completion >vars &&
+	sort -u <vars >vars.new &&
+	mv vars.new vars &&
+	test_cmp human.munged vars
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
2.33.0.1098.gf02a64c1a2d

