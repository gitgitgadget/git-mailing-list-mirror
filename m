Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A80EC433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECED20842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y16DgxH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHEBV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgHEBVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:21:06 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF95C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:21:06 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 19so12342119pfu.20
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rBtjqe68U0wwmHsT0FRWRNllwmP9aO0zsilqUwBM7xU=;
        b=Y16DgxH6Ag2b+5Ia811Dwi2sPerAD2a5K3ZyJ6bczvfzouCtYTk9AVmGfm5pcs4PXA
         +gV6x+8qYPqzTBrsccxsfNw6KximAPPaTDu7hU9BQ/kELYFb3b364j+H+a8XP2j2XVAE
         wnSTyM37rQQlm8FXHYn5GwAmZQ69/e0fzDNPivT3LCP8gpOQ0UfLWQVzyy+jbNaaCIea
         /MrSSnEiXS02oAN3/irzONFTMUDGmqEK/FSbRQlIeV/lNXXfsJf5PcW6uJqTyiU4dm0c
         7+NkqWugv+0lCwVMbqY6hS+uHeQ+vuJGkT+fy/Wq0//fYAJUhp0XhU0gc5T3xDh0EpzV
         ev7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rBtjqe68U0wwmHsT0FRWRNllwmP9aO0zsilqUwBM7xU=;
        b=QR3O69FDCR+eJ+3uUFIzvGFNsni3eD0R2m3NrwX6uxXV7Le7kAYM72lZvKBkS4q5ZP
         VssAL7UBmq8FnTpHooUhthKlUNBja620ZPCQMmXIPq3IRYjs5HtHOvXtQtfaflUSzUqO
         JzdN4QsQSNJMaDn8D8IRlIGESKu43uRy33P6CmwhPRlI7qv5FPt4UMqnpbNyl6BE0Pl/
         jbPXEDqPeeQZxSXnkEkPKkr09RYRjrXH3G42/BiQtpDQlp2DQJZc5QByt5KbtX47AS3B
         4Thjx4ZA66QyXFVEFYP4B88W9xlW7QLgoi57JHD/Lc5PR16zTftJKKMFvVACrTHOQbWc
         IBHA==
X-Gm-Message-State: AOAM532uYKhk7WShbF49lHvue9w1ezJrqaGQXEQO2H8opAvhBW3ziKn6
        xxQSE69ohjaNVF2U0VRiKB3f4I9+cRQVDZRbBe9e7+tzyeTs6C52lfsitcz5Y95Qzq8Ndg50OA9
        AWUiBlCnIZfkixAlGiTiFrxAfhht2oeBoKibRiE7ANMYimgHrbDfQLjMy68Bi0PuoppwnfYy+OM
        3k
X-Google-Smtp-Source: ABdhPJycVXYIgstHXjnisiakA/saTQ0ifZyL/2pmX6AqXQ7DInZXjx0U8SQv+iMMO4y/IAgBLuBpmAJb6/PChhMhHHLg
X-Received: by 2002:a17:902:a981:: with SMTP id bh1mr892658plb.157.1596590465776;
 Tue, 04 Aug 2020 18:21:05 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:49 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <d4dd33e465e9cf808e3cfb9a2679174a1dac8f91.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 6/7] fetch: only populate existing_refs if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 29db219c68..6460ce3f4e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -449,6 +449,7 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
 	struct hashmap existing_refs;
+	int existing_refs_populated = 0;
 
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
@@ -542,15 +543,18 @@ static struct ref *get_ref_map(struct remote *remote,
 
 	ref_map = ref_remove_duplicates(ref_map);
 
-	refname_hash_init(&existing_refs);
-	for_each_ref(add_one_refname, &existing_refs);
-
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref) {
 			const char *refname = rm->peer_ref->name;
 			struct refname_hash_entry *peer_item;
 			unsigned int hash = strhash(refname);
 
+			if (!existing_refs_populated) {
+				refname_hash_init(&existing_refs);
+				for_each_ref(add_one_refname, &existing_refs);
+				existing_refs_populated = 1;
+			}
+
 			peer_item = hashmap_get_entry_from_hash(&existing_refs,
 						hash, refname,
 						struct refname_hash_entry, ent);
@@ -560,7 +564,8 @@ static struct ref *get_ref_map(struct remote *remote,
 			}
 		}
 	}
-	hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
+	if (existing_refs_populated)
+		hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
 
 	return ref_map;
 }
-- 
2.28.0.163.g6104cc2f0b6-goog

