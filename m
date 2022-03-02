Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0BCC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiCBR2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbiCBR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1825FD16
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r65so1604895wma.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6VyXf7EcgSc6ABJcoZBJLd6bY76SpfXGUQYhq5MpIR0=;
        b=OOqxnI+pXtbO2xAzbPbtk6L/CRT6/xL/NMAc2tqFYwd//mnkSALiDgXCeAHzlrSwYW
         6juZkhMJdUhSne8NTLttzjYl2+GWYBrh25mX432OYEgDWJYvVpYayXSs4E01lzu5lgpK
         EH4MADMZ+EGOYz8O72GazD+CFI/9gSU7NWyfuGOZGNlZUTFfNO9mgTYNrCzBdyJycna6
         uCAjrQ1E3wBCi6SbjYZEQh08P8dKdVBCJRKnkZAdtipphIM9a1CTFs4XT/j1OLK93IG8
         xx+Uc6j3oWXVFD3J3MVkgyFm0PTjPukuO7G8xeAx/klHAd7997qPoVceBrRlpfqndzNA
         Vy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VyXf7EcgSc6ABJcoZBJLd6bY76SpfXGUQYhq5MpIR0=;
        b=xRHbmQsfFZnwGoxXW2S2eQoHcqMlk3eYdJZjWHHpXSaNEVCraK8hXwzJmZmRCuf1lH
         1Q/yAstLM+egIEUfjckMnRKFr7jMliAi9FHe00N2Pqyhg5ulN+9v2vjr+uvJBSzoJHVY
         4CmyAgXoVb5fRkml6eLIfR4E3b8z4eoNKYS1ssReqD2Lr0hzB6lrbhRHsT53LblRYyVT
         qXf6pk0ZIJdwDVjzhA+WTB/spIZY3o/pw1sd3uu2XFdkq5m6dFHlIv8ctlWhae2sTfMB
         cJOjiNJGQEnaHb6pWFQW48TOuG5k1dzSfTOUvv6zyWN12ZFvzlH0abeNPdcn/paoYDLa
         ocKg==
X-Gm-Message-State: AOAM530XZiQG1Rn8EDaiX3KkzAIyYXG2lydDbfIqdzUC+L7iqFSPzSDx
        E/5wd0iJLUDWWBmqogjmZW+Lihrg8oHuTQ==
X-Google-Smtp-Source: ABdhPJxUrWf9Kx2dIQ8o4guWkL/XKJ8QGS8dwLWWX8xS2yI4Kegt14TkgEFDrheOh2wAVNQItRchkg==
X-Received: by 2002:a05:600c:4fc4:b0:37c:9116:ef3d with SMTP id o4-20020a05600c4fc400b0037c9116ef3dmr649796wmq.167.1646242056994;
        Wed, 02 Mar 2022 09:27:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/15] rev-parse tests: don't ignore "git reflog" exit code
Date:   Wed,  2 Mar 2022 18:27:17 +0100
Message-Id: <patch-08.15-dca2ac3a171-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a test added in 9c46c054ae4 (rev-parse: tests git rev-parse
--verify master@{n}, for various n, 2010-08-24) so that we'll stop
ignoring the exit code of "git reflog" by having it on the
left-hand-side of a pipe.

Because of this I'd marked this test as passing under SANITIZE=leak in
f442c94638d (leak tests: mark some rev-parse tests as passing with
SANITIZE=leak, 2021-10-31). As all of it except this specific test
will now pass, let's skip it under the !SANITIZE_LEAK prerequisite.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1503-rev-parse-verify.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 94fe413ee37..ba43168d123 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -132,8 +132,9 @@ test_expect_success 'use --default' '
 	test_must_fail git rev-parse --verify --default bar
 '
 
-test_expect_success 'main@{n} for various n' '
-	N=$(git reflog | wc -l) &&
+test_expect_success !SANITIZE_LEAK 'main@{n} for various n' '
+	git reflog >out &&
+	N=$(wc -l <out) &&
 	Nm1=$(($N-1)) &&
 	Np1=$(($N+1)) &&
 	git rev-parse --verify main@{0} &&
-- 
2.35.1.1226.g8b497615d32

