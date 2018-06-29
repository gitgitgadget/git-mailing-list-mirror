Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643431F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936477AbeF2BXJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:09 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:40185 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936468AbeF2BXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:05 -0400
Received: by mail-io0-f201.google.com with SMTP id r10-v6so5636004ioh.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=G/ZfassT88Se/jXLVIsBm6s5YHX7OLdDGl1rp4Sc4wA=;
        b=a34m5JC/yMAPcnb+rZN4MouLSlZMyIL6QRCL9x9onPkuX4oX1TZITqqnDKUDPI4+z1
         YYFu7ZuKPsxCRAJXUNzQTxyotmp6XP1sKJVUWumjZPwfDQFqhV4IBLzmA2+K3DzpVW6O
         JfVXA/OZS9lB5q5fx+sFez9u4tv3gDj/dJ8b8p2lHswCr3gEBKbIg9vJaoYa/f0JzfRR
         xih34nhoVK28qTCew85b2K9fIj4GdS0MMsnKrvziT1abg4hV/dw113ztOugs5Zko9/Rk
         InJNCbilvo/6cgDJFfflR52pKkdnPSmhQO/OjSK2Dd2YIKEgiB1+PyvCey/kdFBVZLqC
         VC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=G/ZfassT88Se/jXLVIsBm6s5YHX7OLdDGl1rp4Sc4wA=;
        b=UJAzLXhW83K8/O7xFtWRqEkrYr09vlp0QwuJmCTkFar86ZqSGDfXriEabK0jyA7kXt
         XyfLEslQ8968PFliuGsq0jPB+9Z3w2Zz/Z0YR3YmwiWXr52NR2T/EiKOdqw5BCtSICcj
         XdeF/X+iTl5z/8e5VPG9JHX7+NahMLIIy5SbH4xFQ8mIXMZw6hcZr9jG27OFzaBX2hc5
         4WlMYTWzNf1Lny4TNU0IBr0pFgK9K18aVy45jXxR6XjrVlVzqnABthh8VikMVgVC3aNx
         2VH2b/ALIvQfA/W/ahaSkTPBBnbcwGgD+GnQaq+6R4EShEu/HUpgzha+oW77S0EEs91z
         AbQQ==
X-Gm-Message-State: APt69E3jhRSIwYBZn6nZAF+LByKQoszIT8H8rqoJ2u0fo2INwO/ZuyxH
        yHs5RipZLCyQGatXNGyciBbyJrqYVrXr98PsdHP6z0btYvW+i5DM6oUtJ50aC+71U51CwRGvr4l
        H72YRIAMiXujxmaa1prKosqLOmvvaiMhQAVCiHVkdjmnjZtWD86BEo6zuj4KM
X-Google-Smtp-Source: AAOMgpdTvEmzJs10alyp299ePGx7kTnq62VVKodK6KbcKBFXnw8yuG8YvDDYLWQIoHRAcp945DkFt8s/Cc35
MIME-Version: 1.0
X-Received: by 2002:a24:7853:: with SMTP id p80-v6mr90135itc.4.1530235385215;
 Thu, 28 Jun 2018 18:23:05 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:04 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-15-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 14/32] tag: add repository argument to parse_tag_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_tag_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 2 +-
 log-tree.c        | 2 +-
 object.c          | 2 +-
 sha1-file.c       | 2 +-
 tag.c             | 4 ++--
 tag.h             | 3 ++-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 0351b7c62cf..ef22d724bbc 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -405,7 +405,7 @@ static int check_one_mergetag(struct commit *commit,
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		return error(_("bad mergetag in commit '%s'"), ref);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		return error(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
diff --git a/log-tree.c b/log-tree.c
index 840423ca149..76475d0136b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -503,7 +503,7 @@ static int show_one_mergetag(struct commit *commit,
 		return -1; /* error message already given */
 
 	strbuf_init(&verify_message, 256);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
 	else if (is_common_merge(commit) &&
 		 !oidcmp(&tag->tagged->oid,
diff --git a/object.c b/object.c
index bcfcfd38760..e095d49b379 100644
--- a/object.c
+++ b/object.c
@@ -225,7 +225,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
-			if (parse_tag_buffer(tag, buffer, size))
+			if (parse_tag_buffer(the_repository, tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
diff --git a/sha1-file.c b/sha1-file.c
index 75ba30b4ab1..c75ef771f8b 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1809,7 +1809,7 @@ static void check_tag(const void *buf, size_t size)
 {
 	struct tag t;
 	memset(&t, 0, sizeof(t));
-	if (parse_tag_buffer(&t, buf, size))
+	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die("corrupt tag");
 }
 
diff --git a/tag.c b/tag.c
index 5b41fc71fad..4971fd4dfc9 100644
--- a/tag.c
+++ b/tag.c
@@ -126,7 +126,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -203,7 +203,7 @@ int parse_tag(struct tag *item)
 		return error("Object %s not a tag",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_tag_buffer(item, data, size);
+	ret = parse_tag_buffer(the_repository, item, data, size);
 	free(data);
 	return ret;
 }
diff --git a/tag.h b/tag.h
index 276c448cd55..149959c81ba 100644
--- a/tag.h
+++ b/tag.h
@@ -13,7 +13,8 @@ struct tag {
 };
 #define lookup_tag(r, o) lookup_tag_##r(o)
 extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
-extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
+#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
+extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 extern struct object *deref_tag(struct object *, const char *, int);
-- 
2.18.0.399.gad0ab374a1-goog

