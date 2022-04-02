Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEABC4332F
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354589AbiDBKwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354580AbiDBKwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4AC141D86
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id yy13so10742704ejb.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0A4tpYlR2mITnLl3It5BKrIhMqbrVBSpv8XWkqVpoc=;
        b=lA94DVUX8HdaAeNNo7WzTy1+OGVOQcYXyRyAvNBN1Y7SY/38x0X3PSIXsJLfxeJvU0
         HWuWMomDuFvk5RbaArSji4l+BZWOXve1xyd9mp1qjObn+uaLvm/FGGNN9HHp0L+34Qsf
         UC7TbQ4NfkUAxHWrql5gTkiwyFyjEszr82gHzAMhSChn3MZz9bdYbhPcUDbgFj2aD2uf
         7l61XosN4YcKNL1zCJS+92/wczELhUePCZnhfdDeKyjYol39E4QfZXGi9ekpolnnd2i9
         FYyRg7dMWIn3wEOc4e07bj2neFDdAif+IjiFzrmfmsFEOrGKoT8YVnWBjZQrYaAr4RM+
         kxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0A4tpYlR2mITnLl3It5BKrIhMqbrVBSpv8XWkqVpoc=;
        b=SpWGSzidLfRkBogQ9ZJzQ0fuIDvfDD9/Vbs/XyZh1kGP9YhuRR84YmxKyCOU/p+YEs
         SJDdoycRHujTk7bRKy+eqQqpJ/MxNd6YaK/zymDhL6JIAWyvOQbCfCG2cPfleHNcJnbI
         BKF5cXdMICMglF38sC/Wj+8dA+OtBgcZS/5wY7/c5TlWoxOMBAyWN+KVHmhoh8oUyCnE
         U2cOkHAdpqhbp0IhnPfmX9hfY5Hz5ReqwwJQVP1A6enaCy+7+fQPH43KBRN1aRu/E0/B
         LWYny20+SDB4Whi1QkkOt5yqA9bg7fpX7+TwP2dAP1ZArReLVx23BzMTVDJUbOLOt5q9
         EMgw==
X-Gm-Message-State: AOAM532Odh5OEX2ZFHljzxc7Dz4KgZxAZWGRpvPUxEdd2WZxaJsr96Qt
        FgKt9o8t2wM/i4+KVEsqAUG5AiB9gblKBw==
X-Google-Smtp-Source: ABdhPJwoC8QGeig4PkBV9fRRLNNQ0cdWNuzWUHJG1mtAl8dP0sxEhKPr8jzr4VIeqFB1NT8qnOT7MQ==
X-Received: by 2002:a17:907:3f8c:b0:6e0:6970:dc87 with SMTP id hr12-20020a1709073f8c00b006e06970dc87mr3368156ejc.236.1648896609347;
        Sat, 02 Apr 2022 03:50:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 25/27] revisions API: have release_revisions() release "date_mode"
Date:   Sat,  2 Apr 2022 12:49:39 +0200
Message-Id: <patch-v5-25.27-d428d752462-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
index 8bc777da828..ef98e4711f3 100644
--- a/revision.c
+++ b/revision.c
@@ -2953,6 +2953,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	clear_pathspec(&revs->prune_data);
+	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
-- 
2.35.1.1585.gd85f8dcb745

