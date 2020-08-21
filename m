Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8EC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED21720748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2TmCM2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHUSwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgHUSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:52:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613AC0613ED
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k8so2788465wma.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jLC6+Dg0oFm7zIlpMUr3c3sbyDAR4md6X1v2GjWUA1E=;
        b=U2TmCM2Bp7wmjza/LW+7UYBlJqcjnKJTHtpCfaZTbHFlMqEnf0+eaZ5P2IS30P4ewD
         A/DsVSANiDd9EJe2tCDsUDeJ5/dp9B7+ndzoVZ8mZjxL/kpaCV6u/Cm+5FheIvEM1Qi2
         zkUXOr0yYotsZBvtqj2Jk3hlm637dLxPwevC/C/cpt3RMwtIA1+ppIUTNCzmSCDNKS1L
         zL59a4wE0noFAVDL5E4a0e0swHi3q+1XK1Wlnd9zjRmBvg12rBKvyBpjP2+7loCeFGLN
         dgqbrYuRJyFpk3RbpYeBOJF4NRlKEl/ninlep/ipPrtwYXdqaI2pRv2pbATx4WCHRGpU
         Uqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jLC6+Dg0oFm7zIlpMUr3c3sbyDAR4md6X1v2GjWUA1E=;
        b=fbgHnouCNAyoO7AQoO9apAau3gcT/bEKR+RsY7MDckdvk1GP/O/jh31HN4HSyhbhkQ
         KJTQwQj72Cxcs6SnXHs4ZdN8XrqzSewrc6FAa3xYvONvP1qL2KifF69zLFyxLlAomZ04
         Ed56EkrJreDM0BYifpqjIcUuatlLr9iUY+AU+G3Cjri+K0ICbvlUcRWYTSUceWYV37IQ
         VR6oQwV4kT11RVwSUL+YdcFHJExFPkPGVIlkayRYk0EiFGo12Fp7l9vjN4XwvkuQB3ul
         W6CJzhXDAKA3xZn2cEFggg7qbz5g6xZP0rnhG4dZS4FRUZhDE+xaAk4xEUTyOeEgztoh
         hmmA==
X-Gm-Message-State: AOAM530RWkIptdjk7u1EePsMUJCh6pFjNigy0EEl9hImk795Ao6fKbga
        /wF/dvOh64jIuuiwFo+Hsy3UV/94GUI=
X-Google-Smtp-Source: ABdhPJydRprpYfDi/LO7eJIeFY5LxQWhYcN3XXxYKFOC93g2vabzvi+gZtLk9WZx9m6sr8et+95FJw==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr1561702wml.16.1598035951802;
        Fri, 21 Aug 2020 11:52:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6sm6805851wmg.0.2020.08.21.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:52:31 -0700 (PDT)
Message-Id: <b295e9393a8998b3b9263ab7cd195907d4002e36.1598035949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 18:52:25 +0000
Subject: [PATCH 1/5] hashmap: add usage documentation explaining
 hashmap_free[_entries]()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The existence of hashmap_free() and hashmap_free_entries() confused me,
and the docs weren't clear enough.  I had to consult other source code
examples and the implementation.  Add a brief note to clarify,
especially since hashmap_clear*() variants may be added in the future.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index ef220de4c6..a2f4adc1b3 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -236,13 +236,36 @@ void hashmap_init(struct hashmap *map,
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
+ *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
+ *      free(e->somefield);
+ *      free(e);
+ *    }
+ *    hashmap_free(map);
+ * instead of
+ *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
+ *      free(e->somefield);
+ *    }
+ *    hashmap_free_entries(map, struct my_entry_struct, hashmap_entry_name);
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

