Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471251F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfGYRqZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37602 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403788AbfGYRqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id i70so12659206pgd.4
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4c/YPBnjMIXkYUz2kwf+SuiNKhrLX2Lj/RZ4xscmX0=;
        b=aSC/N7ncOjsi6jB+brCEmMVVNZWKtDJfL2Tfw0IpQdi7CgMQgSJOvbURmqPqEwTGhk
         EwS3kbX0uR8cHrp6yTOUTbgiyD7pGQnZNkkuV7SCKPnHBBY60JatVUKoph1+Fsd17bIk
         kwCoLnVIUTVRTitduffWQ9sY/gY/tNr1XC77DvybCD7a3hKevKpxkZe671QcOI8D2Kvu
         ix7kumx/0CQCiTGHBcPVdiZNOve2UbcwJinHktdNDq/3V7mm/XxiNeRUFrnXTaFDQFfY
         298ueRQ+qPb9fC96KJVOvfKxkx4rmIG58WY6VLc/REoLNAwxPwawxTUpzzEIRJOumbAA
         Z62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4c/YPBnjMIXkYUz2kwf+SuiNKhrLX2Lj/RZ4xscmX0=;
        b=W/nWHHCkicKA9rp8YMJ/9b/h6z4nX7IWzZz4xsgu1tofwi4p6D2kmaNYZJWeWuCMbQ
         LwuEymhmLlm3AMI0paFcIm6A3HepFqZmGwZ0wul/RtjWZhwoHF5iU/opLPFoCHcbSZZ8
         wp8S24nfkmT7Vp3wTtVJTjtAh/TmVb5Cn8dQiYmRrFpxlT3um5gPGmoz8CCLz6DRtMAK
         5qru9glTA4nOrRoWjB6oI3TrEzcu9fOml/5X+9IWS6ZAEPwC67gNxM2oU1WW8ULckdpU
         q672yx6ZFedzp32NbzxN7JxTUZBvzp1nTexsc9om7+sxpXYf6Xw+RxCE2PBUEcMch2zo
         /Ufg==
X-Gm-Message-State: APjAAAVBwjoDCRSkKOijT7wc4P6Wh1yuAdF6PG+yPujFtwKCjn6VhgaU
        KGHj4WLqtkFUza5dOXt2CFN14utQ
X-Google-Smtp-Source: APXvYqyeT09zBEqpTAjEI3/CVfUYy8L+zPk4s1pOiwyxYMEohj59LjGiR59+pkZGUQThLZdI9TAqzA==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr18288076pfd.207.1564076782829;
        Thu, 25 Jul 2019 10:46:22 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 06/19] Change call signature of write_tree_from_memory()
Date:   Thu, 25 Jul 2019 10:45:58 -0700
Message-Id: <20190725174611.14802-7-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_tree_from_memory() is more of a cache-tree thing than a
merge-recursive thing (especially since it is called from checkout.c in
a context before doing anything with merging), but in particular there
is no need for it to take a merge_options struct when it only really
needs a repository struct.

One small wrinkle in this is that there is a call to err(), which takes
a merge_options.  However, this did not used to be there.  In commits
6003303a1e50 ("merge-recursive: switch to returning errors instead of
dying", 2016-07-26) and 033abf97fcbc ("Replace all die("BUG: ...") calls
by BUG() ones", 2018-05-02), all the calls to die() were switched over
to either err() or BUG() -- and this particular case was converted
incorrectly; it should have been a BUG().

So, convert write_tree_from_memory()'s current call to err() to instead
call BUG(), and then make it take a struct repository instead of a
struct merge_options.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c |  2 +-
 merge-recursive.c  | 11 +++++------
 merge-recursive.h  |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 91f8509f85..ec13116354 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -760,7 +760,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
-			work = write_tree_from_memory(&o);
+			work = write_tree_from_memory(the_repository);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
diff --git a/merge-recursive.c b/merge-recursive.c
index 7f56cb0ed1..1a3c6ab7f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -412,10 +412,10 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->unpack_opts);
 }
 
-struct tree *write_tree_from_memory(struct merge_options *opt)
+struct tree *write_tree_from_memory(struct repository *repo)
 {
 	struct tree *result = NULL;
-	struct index_state *istate = opt->repo->index;
+	struct index_state *istate = repo->index;
 
 	if (unmerged_index(istate)) {
 		int i;
@@ -434,11 +434,10 @@ struct tree *write_tree_from_memory(struct merge_options *opt)
 
 	if (!cache_tree_fully_valid(istate->cache_tree) &&
 	    cache_tree_update(istate, 0) < 0) {
-		err(opt, _("error building trees"));
-		return NULL;
+		BUG("error building trees");
 	}
 
-	result = lookup_tree(opt->repo, &istate->cache_tree->oid);
+	result = lookup_tree(repo, &istate->cache_tree->oid);
 
 	return result;
 }
@@ -3471,7 +3470,7 @@ static int merge_trees_internal(struct merge_options *opt,
 
 	unpack_trees_finish(opt);
 
-	if (opt->call_depth && !(*result = write_tree_from_memory(opt)))
+	if (opt->call_depth && !(*result = write_tree_from_memory(opt->repo)))
 		return -1;
 
 	return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index c2b7bb65c6..33f3d53c09 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -97,7 +97,7 @@ int merge_recursive_generic(struct merge_options *o,
 
 void init_merge_options(struct merge_options *o,
 			struct repository *repo);
-struct tree *write_tree_from_memory(struct merge_options *o);
+struct tree *write_tree_from_memory(struct repository *repo);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
 
-- 
2.22.0.559.g28a8880890.dirty

