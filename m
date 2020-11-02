Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2723FC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42332071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGhm+zME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgKBUoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKBUoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:09 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B13C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:09 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so6964373oih.8
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F38hhNw/G8Gyp0GH8i2VeT5MijQbGXIg+WonHnkcw0s=;
        b=mGhm+zMEiJSwcKQAyD31ddLjwXocjOpSxb+nt8pR+A4rzHa923tPeQ2mQNYAvhkMkI
         TJxOf2wGGAcTiGRYeCnKIYYGNUon4cwjQlJsH3isA+8f1SZoqOz4FND6xXaHS4igg6BC
         Etudu5YUSCN0O5F/zrlq/VABYFdQDbmDN7fkUMvy67/yH1ewkh9gXOd7RJuckaJ+8Uqr
         m+9M3ebDSV5dbdVumJwtb2taRbzcZiW3LPgsVHovKz30KuXXupfXwLRScuc/Cj208pjs
         hwQHOxVoR3CKSQEmvQ10VaCLiv2JkIEJAtGeku+SrkVp5oeRYuQ/2D1V/R5Oi94v6WAZ
         q5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F38hhNw/G8Gyp0GH8i2VeT5MijQbGXIg+WonHnkcw0s=;
        b=MRA00GjpJYNVpiAJJAA1wCJmGazLDFdzUazunXpsv4ZOO+naKqphSdDDabQ/mY/e4V
         QcnfFyUPACGKsJDqqJLDc8C0lzDQf8jDnNwkway6DBDJmI2IcAl8XYcjNp49SdBtd45A
         wr3fYnFQPp0B/me/PAM9S9uV4yA8+Q4tyu6WSk9gcnUoAsDmb4lhbn8fNbLLr040dS00
         GaLGum+N5H44dfBaa01lP6EIEgSS25kGBfHEOJ579y4TCXlWYJfWEnQ9n1Bvyo8plCLw
         vTy8kG7dj2JQSIRwYTfl4WUn0i24I5AW+rxki02uBiP70ekFTL2QXFNzJ4fuL+n4N1Nb
         REIQ==
X-Gm-Message-State: AOAM532WlK7Kx0gLDPNskeGa7KQUGLquzDOktkPcnSejnkJcuC3iRs7p
        jLBySOOXTvR/Mi9WLsb1kGJwdWitJbzMMA==
X-Google-Smtp-Source: ABdhPJy6HeLK5eKvBuW4MKug7cz2pzvGpi6/kAaN/DcRG21fobrPWOhUYZXplYY3qijnKqqDVo7q9Q==
X-Received: by 2002:aca:c188:: with SMTP id r130mr139765oif.99.1604349848933;
        Mon, 02 Nov 2020 12:44:08 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 14/20] merge-ort: step 2 of tree writing -- function to create tree object
Date:   Mon,  2 Nov 2020 12:43:38 -0800
Message-Id: <20201102204344.342633-15-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function, write_tree(), which will take a list of
basenames, modes, and oids for a single directory and create a tree
object in the object-store.  We do not yet have just basenames, modes,
and oids for just a single directory (we have a mixture of entries from
all directory levels in the hierarchy) so we still die() before the
current call to write_tree(), but the next patch will rectify that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index ff4d455dce..c560dd1634 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -19,6 +19,7 @@
 
 #include "diff.h"
 #include "diffcore.h"
+#include "object-store.h"
 #include "strmap.h"
 #include "tree.h"
 #include "xdiff-interface.h"
@@ -354,6 +355,50 @@ struct directory_versions {
 	struct string_list versions;
 };
 
+static void write_tree(struct object_id *result_oid,
+		       struct string_list *versions,
+		       unsigned int offset)
+{
+	size_t maxlen = 0;
+	unsigned int nr = versions->nr - offset;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
+	int i;
+
+	/*
+	 * We want to sort the last (versions->nr-offset) entries in versions.
+	 * Do so by abusing the string_list API a bit: make another string_list
+	 * that contains just those entries and then sort them.
+	 *
+	 * We won't use relevant_entries again and will let it just pop off the
+	 * stack, so there won't be allocation worries or anything.
+	 */
+	relevant_entries.items = versions->items + offset;
+	relevant_entries.nr = versions->nr - offset;
+	string_list_sort(&relevant_entries);
+
+	/* Pre-allocate some space in buf */
+	for (i = 0; i < nr; i++) {
+		maxlen += strlen(versions->items[offset+i].string) + 34;
+	}
+	strbuf_reset(&buf);
+	strbuf_grow(&buf, maxlen);
+
+	/* Write each entry out to buf */
+	for (i = 0; i < nr; i++) {
+		struct merged_info *mi = versions->items[offset+i].util;
+		struct version_info *ri = &mi->result;
+		strbuf_addf(&buf, "%o %s%c",
+			    ri->mode,
+			    versions->items[offset+i].string, '\0');
+		strbuf_add(&buf, ri->oid.hash, the_hash_algo->rawsz);
+	}
+
+	/* Write this object file out, and record in result_oid */
+	write_object_file(buf.buf, buf.len, tree_type, result_oid);
+	strbuf_release(&buf);
+}
+
 static void record_entry_for_tree(struct directory_versions *dir_metadata,
 				  const char *path,
 				  struct conflict_info *ci)
@@ -502,9 +547,16 @@ static void process_entries(struct merge_options *opt,
 			process_entry(opt, path, ci, &dir_metadata);
 	}
 
+	/*
+	 * TODO: We can't actually write a tree yet, because dir_metadata just
+	 * contains all basenames of all files throughout the tree with their
+	 * mode and hash.  Not only is that a nonsensical tree, it will have
+	 * lots of duplicates for paths such as "Makefile" or ".gitignore".
+	 */
+	die("Not yet implemented; need to process subtrees separately");
+	write_tree(result_oid, &dir_metadata.versions, 0);
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
-	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
2.29.0.471.ga4f56089c0

