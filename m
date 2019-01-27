Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B81F453
	for <e@80x24.org>; Sun, 27 Jan 2019 13:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfA0NIw (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 08:08:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37866 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfA0NIw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 08:08:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so14953385wrt.4
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 05:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ndYXQ++/SemBJkorJPERUSDs4zddrgtofp3TmfzX05w=;
        b=gDWfgbHxwNa+l8qh3Rnp+rZel7EuGVG2jIsYn3txZLeDZweixGzPCUIEvgouNIYQM0
         Mi9B+bEw+f7ei4VOe3Dgcw++nsueaUolQW0IDAY/7GZHIDD6iabAwXl30pxqlYB+Bd2V
         Oj2O06bsnbHVzZbS08LI00WlkksV3V2alljgAbDXe/pKd6IkOB2efRadK/JALs2vXInD
         NJHUETA637RB/DazrMC5+TILDvu0nPlRM6jVj5VomUr+mhArXIAzeT4YD+5tOW/D7yx7
         CZImAFKsQ8W3i/1hXKNK5sGKqpgwUB/ckbt+LabhvIsU/FCSnsIvBAdWkY/zQHGSxnT2
         Oh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndYXQ++/SemBJkorJPERUSDs4zddrgtofp3TmfzX05w=;
        b=tjJPMDyUCXSa1/QQHDBRFi3g+Nl9UZI9ZXpazdXWReS7ho3RfTcwj/9vwRpTTsEki1
         bGylsoxkmzYHsyJxKIYArP+orzHPrjf45EA4aYtD5/V8dK4UbJGbAeyWj5tY5SPWJQJ/
         OXZSWQHRtbAfdvLhnt2C0+omDopkBf7pK5tAFJaK7ZHlZMHLSVlzzpBvOzBImOgo+F9D
         EqYagUzrgMD/57dJH3zNqHKM1+5OJE/cesRBqavm8vs5ZGXeG+SxBwttg4uRcXLHgP4N
         17xdUyFCI8rX/xEJjkrR0Te35LDBvtt7tyY7WUlx4/KNG/pVJ+J9qjnepkchyKCJa/o+
         7HCQ==
X-Gm-Message-State: AJcUukeC+ECN65/tbwlJxr1UHWjU6VqyP+1gUq6Hcbe3emI6N0xsvOI9
        4P6h3SoxoEfkiBUJDhNW2ac=
X-Google-Smtp-Source: ALg8bN66+zL19VEgtRIPcpWjkjAwz2rTwKSH3FuylHZKWPBTZPR9hT+G+8youXONoWKTy4oR2DO6Ww==
X-Received: by 2002:adf:8001:: with SMTP id 1mr17576236wrk.23.1548594529853;
        Sun, 27 Jan 2019 05:08:49 -0800 (PST)
Received: from localhost.localdomain (x4dbd90dd.dyn.telefonica.de. [77.189.144.221])
        by smtp.gmail.com with ESMTPSA id p139sm140504650wmd.31.2019.01.27.05.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Jan 2019 05:08:49 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] object_as_type: initialize commit-graph-related fields of 'struct commit'
Date:   Sun, 27 Jan 2019 14:08:32 +0100
Message-Id: <20190127130832.23652-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.642.gc55a771460
In-Reply-To: <20190125222126.GH6702@szeder.dev>
References: <20190125222126.GH6702@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the commit graph and generation numbers were introduced in
commits 177722b344 (commit: integrate commit graph with commit
parsing, 2018-04-10) and 83073cc994 (commit: add generation number to
struct commit, 2018-04-25), they tried to make sure that the
corresponding 'graph_pos' and 'generation' fields of 'struct commit'
are initialized conservatively, as if the commit were not included in
the commit-graph file.

Alas, initializing those fields only in alloc_commit_node() missed the
case when an object that happens to be a commit is first looked up via
lookup_unknown_object(), and is then later converted to a 'struct
commit' via the object_as_type() helper function (either calling it
directly, or as part of a subsequent lookup_commit() call).
Consequently, both of those fields incorrectly remain set to zero,
which means e.g. that the commit is present in and is the first entry
of the commit-graph file.  This will result in wrong timestamp, parent
and root tree hashes, if such a 'struct commit' instance is later
filled from the commit-graph.

Extract the initialization of 'struct commit's fields from
alloc_commit_node() into a helper function, and call it from
object_as_type() as well, to make sure that it properly initializes
the two commit-graph-related fields, too.  With this helper function
it is hopefully less likely that any new fields added to 'struct
commit' in the future would remain uninitialized.

With this change alloc_commit_index() won't have any remaining callers
outside of 'alloc.c', so mark it as static.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

So, it turns out that ec0c5798ee (revision: use commit graph in
get_reference(), 2018-12-04) is not the culprit after all, it merely
highlighted a bug that is as old as the commit-graph feature itself.
This patch fixes this and all other related issues I reported
upthread.

I couldn't find any other place where an object of unknown type is
turned into a 'struct commit', so this might have been the only place
that needed fixing.

Other object types seem to be fine, because they contain only fields
that should be zero initialized.  At least for now, because a similar
issue might arise in the future, if one of them gains a new field that
should not be initialized to zero...  but will they ever get such a
field?  So I'm not too keen on introducing similar init_tree_node(),
etc. helper funcions at the moment.

 alloc.c  | 11 ++++++++---
 alloc.h  |  2 +-
 object.c |  5 +++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/alloc.c b/alloc.c
index e7aa81b7aa..1c64c4dd16 100644
--- a/alloc.c
+++ b/alloc.c
@@ -99,18 +99,23 @@ void *alloc_object_node(struct repository *r)
 	return obj;
 }
 
-unsigned int alloc_commit_index(struct repository *r)
+static unsigned int alloc_commit_index(struct repository *r)
 {
 	return r->parsed_objects->commit_count++;
 }
 
-void *alloc_commit_node(struct repository *r)
+void init_commit_node(struct repository *r, struct commit *c)
 {
-	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index(r);
 	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
 	c->generation = GENERATION_NUMBER_INFINITY;
+}
+
+void *alloc_commit_node(struct repository *r)
+{
+	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
+	init_commit_node(r, c);
 	return c;
 }
 
diff --git a/alloc.h b/alloc.h
index ba356ed847..ed1071c11e 100644
--- a/alloc.h
+++ b/alloc.h
@@ -9,11 +9,11 @@ struct repository;
 
 void *alloc_blob_node(struct repository *r);
 void *alloc_tree_node(struct repository *r);
+void init_commit_node(struct repository *r, struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 void alloc_report(struct repository *r);
-unsigned int alloc_commit_index(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
diff --git a/object.c b/object.c
index c4170d2d0c..7bccfd5d8e 100644
--- a/object.c
+++ b/object.c
@@ -164,8 +164,9 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			((struct commit *)obj)->index = alloc_commit_index(r);
-		obj->type = type;
+			init_commit_node(r, (struct commit *) obj);
+		else
+			obj->type = type;
 		return obj;
 	}
 	else {
-- 
2.20.1.642.gc55a771460

