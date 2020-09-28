Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0371C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532482074B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="QkmtACq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgI1QvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgI1QvI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 12:51:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AADC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:51:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so1575419qki.6
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ymTQ4F6iuFrFEgP+wQeRG9ELSnEUHRnYVcBSZJxedM=;
        b=QkmtACq7DYq2A1w6X9r+sGtL9J1oc+mmBhfG3f1rCe4C55bcSRiGniDv1/8a6sQj4s
         2lFq7xw6rCx4NYRCAqAjBC/8gZOCtIy6xgpmrUjzlOgimAPOmdYa9evO4MwQxiLPcCzN
         ZQUQm6LZPVOnqeWzmJb7Gj1SNlpTbMv9cXo/VdEsJW0L22q9yduoFERjLscXZK0F/LI0
         RbiYmrZINWAjVLGMDuqfogtP4f5u4JR7b5ZDlCcznnBcptkvgreBNuLAV17o4+0iixZb
         1KbWcdYa4vRBePCI9C9JSZGSfgZZcDVoseMlFCvfti/rOXdkhzvciL5HMJhn3sxT99RE
         rfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ymTQ4F6iuFrFEgP+wQeRG9ELSnEUHRnYVcBSZJxedM=;
        b=dtZ+qPB3WyZH/UkGXFtaSZqtMLI+H0Sh/csMBs6bvOnhzkOBDc7QnO5GCxqSJMU+gV
         Mu9V5sE8ye/WyLobIXlaE3cAiZnJOT7qYABqkcA6M2hKSDV33rF8SgZRpZAryK20WhoU
         vRmN7eLBIwOa/VT4nLJ3v/wE/JacBy/6vL4NtkCQ/nk2AzDK5MbvlSFy9ibqiGraSL42
         ViM+TAfAH9MuqmBcT0SCaoSEctmtoMZZSJ2FTnRekCFGGkqfdFuk/xdglYnzgwbb5Ffd
         jhdVImkp10RleFTH41VC7S1H4l9fqaUCjwrNFCr/GchdI9xEBS3XedcSPjUh1+tQM88i
         hK7g==
X-Gm-Message-State: AOAM532l7Gjvwxh0EEPukd2UuDusIx026E+TtBGAGLDKoE6I6DXLfumS
        eG55j0d0RGCjAMbIxqZOhpCKwdoopWAT9A==
X-Google-Smtp-Source: ABdhPJzPLJANOfbZFuApWkvfSwQK/1tyVD3LyWuuRVk31rxdAN+1MP+0Ilmo7CxuY7tZbkBDlilTKg==
X-Received: by 2002:a05:620a:9c1:: with SMTP id y1mr309500qky.241.1601311866842;
        Mon, 28 Sep 2020 09:51:06 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id u18sm1908358qtk.61.2020.09.28.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:51:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com
Subject: [PATCH 1/2] packfile: fix race condition on unpack_entry()
Date:   Mon, 28 Sep 2020 13:50:34 -0300
Message-Id: <42a7948f94cb57ebd9c37c3850b46b1ac9813ec6.1601311803.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601311803.git.matheus.bernardino@usp.br>
References: <cover.1601311803.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The third phase of unpack_entry() performs the following sequence in a
loop, until all the deltas enumerated in phase one are applied and the
entry is fully reconstructed:

1. Add the current base entry to the delta base cache
2. Unpack the next delta
3. Patch the unpacked delta on top of the base

When the optional object reading lock is enabled, the above steps will
be performed while holding the lock. However, step 2. momentarily
releases it so that inflation can be performed in parallel for increased
performance. Because the `base` buffer inserted in the cache at 1. is
not duplicated, another thread can potentially free() it while the lock
is released at 2. (e.g. when there is no space left in the cache to
insert another entry). In this case, the later attempt to dereference
`base` at 3. will cause a segmentation fault. This problem was observed
during a multithreaded git-grep execution on a repository with large
objects.

To fix the race condition (and later segmentation fault), let's reorder
the aforementioned steps so that the lock is not released between 1.
and 3. An alternative solution which would not require the reordering
would be to duplicate `base` before inserting it in the cache.
However, as Phil Hord mentioned, memcpy()'ing large bases can negatively
affect performance: in his experiments, this alternative approach slowed
git-grep down by 10% to 20%.

Reported-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 packfile.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/packfile.c b/packfile.c
index 9ef27508f2..0319418d88 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1775,12 +1775,10 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		void *external_base = NULL;
 		unsigned long delta_size, base_size = size;
 		int i;
+		off_t base_obj_offset = obj_offset;
 
 		data = NULL;
 
-		if (base)
-			add_delta_base_cache(p, obj_offset, base, base_size, type);
-
 		if (!base) {
 			/*
 			 * We're probably in deep shit, but let's try to fetch
@@ -1818,24 +1816,33 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      "at offset %"PRIuMAX" from %s",
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
-			free(external_base);
-			continue;
-		}
+		} else {
+			data = patch_delta(base, base_size, delta_data,
+					   delta_size, &size);
 
-		data = patch_delta(base, base_size,
-				   delta_data, delta_size,
-				   &size);
+			/*
+			 * We could not apply the delta; warn the user, but
+			 * keep going. Our failure will be noticed either in
+			 * the next iteration of the loop, or if this is the
+			 * final delta, in the caller when we return NULL.
+			 * Those code paths will take care of making a more
+			 * explicit warning and retrying with another copy of
+			 * the object.
+			 */
+			if (!data)
+				error("failed to apply delta");
+		}
 
 		/*
-		 * We could not apply the delta; warn the user, but keep going.
-		 * Our failure will be noticed either in the next iteration of
-		 * the loop, or if this is the final delta, in the caller when
-		 * we return NULL. Those code paths will take care of making
-		 * a more explicit warning and retrying with another copy of
-		 * the object.
+		 * We delay adding `base` to the cache until the end of the loop
+		 * because unpack_compressed_entry() momentarily releases the
+		 * obj_read_mutex, giving another thread the chance to access
+		 * the cache. Therefore, if `base` was already there, this other
+		 * thread could free() it (e.g. to make space for another entry)
+		 * before we are done using it.
 		 */
-		if (!data)
-			error("failed to apply delta");
+		if (!external_base)
+			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
 
 		free(delta_data);
 		free(external_base);
-- 
2.28.0

