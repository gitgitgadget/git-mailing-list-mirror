Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06523C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE682087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh20k604"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKKUC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:26 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B65C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:26 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so3754462wrx.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=mh20k6041XEz1CPGPKI6dihqw1vT5Da+orLgydqLmezat3bqCEPqEK9xurQrYmDUKA
         cjDFH/i9F3dUm+qWxZ6sG3ypik43VmMIA4oU3/eB/qWwpZorgv6DUni9A3p+GhmX64B0
         z9W7LzvFAO0LZeN1OIlLDFLV0WkjD3fqHPpArxis94Fi3LtbKrXuaFVhzQTzjzRD7n1C
         UyOBuU1FRMz2GrGoWETdZb7pwdrlv02NzDSpl7Isivfk0uNbYMuer3jxRSGUXQPrE3Ki
         9lnXqGrxgjLLevW5BdYuXXu1w0qO5GLK0lhnZDZ6t4hXTpe8njYO3KRRVZ3gZt+kTjW2
         rUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=cLxX2in8ZIghddFirwoZb++V+XiBh9Mi4WW1s0bGhTV7esijT+lPLS5b7MHbrvhrsK
         2S2/TPKJ6Xpot8DU2MxvxlGrQGikxDIgKheJ0wphzldfq8fpT80+U2NLIyxomp5O7RMV
         UbA4FQpbUMCAowvk5IJi7Lmc8SbRJ2TTWHYZ9ttMYBye6/E65HtO8g2qU9OUAo6gbr4C
         Yytm+fXFIi7jXMRku3GmVoHVjjQ0z5h3apN3M7qaxF9wpQzDnT1mbowoiZ0PIolanuMT
         Af/4P5RYLHzV/rVXXvN0DV7URvecGNepZRn+Pe7iQ7vqVAFWZaeGTT3DWPNQPU+KA1TE
         yS7w==
X-Gm-Message-State: AOAM530AZ9oBjwQHd53c9U0QmLeFTnQOWgF3fojC5UUjmkWWD4XVQiaJ
        pv9Kn+Kj/WDNZn0+wd3hmZOUTVGpaPI=
X-Google-Smtp-Source: ABdhPJzjVpUCib3my4oxQ6BdiCUvBhnlRjS3OeV1pQThUSWge3Bu1bRXoIODeDqaaH2tNWQb222mtw==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr15489088wrm.259.1605124944818;
        Wed, 11 Nov 2020 12:02:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm3473386wmj.36.2020.11.11.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:24 -0800 (PST)
Message-Id: <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:07 +0000
Subject: [PATCH v6 01/15] hashmap: add usage documentation explaining
 hashmap_free[_entries]()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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

