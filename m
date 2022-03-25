Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787EC433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiCYRaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbiCYR34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C6167E1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:28:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so9383100wme.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfvHJtlpu5EDELzVgDjDwVufXrvVjqOeSahjWQCVp24=;
        b=JDR8Zq28oAYc5mG/GqoUmAW0EHrNglBQV1cKhq2XR7H3QmN7rAJaMc4zcq85h2ER/k
         JkFnK+8jWG/0G33KRpzN2eXM35SqXsAgtroWwF0KvlJ6SeM28xDEctXoMRQq4hHvSMav
         b+HVdN49Nf0GblGeJyN3I+5Oka9cTo1zqjew/I7KKFM0qktFD/ufMLCaycL2j7B+8ThM
         ICwZgjiXdER2oQ7+53xOSD1kt8v6T1W4FoLimBJfRvUXQyPEc3NboQ4PrqnshFXgoBa2
         QBgRtMdSZ3+2/GwidcEDQmDq2M7vza/ysiTXex8PDKGbWMQqvtMg+bHW2j2+mSA09EFA
         0npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfvHJtlpu5EDELzVgDjDwVufXrvVjqOeSahjWQCVp24=;
        b=OUdDv7w2/xuVf/+yp4apdM5+zs1bOItknrze8kAoPKfZlCN8rNERVDDyy5E272g8+S
         oy5KlMYhKcJGVHk59vAABF2VA3XLQmyA/PjKGNWsqclUlksUt5uUg9QtRBlfMjif7sCl
         QAFDcnVrHaKOseRuGzZVwCBPlao6s590VdGpNyfkylf7VzR6MYOTlOMmRV65RxKo+wRL
         I4zT7Wv81YBZV3tYDZcBvYdTRAdoYGUAivayZQlgGPZLIJwe8iYv0V6zCJZm/ewZh1B4
         +pPdCzMAmEmB994WOGQ1Q8/zfKkACWM/W8D9u3px+VVm/6XS/CmhmVO7KtJ8jamkXPrr
         RZfQ==
X-Gm-Message-State: AOAM5328JFlae/9FcSMs/DkrEDm5xp6j3Yw9EnGou+xVJaT725/fufLe
        7QpHYhmWS4OuKf5g5ynn5umz6GXRS83bzA==
X-Google-Smtp-Source: ABdhPJy5P06xnGHkkS1Vlh3U/xkwHpbk2G/oj8O+XsyN4s95gQlT9dHcv0KklSCZr4Sl+AhIW78RsA==
X-Received: by 2002:a1c:f719:0:b0:381:ba:5247 with SMTP id v25-20020a1cf719000000b0038100ba5247mr10931870wmh.183.1648228795027;
        Fri, 25 Mar 2022 10:19:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:54 -0700 (PDT)
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
Subject: [PATCH v3 25/27] revisions API: have release_revisions() release "date_mode"
Date:   Fri, 25 Mar 2022 18:18:49 +0100
Message-Id: <patch-v3-25.27-0eacbd66711-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index 9ac06e4d285..49668012ed1 100644
--- a/revision.c
+++ b/revision.c
@@ -2958,6 +2958,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	clear_pathspec(&revs->prune_data);
+	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
-- 
2.35.1.1509.ge4eeb5bd39e

