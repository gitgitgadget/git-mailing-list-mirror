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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A742C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3030961073
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbhHZMXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbhHZMXS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05827C06179A
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so4793959wrp.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dp5ASmgFpHbEf4l9++NgoaQQA3i+VNhErYSMWvhk0hA=;
        b=kgY50uI77HUCGgERQ7fFu0Ru0GprOm72kz7ENyBCk2MNdjfhe8amnsaIZjZkb2Kfk0
         w0oOJ8WkJVOuFrPxq/cmiWgB6BCmyPW9VvBv7hPZTau1VdAWselLfV6+D33Fohtvamy3
         vkhMmn11ctnfM7gBeW2b2m1Z1+gV/mibhUpxJtdkjZ2xSYk7BYZLVq7BEGDBQdZ6wY8B
         QEQ7yoFapmIMxSAfaVuUXoXfLzkV+waGjumhk2yUxsNtoJWGBPLw1Mg9+exKR+1W7wSp
         IpofZzNQri//brES6tiaSbMMSLcMPjUchUL2vqiMGbggGEucfRJAg8Ppo9Z8u+Mc1v3j
         T1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dp5ASmgFpHbEf4l9++NgoaQQA3i+VNhErYSMWvhk0hA=;
        b=CiEDzlh74bp+hZTdeAJd8wefHpJb7LoogaM4//fBooCkZ16i6gsk0C3R+Xw7QQoEP3
         gAhukrnNaIDcRXi3UT6GpULNV5EIj/DZ6Nv0GI8gOExk+zdWy1pNKcDr/avVwwxht6Ju
         4p22nXix10oMe9GX91sOa3yBBX6Qt6FH1mX6OnTxbVCN81ayGp8eJxNLiefDL70FxzkP
         N3Dk2tuPQul5dHp+uI66Tgsvr1l1vdApRott8a9hDQL8x8Rh0twOujxcPooeScumqnkO
         NyhuixXiRs/OWN+P6FqytzUBY5UAieKQhf1d05naCtZHLOsPy26lH5YfSBQGGueUcPv/
         Ellg==
X-Gm-Message-State: AOAM531Y8/QU/ba00+9hqtaIj6BXxDoZULRmATGj4DcfLBA4rs/ecNmq
        NGe0fDj8yQvgbQjeUfmSK8Am/SHLGrR+KQ==
X-Google-Smtp-Source: ABdhPJzhNsVmhafUPh/I2oLBjXBto3v0wJuJSh1Qe2wMxPIpmqQsXR1jmNU9hRz+qN6ozXllxJRkqA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3524560wrr.375.1629980549424;
        Thu, 26 Aug 2021 05:22:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] tr2: stop leaking "thread_name" memory
Date:   Thu, 26 Aug 2021 14:22:21 +0200
Message-Id: <patch-v2-3.6-1d835d6767e-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in ee4512ed481 (trace2: create new
combined trace facility, 2019-02-22), we were doing a free() of other
memory allocated in tr2tls_create_self(), but not the "thread_name"
"struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 trace2/tr2_tls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 067c23755fb..7da94aba522 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
+	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
-- 
2.33.0.733.ga72a4f1c2e1

