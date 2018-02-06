Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FCE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBFAS3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:18:29 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38751 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFAS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:27 -0500
Received: by mail-pl0-f66.google.com with SMTP id 13so121146plb.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lh6floVyumKy1WUQ6RcwEosWRSjfo2wEUL5+VanFNwg=;
        b=f0pGZcVMNN977XjDWOtXPjOP/IH1qoV3WucQVYaWt7cO9g8Z4IL/t5eMyKiGqtUy83
         reCCq2/mO/9zWVVYlqsa0wnm8lUWcPigH0b2jK3/YvA3NUSay10Y06xuZwD93SrUi3q+
         18KtvhBg0iOjETXDuKhdqfgrbDv0+5hZbCHshsrUDVJXGQVhoN/Qq/2+wCEFv/X30E7m
         tGjPcgFi0NJ29zATugqKg76A8alMRf08aw+FQe41KpZGChTSOnqmFgUw9T2uXmCWQpPj
         xwdDHUR8yhsRgvoUzDTHeoideNVfiAp0/RJh2KCCAfdwo2/EuFFOrIja29Syx62MrVzY
         AxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lh6floVyumKy1WUQ6RcwEosWRSjfo2wEUL5+VanFNwg=;
        b=QDD0fkHoV2FZAZ7Cras7BzQIFHQFev4ikj8JvfuYd3Mm1jV3ooHGNG8Oxbto50dhAI
         6KnUXCfP0UYm45kcFH8lJ4azay4DVabPGVNehZW514Y0PZgj9C+1I9S9hdRAd4Wb7Mb+
         Okjn+3V9CvLi/IsoR4Os72Gg97j2w63z6rrj+dsq8L0irm+MP1dNZPzw5JKrdZJC9WDI
         1VrAV+ZZv/T8QdQkmZN0m5fQcZYt1MXgiaaPyw0OM1CTxkdS/DYhyYkF/oTTaSLTBBF6
         5tsRkF64m8QA7mBxZ4MZ5I56rIZ0jc8t4jKCme4VgTtWoAi6bpZ4sXF9JeJekBiIfVlJ
         DtIw==
X-Gm-Message-State: APf1xPBPBhri1pdaaNw+519ZfzMyHLqx+Bhq9Kqz4Wna9fygrqda5Hm7
        rHp/XSejowsFHoryiUZQAIgbZNYu9uA=
X-Google-Smtp-Source: AH8x226V1nXZ5tOMUHfH+nM0v9yGc9iz2eRglpEy25V3PRG2pb9TFjoHr/5dYySLzgOY8pJwuBhxGA==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr531495plz.307.1517876306590;
        Mon, 05 Feb 2018 16:18:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s90sm19328049pfi.139.2018.02.05.16.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:18:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 102/194] object: add repository argument to lookup_unknown_object
Date:   Mon,  5 Feb 2018 16:16:17 -0800
Message-Id: <20180206001749.218943-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of lookup_unknown_object to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fsck.c                         | 2 +-
 builtin/pack-objects.c                 | 2 +-
 contrib/coccinelle/object_parser.cocci | 7 +++++++
 http-push.c                            | 2 +-
 object.c                               | 2 +-
 object.h                               | 3 ++-
 refs.c                                 | 2 +-
 t/helper/test-example-decorate.c       | 6 +++---
 upload-pack.c                          | 2 +-
 walker.c                               | 2 +-
 10 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 79da01d338..78cd8cdc69 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -615,7 +615,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 
 static void mark_object_for_connectivity(const struct object_id *oid)
 {
-	struct object *obj = lookup_unknown_object(oid->hash);
+	struct object *obj = lookup_unknown_object(the_repository, oid->hash);
 	obj->flags |= HAS_OBJ;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6348a5e721..fae579f12a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2672,7 +2672,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 
 		for (i = 0; i < p->num_objects; i++) {
 			nth_packed_object_oid(&oid, p, i);
-			o = lookup_unknown_object(oid.hash);
+			o = lookup_unknown_object(the_repository, oid.hash);
 			if (!(o->flags & OBJECT_ADDED))
 				mark_in_pack_object(o, p, &in_pack);
 			o->flags |= OBJECT_ADDED;
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 987630f70f..43a312480f 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -105,3 +105,10 @@ expression E;
  lookup_commit_graft(
 +the_repository,
  E)
+
+@@
+expression E;
+@@
+ lookup_unknown_object(
++the_repository,
+ E)
diff --git a/http-push.c b/http-push.c
index de5e70ea7b..7cefc2df76 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1427,7 +1427,7 @@ static void one_remote_ref(const char *refname)
 	 * may be required for updating server info later.
 	 */
 	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
-		obj = lookup_unknown_object(ref->old_oid.hash);
+		obj = lookup_unknown_object(the_repository, ref->old_oid.hash);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
 		add_fetch_request(obj);
diff --git a/object.c b/object.c
index 7cac87aa22..3eb12bec49 100644
--- a/object.c
+++ b/object.c
@@ -174,7 +174,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 }
 
-struct object *lookup_unknown_object(const unsigned char *sha1)
+struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(the_repository, sha1);
 	if (!obj)
diff --git a/object.h b/object.h
index d59edc88af..083111d7b7 100644
--- a/object.h
+++ b/object.h
@@ -130,7 +130,8 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
 struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
-struct object *lookup_unknown_object(const unsigned  char *sha1);
+#define lookup_unknown_object(r, s) lookup_unknown_object_##r(s)
+struct object *lookup_unknown_object_the_repository(const unsigned char *sha1);
 
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
diff --git a/refs.c b/refs.c
index ddcb4a908f..0ea9b05d03 100644
--- a/refs.c
+++ b/refs.c
@@ -300,7 +300,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(name->hash);
+	struct object *o = lookup_unknown_object(the_repository, name->hash);
 
 	if (o->type == OBJ_NONE) {
 		int type = sha1_object_info(the_repository, name->hash, NULL);
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 90dc97a9d0..156b72733e 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -25,8 +25,8 @@ int cmd_main(int argc, const char **argv)
 	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
 	 * decoration.
 	 */
-	one = lookup_unknown_object(one_oid.hash);
-	two = lookup_unknown_object(two_oid.hash);
+	one = lookup_unknown_object(the_repository, one_oid.hash);
+	two = lookup_unknown_object(the_repository, two_oid.hash);
 	ret = add_decoration(&n, one, &decoration_a);
 	if (ret)
 		die("BUG: when adding a brand-new object, NULL should be returned");
@@ -55,7 +55,7 @@ int cmd_main(int argc, const char **argv)
 	ret = lookup_decoration(&n, two);
 	if (ret != &decoration_b)
 		die("BUG: lookup should return added declaration");
-	three = lookup_unknown_object(three_oid.hash);
+	three = lookup_unknown_object(the_repository, three_oid.hash);
 	ret = lookup_decoration(&n, three);
 	if (ret)
 		die("BUG: lookup for unknown object should return NULL");
diff --git a/upload-pack.c b/upload-pack.c
index 469a843669..9c003553f8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -898,7 +898,7 @@ static void receive_needs(void)
 static int mark_our_ref(const char *refname, const char *refname_full,
 			const struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(oid->hash);
+	struct object *o = lookup_unknown_object(the_repository, oid->hash);
 
 	if (ref_is_hidden(refname, refname_full)) {
 		o->flags |= HIDDEN_REF;
diff --git a/walker.c b/walker.c
index 2b6bd9da81..b96e00a8f1 100644
--- a/walker.c
+++ b/walker.c
@@ -288,7 +288,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
 			goto done;
 		}
-		if (process(walker, lookup_unknown_object(oids[i].hash)))
+		if (process(walker, lookup_unknown_object(the_repository, oids[i].hash)))
 			goto done;
 	}
 
-- 
2.15.1.433.g936d1b9894.dirty

