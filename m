Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6891CC433E8
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4630B2072A
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfiVYwxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRECF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgHREB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:01:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C54C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id v10so11415887plp.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5hNEHEENUI4eo6zzDwPOVmARFBBOlvUqOQ7IQvMHKrQ=;
        b=lfiVYwxYe1PRc7B1iOXBWwzucdS4uE/r/uNNOpIzxUaaIO0IhjYf93EsOrPBsnPzFT
         8fdcT1eHncH/naZwOsqtcROUpEA8SDvASSPeq1YYXuoTzrcEllDoP1cNA/b01HDr/E0s
         9mdiyfQR9vbzenMxQ6ZyetL4JFde+q6wcuIYrCV2pRo24OW8KkxThLboV6wnxsa1vQEr
         WspPKqqHS7BEPwYBrR1Oyn8A2EBhRP8OvdArbkvw/VUmF6irzvtp5OfRDs/j0YcabfRy
         kKtl+4Zq3+yvdYBy257C+G5sXehHkGCg89rHQGDfCiPTFc4fXd3bi83CsORZkv5lyHAg
         cmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5hNEHEENUI4eo6zzDwPOVmARFBBOlvUqOQ7IQvMHKrQ=;
        b=G1qoY2JKqYF6SUpvWMSxnzDBJncIT8d6pULNdu7gPbeVzQUQLbpvuoslk5+qFlAdOJ
         UzPv9URpuc+HdnBW1E4ZERtLk1Zkyi9cJfHLHIIINHTqssLyTOHi5ruFpM4mmYjLXr75
         sSQXa66trVYHvBguQwkzo0Rw5J7Jdl94QV5NsZYH8a0yGdDj9TcxQ19BqiE2t88S+qL9
         7vkdH2VGmcxWe6BmmdtX0FdfMhVvjnPk7RWMEABfMtfwTP7jLMQ8I0YoKr46mLfKw3eL
         I9dQATUh3dwRH+ZL54rpfDWJ//sPCvwW3VN4t5NVc9vhIvyXWiqHATSoDn89NNP1yQln
         pcmA==
X-Gm-Message-State: AOAM5336ak5T4eRqklV7KAW4rD/x1tyU76NgDVs/trgVUk+PoLC39FFR
        XWfnNYjkZENGtDkujaiOgZifrcf6e2H3d7ghV/lvwTdG/Ap5V67bvT8FvuCrneHI8xD4RumxZdH
        tA8FhCKOcRIiJIwEA8P305HfV+EBLcpHCDpw5TqZfY98sLNlRFsAD3wi90FSmyhmZAvFHNUn8yK
        1k
X-Google-Smtp-Source: ABdhPJwcm2JVKTXnON222Vz8sWummVhPxxVEcsXeETkCmB8kSLoE/CSMnYbSVrLp0AmvIIRp3X8eo0WpkfgB1Ncaar7u
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr14846478pjb.230.1597723316511;
 Mon, 17 Aug 2020 21:01:56 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:34 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com>
Message-Id: <a5554cd27f8aac5018e5699837e3b9e9badcd3a4.1597722942.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597722941.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 4/7] fetch: only populate existing_refs if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "fetch", get_ref_map() iterates over all refs to populate
"existing_refs" in order to populate peer_ref->old_oid in the returned
refmap, even if the refmap has no peer_ref set - which is the case when
only literal hashes (i.e. no refs by name) are fetched.

Iterating over refs causes the targets of those refs to be checked for
existence. Avoiding this is especially important when we use "git fetch"
to perform lazy fetches in a partial clone because a target of such a
ref may need to be itself lazy-fetched (and otherwise causing an
infinite loop).

Therefore, avoid populating "existing_refs" until necessary. With this
patch, because Git lazy-fetches objects by literal hashes (to be done in
a subsequent commit), it will then be able to guarantee avoiding reading
targets of refs.

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
2.28.0.220.ged08abb693-goog

