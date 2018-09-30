Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C15B1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 02:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeI3ImN (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 04:42:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeI3ImM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 04:42:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so5485722wmb.5
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZeT3puU2UY725SHI03cUCHuWQE2mgNfuR/SFUueZySE=;
        b=h/MtBfLfMA3KgIyBZnTWre+QdApiW4mfwvllDYHy20Bh7fUTc2YKzaA2koNzg4Xm1B
         IVrOEpffLTVPvrY1Hk9HOr6iTfQE8jdbyEMeAJxU6l2Qk26ZJDGNq8t4uaL0QXWWNNh+
         AucwVDYcoLv/6pn9TOqeDZ5D6SsHW3D098rEpmZBbU8RN2qmKZX/1leiuzCeneUdGT+q
         KgPR9YsSB3BZhowFj2kElaEWV+kuoTnz756IWfJLIxNj8w6a1EFXdvO2Iq6Q4wppBbbE
         VWW7Ton/LBH2XMU2/SewuUMxNah1Kh+KQYjUjHsxhVniGio1PAlHpuo90QiOznOrY7F3
         zLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZeT3puU2UY725SHI03cUCHuWQE2mgNfuR/SFUueZySE=;
        b=d8qm0zrW4yhspfAg/HFi8ZLEdHBa+hZNxPJBBF/pX/HGgnEAneqMGk8IlKsUhMcXug
         72/nnZVL2TT5+nKuwrLEOwprIuQm3kLfOUpbqhbBW8SA820arhyItBPh5EkMhzdk1hCX
         unwCr9rNd0UidaxOM2Ur/lC723couazUiqsuwmgUWNw7DhuULuk7o7xMhazLf4hC9AKL
         OqnP5ystyikVqKNoZNNxY4FCu9Dnh3a6TwBBQn10SplaN7aT5/MuoTyaJE7zwOB0fNUY
         YmOAcpzXc//pOB7iA7VNahD+sqRqv97kCX1jVSPFrsY5gMdtNRXVdcpo6/Sm5D14N/1u
         rlnQ==
X-Gm-Message-State: ABuFfoiyIc5RYvOLBTMLkKAgnBX6ocsTf+eKp0mR52RhrmGS2XY+J1Bi
        0BIFB9gYhyHho51/HspDcaU=
X-Google-Smtp-Source: ACcGV60gPSsvenu1kWXi98zjLDzBFqHuWvXCUpBiYsE/q2vCroqjTd+/qHNYdNvxs2g4NHo1NKKTxg==
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr5158632wmp.58.1538273475511;
        Sat, 29 Sep 2018 19:11:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b193-v6sm4929493wmg.44.2018.09.29.19.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 19:11:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] fetch: replace string-list used as a look-up table with a hashmap
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
        <20180927053418.GB14178@sigill.intra.peff.net>
Date:   Sat, 29 Sep 2018 19:11:13 -0700
In-Reply-To: <20180927053418.GB14178@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Sep 2018 01:34:19 -0400")
Message-ID: <xmqq5zyn91ku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So yet another alternative here is to just define a single hashmap that
> stores void pointers. That also throws away some type safety, but is
> maybe conceptually simpler. I dunno.

I was tempted to try that route, which would essentially give us "if
you are abusing string-list as a look-up table, and if either you do
not need to iterate over all the elements, or you do not care about
the order in which such an interation is made, then use this
instead" API that can more easily substitute string-list without
boilerplate.

But I am not sure if that is worth it.  Perhaps we may end up doing
so when we find the second thing to move from string-list to hashmap,
but not with this patch (and yes, there is another string-list user
in the same source file, which I think can reuse what I added with
this patch).

In any case, I expect to be offline more than half of the next week,
so before I forget, here is an updated patch.  Two changes since the
version posted earlier are:

 - remote_refs_list (not remote_refs which is a hashmap) is passed
   to string_list_clear() at the end.  This is a fix for an outright
   bug Ramsay noticed.

 - The callback function now takes (const void *) and casts its
   parameters to correct type before they are used, instead of
   casting the pointer to a function whose signature is wrong in the
   call to hashmap_init().  This was noticed by Stefan and I agree
   that doing it this way makes more sense.

-- >8 --
Subject: [PATCH v2] fetch: replace string-list used as a look-up table with a hashmap

In find_non_local_tags() helper function (used to implement the
"follow tags"), we use string_list_has_string() on two string lists
as a way to see if a refname has already been processed, etc.

All this code predates more modern in-core lookup API like hashmap;
replace them with two hashmaps and one string list---the hashmaps
are used for look-ups and the string list is to keep the order of
items in the returned result stable (which is the only single thing
hashmap does worse than lookups on string-list).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 121 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 27 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..489531ec93 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -246,16 +246,76 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
+struct refname_hash_entry {
+	struct hashmap_entry ent; /* must be the first member */
+	struct object_id oid;
+	char refname[FLEX_ARRAY];
+};
+
+static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
+				  const void *e1_,
+				  const void *e2_,
+				  const void *keydata)
+{
+	const struct refname_hash_entry *e1 = e1_;
+	const struct refname_hash_entry *e2 = e2_;
+
+	return strcmp(e1->refname, keydata ? keydata : e2->refname);
+}
+
+static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
+						   const char *refname,
+						   const struct object_id *oid)
+{
+	struct refname_hash_entry *ent;
+	size_t len = strlen(refname);
+
+	FLEX_ALLOC_MEM(ent, refname, refname, len);
+	hashmap_entry_init(ent, memhash(refname, len));
+	oidcpy(&ent->oid, oid);
+	hashmap_add(map, ent);
+	return ent;
+}
+
+static int add_one_refname(const char *refname,
+			   const struct object_id *oid,
+			   int flag, void *cbdata)
+{
+	struct hashmap *refname_map = cbdata;
+
+	(void) refname_hash_add(refname_map, refname, oid);
+	return 0;
+}
+
+static void refname_hash_init(struct hashmap *map)
+{
+	hashmap_init(map, refname_hash_entry_cmp, NULL, 0);
+}
+
+static int refname_hash_exists(struct hashmap *map, const char *refname)
+{
+	struct hashmap_entry key;
+	size_t len = strlen(refname);
+	hashmap_entry_init(&key, memhash(refname, len));
+
+	return !!hashmap_get(map, &key, refname);
+}
+
 static void find_non_local_tags(const struct ref *refs,
 				struct ref **head,
 				struct ref ***tail)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
-	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
+	struct hashmap existing_refs;
+	struct hashmap remote_refs;
+	struct string_list remote_refs_list = STRING_LIST_INIT_NODUP;
+	struct string_list_item *remote_ref_item;
 	const struct ref *ref;
-	struct string_list_item *item = NULL;
+	struct refname_hash_entry *item = NULL;
 
-	for_each_ref(add_existing, &existing_refs);
+	refname_hash_init(&existing_refs);
+	refname_hash_init(&remote_refs);
+
+	for_each_ref(add_one_refname, &existing_refs);
 	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -271,10 +331,10 @@ static void find_non_local_tags(const struct ref *refs,
 			    !has_object_file_with_flags(&ref->old_oid,
 							OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, ref->old_oid.hash) &&
-			    !has_sha1_file_with_flags(item->util,
+			    !has_sha1_file_with_flags(item->oid.hash,
 						      OBJECT_INFO_QUICK) &&
-			    !will_fetch(head, item->util))
-				item->util = NULL;
+			    !will_fetch(head, item->oid.hash))
+				oidclr(&item->oid);
 			item = NULL;
 			continue;
 		}
@@ -286,48 +346,55 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
-		    !will_fetch(head, item->util))
-			item->util = NULL;
+		    !has_sha1_file_with_flags(item->oid.hash, OBJECT_INFO_QUICK) &&
+		    !will_fetch(head, item->oid.hash))
+			oidclr(&item->oid);
 
 		item = NULL;
 
 		/* skip duplicates and refs that we already have */
-		if (string_list_has_string(&remote_refs, ref->name) ||
-		    string_list_has_string(&existing_refs, ref->name))
+		if (refname_hash_exists(&remote_refs, ref->name) ||
+		    refname_hash_exists(&existing_refs, ref->name))
 			continue;
 
-		item = string_list_insert(&remote_refs, ref->name);
-		item->util = (void *)&ref->old_oid;
+		item = refname_hash_add(&remote_refs, ref->name, &ref->old_oid);
+		string_list_insert(&remote_refs_list, ref->name);
 	}
-	string_list_clear(&existing_refs, 1);
+	hashmap_free(&existing_refs, 1);
 
 	/*
 	 * We may have a final lightweight tag that needs to be
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
-	    !will_fetch(head, item->util))
-		item->util = NULL;
+	    !has_sha1_file_with_flags(item->oid.hash, OBJECT_INFO_QUICK) &&
+	    !will_fetch(head, item->oid.hash))
+		oidclr(&item->oid);
 
 	/*
-	 * For all the tags in the remote_refs string list,
+	 * For all the tags in the remote_refs_list,
 	 * add them to the list of refs to be fetched
 	 */
-	for_each_string_list_item(item, &remote_refs) {
+	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
+		const char *refname = remote_ref_item->string;
+		struct hashmap_entry key;
+
+		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
+		item = hashmap_get(&remote_refs, &key, refname);
+		if (!item)
+			continue; /* can this happen??? */
+
 		/* Unless we have already decided to ignore this item... */
-		if (item->util)
-		{
-			struct ref *rm = alloc_ref(item->string);
-			rm->peer_ref = alloc_ref(item->string);
-			oidcpy(&rm->old_oid, item->util);
+		if (!is_null_oid(&item->oid)) {
+			struct ref *rm = alloc_ref(item->refname);
+			rm->peer_ref = alloc_ref(item->refname);
+			oidcpy(&rm->old_oid, &item->oid);
 			**tail = rm;
 			*tail = &rm->next;
 		}
 	}
-
-	string_list_clear(&remote_refs, 0);
+	hashmap_free(&remote_refs, 1);
+	string_list_clear(&remote_refs_list, 0);
 }
 
 static struct ref *get_ref_map(struct remote *remote,
-- 
2.19.0-271-gfe8321ec05


