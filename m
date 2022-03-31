Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F1C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352293AbiCaBO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352279AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BCE66F90
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so31544999wrb.8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GF26u2578D6NwjIb7dInK8uEsFHPbW/Nlc6GzKdah0=;
        b=AJ4kLppNA9M0uq5urMWeWuhtLQ0UUsQbpE9xRdlnpSkM4/ihmS/GZ/5KBTDMKxGR0S
         DmAK+YKhICmJmp0KMbom2tU70NpIKUo+9ctywS7fjwSkONT6npJ8ekapMoVvzLm4iZHa
         bbS9otpflmxq/CXTCvpg1+ZR7XwKVfMjKgfXTHf7clXSnxtYW8jUuNWKWQJPIPFylPiN
         3QDHT7XE3mpfaKxuLoPmubB4n1ifxYSFbbjdEJx+ITx4DjkNqIDW8Y4UCK1SVLV8KFGm
         sEJ5eNmAL7F6zxN89xIDHAfSsgcIOdoTyYwdQfpheQR4XEJE1RU8OdlF+1Glap+H3GLM
         PPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GF26u2578D6NwjIb7dInK8uEsFHPbW/Nlc6GzKdah0=;
        b=A7YSqrx7UGNTwx+uN/di8ACs6cOGNOgULWg0r+NMG64vX/IfzILgYOnz7BN8Rj26bG
         g58nX9+c48frfivh/uf2Hk2IbdGO+LUsjav6i2e9UYNE4peek2CbiFD/kxKdIefIZw43
         ZBZXB4DDKz9TsAh1UFeFX1CCDdEqd7jxfcwCtaW0Xz3WpzFRu5oYwR/qh/aN6A9/9jw6
         0A4rO2odV0HodXOk/uAgbKwQ8nLHttKAY9l+vKZ1M4RMTGCsxydD1haOdTy4Wg78UVcn
         EpRgbHveiQYHxY93hlEqllLfE4tmHCLmmf7lznQyWxcIMx0PEkj945PO/SShEdr4Gn1/
         HJRQ==
X-Gm-Message-State: AOAM533EwgLod08oEVJlyrh/86s0U47hwdiIXeLW3ldntIbLQ4RFd4px
        GOpGpv579l51E3diZ1NP5KzEM9XvfWcbqA==
X-Google-Smtp-Source: ABdhPJzUqeiGNglnNdQZObtOq+nm9s/wpPNT49WNjn1Jf83YLTdojDQQ1FJIyIN/BzRHnz65f1ymng==
X-Received: by 2002:a5d:47c3:0:b0:204:5b8:225c with SMTP id o3-20020a5d47c3000000b0020405b8225cmr1999526wrc.474.1648689147050;
        Wed, 30 Mar 2022 18:12:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 25/27] revisions API: have release_revisions() release "date_mode"
Date:   Thu, 31 Mar 2022 03:11:30 +0200
Message-Id: <patch-v4-25.27-9a51c1ae1d1-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"date_mode" in the "struct ref_info".

This uses the date_mode_release() function added in 974c919d36d (date
API: add and use a date_mode_release(), 2022-02-16). As that commit
notes "t7004-tag.sh" tests for the leaks that are being fixed
here. That test now fails "only" 44 tests, instead of the 46 it failed
before this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 6490179fb83..31fc5e58da0 100644
--- a/revision.c
+++ b/revision.c
@@ -2962,6 +2962,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	clear_pathspec(&revs->prune_data);
+	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
-- 
2.35.1.1557.g4e3e9cdb5e0

