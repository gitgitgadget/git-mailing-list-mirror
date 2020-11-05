Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE77C2D0A3
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9446720867
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE1rd19X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgKEAYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgKEAWu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9175C0613D2
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so23834wml.5
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=BE1rd19XtKUFSUvD9ERc0gsaQyToqT66XPiEATk81sNuqaMv9T8mTyjmQpyKJ6Uof2
         6D+AjG7Lo1pW2E6YmylGzvBorz1fFbxOWBXzHpE4T5bvj29RjLyDGkpiZvcK9u8fdDZD
         pba0A3bTZQCbWszezZlM6EBjzEHc4zX7l9LCqd+yPDoUOsC9rahD/JsN+W6k1L2TWs1J
         ZICM7hmr//AAkIRcwBwVYCxW+I9iw7a8KhvkfNskDKnxURqqCF7ftCB2THXtcGVGHsap
         BUqGnjpmhbKh3tat1HANaq0Lg5Z/rFiKeg9yl7UUN4Zyybx8K5fPwH6E6zJXVRnArslN
         PB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=qru12V6Pu3oGvyrGdrYuJxBSTyIdrqVcx5y01194l9LEUtZv2zz7Pe0xJyiPZDUkUF
         qN5z5hKGC52vL4cbrwHP0Ws437e0HDlaTlSpDorGUxN2Mk+UiVTk57hx5/d7YcmfXmKx
         4I9xlliRgqVy6areSzlqlDqoXzGmai1VEeAp0u79hfSIGGWsdroCSG0RFLMA9KpIlkNs
         XYZn5vgxFZvn6mTpp3WxwRVUWMYkDSD8lit/udmoNO9Di0LgVjq+xCySdITkPZLGB5nI
         if4GdBpsjAzksPWViejLkKkLngBLhUID3C9LQqQAQtVzC8FC/3olDuUr/xZbrUlJGTNb
         MVfA==
X-Gm-Message-State: AOAM533JoxIubD4iuo9takLwVt8iKP8ZQ0DowDT7laaY0peCLCN0a6Pa
        PRKKJdYmU898RDxG5tR2PZFN0XxqBA4=
X-Google-Smtp-Source: ABdhPJxQOJrCUorbTLEB1Yy+hftN6XF+me9leV8eDFUGonZW0fgMA2Aisu8+1/wQ6l4UUn43/6MsLA==
X-Received: by 2002:a1c:4888:: with SMTP id v130mr87245wma.84.1604535768218;
        Wed, 04 Nov 2020 16:22:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm26918wmi.32.2020.11.04.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:47 -0800 (PST)
Message-Id: <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1604535765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:33 +0000
Subject: [PATCH v4 01/13] hashmap: add usage documentation explaining
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

