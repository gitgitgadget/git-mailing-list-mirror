Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2AC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 11:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiHHL30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 07:29:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9408E0A5
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 04:29:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l4so10489003wrm.13
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=UgO1LROeKnZdz7tisBWU36NIBw3fruV8DCaLea4GOFI=;
        b=a3rAgY0wtKYET+vhzHA06vdHoVnyY9HIxJYdwHOkT9j1oQL4HNaYqKz/Y4ZWOkzm+F
         hjxCSxdST6frJISdFkoSx/DqGPpKBMFkgzBB2x6LBdXgd1PV25Yp+7iS9rALqu79SvY3
         F/mStb8CbrkQN7DevYG2fZf+kHbln5rw36ktitnLHQf31TFVgPFUQ4m8t3Mwci9eZGEe
         psT/Slvyz4bxjprz1ZXI6isDCKxuvg/k6MVcTrDdrt/g5JsM/wKLGS+QVQwBZXRhjyph
         laIFOnxG9q5EtzkdEmYKZqIP6a2L5eE2b4FNrS3zY0yLbmRHky+m2YX52hhvV4LZNJU0
         I+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=UgO1LROeKnZdz7tisBWU36NIBw3fruV8DCaLea4GOFI=;
        b=FLJkpkTeZLnsl9HC3oTRaahEZlxgv8Io1AN7WbxY0StISD33/Y6fBkj+77ZiRe3VVO
         XTu/GWPaRF13vqjq0QyUmp5nMS5ymtsC1T80k2ovrX+qxk0mvi8aPsVUMhC4RCGSr1jO
         fE+g7uXI3bpcvr7+O/ElCAtBJ4NroWrLiRaKl0e8skrDI4uLDCUK4b1S2Be5DS0+QMjo
         dRQj/evUCpQzGRvC4NYqYn8grtXKmTgVWuQjkHq8gMLjroKlYgdKloDxKM6c3U3OkuRh
         whS+3VloR944SmZH3ndiBjE/O2RcjaONvTD5ccJVsiJySip5xNeFa9PnpvGOne1KKvpK
         Oz6w==
X-Gm-Message-State: ACgBeo3Zp7PsOfAnjqVQt7Oj39vv5z5V5JV4rCcH2KDjRK2c+/A7rDRS
        l3kZcSlJlqCBiOxpZ4eqb4G4taMBkTk=
X-Google-Smtp-Source: AA6agR4O8Q2ryy9bkzaaKwOtq5uSPsBh3NL3pqLfXV5CZHrSeuLtgimuOqKmmtiXOf5eizIZEnpFfg==
X-Received: by 2002:adf:fb10:0:b0:207:af88:1eb9 with SMTP id c16-20020adffb10000000b00207af881eb9mr11272262wrr.238.1659958160961;
        Mon, 08 Aug 2022 04:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003a524470beasm9414656wms.37.2022.08.08.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:29:20 -0700 (PDT)
Message-Id: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 11:29:19 +0000
Subject: [PATCH] [RFC] list-objects-filter: introduce new filter
 sparse:buffer=<spec>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Although we already had a `--filter=sparse:oid=<oid>` which
can used to clone a repository with limited objects which meet
filter rules in the file corresponding to the <oid> on the git
server. But it can only read filter rules which have been record
in the git server before.

But sometimes users may want to pass their own filter rules
without upload it to the git server first. So now introduce a
new filter `sparse:buffer=<spec>`, which can pass users
required filterspec.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [RFC] list-objects-filter: introduce new filter sparse:buffer=
    
    This patch mainly do a small optimization for partial-clone:
    
    Introduce new filter sparse:buffer=, user can passes their required
    filterspec from the command line.
    
    e.g. git clone --filter="sparse:buffer=zip.c" --no-checkout
    git@github.com:git/git.git which can filter out all blobs except zip.c.
    
    git clone --filter="sparse:buffer=block-sha" --no-checkout
    git@github.com:git/git.git which can filter out all blobs outside of
    this directory block-sha/.
    
    or user can write a filterspec file:
    
    cat >filterspec <<-EOF && block-sha1 !block-sha1/sha1.c EOF git clone
    --filter="sparse:buffer=`cat filterspec`" --no-checkout
    git@github.com:git/git.git
    
    which can use filter out all blobs outside of block-sha1/ and
    block-sha1/sha1.c.
    
    Why cannot we introduce a new option like
    --filter="sparse:specfile=<file>": git server/client now use same filter
    parsing function, if we pass the specfile data as the filter content to
    server, server parse it again as a specfile... So maybe we need a
    differentiation of filter parsing functions on client and server.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1316%2Fadlternative%2Fzh%2Fparital-clone-sparse-buffer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1316/adlternative/zh/parital-clone-sparse-buffer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1316

 Documentation/rev-list-options.txt |  4 ++
 dir.c                              |  6 +--
 dir.h                              |  3 ++
 list-objects-filter-options.c      |  8 +++
 list-objects-filter-options.h      |  3 ++
 list-objects-filter.c              | 27 ++++++++++
 t/t5616-partial-clone.sh           | 83 ++++++++++++++++++++++++++++++
 7 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..76410cdafd6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -913,6 +913,10 @@ specification contained in the blob (or blob-expression) '<blob-ish>'
 to omit blobs that would not be required for a sparse checkout on
 the requested refs.
 +
+The form '--filter=sparse:buffer=<spec>' uses a sparse-checkout
+specification contained in the buffer to omit blobs that would not
+be required for a sparse checkout on the requested refs.
++
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
diff --git a/dir.c b/dir.c
index d7cfb08e441..5c438d2e730 100644
--- a/dir.c
+++ b/dir.c
@@ -1037,10 +1037,6 @@ static void invalidate_directory(struct untracked_cache *uc,
 		dir->dirs[i]->recurse = 0;
 }
 
-static int add_patterns_from_buffer(char *buf, size_t size,
-				    const char *base, int baselen,
-				    struct pattern_list *pl);
-
 /* Flags for add_patterns() */
 #define PATTERN_NOFOLLOW (1<<0)
 
@@ -1123,7 +1119,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 	return 0;
 }
 
-static int add_patterns_from_buffer(char *buf, size_t size,
+int add_patterns_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
 				    struct pattern_list *pl)
 {
diff --git a/dir.h b/dir.h
index 7bc862030cf..7dfc49cf83a 100644
--- a/dir.h
+++ b/dir.h
@@ -440,6 +440,9 @@ void add_patterns_from_file(struct dir_struct *, const char *fname);
 int add_patterns_from_blob_to_list(struct object_id *oid,
 				   const char *base, int baselen,
 				   struct pattern_list *pl);
+int add_patterns_from_buffer(char *buf, size_t size,
+				    const char *base, int baselen,
+				    struct pattern_list *pl);
 void parse_path_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 4b25287886d..0afb066e795 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -29,6 +29,8 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 		return "tree";
 	case LOFC_SPARSE_OID:
 		return "sparse:oid";
+	case LOFC_SPARSE_BUFFER:
+		return "sparse:buffer";
 	case LOFC_OBJECT_TYPE:
 		return "object:type";
 	case LOFC_COMBINE:
@@ -84,6 +86,11 @@ int gently_parse_list_objects_filter(
 		}
 		return 1;
 
+	} else if (skip_prefix(arg, "sparse:buffer=", &v0)) {
+		filter_options->spec_buffer = xstrdup(v0);
+		filter_options->choice = LOFC_SPARSE_BUFFER;
+		return 0;
+
 	} else if (skip_prefix(arg, "object:type=", &v0)) {
 		int type = type_from_string_gently(v0, strlen(v0), 1);
 		if (type < 0) {
@@ -338,6 +345,7 @@ void list_objects_filter_release(
 		return;
 	string_list_clear(&filter_options->filter_spec, /*free_util=*/0);
 	free(filter_options->sparse_oid_name);
+	free(filter_options->spec_buffer);
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index ffc02d77e76..21d9ed4ef5d 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -14,6 +14,7 @@ enum list_objects_filter_choice {
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
+	LOFC_SPARSE_BUFFER,
 	LOFC_OBJECT_TYPE,
 	LOFC_COMBINE,
 	LOFC__COUNT /* must be last */
@@ -58,6 +59,8 @@ struct list_objects_filter_options {
 	unsigned long tree_exclude_depth;
 	enum object_type object_type;
 
+	char *spec_buffer;
+
 	/* LOFC_COMBINE values */
 
 	/* This array contains all the subfilters which this filter combines. */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1c1ee3d1bb1..17127c167d4 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -545,6 +545,32 @@ static void filter_sparse_oid__init(
 	filter->free_fn = filter_sparse_free;
 }
 
+static void filter_sparse_file_path__init(
+	struct list_objects_filter_options *filter_options,
+	struct filter *filter)
+{
+	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
+	struct strbuf strbuf = STRBUF_INIT;
+	char *buf;
+	size_t size;
+
+	strbuf_addf(&strbuf, "%s\n", filter_options->spec_buffer);
+	buf = strbuf_detach(&strbuf, &size);
+	if (add_patterns_from_buffer(buf, size, "", 0, &d->pl) < 0)
+		die(_("unable to parse sparse filter data: %s"),
+		    filter_options->spec_buffer);
+	strbuf_release(&strbuf);
+
+	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
+	d->array_frame[d->nr].default_match = 0; /* default to include */
+	d->array_frame[d->nr].child_prov_omit = 0;
+	d->nr++;
+
+	filter->filter_data = d;
+	filter->filter_object_fn = filter_sparse;
+	filter->free_fn = filter_sparse_free;
+}
+
 /*
  * A filter for list-objects to omit large blobs.
  * And to OPTIONALLY collect a list of the omitted OIDs.
@@ -766,6 +792,7 @@ static filter_init_fn s_filters[] = {
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
+	filter_sparse_file_path__init,
 	filter_object_type__init,
 	filter_combine__init,
 };
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 4a3778d04a8..14c435f2f4b 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -421,6 +421,9 @@ test_expect_success 'setup src repo for sparse filter' '
 	git -C sparse-src config --local uploadpack.allowanysha1inwant 1 &&
 	test_commit -C sparse-src one &&
 	test_commit -C sparse-src two &&
+	mkdir sparse-src/three &&
+	test_commit -C sparse-src/three four &&
+	test_commit -C sparse-src/three five &&
 	echo /one.t >sparse-src/only-one &&
 	git -C sparse-src add . &&
 	git -C sparse-src commit -m "add sparse checkout files"
@@ -451,6 +454,86 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
 	test_i18ngrep "unable to parse sparse filter data in" err
 '
 
+test_expect_success 'partial clone with sparse:buffer filter with single file succeeds' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=sparse:buffer=one.t \
+		  sparse-src dst.git &&
+	(
+		cd dst.git &&
+		git rev-list --objects --missing=print HEAD >out &&
+		grep "^$(git rev-parse HEAD:one.t)" out &&
+		grep "^?$(git rev-parse HEAD:two.t)" out &&
+		grep "^?$(git rev-parse HEAD:three/four.t)" out &&
+		grep "^?$(git rev-parse HEAD:three/five.t)" out
+	)
+'
+
+test_expect_success 'partial clone with sparse:buffer filter with single dir succeeds' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=sparse:buffer=three \
+		  sparse-src dst.git &&
+	(
+		cd dst.git &&
+		git rev-list --objects --missing=print HEAD >out &&
+		grep "^?$(git rev-parse HEAD:one.t)" out &&
+		grep "^?$(git rev-parse HEAD:two.t)" out &&
+		grep "^$(git rev-parse HEAD:three/four.t)" out &&
+		grep "^$(git rev-parse HEAD:three/five.t)" out
+	)
+'
+
+test_expect_success 'partial clone with sparse:buffer filter with filterspec file succeeds' '
+	test_write_lines one.t three > filterspec &&
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter="sparse:buffer=`cat filterspec`" \
+		  sparse-src dst.git &&
+	(
+		cd dst.git &&
+		git rev-list --objects --missing=print HEAD >out &&
+		grep "^$(git rev-parse HEAD:one.t)" out &&
+		grep "^?$(git rev-parse HEAD:two.t)" out &&
+		grep "^$(git rev-parse HEAD:three/four.t)" out &&
+		grep "^$(git rev-parse HEAD:three/five.t)" out
+	)
+'
+
+test_expect_success 'partial clone with sparse:buffer filter with filterspec file and special character' '
+	cat >filterspec <<-EOF &&
+	three
+	!three/four.t
+	EOF
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter="sparse:buffer=`cat filterspec`" \
+		  sparse-src dst.git &&
+	(
+		cd dst.git &&
+		git rev-list --objects --missing=print HEAD >out &&
+		grep "^?$(git rev-parse HEAD:one.t)" out &&
+		grep "^?$(git rev-parse HEAD:two.t)" out &&
+		grep "^?$(git rev-parse HEAD:three/four.t)" out &&
+		grep "^$(git rev-parse HEAD:three/five.t)" out
+	)
+'
+
+test_expect_success 'partial clone with sparse:buffer filter with unknown filterspec' '
+	rm -rf dst.git &&
+	git clone --no-local --bare \
+		  --filter=sparse:buffer=unknown \
+		  sparse-src dst.git &&
+	(
+		cd dst.git &&
+		git rev-list --objects --missing=print HEAD >out &&
+		grep "^?$(git rev-parse HEAD:one.t)" out &&
+		grep "^?$(git rev-parse HEAD:two.t)" out &&
+		grep "^?$(git rev-parse HEAD:three/four.t)" out &&
+		grep "^?$(git rev-parse HEAD:three/five.t)" out
+	)
+'
+
 setup_triangle () {
 	rm -rf big-blob.txt server client promisor-remote &&
 

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
gitgitgadget
