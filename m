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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A9C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459F26135F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhGVLjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhGVLjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:39:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330DC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r11so5707476wro.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDDmT+cwu1XitVL3ZnCajAm++HbGjdAsGYgNSbmDXB0=;
        b=gh5SE028LAHGKcTkZM+VBUWcOGz5LGnBFWcBtu5MWBCdf/FaulnFFfyyxEvyeh1Oxg
         eZiMVVXvcXt2ltXyhuhMzp7LaKlS4XecbA+WdBvbKKZWPFUv+PO57dq0IIXdKqpYmVfS
         pvHXN06UuXpDUsiBWfgHMy2W4RTGNuL2XZFV5urzv5xO7LzUvVLIYFwSy89hvY2QxBP7
         U1ISW+g4MVwRGsncazCGOj/rfUB+nsi8cpLJvYzoVQ0wZsNwRQG9eNezI9tRJVq+T40L
         MwPnEZfZgbCCGX0hJaVY6mOneLHhW6oTvd2an0PrulcLiTI97kjWuZoepiZJlAbGZE2P
         HtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDDmT+cwu1XitVL3ZnCajAm++HbGjdAsGYgNSbmDXB0=;
        b=XUKFJgdB8QVBbLJQgv5A97bMFU0toMwi4XmdZ1jWx4KPNUoh4pCPh2uTDwm1N9KFsp
         6g/hKCge/Moe0CXpnyi/0/oBPjrNQrFz/qS0tfFwB6vOX+TXU+gmWbIpouXGZkqntLYE
         ZhjHswSpdC3UnQNzuvYcMTjSdlrNMKIPssnZprE2jxZWtQS092pB5r5+BN0BkSGjZ52C
         0rAu+/ygcs3iMoy6zwZkOZxmhVMnUFoMvA4ta9g2O2JVgtHL3PNoGPcjGNwwFb4OhD8P
         EGG/dl0DR9pL2hfmXVxg+F5Xg2BNE96V/9dxurEprzLNvS3t7TK36Yp/pFa/B06RAU8d
         5m/w==
X-Gm-Message-State: AOAM533G/7J+Dx9MiQMiEb0drudmwUolsFB8F+Uh7w8o9sWP8F9gNy5Q
        uL69KpDEjTgq9hGDn3FIAhSJCuEbTckI4Q==
X-Google-Smtp-Source: ABdhPJzohHx2cqttm4Ubgdbv8t6HeFR0dy9S/P3rkvuuYmdxnHD7IEcdZH1mDOs0/qoexXfSus3fiA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr48651357wrr.296.1626956421314;
        Thu, 22 Jul 2021 05:20:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n23sm23506991wms.4.2021.07.22.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:20:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] midx: don't provide a total for QSORT() progress
Date:   Thu, 22 Jul 2021 14:20:16 +0200
Message-Id: <patch-2.3-3411fe0515-20210722T121801Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The quicksort algorithm can be anywhere between O(n) and O(n^2), so
providing a "num objects" as a total means that in some cases we're
going to go past 100%.

This fixes a logic error in 5ae18df9d8e (midx: during verify group
objects by packfile to speed verification, 2019-03-21), which in turn
seems to have been diligently copied from my own logic error in the
commit-graph.c code, see 890226ccb57 (commit-graph write: add
itermediate progress, 2019-01-19).

That commit-graph code of mine was removed in
1cbdbf3bef7 (commit-graph: drop count_distinct_commits() function,
2020-12-07), so we don't need to fix that too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 9a35b0255d..eaae75ab19 100644
--- a/midx.c
+++ b/midx.c
@@ -1291,7 +1291,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Sorting objects by packfile"),
-						 m->num_objects);
+						 0);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
-- 
2.32.0.957.gd9e39d72fe6

