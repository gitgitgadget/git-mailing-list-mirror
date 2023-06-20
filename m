Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881EFEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjFTOVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjFTOVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B8E7D
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:10 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-570284c7e61so53346007b3.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270869; x=1689862869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v12ZQZOAJQE43Nj+s0NNW9ZMbLP9eoX23DKAVOWWoGQ=;
        b=sOXT63ERngHT5UMw//hxAG56j/cKmGm7XnwEgxSt1KuI3icETboFGDWFw7Tz37uZhu
         s+W37iEWuLG9VyTR3IRJUZH4NmQ6C6NRfb6JcNnCM2kYAGg5s3PMGx4CjsDdiPxGldCK
         Lm77fZ9Fcd78euNwqXhe2RiGSzfiLbXiHEFsxzi2Rt0wSnE1fQjAXf9ctwhWNX8C+1W6
         bsq665V3QZysJKeoATsDeL2UFGaZCdDI3f2I9K7Cin4VoOrQ6bvtQ9PPni85mR9KX0UZ
         HwHAr6VsCA4LoMdDhhf8nq4Mpw6o0aKQbQrpbJiHgjTVKWqbTE1lCTNjfYmQWLsRB6Vh
         RiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270869; x=1689862869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v12ZQZOAJQE43Nj+s0NNW9ZMbLP9eoX23DKAVOWWoGQ=;
        b=NUw2T3JGnXOBMF3t2llQEyRpJ15POUrsJ3soWK0hyXuwGjcPn/w3tRm36+E4J5NFxM
         d1m0wgU+tuiWVk98CNmRQfTxt2mhmLe5CYjeG9EOzWVCotEu/KCHTkXyWBaPmk2+Gd2P
         b9+7nUytDUNk/PHzGsJRin+2Q2C7JNUL6yNtCGynRNtXE4pjh0AOQXgs/s60uyniodCI
         9QuZScbnrI+0E4Az2qxzBFd7cAqvL8cAS1kfRX7Pr62RTAIgNE2w7ek4n2KRKMu5+V+F
         cU3sCBswF6mO5HqlHOf213Z/SWtvSHLXM6kaENn16K2SY2tI20Khvoeky9a+CZhkU6N/
         t6HQ==
X-Gm-Message-State: AC+VfDyINOB4NOBvOh4asLiMerAuj+GkBoR2HgTjzm57livAFH5geinb
        kTeNKY4+TCsn8O3RjJb7WGArV8gm9sZ1z3cB+cTEMPmh
X-Google-Smtp-Source: ACHHUZ5oU9YdUV9TEcKJpoIdcZqcH96FHSwkFBYVQOEaR/+0mVpCo3bNf2Sq8jbMsfPuYIeKdbZCkA==
X-Received: by 2002:a81:6f54:0:b0:570:8856:5dbc with SMTP id k81-20020a816f54000000b0057088565dbcmr10085059ywc.41.1687270869283;
        Tue, 20 Jun 2023 07:21:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j206-20020a816ed7000000b0056d2eb86724sm492888ywc.142.2023.06.20.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:08 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 02/16] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <7ce82b6a5a451ff183ba8d35fc0f50acccee8972.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Provide a sane initialization value for `struct ref_filter`, which in a
subsequent patch will be used to initialize a new field.

In the meantime, fix a case in test-reach.c where its `ref_filter` is
not even zero-initialized.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/branch.c       | 3 +--
 builtin/for-each-ref.c | 3 +--
 builtin/tag.c          | 3 +--
 ref-filter.h           | 3 +++
 t/helper/test-reach.c  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..7891dec361 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,7 +707,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int reflog = 0, quiet = 0, icase = 0, force = 0,
 	    recurse_submodules_explicit = 0;
 	enum branch_track track;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -765,7 +765,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
-	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 695fc8f4a5..99ccb73518 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -24,7 +24,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	int maxcount = 0, icase = 0, omit_empty = 0;
 	struct ref_array array;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_format format = REF_FORMAT_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -61,7 +61,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&array, 0, sizeof(array));
-	memset(&filter, 0, sizeof(filter));
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 49b64c7a28..ec778ba860 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -437,7 +437,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -496,7 +496,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, &sorting_options);
 
 	memset(&opt, 0, sizeof(opt));
-	memset(&filter, 0, sizeof(filter));
 	filter.lines = -1;
 	opt.sign = -1;
 
diff --git a/ref-filter.h b/ref-filter.h
index 430701cfb7..a920f73b29 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -92,6 +92,9 @@ struct ref_format {
 	struct string_list bases;
 };
 
+#define REF_FILTER_INIT { \
+	.points_at = OID_ARRAY_INIT, \
+}
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
 	.bases = STRING_LIST_INIT_DUP, \
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5b6f217441..ef58f10c2d 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -139,7 +139,7 @@ int cmd__reach(int ac, const char **av)
 
 		printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_with_flag(&X_obj, 2, 4, 0, 0));
 	} else if (!strcmp(av[1], "commit_contains")) {
-		struct ref_filter filter;
+		struct ref_filter filter = REF_FILTER_INIT;
 		struct contains_cache cache;
 		init_contains_cache(&cache);
 
-- 
2.41.0.44.gf2359540d2

