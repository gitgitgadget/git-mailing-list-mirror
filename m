Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C5E20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 23:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLKXtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 18:49:32 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45716 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKXtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 18:49:31 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so18534549qtr.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AlftHj2ujftvPOoUScTIaiLEPtRGjHi1QQWqXjN43VQ=;
        b=R7MGAdCFfbPIi/DyXL9J8H+zQwXsBWXAbm9NpOIwQnDSxfQYyx8mTvbUWFVZBTjKVE
         CR+6iTep9p5h6yhfMGr3nBwLolzNbQ1UMMeg0sqgckJZhX75eyDB3WGtmOiyhNRWT7Cc
         DlpK+vMgDUf8LfJcwM/Hx6OE4DH5arTWIw12e9YhAKLD8ykCEsR9/j6FdHAoQC6V6D5L
         VnR7qspDIdFNZAIqFyzvCtDPkdwcFlmq8TPXC1tYPxTN+KXHrNXuYzU5eXU2Zy9YqcyY
         XVEN9JPFsH0/SeMZlWpiqxlyTQDfAsTyHMaPDl6qjNPupEBZCleHnMtTToRbxoawcMQT
         MxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AlftHj2ujftvPOoUScTIaiLEPtRGjHi1QQWqXjN43VQ=;
        b=eewzGz/mE+Ow0kIvjRSMdGHnQ5+N4BDxg6LcvLdaQIkKbbLKcKhZzwCt81RjZUpXih
         niASqTE+G+2cUculNqrcwJCDOuc6cjSybjWgr7lEodQ5X977Xl+kGT84U2E2I+AHJAeg
         EQI/hi1CRBZxpjemmMmPTgtgP9/qi3HJci1Ul/V0MLPyK0Uz/7un55pORYNGPc6vv1xw
         KDTzXCdYKz2JnpEqO0hQVhQWc6MLSGGWo1xrEwQ1490giqJPUCrPWY3JhcV5Op67rFf8
         orHsRJQpIxBcs4nK6Hr131/+kpmoFhuPu6v5iaH09J7LsjnurLeQu8CtlHMATZr9IBhM
         fY/Q==
X-Gm-Message-State: AA+aEWbg0w2prT0zzWIG07IrADAjSu4J1D4eXnY2ughR5Axbf+HNHN7V
        HINbOBXoUeKFPSHUznHTYWOB8UQk
X-Google-Smtp-Source: AFSGD/VZMEvaq86WAdKMScNEw2/AtANsf6JCl5v4FpVII4EztUPNNPOFFbqf7Hu/gEMXUMxaPzAEmg==
X-Received: by 2002:a0c:88e6:: with SMTP id 35mr17243036qvo.61.1544572169908;
        Tue, 11 Dec 2018 15:49:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:fd8f])
        by smtp.gmail.com with ESMTPSA id q38sm10108450qtj.65.2018.12.11.15.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:49:29 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com, Tejun Heo <htejun@fb.com>
Subject: [PATCH 1/5] trailer: Implement a helper to reverse-map trailer xrefs
Date:   Tue, 11 Dec 2018 15:49:05 -0800
Message-Id: <20181211234909.2855638-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211234909.2855638-1-tj@kernel.org>
References: <20181211234909.2855638-1-tj@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tejun Heo <htejun@fb.com>

Some trailers refer to other commits.  Let's call them xrefs
(cross-references).  For example, a cherry pick trailer points to the
source commit.  It is sometimes useful to build a reverse map of these
xrefs - ie. source -> cherry-pick instead of cherry-pick -> source.

This patch implements trailer helpers to enable such reverse maps.

The helpers can process arbitrary trailers and once the xrefs are
recorded, the reverse-mapping can be iterated per source commit using
trailer_rev_xrefs_for_each().

Signed-off-by: Tejun Heo <htejun@fb.com>
---
 trailer.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 trailer.h |  38 ++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/trailer.c b/trailer.c
index 0796f326b..15744600b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "string-list.h"
 #include "run-command.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tempfile.h"
 #include "trailer.h"
@@ -1170,3 +1171,107 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	format_trailer_info(out, &info, opts);
 	trailer_info_release(&info);
 }
+
+implement_static_commit_slab(trailer_rxrefs_slab, struct object_array *);
+
+static struct object_array *get_trailer_rxrefs(
+			struct trailer_rev_xrefs *rxrefs, struct commit *commit)
+{
+	struct object_array **slot =
+		trailer_rxrefs_slab_peek(&rxrefs->slab, commit);
+
+	return slot ? *slot : NULL;
+}
+
+static struct object_array *get_create_trailer_rxrefs(
+			struct trailer_rev_xrefs *rxrefs, struct commit *commit)
+{
+	struct object_array **slot =
+		trailer_rxrefs_slab_at(&rxrefs->slab, commit);
+
+	if (*slot)
+		return *slot;
+
+	add_object_array(&commit->object, oid_to_hex(&commit->object.oid),
+			 &rxrefs->dst_commits);
+	*slot = xmalloc(sizeof(struct object_array));
+	**slot = (struct object_array)OBJECT_ARRAY_INIT;
+	return *slot;
+}
+
+void trailer_rev_xrefs_init(struct trailer_rev_xrefs *rxrefs,
+			    const char *trailer_prefix)
+{
+	rxrefs->trailer_prefix = xstrdup(trailer_prefix);
+	rxrefs->trailer_prefix_len = strlen(trailer_prefix);
+	init_trailer_rxrefs_slab(&rxrefs->slab);
+	rxrefs->dst_commits = (struct object_array)OBJECT_ARRAY_INIT;
+}
+
+/* record the reverse mapping of @commit's xref trailer */
+void trailer_rev_xrefs_record(struct trailer_rev_xrefs *rxrefs,
+			      struct commit *commit)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	struct trailer_info info;
+	int i;
+
+	buffer = read_object_file(&commit->object.oid, &type, &size);
+	trailer_info_get(&info, buffer, &opts);
+
+	/* when nested, the last trailer describes the latest cherry-pick */
+	for (i = info.trailer_nr - 1; i >= 0; i--) {
+		char *line = info.trailers[i];
+
+		if (starts_with(line, rxrefs->trailer_prefix)) {
+			struct object_id dst_oid;
+			struct object *dst_object;
+			struct commit *dst_commit;
+			struct object_array *src_objs;
+			char cherry_hex[GIT_MAX_HEXSZ + 1];
+
+			if (get_oid_hex(line + rxrefs->trailer_prefix_len,
+					&dst_oid))
+				continue;
+
+			dst_object = parse_object(the_repository, &dst_oid);
+			if (!dst_object || dst_object->type != OBJ_COMMIT)
+				continue;
+
+			dst_commit = (struct commit *)dst_object;
+			src_objs = get_create_trailer_rxrefs(rxrefs, dst_commit);
+
+			oid_to_hex_r(cherry_hex, &commit->object.oid);
+			add_object_array(&commit->object, cherry_hex, src_objs);
+			break;
+		}
+	}
+
+	free(buffer);
+}
+
+void trailer_rev_xrefs_release(struct trailer_rev_xrefs *rxrefs)
+{
+	clear_trailer_rxrefs_slab(&rxrefs->slab);
+	object_array_clear(&rxrefs->dst_commits);
+	free(rxrefs->trailer_prefix);
+}
+
+void trailer_rev_xrefs_next(struct trailer_rev_xrefs *rxrefs, int *idx_p,
+			    struct commit **dst_commit_p,
+			    struct object_array **src_objs_p)
+{
+	if (*idx_p >= rxrefs->dst_commits.nr) {
+		*dst_commit_p = NULL;
+		*src_objs_p = NULL;
+		return;
+	}
+
+	*dst_commit_p = (struct commit *)
+		rxrefs->dst_commits.objects[*idx_p].item;
+	*src_objs_p = get_trailer_rxrefs(rxrefs, *dst_commit_p);
+	(*idx_p)++;
+}
diff --git a/trailer.h b/trailer.h
index b99773964..07090a11f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -2,6 +2,8 @@
 #define TRAILER_H
 
 #include "list.h"
+#include "object.h"
+#include "commit-slab.h"
 
 struct strbuf;
 
@@ -99,4 +101,40 @@ void trailer_info_release(struct trailer_info *info);
 void format_trailers_from_commit(struct strbuf *out, const char *msg,
 				 const struct process_trailer_options *opts);
 
+/*
+ * Helpers to reverse trailers referencing to other commits.
+ *
+ * Some trailers, e.g. "(cherry picked from...)", references other commits.
+ * The following helpers can be used to reverse map those references.  See
+ * builtin/reverse-trailer-xrefs.c for a usage example.
+ */
+declare_commit_slab(trailer_rxrefs_slab, struct object_array *);
+
+struct trailer_rev_xrefs {
+	char *trailer_prefix;
+	int trailer_prefix_len;
+	struct trailer_rxrefs_slab slab;
+	struct object_array dst_commits;
+};
+
+void trailer_rev_xrefs_init(struct trailer_rev_xrefs *rxrefs,
+			    const char *trailer_prefix);
+void trailer_rev_xrefs_record(struct trailer_rev_xrefs *rxrefs,
+			      struct commit *commit);
+void trailer_rev_xrefs_release(struct trailer_rev_xrefs *rxrefs);
+
+void trailer_rev_xrefs_next(struct trailer_rev_xrefs *rxrefs,
+			    int *idx_p, struct commit **dst_commit_p,
+			    struct object_array **src_objs_p);
+
+/*
+ * Iterate the recorded reverse mappings - @dst_commit was pointed to by
+ * commits in @src_objs.
+ */
+#define trailer_rev_xrefs_for_each(rxrefs, idx, dst_commit, src_objs)		\
+	for ((idx) = 0,								\
+	     trailer_rev_xrefs_next(rxrefs, &(idx), &(dst_commit), &(src_objs));\
+	     (dst_commit);							\
+	     trailer_rev_xrefs_next(rxrefs, &(idx), &(dst_commit), &(src_objs)))
+
 #endif /* TRAILER_H */
-- 
2.17.1

