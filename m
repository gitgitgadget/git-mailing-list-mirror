Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA22BC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8554F206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRYtzt/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHKWwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHKWwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 18:52:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45969C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h2so123775pgc.19
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jwRjL2mpTqfC1FMsfWpfqXN6M+5vuTAImcsjzmY1qOg=;
        b=sRYtzt/4chinj+e7sN7SKss06ChfANGdUPR3EPDRlkd+Gn1hlzaqUMZkuc0Dw4bKgt
         ztl9jRku1l/t1IFBJQEnfmkh7GFRWUJGR2TJ7/wvWCojwU5kteEew9hFSexlAZlb3yNu
         NaN8oZ/IStMU3aHx8EYpzC8eFSQPTdm+keOp+0zrzEY8wNEILUgPywi1dLVyixraC7Jo
         fzRg1/7qBBGhln+3jGN8/TqXrIv6/3E/lgETpMlOMXYIvjMrILyAstP7UkObyGnrIN3U
         nx6uidI4UL88TyOVzthvPj+Kbzp0zCV2X+tiPBAm6SIgJuymGWOyCgugPa7ju8LcAl6F
         Kqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jwRjL2mpTqfC1FMsfWpfqXN6M+5vuTAImcsjzmY1qOg=;
        b=XQ5y8mabhwBsGoqKaY2eselG5VuVsqQsKwyh0jHrpMwE5s0TCsh8/+rbBtFPjrM0Zn
         taNOSfDTQ/U1r9Q3HsnFxLF/igiBQJPDFvL4Khfq0yj46N7fZKGn+c0CKyMlUCjGobkI
         MRakJh6FRcCpxWZnckETZEr/y8Ul+I/KhaY3rOB6X/M0uRXEWYSv7mQNyQ1ZDmgDKsA6
         48mw5v3Eh63/njzKRdwD2SWTs/4PIZfv/zIR7CBotQ1v/by6qi7W8supQ+SdJnNH91hL
         foUGtu8/SpgCjfk4E/5AA0mI8bMRw6CTDHevaOZuXFGZLaL+6EdlZye5Ev+4csiV9+mf
         034g==
X-Gm-Message-State: AOAM532V8yP4DBNmiH2ZvPl0ySlA0J3R/IgkIB+9LxRLzQftwx/rTsDH
        6J2Itf6fqj7H0jloLNTIXvM6qZ+rDVfSzZgPPt5jaRg6kRcro3R54AmFKzQ5wAwFxndIRQS9KVF
        PC1pwyfMCBDVxtoOaPfvCoZTGGl2nuWt2E4KLl/9+6bw+a/BJrkdzwvVFL/1hQR2Px+U5sdG/y8
        7F
X-Google-Smtp-Source: ABdhPJyXXn01pW2JgPNOzRv/bYzbLVL+BitnVVvaBAmukcDu2LIEfXZu+MowA8UX31EM2zbIjF0YFtEeP2Pu7UZFndXa
X-Received: by 2002:a17:90b:3684:: with SMTP id mj4mr3184949pjb.195.1597186354690;
 Tue, 11 Aug 2020 15:52:34 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:52:19 -0700
In-Reply-To: <cover.1597184948.git.jonathantanmy@google.com>
Message-Id: <77bc83e7f2c0a9c95e2ff31aa7a11295bbdf054c.1597184949.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597184948.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 4/7] fetch: only populate existing_refs if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching tags, Git only writes tags that do not already exist in
the client repository. This necessitates an iteration over all the refs,
but fetch performs this iteration even if no tags are fetched.

This issue is more severe in a partial clone because the iteration over
refs also checks that the targets of those refs are present,
necessitating a lazy fetch if the target is missing.

Therefore, iterate over the refs only when necessary. The user can avoid
this iteration by refraining from fetching tags, for example, by passing
--no-tags as an argument. A subsequent patch will also teach Git to use
"git fetch" to lazy-fetch missing objects in a partial clone, thus also
making use of this change.

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
2.28.0.236.gb10cc79966-goog

