Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC264C55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A9F2083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYwGJ0Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbgKFAZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFAZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304DC0613D2
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e6so3767791wro.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=mYwGJ0ZwfFKVimvvq5UpLu6mIjbEIb2f8fh5C5mzpNE98Lk7G77AunQUrp+4Z1+DYz
         wQuG/uc4WdSjxBCr7LZox37p0TtI0hmVy2++6ETJrBQDoEF92Ct0xhJA0mSQzsht8SVZ
         qtya+C+we0TBfUtUd7xv7CXOpTs6GI1kAvdpgmchVTWwzDFXMQDHntYtLumrmGNCpAO0
         +loZZrS6a9Kzp2Xrfdv/KKEjh3vT+1Uwbcj68+F6ywVqsUWfMVkPQmPEZeoAKjaCkTl5
         sU5aKIQBR3NMVf8dFrzHdAaVH4ImDjjz0mECuo3x6EEwT2rWY/wI+ep+3CUysvtL1P1p
         eKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFAswi3o4d7CVNEpLSnDCYqFONh+d8GGqoJ1wyK3dI8=;
        b=FLsyP0Ek/GTjpvtiZE+mDkEt3Ao4IQPWQ2D8YRgAqCKk6VYSMj6kOG+CJzDMoKqvWP
         srvYqOebhNROj5s4WYzsPVqZJyaPEyMWSHOmfoQU2Eq/wcmwQv2FaqbDuC/xF8ECq8EB
         d8pvULhvJxV1X8uKTN6ltLt2T11Us3zpd69T+2tFTTdHANwl8LJTcKmXHWjdtOjYNX92
         P3LIMYlkwi8zn+1VghXqCaOdygAybGRTB58Cca4x4T+DX2F6kQMSaYGNgjy9ZMbAGGu2
         IlFmizRn7qs153x5QOxrqG1XCVyhjPt9rXiE5iTdWKZkeAJI2cpf63HVD9sdDK7+eVVl
         9WjA==
X-Gm-Message-State: AOAM5309aWV0+w+V0NzmzkRhCnAd4I1VGVpj6CZ/mk7jmqjJJG3HdLEF
        /M8pG/nXuJrRVbACxLeME+Ef+hEVO1g=
X-Google-Smtp-Source: ABdhPJwQi8tlL/q9Im4PfLcQeihcetuRcjstsBDUGkLS/1TL1iczxBNZqrOO0zz6N3OR+QoAcP2Ilw==
X-Received: by 2002:adf:e751:: with SMTP id c17mr5898978wrn.345.1604622301135;
        Thu, 05 Nov 2020 16:25:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22sm5656437wrb.97.2020.11.05.16.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:00 -0800 (PST)
Message-Id: <af6b6fcb460be900d3fffeb743a42f3f87ce6b7f.1604622298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:44 +0000
Subject: [PATCH v5 01/15] hashmap: add usage documentation explaining
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

