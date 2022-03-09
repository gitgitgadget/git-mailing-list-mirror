Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEFC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiCINTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiCINT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720A179A01
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso1454294wmr.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIrXygs4o+TPlfEPMygxwNEAcKRGKrD54ak/UVSj+Og=;
        b=G/NYdcnkqKIpTUXooT8dtcMEmWF0fh/RiC4Adj8/Ns+87C0zGZ15uhIr3WKknhE0uL
         wnJWAjQGpudmlp9Mt4PeF1KoSHcDTuQTm+k8/djf+5xbyOXyJ5pSo8c5+gMj44HlD18V
         QM62N1pAwoMcduuVO6u0hFuMD82X8Q9jo+VvG2VyBjpDHxYrbK8bjykhCduBNEmwxmT6
         Lge/aKxjYxGlV5mAP4M90k/5iqpDo/Mw7SuwafHLk51K8aKFECfooJnXv21alRICVgHV
         BuZUz6iHDFp4NFaSlmW2CY17zhkjnP6qySV+yZ+8wFkhhbyM4KcTLp/xlN/WVXzAtAXz
         rPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIrXygs4o+TPlfEPMygxwNEAcKRGKrD54ak/UVSj+Og=;
        b=zGP8GHaXm5qq2RSi1umiZ1AOiauAgh+t8tKHpZ9Pmu6Cg7eOjQ5OItCfqFr59HLlny
         1zBOxTHZJ6T3ZGLVjaq8zBQWv6gPQIucAOk3NJItO9rKFHp2CxJ1DdVx90e7zVfa/TVM
         eksJ4ySzlaZRZOYGLIcuLcYqq/744+705VVkPg3NuWN3lEa3aUnpQbqd6nrAY8tbMUQi
         pIQZUUpSDCb/oqq4GrfqtnJYXMb/mijgd9M/8hWdClHUhY/Glc0AhxYsN6DduViHEFyh
         VaWn6m/sXOpRB/wImS7lENVK0jL7VA9h9p7+/IgRVj83NJ9Zqhv2nQGggZ5XgKzOInxP
         V4Ag==
X-Gm-Message-State: AOAM531sIknDu3Jo/xx4fxdBMhrt8UKvbQJ28HDfYJMnJaDfwxo9bjHo
        jdeR7PRoLOo8ycXgjOYt+TJO04nkgufEQw==
X-Google-Smtp-Source: ABdhPJwFYwHIBp1qfFYPv2rR364toeNkMjNdnIT/gsV/8ImUH3zdJTIP9uHQFOLpc0RlxXAG2c+RaQ==
X-Received: by 2002:a05:600c:27cb:b0:381:400d:3bba with SMTP id l11-20020a05600c27cb00b00381400d3bbamr7644889wmb.60.1646831884348;
        Wed, 09 Mar 2022 05:18:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:18:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 23/24] revisions API: have release_revisions() release "date_mode"
Date:   Wed,  9 Mar 2022 14:16:53 +0100
Message-Id: <patch-23.24-fd457f0d85c-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
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
index 81f4a36fc9d..9d03e7805ff 100644
--- a/revision.c
+++ b/revision.c
@@ -2954,6 +2954,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	object_array_clear(&revs->boundary_commits);
 	clear_pathspec(&revs->prune_data);
+	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
-- 
2.35.1.1295.g6b025d3e231

