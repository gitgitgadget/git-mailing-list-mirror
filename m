Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1319C64E8A
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B0D221FC
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTbaKI6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgJMAkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgJMAkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6BC0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f21so19143376wml.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=rTbaKI6gofH8NVyrb0w4V22aSi7XwFCT9zm8nwH1DJP47xYtF4byFteGqJTbPklXKR
         c/K2vqc5+qKYJp/jXLzJyJImLGAvhLfbMWmaYyaj6wVbqQt0TA944TywkvfZrZz346TL
         f8xbQLwuUrAos5K8NV2mAqfhA/vRj1bEmSPQz7AlK36tAPu6C0bvg4GI7Hls6len1JKL
         yAtfuq0p+zM85u8vak78hrZDNjzzGNsA152nM5TZ88InGwppajoBckYSk7eSDYiUaCQu
         x2CnExht1HEg/PinLM7C9SM0LxCvfaZhwzlRSoq/EILdlIAa7MbpBZWpsOzn239S/1Dw
         W7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=Z3XfwxR1PwhCJghl0MA5aSgIe6s/Xh9g4u7ItycX0MANuV6x26wdZHKaz4LUrpzjkA
         qNmMbitAlRzzMtd9X9VRM93p5840mFA/Y3MZygDJPKSUqPdINzfQOGpkvzMYeWQfFqqj
         XRh8hzz2A724OKgYUYeYR2Mz6ZZWO5uEFI+3i+urS4e135vE35szEz/3RFhT7v88uytt
         RpjlOQkZWO2DZY8lSEqnJZZuQ7YVqgEyLp8/4DhFfM1iaTXXJS2GZv8vT2nug832RgWV
         NOqxKCG689LKYv8WwiQcg+UbHxXiPK/RBK0ur/lRGot63VLqvFMsl5sHN1/wwxFspNNR
         RoPw==
X-Gm-Message-State: AOAM5321BtKeYfB9Qc3r6UWlYCyrv0Y1q3edpVVEUN37iSvmxfQTmagu
        7Tq2Q9+Mm8DgTM4mdX6ll6bAMJvAiV0=
X-Google-Smtp-Source: ABdhPJylsKYFKbRk5RY00o7KWKdC6Yy1h6EMuQi32DoAqXivbhVVb/yx4esgnxAVqDYhA66YEcf5Ig==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr13379038wmj.102.1602549653440;
        Mon, 12 Oct 2020 17:40:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm17780247wrh.94.2020.10.12.17.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:52 -0700 (PDT)
Message-Id: <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:41 +0000
Subject: [PATCH v2 01/10] hashmap: add usage documentation explaining
 hashmap_free[_entries]()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The existence of hashmap_free() and hashmap_free_entries() confused me,
and the docs weren't clear enough.  We are dealing with a map table,
entries in that table, and possibly also things each of those entries
point to.  I had to consult other source code examples and the
implementation.  Add a brief note to clarify the differences.  This will
become even more important once we introduce a new
hashmap_partial_clear() function which will add the question of whether
the table itself has been freed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.h | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index b011b394fe..2994dc7a9c 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -236,13 +236,40 @@ void hashmap_init(struct hashmap *map,
 void hashmap_free_(struct hashmap *map, ssize_t offset);
 
 /*
- * Frees a hashmap structure and allocated memory, leaves entries undisturbed
+ * Frees a hashmap structure and allocated memory for the table, but does not
+ * free the entries nor anything they point to.
+ *
+ * Usage note:
+ *
+ * Many callers will need to iterate over all entries and free the data each
+ * entry points to; in such a case, they can free the entry itself while at it.
+ * Thus, you might see:
+ *
+ *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
+ *      free(e->somefield);
+ *      free(e);
+ *    }
+ *    hashmap_free(map);
+ *
+ * instead of
+ *
+ *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
+ *      free(e->somefield);
+ *    }
+ *    hashmap_free_entries(map, struct my_entry_struct, hashmap_entry_name);
+ *
+ * to avoid the implicit extra loop over the entries.  However, if there are
+ * no special fields in your entry that need to be freed beyond the entry
+ * itself, it is probably simpler to avoid the explicit loop and just call
+ * hashmap_free_entries().
  */
 #define hashmap_free(map) hashmap_free_(map, -1)
 
 /*
  * Frees @map and all entries.  @type is the struct type of the entry
- * where @member is the hashmap_entry struct used to associate with @map
+ * where @member is the hashmap_entry struct used to associate with @map.
+ *
+ * See usage note above hashmap_free().
  */
 #define hashmap_free_entries(map, type, member) \
 	hashmap_free_(map, offsetof(type, member));
-- 
gitgitgadget

