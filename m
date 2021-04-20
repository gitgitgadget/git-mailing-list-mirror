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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065ECC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D1F61264
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhDTNho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhDTNhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD6C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u187so701014wmb.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93JzT/X8Lq9M0rfcmdi54FEWCuPfn1NVdNk8bq0QCJA=;
        b=twkspK35VC6oIl8zIQHIY1rZb+TR+aeWztCWsJc17AW9mrRUl8HLZ7C8GAw8n3sexD
         ynFn2ii4FDL8XchrxdEIjoh8CDyWQJcOqBR997hO/6yc8XsYCKiRxO+Uj6B5OOeRiCNA
         J4/EeT1TeR325HY/wxOaYhcEdTDYVPRYHgmwv0ltL/i15DeIc/wihCf080toDqEmhHbK
         S/eY9G+TN0NYIblKB25RfMTCqGtVbeADqDaZO9envaaE6ObKuALsoKQ/mf1cVYaNciZ1
         UZ50CX0+dkfKRosLYr6xv5VAFhwejKiM5K5Kbsvw2GzD/OC5V/KXICvxaDzLI9HNkEJh
         uALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93JzT/X8Lq9M0rfcmdi54FEWCuPfn1NVdNk8bq0QCJA=;
        b=kx7dKtCJW7fWD80HGVyA1Y3PL7B1nRrROUzjk7aGN6C/ti2CN8sNF/PmRndo7pPjB+
         +Ru4rnN53H5DTkwSKZzE+Cw8rZk14Rk92h4ar1zKTTs/2vdspOcwG4+pttVtPRBNf7jm
         ZI2/MJI8ItFzfVQg2AwUYuxKvUWvhhOg1bG80YQzpBAqFn0iGRWcMOuzRdC8ONEysuzN
         SB369pVQIGKqdrnGCNb+0p6zGFprymelQyWTHPBN/fAGFQePhE7eTbHphPvi41OPc6Cz
         MtN0pq0oaSJ+o1UhObImT76Fh+u7TpCgbGCFnBqcRZsWqAX1p2Cts3gCGuuixceztJsN
         Jl2w==
X-Gm-Message-State: AOAM5311BoFCYd9UG70XrtRJIzgHdIhg+4p6BwUuLlpvecQDXS2+/Xt7
        4oZBV0ngiFlsV5/368ZGThHAha6NAw7drA==
X-Google-Smtp-Source: ABdhPJxapVvMKvKH6iTTgSQf1pkBjMYWSZ3Qh/vTwTGqF9XZxcJNTTWkqYTeTnuezByMJ/n+ail1iA==
X-Received: by 2002:a1c:bd85:: with SMTP id n127mr4542947wmf.37.1618925826958;
        Tue, 20 Apr 2021 06:37:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] commit-graph: use obj->type, not object_as_type()
Date:   Tue, 20 Apr 2021 15:36:56 +0200
Message-Id: <patch-4.8-8e43d44911-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a check of a deref_tag() return value to just use obj->type
instead of object_as_type(). The object_as_type() function is for
low-level use by fsck, {commit,tree,blob,tag}.c and the like, here we
can just assume the object is fully initialized.

As can be seen in plenty of existing uses in our codebase the return
value of deref_tag() won't be an obj->type == OBJ_NONE or
!obj->parsed. Fixes code added in 2f00c355cb7 (commit-graph: drop
COMMIT_GRAPH_WRITE_CHECK_OIDS flag, 2020-05-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd86315221..347d65abc8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -158,7 +158,7 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
 			   NULL, 0);
 	if (!result)
 		return error(_("invalid object: %s"), hash);
-	else if (object_as_type(result, OBJ_COMMIT, 1))
+	else if (result->type == OBJ_COMMIT)
 		oidset_insert(commits, &result->oid);
 
 	display_progress(progress, oidset_size(commits));
-- 
2.31.1.723.ga5d7868e4a

