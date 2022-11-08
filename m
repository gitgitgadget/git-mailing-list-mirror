Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2313FC43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiKHSTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiKHSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EB35E3D2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id q9so40922196ejd.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE7qy6enBdSqTWZxEtVL6T7HlCuYaR9JanWzaosNhiE=;
        b=bNLtLuloXPG/UYEdj3CrKeJ6W1qIo+PZDfqC6UBiVuWM4GeUB9S6qwJPaD1BXq4gum
         dyHrUN7CQ+Hj0CzIWgq2xmCKE7/EjFpRbrsVsc9+zaTK/dIef7jKUOI06paatFW5xYcl
         jPbw62/YfGdnaeSV8LLxRITeVT2/f7JHJrVNnsAqqvAF+uydOg5pTXAeP+8CJByeZM6f
         LihPtS0ZJNpPZWbjUn8I5f778Ed+F8ZObmYjFZYzg5PL/IAjnLFkuVqP9rg895CgDKLZ
         Ci+8e4uGBs1iUvBdE41UbFF+o0qad3b3U6v65p7xX2hdx0pNBpH3g7l2VFBnsPhORX7E
         oyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE7qy6enBdSqTWZxEtVL6T7HlCuYaR9JanWzaosNhiE=;
        b=DVtfSGJ/iVWfMmihgvJWu9+WCr7taVbW62gj3/WgaqZkXoMXFCix/7sywbA0vVUr0T
         FidJjNMZoGrIiWKpy+0rVAEFRChj4JHj6b5AZVHD+lT6S9WxpAQZwCzH8ti351fk9Xq+
         rCrXxKu3tumxtN/BZEOBmNuRSNtdpb8dpAhlgwccPmiC/0cb5WHkOCFn5f3rJUSfceIa
         e6Iq8l00kmsuHu7VhrsJQsVQChR8Ri0E7bmzIrxziF2oEzZO0lGL7j1GBF6ZqoEnc9zd
         A6hQ8r5ujbltbsoP94uWKxKD3hD7COxhpV53v2+70lBOcgfzNXzWmMw1wJGX7g2yflrL
         CZNg==
X-Gm-Message-State: ACrzQf2jJqqtkV7c62LmZd80Oy8zeuZpAywil5aMeLQBwQ9AaReTnKiT
        DKE2bZzTBt5flZGPoD7WLzk5i3t9XI9s/A==
X-Google-Smtp-Source: AMsMyM4iFDjTkdlolH38BjZeKLIaae2kEqP9gWP437YgvSngDrr3svaLmIFoX7iw+nbY29Q3SKtQIg==
X-Received: by 2002:a17:906:5a46:b0:7ad:b822:d2c2 with SMTP id my6-20020a1709065a4600b007adb822d2c2mr51473502ejc.41.1667931485753;
        Tue, 08 Nov 2022 10:18:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/15] revert: fix parse_options_concat() leak
Date:   Tue,  8 Nov 2022 19:17:50 +0100
Message-Id: <patch-v2-14.15-614c8fc1aef-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free memory from parse_options_concat(), which comes from code
originally added (then extended) in [1].

At this point we could get several more tests leak-free by free()-ing
the xstrdup() just above the line being changed, but that one's
trickier than it seems. The sequencer_remove_state() function
supposedly owns it, but sometimes we don't call it. I have a fix for
it, but it's non-trivial, so let's fix the easy one first.

1. c62f6ec341b (revert: add --ff option to allow fast forward when
   cherry-picking, 2010-03-06)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c            | 1 +
 t/t3429-rebase-edit-todo.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0f81c8a795a..8bc87e4c770 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -221,6 +221,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	opts->strategy = xstrdup_or_null(opts->strategy);
 	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
 		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
+	free(options);
 
 	if (cmd == 'q') {
 		int ret = sequencer_remove_state(opts);
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index abd66f36021..8e0d03969a2 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -2,6 +2,7 @@
 
 test_description='rebase should reread the todo file if an exec modifies it'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-- 
2.38.0.1467.g709fbdff1a9

