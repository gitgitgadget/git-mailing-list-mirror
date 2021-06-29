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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D36C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F07361C99
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhF2CHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhF2CH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E46C061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u8so10418384wrq.8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O0bk0uMoOfzc+R3V+w3r7b7PaKiQoEFR2JUhLyX6ccg=;
        b=Yast+wFnNT8WJjGHCAMvvCvJNwi1E9F5rwYxG9fgDHKjG5Mat+OnQyCUN5MCymzUwo
         Y1T8T70kMqbUWBwcvRURWki7DhiUdaNYAt5/+iLdehKZKeVESZWl5SQJhezNCp3ANQad
         r+Y2VOK1urs9A9I2iKniCM8gBC8lFXT1vMv7DzKDSroDSMsTl6zahNrpt5LoWBBXFp14
         cKFq+5o5KZ263IbSqH03p6EOom9KPMe6pG8ZIYbFAjSfLEDDihdmf7ALNWtXMlYo27ar
         nUm6wQNIRPvpuRsJqRvknIgRCNyI/a4BuXqt5xTmZg/MDeCBwn0GEDuiqH45S/jsm+PX
         LixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O0bk0uMoOfzc+R3V+w3r7b7PaKiQoEFR2JUhLyX6ccg=;
        b=APGimeOK0WBbq8qIodTsUdUYR93kfWrs7Kd4Mtn6FBPKifTuPNr1KsvaVRVFFHo8Ew
         C5xroDCPVOSIB9tDqZJ0mA5HxbSqP0CHWJaq0mQxTuH90jiR6ym0/bY6iV+i8s+TMTrr
         dRNCDapaOnYI+67my90tQqLu3Oir0+0jP6gMcuyXLT5QJUguDNkjAMazgku9YvWIfi+p
         pq1ZFAMhgtehLLEUCDTht3XRl1Mtj2FV4wEHcgHyK2uJeUioMaP7V3JMu9FvQMto2vu6
         6I1GHOJGeqex7qw1LgA6JFr4V16htrLK8NfpPw2lQeIKkzsBs5GlVbsgDcSa3fEjAS20
         QmAQ==
X-Gm-Message-State: AOAM530uxXI+9DkoFdojdvsZdchodmfe2LLVVqi6oNG337dVq0nGrRvW
        cTNNLSSh8XOJ6x91Wl4XIZjMo5T4M08=
X-Google-Smtp-Source: ABdhPJx5DogrQVbHoYXr1LRhzKPKQpylDjcRRsfUDCKFPN1T8fKM7keWMyqj3DhktEGfjc9ZVKz8pw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr10303292wrp.52.1624932299568;
        Mon, 28 Jun 2021 19:04:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm15308834wma.48.2021.06.28.19.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:59 -0700 (PDT)
Message-Id: <d04b62381b8c18cce8ec499d7213041772bfd4b2.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:45 +0000
Subject: [PATCH v7 08/16] unpack-trees: rename unpack_nondirectories()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In the next change, we will use this method to unpack a sparse directory
entry, so change the name to unpack_single_entry() so these entries
apply. The new name reflects that we will not recurse into trees in
order to resolve the conflicts.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b113cc750f2..d26386ce8b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -804,7 +804,7 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 		BUG("We need cache-tree to do this optimization");
 
 	/*
-	 * Do what unpack_callback() and unpack_nondirectories() normally
+	 * Do what unpack_callback() and unpack_single_entry() normally
 	 * do. But we walk all paths in an iterative loop instead.
 	 *
 	 * D/F conflicts and higher stage entries are not a concern
@@ -1075,11 +1075,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
  * without actually calling it. If you change the logic here you may need to
  * check and change there as well.
  */
-static int unpack_nondirectories(int n, unsigned long mask,
-				 unsigned long dirmask,
-				 struct cache_entry **src,
-				 const struct name_entry *names,
-				 const struct traverse_info *info)
+static int unpack_single_entry(int n, unsigned long mask,
+			       unsigned long dirmask,
+			       struct cache_entry **src,
+			       const struct name_entry *names,
+			       const struct traverse_info *info)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
@@ -1322,7 +1322,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
-- 
gitgitgadget

