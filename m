Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52087C77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbjFGKlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbjFGKlF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:05 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E9E1BE3
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb1f7c5495dso8143983276.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134462; x=1688726462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jX0N8JFZbxglHUJIDDeEixEf5mA1yVKgPVZm5bHwtyo=;
        b=AuMrgRw5MhFMTwO5hPcD76fL2J7peUnqWUed7sq41tQX+OSiGgNMqT5Y0dmdUSy+Nx
         FhMnhWuc63QOzVUVZSq3qu9gjy8rjM+uWfVnvAr8edRAubfkseuhoszxUQbbjOA7hPgP
         /3KLakbJB2Z58TSEgE6mrkuGL6tvPDkXFb89MeS0r56OSe4E+o2FJbjd82NIfFO+rwNE
         +qF9xKeSoO8waE3EPZxjuX3rNlXcGas9pJG6/sp6nGyeZiCBHR3SYzv9iA+9uaFVDvZT
         7jfhcLGJby29I7CbT1/MO/tfxvi2OlQ3IrJwb1rRo3lPH/wluRU8WBZE2BbOYAmHPTK2
         ipMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134462; x=1688726462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX0N8JFZbxglHUJIDDeEixEf5mA1yVKgPVZm5bHwtyo=;
        b=JELx+9FVU9eJsRt7d0js16f3UFdSp5o+Vi7mASjlO0FpU3/nXOdQXbLUs3u9GGL4v5
         4XQQo6Ys08byl3oG5kidTE7o0Suw9GVKqja39024EfE02Pzxde9qJtctRxqAFCthAYdL
         l9j4KoJUpq9iRwFkPr6T7QWIeRYDsESyxVzbOh/QYjecxIW2RfucoeKOMf40MXUEfUxi
         hCi66E5pMLmj46F3My8Ullc6ZTqbCFqnEys4POazVuwvDUGLPmWjHs728HNr9QQ4g9oD
         mQYkXUjZlK0yE3SWX0xYEK06ZNw6p9uFLTxgzgbtbzRFNZo1gsA4ly8s9b+GZ3Ut8b5C
         cL6Q==
X-Gm-Message-State: AC+VfDyeAKf+cXTLXq18dwtw9hTUZFqmCptKWCOQXzLSUg9zBBBO2+pW
        nx88dqFXSpjPlYTwLNxjqxnLkFz1Htf+QNis5Sc0t8nZ
X-Google-Smtp-Source: ACHHUZ7p9q9GJNksYmgUDwYNIz32XpQ/HdvJM334tFFRao8eou8nmNUrgyQnqWUmaMfx7Pv9tiGaow==
X-Received: by 2002:a25:4cc3:0:b0:bac:26d2:53dd with SMTP id z186-20020a254cc3000000b00bac26d253ddmr4117285yba.43.1686134461599;
        Wed, 07 Jun 2023 03:41:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p184-20020a25d8c1000000b00bb188e29af3sm3762986ybg.22.2023.06.07.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:01 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:40:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 02/16] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <b9336e3b778bff1bc944de3b713c7adf4aabf020.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
index 1850a6a6fd..6b41bb7374 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -443,7 +443,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -501,7 +501,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
2.41.0.16.g26cd413590

