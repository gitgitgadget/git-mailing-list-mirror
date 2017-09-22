Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19524202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbdIVXfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33843 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdIVXfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id i131so2481432wma.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiB1SphO5MNUssFanlAspS1dtR/3alcnM/dS5yCdEJw=;
        b=gt4jdGVm5YOM2AYeniVJkQ+NjAMgCmj6eQWmZumdfv7b61nOXze1Zsx9C20I/8tLxL
         pC46ElbvZpqjz9CRajmnPXb1k096oVYPet8fiV2BL1/d/S8l9qZ1UWouerL1dAsNbuIn
         R8/wxgsCAk1qa0CaIJ8mv+wJKtYxP6HFmV2aN1BuIBCF6zwphghQ7CNZjj9V/2d64kYp
         4IJUqj0ZrcBgmdtoA8c2TcYGOQ0rAhAhPKu2uKndGSKHmQf+XpdM6lbRhVDbqoIyFWaR
         8TU7RWHRochrF8zYz66qBVXZAAFdn6OoE1vjXcOqXxCXpAfJKfFRqcQvlFKM8I8CmQy6
         aiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiB1SphO5MNUssFanlAspS1dtR/3alcnM/dS5yCdEJw=;
        b=GqWEAXbVQ7VnXKiBvOwI1rRwNRXaMJZv9P/mhJG01JiRavUf4cu7UshhK/yMEwzcYg
         htrrA5ybOFOECtwFUXxMjneHqEeiDC+DPNr7qnSmZICwZGHxLEAmsGI4Wdbxyvh3y6Wb
         Z2f53e56Qqynh3nypiswB71P6FElQlv7MOiZk2NHlXqNa60btgdNgCmomUJqiRs5NtPz
         KhY6x2VFEcwFX4AYQBGlxDNbIdULTXgr/XuA1ke5vTpk8F9ZlG0mJ7E8a8cxIcDCV80e
         N/+dyXxVAV3m+sSWT23PYxEI/O4xzKXzfcql+oBldcQrFABF0+Z+n5k7aBHx1P7vtejW
         7Yag==
X-Gm-Message-State: AHPjjUi2faYkdWUNV2C9WhJyjLqEr/NceXNqXBCb78O6kjCiqi9oVrzw
        OwEqN5PJE/CeH3cllx9v0i7q/w==
X-Google-Smtp-Source: AOwi7QDH/GTk1wV/4VA7wfhSbuzia0kaGeFLmjS+o632d1OmYkQdjPZpq9w9Kd/Tjp6YPKJMMdEoGQ==
X-Received: by 10.28.218.146 with SMTP id r140mr4625030wmg.14.1506123329780;
        Fri, 22 Sep 2017 16:35:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 5/6] object_array: add and use `object_array_pop()`
Date:   Sat, 23 Sep 2017 01:34:53 +0200
Message-Id: <80eaae517f73f57137db6adfcaef2e8ce16576c1.1506120292.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net> <cover.1506120291.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a couple of places, we pop objects off an object array `foo` by
decreasing `foo.nr`. We access `foo.nr` in many places, but most if not
all other times we do so read-only, e.g., as we iterate over the array.
But when we change `foo.nr` behind the array's back, it feels a bit
nasty and looks like it might leak memory.

Leaks happen if the popped element has an allocated `name` or `path`.
At the moment, that is not the case. Still, 1) the object array might
gain more fields that want to be freed, 2) a code path where we pop
might start using names or paths, 3) one of these code paths might be
copied to somewhere where we do, and 4) using a dedicated function for
popping is conceptually cleaner.

Introduce and use `object_array_pop()` instead. Release memory in the
new function. Document that popping an object leaves the associated
elements in limbo.

The converted places were identified by grepping for "\.nr\>" and
looking for "--".

Make the new function return NULL on an empty array. This is consistent
with `pop_commit()` and allows the following:

	while ((o = object_array_pop(&foo)) != NULL) {
		// do something
	}

But as noted above, we don't need to go out of our way to avoid reading
`foo.nr`. This is probably more readable:

	while (foo.nr) {
		... o = object_array_pop(&foo);
		// do something
	}

The name of `object_array_pop()` does not quite align with
`add_object_array()`. That is unfortunate. On the other hand, it matches
`object_array_clear()`. Arguably it's `add_...` that is the odd one out,
since it reads like it's used to "add" an "object array". For that
reason, side with `object_array_clear()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/fast-export.c |  3 +--
 builtin/fsck.c        |  7 +------
 builtin/reflog.c      |  2 +-
 object.c              | 13 +++++++++++++
 object.h              |  7 +++++++
 shallow.c             |  2 +-
 6 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d412c0a8f..cff8d0fc5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -634,11 +634,10 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs)
 {
 	struct commit *commit;
 	while (commits->nr) {
-		commit = (struct commit *)commits->objects[commits->nr - 1].item;
+		commit = (struct commit *)object_array_pop(commits);
 		if (has_unshown_parent(commit))
 			return;
 		handle_commit(commit, revs);
-		commits->nr--;
 	}
 }
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d18244ab5..7d4ad0273 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -181,12 +181,7 @@ static int traverse_reachable(void)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 	while (pending.nr) {
-		struct object_array_entry *entry;
-		struct object *obj;
-
-		entry = pending.objects + --pending.nr;
-		obj = entry->item;
-		result |= traverse_one_object(obj);
+		result |= traverse_one_object(object_array_pop(&pending));
 		display_progress(progress, ++nr);
 	}
 	stop_progress(&progress);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6b34f23e7..2067cca5b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -126,7 +126,7 @@ static int commit_is_complete(struct commit *commit)
 		struct commit *c;
 		struct commit_list *parent;
 
-		c = (struct commit *)study.objects[--study.nr].item;
+		c = (struct commit *)object_array_pop(&study);
 		if (!c->object.parsed && !parse_object(&c->object.oid))
 			c->object.flags |= INCOMPLETE;
 
diff --git a/object.c b/object.c
index 321d7e920..b9a4a0e50 100644
--- a/object.c
+++ b/object.c
@@ -353,6 +353,19 @@ static void object_array_release_entry(struct object_array_entry *ent)
 	free(ent->path);
 }
 
+struct object *object_array_pop(struct object_array *array)
+{
+	struct object *ret;
+
+	if (!array->nr)
+		return NULL;
+
+	ret = array->objects[array->nr - 1].item;
+	object_array_release_entry(&array->objects[array->nr - 1]);
+	array->nr--;
+	return ret;
+}
+
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data)
 {
diff --git a/object.h b/object.h
index 0a419ba8d..b7629fe92 100644
--- a/object.h
+++ b/object.h
@@ -115,6 +115,13 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
+/*
+ * Returns NULL if the array is empty. Otherwise, returns the last object
+ * after removing its entry from the array. Other resources associated
+ * with that object are left in an unspecified state and should not be
+ * examined.
+ */
+struct object *object_array_pop(struct object_array *array);
 
 typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 
diff --git a/shallow.c b/shallow.c
index 54359d549..901ac9791 100644
--- a/shallow.c
+++ b/shallow.c
@@ -99,7 +99,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 				cur_depth = 0;
 			} else {
 				commit = (struct commit *)
-					stack.objects[--stack.nr].item;
+					object_array_pop(&stack);
 				cur_depth = *(int *)commit->util;
 			}
 		}
-- 
2.14.1.727.g9ddaf86

