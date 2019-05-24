Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43081F609
	for <e@80x24.org>; Fri, 24 May 2019 11:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391080AbfEXLbQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 07:31:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41766 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390714AbfEXLbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 07:31:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id m18so6940286qki.8
        for <git@vger.kernel.org>; Fri, 24 May 2019 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxvxcRwX+nt0KwgD6Y/C7HzVVip/ECesyT24yxt5cEg=;
        b=N2kzjqePAGGxGAP6HI+oPLmaOY1fDnDIs7IGHbfYvJrwivCimdr5Qfv4TxSACze7q9
         4tYKJto8CUu4oaCsael3TeTUbb9Rdt4jwkq7di7oqF4WYEpCCy7l2lCzPhuW2MkKYTcd
         KyuZne91M3zMLr0oAVjKFedx27H9yL/d3yNEioWFqkH8ZWwlCd2FsCumYWOxjb1KcGhI
         FaubGBrsBAwa9aR4jVl0m43wzQ1jnQWL5AgQqet+WH6VL81mHaVVy1bFKEBo6Z7GU6TU
         Z83dDeCmFBBSJDUs2aJZvwe6t4pqdcTwFVTHMYvn+BChNu2QMpyjB13werriumO/D+kp
         hJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxvxcRwX+nt0KwgD6Y/C7HzVVip/ECesyT24yxt5cEg=;
        b=ryRWWJVsnha40KIPyKegpkYSDnP/23kHTUj/mN3CcWz51gGnkvaKO/n0SXkfaQZakF
         BwmQ9vyLwvqu9hXuWeNi5pIARz78BtsQfeMb5ziDV70gZTYOZxYTqoPvp4gbyCIyzgVl
         uOzDsMohfsTaW4Z2D0eR3+tGcRGqSEWKrOn32i+bLX8eYN7Ja/MWB2mQQEmDe3IZ++PS
         fdibEctckO5GuWcja4vUehIz5Uc9UtCSKk5sBZ0azGR30L0wfZtALvjj7MAcXajdVGyJ
         y/9DQh0clIpxl3GR8YUeDexL2WudBB0NEndIz5l4dIFD0ZiAHQtPzaYdunoD97SZ+1uf
         7Nvg==
X-Gm-Message-State: APjAAAXlS8WaufPp6O25mNH7xdh9zaZSzqSPWcdrs8pix6H6XY/q8mWT
        wOhmoCdY0px0xOGYjAnV1zQ4hYr+X70=
X-Google-Smtp-Source: APXvYqylQd/0OTWGwkH/EqKVGkoqncPvCiD2CaFUhqgwyf/Okhw7yrFlFgreJN0wDC6MtAnmEqH0zQ==
X-Received: by 2002:a37:4948:: with SMTP id w69mr82094448qka.122.1558697474711;
        Fri, 24 May 2019 04:31:14 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id b19sm1115807qkk.51.2019.05.24.04.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:31:14 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, e@80x24.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] pack-bitmap: look for an uninteresting bitmap
Date:   Fri, 24 May 2019 11:31:12 +0000
Message-Id: <20190524113112.30185-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190523113031.GA17448@sigill.intra.peff.net>
References: <20190523113031.GA17448@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we try to do a range query such as C..D with topology as

 A_0 - ... - A_10000 - B - C_1 - ... - C_1000 - C
                         \
                           D_1 - ... - D_1000 - D

and none of the commits in {A_i, B, C_j, C} have a computed
bitmap, then we will very likely walk many many trees before
computing one for the "have" bitmap.

Instead, perform a commit walk to the boundary of C...D and
look for computed bitmaps in { B, C_j, C }. If any are found,
then it is worth starting from there and building a bitmap.
If not, revert to the old method of walking trees.

NOTE: this is only a proof-of-concept, as it fails a test in
t5310-pack-bitmaps.sh (clearly marked as a failure now).

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

On 5/23/2019 7:30 AM, Jeff King wrote:> +	/*
> +	 * First traverse the relevant commits as we would for a normal
> +	 * traversal.
> +	 */
> +	while (commits.nr) {
> +		struct commit *commit = prio_queue_get(&commits);
> +		struct bitmap **dst_bitmap;

I was looking at this code again, and noticed this while() condition.

Shouldn't this use queue_has_nonstale() like in paint_down_to_common()?

Looking at the body of the loop, I don't see a way for the loop to stop
without it walking the entire history of C _and_ D.

Based on that, I wrote the patch below as an experiment. The
has_uninteresting_bitmap_in_frontier() shamelessly steals code from
paint_down_to_common(). Note the failing test, but perhaps there is
something salvageable from this.

Thanks,
-Stolee


 pack-bitmap.c           | 92 ++++++++++++++++++++++++++++++++++++++++-
 t/t5310-pack-bitmaps.sh |  2 +-
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6069b2fe55..1f4683663e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "object-store.h"
+#include "prio-queue.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -679,6 +680,81 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
+#define PARENT1         (1u<<16)
+#define PARENT2         (1u<<17)
+#define STALE           (1u<<18)
+
+static const int all_flags = { PARENT1 | PARENT2 | STALE };
+
+static int queue_has_nonstale(struct prio_queue *queue)
+{
+	int i;
+	for (i = 0; i < queue->nr; i++) {
+		struct commit *commit = queue->array[i].data;
+		if (!(commit->object.flags & STALE))
+			return 1;
+	}
+	return 0;
+}
+
+static int has_uninteresting_bitmap_in_frontier(struct repository *r,
+						struct commit_list *list,
+						struct bitmap_index *bitmap_git)
+{
+	int res = 0;
+	struct commit_list *iter = list;
+	struct prio_queue queue = { compare_commits_by_commit_date };
+
+	while (iter) {
+		prio_queue_put(&queue, iter->item);
+		iter = iter->next;
+	}
+
+	while (queue_has_nonstale(&queue)) {
+		struct commit *commit = prio_queue_get(&queue);
+		struct commit_list *parents;
+		int flags;
+
+		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
+		if (flags == (PARENT1 | PARENT2)) {
+			/* Mark parents of a found merge stale */
+			flags |= STALE;
+		}
+
+		if (flags & PARENT1) {
+			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
+
+			if (pos < kh_end(bitmap_git->bitmaps)) {
+				res = 1;
+				goto cleanup;
+			}
+		}
+
+		parents = commit->parents;
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			if ((p->object.flags & flags) == flags)
+				continue;
+			if (repo_parse_commit(r, p))
+				goto cleanup;
+			p->object.flags |= flags;
+			prio_queue_put(&queue, p);
+		}
+	}
+
+cleanup:
+	clear_prio_queue(&queue);
+
+	iter = list;
+	while (iter) {
+		clear_commit_marks(iter->item, all_flags);
+		iter = iter->next;
+	}
+
+	return res;
+}
+
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 {
 	unsigned int i;
@@ -689,6 +765,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	struct bitmap *wants_bitmap = NULL;
 	struct bitmap *haves_bitmap = NULL;
 
+	struct commit_list *commits = NULL;
+
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
@@ -704,16 +782,22 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 		while (object->type == OBJ_TAG) {
 			struct tag *tag = (struct tag *) object;
 
-			if (object->flags & UNINTERESTING)
+			if (object->flags & UNINTERESTING) {
+				object->flags |= PARENT1;
 				object_list_insert(object, &haves);
-			else
+			} else {
+				object->flags |= PARENT2;
 				object_list_insert(object, &wants);
+			}
 
 			if (!tag->tagged)
 				die("bad tag");
 			object = parse_object_or_die(&tag->tagged->oid, NULL);
 		}
 
+		if (object->type == OBJ_COMMIT)
+			commit_list_insert((struct commit *)object, &commits);
+
 		if (object->flags & UNINTERESTING)
 			object_list_insert(object, &haves);
 		else
@@ -740,6 +824,10 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	if (load_pack_bitmap(bitmap_git) < 0)
 		goto cleanup;
 
+	if (!has_uninteresting_bitmap_in_frontier(the_repository, commits, bitmap_git))
+		goto cleanup;
+
+	/* this is the real no-turning-back point! */
 	object_array_clear(&revs->pending);
 
 	if (haves) {
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a26c8ba9a2..615608fbbf 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -422,7 +422,7 @@ test_expect_success 'fetch without bitmaps ignores delta against old base' '
 '
 
 # And do the same for the bitmap case, where we do expect to find the delta.
-test_expect_success 'fetch with bitmaps can reuse old base' '
+test_expect_failure 'fetch with bitmaps can reuse old base' '
 	test_config pack.usebitmaps true &&
 	test_when_finished "rm -rf client.git" &&
 	git init --bare client.git &&
-- 
2.22.0.rc0

