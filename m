Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A0C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiG1Qao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiG1Qa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7F13DE5
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h188-20020a1c21c5000000b003a34ac64bdfso1142175wmh.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3sx7UQy+f0dM276fdgJp58ZCerfns3AYz/F1d1kqems=;
        b=Mp9ciN6aswOHHm2QNNbvk9gsLcSjwkgozgOi4H4s12hDcOr8A1Reu/20JTaCzdukV3
         2DQl8Lc4kMZuPBhTaGUvyiYzAYUoOZlbCwJk0s8+1wH4qaFQ3e4H+klRf4cKg58ixDdc
         V4XupNyoxtU90tOlTpLGhHWla2tcozqi7jgBgqNVj8lbmzn3VgF5+/dW/g5jt4yEYX8b
         Q9gWzXce7fPWyjj8ERHr3viSkxD5h1Uus7Y27r6aCTzaSTYPVuMHVSpqBO/+jaSn6zWU
         Z8My71bm0HC/5Pg/M/Dny7nmddmkMpLxvwM16Sl3BC4lN3rPXhsafFUoY+SbCd7mN+L+
         +P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3sx7UQy+f0dM276fdgJp58ZCerfns3AYz/F1d1kqems=;
        b=fGGlYr8HKZ0sWM0QAP0kyaoYzTU1u0sgXSyoo72BTx3X37Yx0NP0SZizmcjqXJ16BN
         qG/JCJN2/XjMDWgVF7bd0Tz1lEvDb/C+0IOgj1/RSVHEyKEHFXEL2zOQBgve8hjgoQuF
         MEFo136mTw2M8SUvGiRu4amK4Gm9aRd704mW6XuDaN8vQFqkvgqeKl7dXUZoO63PZPbT
         /KRxPkOD3Q3Uf5UK7kGRoH/BMo65nmwLThEk3K4kxhJt2VG3jeSnpGIkkpG56EcoyreZ
         xqcM75wkVXNQFj+GxfMUmXc18GlMKHudGKsTOjlvCOekNaEeX5AMUTEkKI1z76pgWIRQ
         y6Rw==
X-Gm-Message-State: AJIora/81fL0AdWLf7xj2RlFeORDf5gkqbdWt9DamjR1t7vfJW74Yzca
        a7O+Nay92uFre+K22y+1TZA/0zBRlL6USQ==
X-Google-Smtp-Source: AGRyM1u4KI0Wrz5lanIc95Eq3vCfYAowcanyeQ3YnODE6EEo/n/b9dTJ4KZHkTKMQmrTR1q+IEMwkA==
X-Received: by 2002:a05:600c:3d0a:b0:3a3:561c:a9c9 with SMTP id bh10-20020a05600c3d0a00b003a3561ca9c9mr144734wmb.1.1659025824413;
        Thu, 28 Jul 2022 09:30:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/17] submodule--helper: fix "errmsg_str" memory leak
Date:   Thu, 28 Jul 2022 18:30:01 +0200
Message-Id: <patch-v4-07.17-d4c81e04254-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13), we sometimes append
to the "errmsg", and need to free the "struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 48507a6e0df..5cbe6a41e5f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -960,6 +960,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	free(displaypath);
 	free(src_abbrev);
 	free(dst_abbrev);
+	strbuf_release(&errmsg);
 }
 
 static void prepare_submodule_summary(struct summary_cb *info,
-- 
2.37.1.1197.g7ed548b7807

