Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A2C432C3
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FE264F2A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCQV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhCQV2O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CCC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t9so3297484wrn.11
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vNEoqUX4A42360elOoDcA6cH0Od98QxzvF2EIqCVNu4=;
        b=eqN1OVtMv2LxrRzQnv3ncBCFRsJ/l6kJlfKznQEZbvABrFJ6RdJ1o2PF7NtRHFv591
         ElA+//KAhq1VWwX162sMzgpSd1XcOSgq6q662MoI3UD2DOYXSiUOxHmcH/m7qsJZGL5L
         ByjZf0RDJb8W8FybP5CQduOGwy09ZCirqJZWBTL5RnYkR3tJYcfO0Xz6/2pfiO5pwBdZ
         4fhMYKckMkPr5GdwD3UaHyNaa/lx0/cwASuSosOXBHP/UYAC/2dog/1XjhmDBBdjOvwK
         vvezI6K1zOlMFc/9fF0W5P38ibUDI+suY27PfUsvCRZrlAOoFB+PQjgoB56xxkPWtPws
         7Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vNEoqUX4A42360elOoDcA6cH0Od98QxzvF2EIqCVNu4=;
        b=Wr+S76uTvH+/hLgMXP0pNAbhvVHuEeT5cdAA/FGmeDTbOFQy8gRIHVeE8sdTxyLEJg
         9EgRQboQFqya2hsYA8PoqMHuPebDhxhWGfC5G0N4awDEiz9fuvjXqKQ9tWEu4tal4V7A
         HDwST2yyO+OroKu49LBZkw2ip7gK50cXa1BWqKBFmfs8A2BhGkUF/EGweq4f0DvkTOvc
         ruKSNwnR3mpEDdQgHLLYCKmZCyrBIXdppYfwuKKzqe7Ng2gGDUj/2XctZ7EMjQIl0mkc
         NGaBepc/p8hHVwLjoWpGeX/ESjrMt64rsXCiqcOXUxh3xw8NO9bc/kWr7tn5xKVTIeKZ
         M9cg==
X-Gm-Message-State: AOAM530jbCbsCE0qd4iaTUI2t8ZdQuEFujqxejc72sin8wYO3NXwVoEp
        XpMW3WqCy7fZxLHMBMM9NDezjW3ft4w=
X-Google-Smtp-Source: ABdhPJzGocMlBK/7lGQcCgJlT8tCoAXpK/lyFwTVe2ei0/B+u1RUkOzZjMqX1fm8k264HryvuUI9iA==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr6210666wrw.323.1616016493236;
        Wed, 17 Mar 2021 14:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s20sm104709wmj.36.2021.03.17.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:12 -0700 (PDT)
Message-Id: <6bda855f29806475be14d133e185fec222c8b0be.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:28:03 +0000
Subject: [PATCH v2 11/13] Revert "merge-ort: ignore the directory rename split
 conflict for now"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This reverts commit 5ced7c3da009090c5a926e3123a71314c7f28d42, which was
put in place as a temporary measure to avoid optimizations unstably
erroring out on no destination having a majority of the necessary
renames for directories that had no new files and thus no need for
directory rename detection anyway.  Now that optimizations are in place
to prevent us from trying to compute directory rename count computations
for directories that do not need it, we can undo this temporary measure.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e8f1a435f99a..8258d3fd621e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1636,18 +1636,7 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 				 "no destination getting a majority of the "
 				 "files."),
 			       source_dir);
-			/*
-			 * We should mark this as unclean IF something attempts
-			 * to use this rename.  We do not yet have the logic
-			 * in place to detect if this directory rename is being
-			 * used, and optimizations that reduce the number of
-			 * renames cause this to falsely trigger.  For now,
-			 * just disable it, causing t6423 testcase 2a to break.
-			 * We'll later fix the detection, and when we do we
-			 * will re-enable setting *clean to 0 (and thereby fix
-			 * t6423 testcase 2a).
-			 */
-			/*   *clean = 0;   */
+			*clean = 0;
 		} else {
 			strmap_put(&renames->dir_renames[side],
 				   source_dir, (void*)best);
-- 
gitgitgadget

