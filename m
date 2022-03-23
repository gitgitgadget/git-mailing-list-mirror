Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B543C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbiCWUfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344791AbiCWUef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E68E1A2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h23so3766349wrb.8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsqFI9opocwr/GlQp+L4wNXaZXQbygYv9CoLEZxxN8o=;
        b=MfGqDJdZf0ZtlKUTxXVB8oQbMzCBqPJINHooDokYKtMJnXOX1Q0MSHU/qxnHG4JSc1
         OBRe6Rrv1OdVowkbA3Rc8KxNqjPJmuZ+K9vdFDpZWjstch+DAnFW76jDLYwC3hS5Y2hG
         24wo5WllUTuw+j5i1Kdh/kRePVBogYDltHppvBZw85TyiaOML41r+fbSClZ5PU1zZgiz
         AITzUG1k7Bij6TOBGbcKeieRhlSYO0hOtDrSKtKMoyNqXJX2/nT0p6hq3AOg00WgQsdy
         h1ZOuMUYI3OY5qwj8RO7BuOrsi8cqOPOKsDUxQM60q4mEvzqpPC1hKvtXPJYeqBSQGXF
         Y5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsqFI9opocwr/GlQp+L4wNXaZXQbygYv9CoLEZxxN8o=;
        b=0lmszdLNKseYUYb4otQFwhcaKBTj3H8t7A2oUz7TzDfnHnxGR6WXorhmUheHPjGh4Y
         LtiadyWp/02tpa3yFhHEo/xE1otmerpkXfaz6i5yxtkq3CKd1FZcFh05odv2aJvUtIw8
         Peqjvh4G2Oa4mu/lfieTc4ZJ4a1wDiK70FHDxYxRl3FQmfA4H1awgP3yLJpERatywKc1
         aJ1v3ji6/Xnt9HF7cVsBhV/H6WIHTX0gtczbi7VOD7ZVv5WjQFkwFHuMxcXa0xSadDxy
         UorPtaig/tvmEzcSSP2+FTn1qYaSScMbTcvffb36/sOfJv0I+x0EDuVgJzbOyTK3lp0B
         LGSg==
X-Gm-Message-State: AOAM530CkglZTvKQAZIEnbT/8CevBtwZ1tQ4FcSEBwUQNW1cphwor1q8
        DubaHpIfw6Z+LpMel3s/EuLLyDpaQJx8mA==
X-Google-Smtp-Source: ABdhPJwYu5lW/9yxQEsvZRsOHIhK15dHEgGmJAC3iDJhGcaT9BtKqL3GUyJ3mfIEx5R8cMeOUseACA==
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr1561069wrm.619.1648067568799;
        Wed, 23 Mar 2022 13:32:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:48 -0700 (PDT)
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
Subject: [PATCH v2 25/27] revisions API: have release_revisions() release "date_mode"
Date:   Wed, 23 Mar 2022 21:32:15 +0100
Message-Id: <patch-v2-25.27-dabbb430ece-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
index 32e4d10f27e..62dddeeeab5 100644
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
2.35.1.1452.ga7cfc89151f

