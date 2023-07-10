Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B2EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGJVMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGJVMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4538512E
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:10 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c84fd44593aso1818419276.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023529; x=1691615529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJMJHiJIIkXonyBcT4gAkQdNc5kLwjaeH/bH+PGxOec=;
        b=mInqehien8xJOGCeL0UBE9B/XiUgeCE+b4p3jArHaNzNOAmVm3dCoE5WueSd6i69qd
         iY0w0XZURg/syo25KqimWlLRG/3z+7TW3QTsLGe+mEU8OSRa+GGkvayp04ZDX8vd/xdP
         CeC6VC+ewEQoucfjig5e0oJkdcnCiKwsKToiQRgE/6ERPfUAUHWR0sRC5Ub0DgioVO5t
         D5gDCv6QHFyyWf32BcfgITQxy2e7AevgluB60es9TBW8wzSxTvhO15yhXHc/Mrc3Ta/8
         4YjT+PbYRJMRw3uQuwNMTzn/gvOQe7vAKYwD/ouv2bRUS/OdvR2w8txAXO0wnsjjGes/
         ot1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023529; x=1691615529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJMJHiJIIkXonyBcT4gAkQdNc5kLwjaeH/bH+PGxOec=;
        b=Y2U/kcRtSfjynuMA4/Slp8c3BScrwxuSds92wL/2kj0IfrSKv5zNiz8MIPgTSFHL71
         z+CawWxGEMlTuePvjONo19LJfxPUI7BocK2yYnYZZiybbsibpHvhGD5M98Uhak/EGdDh
         /Tj6jgLzwVAwx4SgkZSuasivjlnaGFr8eBOSNaxUX4brGikJOS9I5LYImVpEEDAklKu3
         fsxgUL2NIoioj7SIY55WJSJYhn7bqwNVm8j0KzbN9/rLbqJ2GJfPQLDxOiha4YdfgknC
         fH/quo18TWFL6ijCuJ+bWZzSFJNkAZXiPv5gFJHa+vRUpjdkA2K6oZC6NsCZ1jBzKO4F
         7lVw==
X-Gm-Message-State: ABy/qLaJXJG+4HSAOJRRkao1YvwXXBdO49clN4cQ7e8dZ5rpCfmbW/Ej
        vUbxZ1x7BmSZVJyIQ1bh9hc2co+imcCD6p+dY1U1PA==
X-Google-Smtp-Source: APBJJlGTG81sGRMIe8CamL4KH5ooQjaXOLWQD1nHZLQsrulHMLyPPlrVrWh++1tX1xWNmijEM8Ngvw==
X-Received: by 2002:a0d:ebc8:0:b0:579:f43e:45d2 with SMTP id u191-20020a0debc8000000b00579f43e45d2mr14325233ywe.37.1689023529161;
        Mon, 10 Jul 2023 14:12:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y80-20020a0dd653000000b0055a21492192sm181866ywd.115.2023.07.10.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:08 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 02/16] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <0c4e995f1d3bb918ea0d4c0e6aed34aa5e9fe9da.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Provide a sane initialization value for `struct ref_filter`, which in a
subsequent patch will be used to initialize a new field.

In the meantime, ensure that the `ref_filter` struct used in the
test-helper's `cmd__reach()` is zero-initialized. The lack of
initialization is OK, since `commit_contains()` only looks at the single
`with_commit_tag_algo` field that *is* initialized directly above.

So this does not fix a bug, but rather prevents one from biting us in
the future.

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
index e8ff3ecc072..322646f38f5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -702,7 +702,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int reflog = 0, quiet = 0, icase = 0, force = 0,
 	    recurse_submodules_explicit = 0;
 	enum branch_track track;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -760,7 +760,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
-	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 15409337f83..6b5e313123f 100644
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
index 7d34af416c7..a624185d105 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -445,7 +445,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -504,7 +504,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, &sorting_options);
 
 	memset(&opt, 0, sizeof(opt));
-	memset(&filter, 0, sizeof(filter));
 	filter.lines = -1;
 	opt.sign = -1;
 
diff --git a/ref-filter.h b/ref-filter.h
index 430701cfb76..a920f73b297 100644
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
index 5b6f2174418..ef58f10c2d6 100644
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
2.41.0.343.gdff068c469f

