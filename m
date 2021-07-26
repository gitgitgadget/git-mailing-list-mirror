Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FECC4320A
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B29A60F91
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhGZXEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhGZXEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A556C061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so1118747wrv.11
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfCQPna/qO14mOzoWOOhf5Qt1GbTwFG3/kyFnef5MbM=;
        b=r8SCifHpz9XBH8I6A+oSpyKmj+qT21HvbT1ucsn3KURIp7aLk9sQ1a4FLyCc98KCiA
         uheFzI/rfnIXhyN6MGoBYTM7ydhjh/Eq05ef/vbULRZXM6tNlecPhEW21hvDM/voeJdY
         F4jSmaiBFE5RbbCigi1+dRXkMaim2F06mn36yubbHT0kuPgQMhXCES8VkbnuOXeJ+/Nl
         irWqDCVfRTlHL5q+RpuVJz3mV7NxWffm+kh1/z3ak9gOZhJE+YNrAO8Q24npEjnfOJ42
         nEsO9CBJa1I1hXCtv1B47D+kHga0VD9TWTxonLIKbJZ7zTQ0IsfuWHhss+NwxUGbZan7
         dBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfCQPna/qO14mOzoWOOhf5Qt1GbTwFG3/kyFnef5MbM=;
        b=U1kxC8a9ZU9oaIJiYNFM+gSandAmenFf/udxiRMceclxIzdPzGyX/Fr663bd/PUL9q
         TlqhXzqgoWrzWkSjibpMkX+yOHfyorn8/n+wynNMquIXnI0h7gEiepSgEY/l9SCBexu8
         LuzwTP1zbWiVZXxtehZRm6zZZZasEpX53zH2f8O4VpfIos4Ul2lcPxPD9QFbOC5O3Gzo
         Gw0WNzbeGASd6Z/W8egAnnWgLpG8eEo4/pwrJ/eIOBALqMwTsAvBnSfUlbPx1inlWr3E
         j/xTt8ILx1eBk9KShGy3qUsMzEVAbHlR982a7Yke2akGE5q+EYX8f2GO3xICIYkBlx61
         w+lw==
X-Gm-Message-State: AOAM533ixZcjWEQv8Le44uBXeGdBS8SPCEjbyvqm1IQTMIRJGG6mx1W4
        LfT1WZvE2te2uBedyHuVw5hFSiZpm8smPg==
X-Google-Smtp-Source: ABdhPJyIMV5Jt+eeo6dKB4tWgX1O0f/WcaafH1oAqjevhpZkVQgS1N1WumTS3+7neFx+K8ergv1VVA==
X-Received: by 2002:a5d:6184:: with SMTP id j4mr9404314wru.340.1627343071555;
        Mon, 26 Jul 2021 16:44:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/11] refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
Date:   Tue, 27 Jul 2021 01:44:18 +0200
Message-Id: <patch-02.11-67cd2331fb-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lock_ref_oid_basic() function has gradually been by most callers
no longer performing a low-level "acquire lock, update and release",
and instead using the ref transaction API. So there are only 4
remaining callers of lock_ref_oid_basic().

None of those callers pass REF_DELETING anymore, the last caller went
away in 92b1551b1d (refs: resolve symbolic refs first,
2016-04-25).

Before that we'd refactored and moved this code in:

 - 8df4e511387 (struct ref_update: move "have_old" into "flags",
   2015-02-17)

 - 7bd9bcf372d (refs: split filesystem-based refs code into a new
   file, 2015-11-09)

 - 165056b2fc (lock_ref_for_update(): new function, 2016-04-24)

We then finally stopped using it in 92b1551b1d (noted above). So let's
remove the handling of this parameter.

By itself this change doesn't benefit us much, but it's the start of
even more removal of unused code in and around this function in
subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd..326f022421 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -934,8 +934,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_DELETING)
-		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-- 
2.32.0.956.g6b0c84ceda8

