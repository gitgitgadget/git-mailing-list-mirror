Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054AA1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030453AbeF2BYH (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:24:07 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:46092 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936441AbeF2BXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:03 -0400
Received: by mail-oi0-f74.google.com with SMTP id w189-v6so4800230oiw.13
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=43/13s5G//UBTV6z0LytVehtLQpI/CNauiXgGx/kspE=;
        b=oGUs/yfpE8ewr1s7S8lFF+ag3ObQDkTH9wgN/OshVDJYmUYNXKftsyfFzhuILaKuiD
         tZo5tPDB4UnCruvlR/UJ7eXr9vGGId6dj8q4Z4kHZsdqw2oq8YQgvVI2tfF9q07XPC7x
         USCB2uAbH6Fiqv/S/+fKlm2/Vkg4JT+IDDRO3e/4Fogz10i/0VKidOgEimiQz+RmKkCB
         BbvdazjL9aZRrJsyxiGB3PZLLdVHRa770ZNzOtPph8JsOhu7qI3N7ruMtkzMm7JZZHH+
         7wDe0vb4f0sTxW2THxpQM/em16BpsDPUZNz1v8UA/Y+RkuJyL9SXB3uYXTYdPlSlIL/n
         CQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=43/13s5G//UBTV6z0LytVehtLQpI/CNauiXgGx/kspE=;
        b=V6FtDAGwnuJrrIDXdKlOT4im+EojVgzekjd4ofATrMc6Xhy/ThXf95/n9ydvDuc+jk
         m+thltxrErYMXLQLlRWrVI7rx+/s8riDa8xZUFa/W2PmEojufKagQsKqk+UL4i7R9Oio
         9LBXbAHEO2ydvZOi/8Rpp4OUaNxEdbmsaeIhxFmWaCiaC3MDhyMzsNKHzTzDPXhgemhV
         Wve938k0xWgUwgrpfKkcdRpMYd9b5PoHvRPhb6anQddCzU0dah2K+KVbpW+UAs0pBkVL
         s7LYt/eTudP8wr1ZvpMOHh7Xt1xaQN/D4Z/+JFnhRiKpBvSwMDFnmAkAfl0Nu/Y+ZKuv
         yfwQ==
X-Gm-Message-State: APt69E392k5uLuXUTJhuZ7JxXlyDYgv5emprVcSNaObKJC3X2RMnRcrG
        tSyeaKrRfkXXLXa6yWrRK9jRbpioNPsZoABQcHQ7z76sFiXQH8wdNnlFxtk9be23KZQVtZ8Vqzq
        SbgKdVqlrvrhZotfc9caAyqQ6DboCNIddqzqcSte1g8EozXJ2113RKTrYiwdi
X-Google-Smtp-Source: AAOMgpdwI3+h8KVahwjaM1nLvJ5Qmo7Eur+nIyC1tbHtZIRDgNRqKgwaXYqgJfq8gEV16thVBZeaODvGYkNa
MIME-Version: 1.0
X-Received: by 2002:a9d:34ca:: with SMTP id t10-v6mr5338971otd.63.1530235382783;
 Thu, 28 Jun 2018 18:23:02 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:03 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-14-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 13/32] tag: add repository argument to lookup_tag
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_tag
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c     | 6 +++---
 builtin/pack-objects.c | 2 +-
 builtin/replace.c      | 2 +-
 log-tree.c             | 2 +-
 object.c               | 2 +-
 sha1-name.c            | 2 +-
 tag.c                  | 4 ++--
 tag.h                  | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index c8ff64766d0..41606c8a900 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -93,13 +93,13 @@ static int replace_name(struct commit_name *e,
 		struct tag *t;
 
 		if (!e->tag) {
-			t = lookup_tag(&e->oid);
+			t = lookup_tag(the_repository, &e->oid);
 			if (!t || parse_tag(t))
 				return 1;
 			e->tag = t;
 		}
 
-		t = lookup_tag(oid);
+		t = lookup_tag(the_repository, oid);
 		if (!t || parse_tag(t))
 			return 0;
 		*tag = t;
@@ -267,7 +267,7 @@ static unsigned long finish_depth_computation(
 static void append_name(struct commit_name *n, struct strbuf *dst)
 {
 	if (n->prio == 2 && !n->tag) {
-		n->tag = lookup_tag(&n->oid);
+		n->tag = lookup_tag(the_repository, &n->oid);
 		if (!n->tag || parse_tag(n->tag))
 			die(_("annotated tag %s not available"), n->path);
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 69d3d7b82af..6565c800ac3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2474,7 +2474,7 @@ static void add_tag_chain(const struct object_id *oid)
 	if (packlist_find(&to_pack, oid->hash, NULL))
 		return;
 
-	tag = lookup_tag(oid);
+	tag = lookup_tag(the_repository, oid);
 	while (1) {
 		if (!tag || parse_tag(tag) || !tag->tagged)
 			die("unable to pack objects reachable from tag %s",
diff --git a/builtin/replace.c b/builtin/replace.c
index 0232f98f020..0351b7c62cf 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -402,7 +402,7 @@ static int check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
-	tag = lookup_tag(&tag_oid);
+	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		return error(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
diff --git a/log-tree.c b/log-tree.c
index abe67e8b2e4..840423ca149 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -498,7 +498,7 @@ static int show_one_mergetag(struct commit *commit,
 	size_t payload_size, gpg_message_offset;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
-	tag = lookup_tag(&oid);
+	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return -1; /* error message already given */
 
diff --git a/object.c b/object.c
index f08a8874de3..bcfcfd38760 100644
--- a/object.c
+++ b/object.c
@@ -223,7 +223,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid);
+		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
 			if (parse_tag_buffer(tag, buffer, size))
 			       return NULL;
diff --git a/sha1-name.c b/sha1-name.c
index 98480ade12d..5854bc75fe2 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -358,7 +358,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid);
+		struct tag *tag = lookup_tag(the_repository, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
diff --git a/tag.c b/tag.c
index 5dcdf7bf6f9..5b41fc71fad 100644
--- a/tag.c
+++ b/tag.c
@@ -92,7 +92,7 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag(const struct object_id *oid)
+struct tag *lookup_tag_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
@@ -160,7 +160,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(&oid);
+		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index 9057d76a506..276c448cd55 100644
--- a/tag.h
+++ b/tag.h
@@ -11,8 +11,8 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-
-extern struct tag *lookup_tag(const struct object_id *oid);
+#define lookup_tag(r, o) lookup_tag_##r(o)
+extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
-- 
2.18.0.399.gad0ab374a1-goog

