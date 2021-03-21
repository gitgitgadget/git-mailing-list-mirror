Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A8C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E3F61941
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCUWhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 18:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCUWgj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 18:36:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B5C061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:36:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so14737481wrs.9
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVPbWZ5GcpzSmelh+15tD+j7SotqyPCPJYmJBHvPNb4=;
        b=s6Fzp5BYADh1WP2YahUDvkjeyrkrs+9DtEY59KHkNAlnm4tKPAvJX/01ZHm8W7jkbZ
         N9syBijPmTvz5R2HO0KLXa0VJPVvuFRO+8j8qt5SFE+t6kpoThsvXdnjquQHiTPcgTXm
         v52jiHTHw1XKLYCQnjhjNN3zt1ized68jJNoo1xZLsrbNm7OrWc+U2FgH1c1o+gONmI2
         FS6Hpr/KNOCFYfUb6xnJ5/PZZFJN05YaC/2KnPs5IoaIMIdctACpiKjbaYW3ynBPXm+U
         R8hVPceCErZ4eDx/NqB/7lmEhrUcJ1ENF8q8PgJVOxYwqtFk7ht9NBs81nrlkXSEu4B/
         qRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVPbWZ5GcpzSmelh+15tD+j7SotqyPCPJYmJBHvPNb4=;
        b=EtSFRkGknhiddF18TeS44LBbCON4eHSJV/JoXg5YWO9FoX0aNvWtecxWOPrNxaSfVK
         yG4862dtMVV0AISsUOk5wOg0R78eo9m20XOz5TzuGviwocfqWQ5H7wC904EUEGEFLK6T
         XLY/9Q7OQcTywEmf2CuQnTRRk9+/ILlO9EFYqO9mcn1XE9vUrpGlyrhn5ZBeJaK2VYwR
         59V0qhdZCb9D3TX0bqM4J4lWo9BpPdoq8GKbK3Gq7zsv2XmxabWUM7SMxm16hcUArGfY
         tyX4QlMsV5Fz61p1mq96ya/XWGuwFPNllhEOSydTRXWRSQxxAjQeKb4xAf6ZMxQHhT6P
         RplA==
X-Gm-Message-State: AOAM530ezEfoc2AfrWq3itNlXO0G98R3dz0BGlkPqRURgfHgqQOQILU6
        AOtUJo/z2olLZEtbClZfPQgCepGSg7gugA==
X-Google-Smtp-Source: ABdhPJyVQW8qDDPYk6I5QQAd3VjCFTD5JKwTnmCQp7onv3qDYyn7+0Ok/3y8k9Mei0wmffXevcD/Dw==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr15077927wrc.138.1616366197293;
        Sun, 21 Mar 2021 15:36:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c131sm14922156wma.37.2021.03.21.15.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:36:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] diff --no-index tests: add test for --exit-code
Date:   Sun, 21 Mar 2021 23:36:19 +0100
Message-Id: <2dbc6c253e2725819602fd5a09f491a8bc14ad8e.1616366036.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616366036.git.avarab@gmail.com>
References: <cover.1616330120.git.avarab@gmail.com> <cover.1616366036.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for --exit-code working with --no-index. There's no reason
to suppose it wouldn't, but we weren't testing for it anywhere in our
tests. Let's fix that blind spot.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4053-diff-no-index.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 0168946b639..44b932fbb20 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -16,6 +16,11 @@ test_expect_success 'setup' '
 	echo 1 >non/git/b
 '
 
+test_expect_success 'git diff --no-index --exit-code' '
+	git diff --no-index --exit-code a/1 non/git/a &&
+	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
+'
+
 test_expect_success 'git diff --no-index directories' '
 	test_expect_code 1 git diff --no-index a b >cnt &&
 	test_line_count = 14 cnt
-- 
2.31.0.285.gb40d23e604f

