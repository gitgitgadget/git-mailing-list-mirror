Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2291FBF4
	for <e@80x24.org>; Sat, 28 Oct 2017 00:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdJ1ApR (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 20:45:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:54482 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdJ1ApM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 20:45:12 -0400
Received: by mail-io0-f195.google.com with SMTP id e89so16132435ioi.11
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dpa/bICKy7WulVihW8hYuqhyDGEgZLEw2vaN0OB8hWM=;
        b=U3MCpUnZnBhGLLpU2/AYl4vSPhLuU2ETHHJ++Mz5vaE9eKbMBjoSim/ug08K6eT/4p
         mHtZE6Gd4wvcFl2ylYOvkAl4FwYuHul2kh7Sty9DknF653hWEr2PoEugoXTXDZqFRtDc
         x/n+eOz23mRk/TGdUAtZ9DMouDyvfH0nuMq5dKsyX2msGWa2OHJGK9Vr1geGZc8zlorG
         qutTc0yRIx9kABDF0dldzd8rNv4+t5FhyW47JsGYccKaSqgaHj3s9EWusGP2ndk5Z1aS
         TyycPGJizrGvu/BWHXdRiQcoAxVfEzlOl1oQp1j5fquOXqJ9/wkj7N0838N8B70lXJm3
         FIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dpa/bICKy7WulVihW8hYuqhyDGEgZLEw2vaN0OB8hWM=;
        b=p/acjFZUdh6IvS7h4HeX8VGkl7NvrQwSpXgPY+kZZV9WpfUfYx1h4PEhjjG2gXx3ZN
         XzeVmeCnqWzl0hnHlwyeMpz59sE1L9/r0OxBqbtc5QgXEA3a5R8qOwLCNe/sBzQdtN0n
         nndq+wpCRuA/eg+nMgwVRi5IzygLRk2PPTfdA/u9hxPfaLJx8ljormltSdiQZJ+V4iFR
         wQGEU2g0Aex/EKT3CcyJ0AJoRd7mHTOoIcqtGG9TGQbuGjKD53wNg8q9LLmYmr9V5lD8
         ejEDxWARUypt+Uy9W5Z92KoBVGieNhpvFgZHww7bdmzRS6vigj/57iXK3cURTRthfABa
         i76A==
X-Gm-Message-State: AMCzsaW4qBTNP9ctiStVqYik2nBCKhel9vjp60lU+0b8jn3hRwO5TETa
        uXqSH+wi9qSulO/9TTDZXrIxEA==
X-Google-Smtp-Source: ABhQp+SLCOjZJuFT4SAoAoyl0bJ8gRU68cFWAhuvoDDdvOy/or79JrFQv4H4riDKOoi5BS1JFyRdZw==
X-Received: by 10.107.135.202 with SMTP id r71mr2733120ioi.26.1509151512066;
        Fri, 27 Oct 2017 17:45:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id k18sm3912246ioc.75.2017.10.27.17.45.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 17:45:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 3/3] builtin/describe: describe blobs
Date:   Fri, 27 Oct 2017 17:45:06 -0700
Message-Id: <20171028004506.10253-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171028004506.10253-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171028004506.10253-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes users are given a hash of an object and they want to
identify it further (ex.: Use verify-pack to find the largest blobs,
but what are these? or [1])

The best identification of a blob hash is done via a its path at a
given commit, which this implements.

[1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..752de5843b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -11,8 +11,9 @@
 #include "hashmap.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "revision.h"
+#include "list-objects.h"
 
-#define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
@@ -282,6 +283,50 @@ static void show_suffix(int depth, const struct object_id *oid)
 	printf("-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
 }
 
+struct blob_descriptor {
+	struct object_id current_commit;
+	struct object_id looking_for;
+};
+
+static void process_commit(struct commit *commit, void *data)
+{
+	struct blob_descriptor *bd = data;
+
+	bd->current_commit = commit->object.oid;
+}
+
+static void process_object(struct object *obj, const char *name, void *data)
+{
+	struct blob_descriptor *bd = data;
+
+	if (!oidcmp(&bd->looking_for, &obj->oid))
+		printf(_("blob %s present at path %s in commit %s\n"),
+			oid_to_hex(&bd->looking_for), name,
+			oid_to_hex(&bd->current_commit));
+}
+
+static void describe_blob(struct object_id oid)
+{
+	struct rev_info revs;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct blob_descriptor bd = { null_oid, oid };
+
+	argv_array_pushl(&args, "internal: The first arg is not parsed",
+		"--all", "--single-worktree", "--objects", NULL);
+
+	revs.tree_blobs_in_commit_order = 1;
+
+	init_revisions(&revs, NULL);
+
+	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
+		BUG("setup_revisions could not handle all args?");
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	traverse_commit_list(&revs, process_commit, process_object, &bd);
+}
+
 static void describe(const char *arg, int last_one)
 {
 	struct object_id oid;
@@ -295,9 +340,14 @@ static void describe(const char *arg, int last_one)
 
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference(&oid);
-	if (!cmit)
-		die(_("%s is not a valid '%s' object"), arg, commit_type);
+	cmit = lookup_commit_reference_gently(&oid, 1);
+	if (!cmit) {
+		if (lookup_blob(&oid))
+			describe_blob(oid);
+		else
+			die(_("%s is not a commit nor blob"), arg);
+		return;
+	}
 
 	n = find_commit_name(&cmit->object.oid);
 	if (n && (tags || all || n->prio == 2)) {
-- 
2.15.0.rc2.443.gfcc3b81c0a

