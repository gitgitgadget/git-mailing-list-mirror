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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9CC4320A
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF5860F4B
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhHIBjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhHIBjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 21:39:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABAC061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 18:38:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o13so16745628qkk.9
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 18:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wopM3YU2gT2K1x6SzjxzBXOS66okIpGtCUrwLNYSCCI=;
        b=K8sBtHiBGU7NrdyqPVgsLVDa8QbXHWQdF/mIgXQp17XSIzlo8gM72GpHIE+QYR4dZr
         JUfiZ7szTKOIOqtqP2UVpvi6yq5EJ7QxvvoKOMHI/zNi+ZVtrV49Bo4MUqIDDrzwBmUo
         VpZLbDFXPyynqmNmeqUU9hZdQuLUW1MsmVhjN3vw4qWU0z7yiCkYiCeDnwwZiHYjFKSQ
         zFYnhka2EX6YCckY4RSlSRq3aTbTnpvKsPqtlyErdy3+k+783KgKbZWCJxQjn5HSMMi2
         skiRzB0Gw6VpiSnX/x84Vw/n2yYY8/QmDhCVX1HzaXjvtXWrI+yq2KUj4HxG4yyEd++1
         nRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wopM3YU2gT2K1x6SzjxzBXOS66okIpGtCUrwLNYSCCI=;
        b=sZWKmhSDqosjy9xMbVvusAyWq8Pt8woRXeSU6FpvyV8xFn/TqiIEpdwTKg8nw8iumB
         6GR2P8hGbYJfIqnbdn8GVRJoWi4soFB2bEEK5lA/M61H/QkSy+DYD+6A/tYpFjng1m3r
         yRC+BIXwsO0bXzaIDORjI2hsFGdcSxaeV6O/D91mTTUznfRydM4i6s8bNVCnV5ewW+rU
         ytTSzCG4qRdYswWTmhDg2uq8KISD7P2YNl6mGsNxVDOUC3Jd1ihde+PORCpZyHGkikXr
         TiR2cfExIRJq83OGp1GMuD8EmRwrqy6+Q9J02MHBc5bnEyGYSHQfmhw3BSkOGFegqiAV
         VLUw==
X-Gm-Message-State: AOAM532PpNhOnw2paHQKcosoVFHIqtVw9hfZPfH0G8r2YZCOGclaizMo
        qUkfbqMi8AYFudWR5vRUUr1NkknbrDc=
X-Google-Smtp-Source: ABdhPJxAswcSgdfXrKP5ViE3a4LNYqppf3Pqfxt20ge4RIGQUQyXO1HgDwjN2BVW0kR2BBBwsNZYXQ==
X-Received: by 2002:a37:9b53:: with SMTP id d80mr17911018qke.209.1628473129729;
        Sun, 08 Aug 2021 18:38:49 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o16sm1279492qtq.95.2021.08.08.18.38.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:38:49 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH/RFC 1/3] oidtree: avoid nested struct oidtree_node
Date:   Sun,  8 Aug 2021 18:38:31 -0700
Message-Id: <20210809013833.58110-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <20210809013833.58110-1-carenas@gmail.com>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

92d8ed8ac1 (oidtree: a crit-bit tree for odb_loose_cache, 2021-07-07)
adds a struct oidtree_node that contains only an n field with a
struct cb_node.

unfortunately, while building in pedantic mode witch clang 12 (as well
as a similar error from gcc 11) it will show:

  oidtree.c:11:17: error: 'n' may not be nested in a struct due to flexible array member [-Werror,-Wflexible-array-extensions]
          struct cb_node n;
                         ^

because of a constrain coded in ISO C 11 6.7.2.1¶3 that forbids using
structs that contain a flexible array as part of another struct.

use a strict cb_node directly instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 oidtree.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/oidtree.c b/oidtree.c
index 7eb0e9ba05..580cab8ae2 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -6,11 +6,6 @@
 #include "alloc.h"
 #include "hash.h"
 
-struct oidtree_node {
-	/* n.k[] is used to store "struct object_id" */
-	struct cb_node n;
-};
-
 struct oidtree_iter_data {
 	oidtree_iter fn;
 	void *arg;
@@ -35,13 +30,13 @@ void oidtree_clear(struct oidtree *ot)
 
 void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 {
-	struct oidtree_node *on;
+	struct cb_node *on;
 
 	if (!oid->algo)
 		BUG("oidtree_insert requires oid->algo");
 
 	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid));
-	oidcpy_with_padding((struct object_id *)on->n.k, oid);
+	oidcpy_with_padding((struct object_id *)on->k, oid);
 
 	/*
 	 * n.b. Current callers won't get us duplicates, here.  If a
@@ -49,7 +44,7 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 	 * that won't be freed until oidtree_clear.  Currently it's not
 	 * worth maintaining a free list
 	 */
-	cb_insert(&ot->tree, &on->n, sizeof(*oid));
+	cb_insert(&ot->tree, on, sizeof(*oid));
 }
 
 
-- 
2.33.0.rc1.373.gc715f1a457

