Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8379C7EE25
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbjEOTX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbjEOTX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:27 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6510A18
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a2691637bso190823417b3.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178595; x=1686770595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oECcKFleKClFDx6LPgTiSCkStj9Y48tPM2y6FoncgkM=;
        b=Im4SgIRUt9zyaKeacxCYPvJXkPgzpNZP4/VHCo8Z/5RF+njX7MsRCYWj20NxiT3QV6
         5bd7dKZTRpuIfVblq2RJywEAPrR8xhy3kWumxCAb+2/RWDRxRxiFDE7nBasU1UXElPOj
         wGQH6q9m7yAtvH3/xA1mcEoftwB283VtY6Xj9FzVL/NiX3yzcL9hoBi93vHMKkQaNiSR
         3pTjtObpaRqOWkVmbJF5bsna6AzH3GlzhdDMbAkHzsLjVg04zQ3iGRSIMq7kG4ita1os
         is8BuLfZ/09YDjWT+P8k19972ifschCVlX6CpePEd9WKoeuDwdM5TmUG2qllDHwEZGGj
         juuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178595; x=1686770595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oECcKFleKClFDx6LPgTiSCkStj9Y48tPM2y6FoncgkM=;
        b=IPv0/+o8CKmEohR2jFFoU4j6PQNgQIBfvxt0iXhk8AKIjQxQZMGu209+ZptCq7jGBS
         vdYC3aPeCxKQuPuB+jyJrz2GY7hdExjbkmhV1jm+Lw5Ap5kY+YdR2FeOUxONM4+CpMwy
         GX58bgYBwTMkq4ezM7UaCmCXcBrP54h5u4OJxfL8xCggWdZSIQW9wom+4yWo2lKYPte0
         C0+oKOSOe/VsAXNE2TtDoobVVAtIJV3LiM/z1PkbFVn6kGLDmGQ9ATItaZPom+hl7uRw
         q09LZKkwG9WWZeW312teBpCCjw4mxjK+mXo5iTg9JnEs3X47TidxTYVv/tN//ILmQQSk
         vJwA==
X-Gm-Message-State: AC+VfDzBu1aVwE83jyXmC8VCRE9iGx2N1YRYDfECe3nABSxDfm3+qVcb
        pxe9OC/ReD42muxZ8gupaY/U3207WaachqP8c1ESpQ==
X-Google-Smtp-Source: ACHHUZ4xqN5W6wQGdxR7Qe/yCxBHnVEgOwpv65SF901FDC2ZaIo09vEAPBIogTe55XDhUeiEvOKnZw==
X-Received: by 2002:a81:53c5:0:b0:55d:c2c3:fbb8 with SMTP id h188-20020a8153c5000000b0055dc2c3fbb8mr29458255ywb.40.1684178595142;
        Mon, 15 May 2023 12:23:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d133-20020a0ddb8b000000b0056183cdb2d9sm21697ywe.60.2023.05.15.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:14 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 02/16] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <8dda7db73816c2e97ed6e195ac8ffb5321f649b7.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
index 501c47657c..03bb8e414c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -662,7 +662,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int reflog = 0, quiet = 0, icase = 0, force = 0,
 	    recurse_submodules_explicit = 0;
 	enum branch_track track;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -720,7 +720,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
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
2.40.1.572.g5c4ab523ef

