Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAA21F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935934AbeFMXGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:05 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:48648 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMXGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:03 -0400
Received: by mail-vk0-f73.google.com with SMTP id e204-v6so1628947vke.15
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rzBCRWTClK7FduFOhpkhzKb33KJIl8160YaFL2NcMmc=;
        b=q3U4IRxdMLwoQKAkwB8LAUwdMsD60OvpMFqstHFdngjd0f/ojFPeoSJnLnqniz3sZ2
         nxcr5XY2RV4rz35mOcWffekyyk7JoSwtSEvBVfw1Ee+vc2rGvH56iG1y0606N+NLkujD
         iRguu7dPQSmUMRyryNYdb/EVwlAIzNMdJK7S6NEaPgtxwOM4tADWC1D0bwUpraLYStfJ
         neV1X42EdpvCW4kzusjeC2SJKVM3hevxNycK9kz7OOTu8ECEP8G3ochj1yxQv+auprMf
         zr6eEZxl0Vx8MliQkgPwaKPvav7mH/aFmIgtvKmMPdSVOaKWv7pP3qHYEh78YvxKy9un
         o+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rzBCRWTClK7FduFOhpkhzKb33KJIl8160YaFL2NcMmc=;
        b=o4zcVz5AUYpXpReyp1jPIONG7nl1qzy8Jqp6zuR33EBrh7CDUtc4NT5Mu1WDiXsP3u
         g0Cv/JDKUHS0Q/INSx5/FtQQaEg3jTAV1oKLs/5qm0CzD7FYmrFULF7PSt747KxPXFhv
         XWfQRi7MPztH5tI9LRINJDboneWAMWaqmMRfNv0NJp9260t8PyeB20oZ4mTyNounzAtK
         phZjK5UfO2M17j5Xthct9ajZnWs9YLL2lx9W9tfuRTvpkjgD6o8i5qHALeYAgMfBndVM
         Odx01TkucVBt50HlnVtvqcglnVagF9hWxm9oZAKMRrvFDUPgsdBR4W9Z2UWmpLGZbSMI
         IhQg==
X-Gm-Message-State: APt69E36wkhe8bi4D54GKfYBZpo/Szd+jEPcEuDyPPN8l4gi+2gDIzH5
        9Jp0eL8NNCUkFvPV5/lupe3ErXIJ6NgO52wnuqHY8S8oEf3fxlpoGmXwz7UKyo7wxpIN1doRSiA
        oJwVHeBFmQdbTkOtPy7YQiRBxSNf8NI1UPaAluA3DpzH5ko5vaqpZawHbaAUZ
X-Google-Smtp-Source: ADUXVKK/Cj6Xb1yIxChIG9kxYBBH3d3jjJ3xn2IBmUNm9HTKb1FC2hTsTX80kXr91gNjvehK4v//YTC0R/GN
MIME-Version: 1.0
X-Received: by 2002:ab0:5982:: with SMTP id g2-v6mr83167uad.102.1528931162806;
 Wed, 13 Jun 2018 16:06:02 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:03 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-13-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 12/31] tag: add repository argument to lookup_tag
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
index 080b5ce082c..6fb713b6be1 100644
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
index 8c108109985..eb11ef4a5dd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2365,7 +2365,7 @@ static void add_tag_chain(const struct object_id *oid)
 	if (packlist_find(&to_pack, oid->hash, NULL))
 		return;
 
-	tag = lookup_tag(oid);
+	tag = lookup_tag(the_repository, oid);
 	while (1) {
 		if (!tag || parse_tag(tag) || !tag->tagged)
 			die("unable to pack objects reachable from tag %s",
diff --git a/builtin/replace.c b/builtin/replace.c
index 14e142d5a80..8c8cec4aae6 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -359,7 +359,7 @@ static void check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
-	tag = lookup_tag(&tag_oid);
+	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
diff --git a/log-tree.c b/log-tree.c
index a47283eca64..727758eb442 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -506,7 +506,7 @@ static void show_one_mergetag(struct commit *commit,
 	size_t payload_size, gpg_message_offset;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
-	tag = lookup_tag(&oid);
+	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return; /* error message already given */
 
diff --git a/object.c b/object.c
index ecaac5c2990..080e9b36eaf 100644
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
index 5eef8ddd6d6..98b66c4896c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -359,7 +359,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
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
2.18.0.rc1.244.gcf134e6275-goog

