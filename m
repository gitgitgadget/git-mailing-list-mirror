Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF5FC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFFB22268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guAH0j0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgKBSzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBSzS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:18 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D7AC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k10so14503058wrw.13
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=guAH0j0//guIUNaZy52kYTA10vkZbIrOn4gPR/KwNYRbk3cTXujlGQA1g/+KKp8Voy
         B3qYJLXYnxla1tOCrbyB3y2gEPREJzJradlZXc8O6+UYKwJlArkrbYL9zEuLA00H7cfK
         499aIYBNHoi/9+PbE7y1uAuhe2vo23rLq43dIOKcLE10IdJBGBvTpx4RSytzAcqeYOGZ
         gAUxu1WtEfpewJjLQ3AHFLCw5mkZRwScYwve8mVf7z5r5X2oPbvcZmdJ3aKBkNKwk8Rt
         BoTK95IYiZU/qaNaXy3JKTf0St8RMUNobrZgXEuDesLZdIS5V1+YDafY/oQen5GjpvqY
         2Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=P2uIx8+wp489ee+0Ln6i35XDZhJeGI5lk1jZ5q8uAh1Kgv7hrrnBlkfuVYwWLTYHMy
         d/G62uQSnPsK+sSkNnvZLg7gHroWvqMovahwNNreOH8quRy8mwRlfmZfx9d4Z3o9fL+y
         Fld/WLi9OYLt+ubgFOO3p+pk4SdrkIoqlh/btYv9MPqXptZbSDekRLPx7AyfIbZcYsDQ
         ddl7jLsl3+GdPyAa5czQXfuIYVssD0RgWSxsLvM+mVr4Y7Cxx4dGUMhVBqkt9KZcWNgy
         lnKJeLwR0OKiYdBVpDzKQV/1F7z4EKBX0aGTpsAlHfXEM/VLnAPlQr+n2EZewGNxPfKv
         hjlQ==
X-Gm-Message-State: AOAM531iD5Fyu3BA9A/S336dp1E2hfBCounM/dj/vfTkUA0aLID247uT
        JxX6qcH6qvnXTXedc9QAnDmrr1AHfb4=
X-Google-Smtp-Source: ABdhPJxvLiNcgUVtMPT8Xx9FF19YNIv3+VRk29vLKCvf0Tt086kqBrMCZhwFhCTBGEbQyf5CbitgKw==
X-Received: by 2002:adf:9bc9:: with SMTP id e9mr20870942wrc.94.1604343316514;
        Mon, 02 Nov 2020 10:55:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm23838905wrq.46.2020.11.02.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:16 -0800 (PST)
Message-Id: <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:01 +0000
Subject: [PATCH v3 01/13] hashmap: add usage documentation explaining
 hashmap_free[_entries]()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

