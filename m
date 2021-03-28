Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA85C433F8
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37CF6196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC1NQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhC1NQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7AC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so10146124wrw.10
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APkrASEGB0c+lMjL7w3tlbh+o93gXeNIvIoHLaesxJ0=;
        b=HsMg/Tpoyx0bYBvlSMpi4DeuSW3f4aW96lV6FDaD26/k69etdbeTk41evF4mB6HdR9
         h1i0ud/TIbUctZ9T5kduxbiIBxNfTP5bfPfKxewlGdq4M5HJf0PuW6xgh6NIeKdwtOiN
         Hgu0KmJs47y3ZYzza2NLMlx0yIA+hX+gG5jQaP4/BFPpEd0Y3nhaYSTbDIf+n9tOS4dU
         tGRibM5iixHoz63/wp3nbu2vJeN4FnOYx0JEr4eOyqZEeZYIsA98oUlO5IAukMrDfwsX
         p4Icvi7KHCuJLcx11Fzdoc707QGJypA76YwwQ20lnrq3dLC8bA/AiL1o5URmjKAoXWUD
         SbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APkrASEGB0c+lMjL7w3tlbh+o93gXeNIvIoHLaesxJ0=;
        b=CpTyfaU04nLba/2gINmSfy0z1lXgCxmsH3oD9+LYO+jqdMQM451yXbxBxaYHJSZv+1
         HhRUhUTzJjnCll0K6ulCL1KN1jCLKW8BWkXDIMRUzOhkMMMhRhTn88qSwcoewpbIbvIR
         PIcSpnwITuQzXaysVqZrE0N8KqbMKKIET56txWFe4O+CthEiuLJPG2/e43kARev77Vbt
         yOXDmFUoKQujdcpTnJPMf9wIVlRW5sK0FCSrSxwVdnJYqTbFVJEIWQI/l2fFGAoAusYh
         K/W+Tc8m9DY5S6V+5N9GwBajn3BxUAQxhUdiwtULzLCB1xRxNmDHpL4BXG4XekfeSy+S
         3Dww==
X-Gm-Message-State: AOAM533P3ZfHTQ1SSN0Xtw5xXdtvWvIUfIdkBKaUXE8AIKMUaOZ6TPH5
        4oTCLT0FwFjMh7m4do0YyX7BTC7Rhl2x9A==
X-Google-Smtp-Source: ABdhPJyV9yPcBX39coR/9cHvWJn8EGf/s+er7rIduyGphGVUh1DX7/wkxoBerJc/zjarGDSojlKbrw==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr23419192wra.179.1616937370378;
        Sun, 28 Mar 2021 06:16:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 19/19] fetch-pack: use new fsck API to printing dangling submodules
Date:   Sun, 28 Mar 2021 15:15:51 +0200
Message-Id: <patch-19.20-6a38cade8c3-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the check added in 5476e1efde (fetch-pack: print and use
dangling .gitmodules, 2021-02-22) to make use of us now passing the
"msg_id" to the user defined "error_func". We can now compare against
the FSCK_MSG_GITMODULES_MISSING instead of parsing the generated
message.

Let's also replace register_found_gitmodules() with directly
manipulating the "gitmodules_found" member. A recent commit moved it
into "fsck_options" so we could do this here.

I'm sticking this callback in fsck.c. Perhaps in the future we'd like
to accumulate such callbacks into another file (maybe fsck-cb.c,
similar to parse-options-cb.c?), but while we've got just the one
let's just put it into fsck.c.

A better alternative in this case would be some library some more
obvious library shared by fetch-pack.c ad builtin/index-pack.c, but
there isn't such a thing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 21 +--------------------
 fetch-pack.c         | 31 ++++++++-----------------------
 fsck.c               | 23 ++++++++++++++++++-----
 fsck.h               | 15 ++++++++++++---
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5b7bc3c8947..15507b5cff0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -120,7 +120,7 @@ static int nr_threads;
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static int verbose;
 static int show_resolving_progress;
 static int show_stat;
@@ -1713,24 +1713,6 @@ static void show_pack_info(int stat_only)
 	}
 }
 
-static int print_dangling_gitmodules(struct fsck_options *o,
-				     const struct object_id *oid,
-				     enum object_type object_type,
-				     enum fsck_msg_type msg_type,
-				     enum fsck_msg_id msg_id,
-				     const char *message)
-{
-	/*
-	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
-	 * instead of relying on this string check.
-	 */
-	if (starts_with(message, "gitmodulesMissing")) {
-		printf("%s\n", oid_to_hex(oid));
-		return 0;
-	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
-}
-
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
@@ -1761,7 +1743,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 	fsck_options.walk = mark_link;
-	fsck_options.error_func = print_dangling_gitmodules;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
diff --git a/fetch-pack.c b/fetch-pack.c
index 4ec10a15852..c80eaee7694 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,7 +38,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
-static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
+static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -988,21 +988,6 @@ static int cmp_ref_by_name(const void *a_, const void *b_)
 	return strcmp(a->name, b->name);
 }
 
-static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
-{
-	struct oidset_iter iter;
-	const struct object_id *oid;
-
-	if (!oidset_size(gitmodules_oids))
-		return;
-
-	oidset_iter_init(gitmodules_oids, &iter);
-	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(&fsck_options, oid);
-	if (fsck_finish(&fsck_options))
-		die("fsck failed");
-}
-
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
@@ -1017,7 +1002,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	int agent_len;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
-	struct oidset gitmodules_oids = OIDSET_INIT;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1134,9 +1118,10 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	else
 		alternate_shallow_file = NULL;
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
-		     &gitmodules_oids))
+		     &fsck_options.gitmodules_found))
 		die(_("git fetch-pack: fetch failed."));
-	fsck_gitmodules_oids(&gitmodules_oids);
+	if (fsck_finish(&fsck_options))
+		die("fsck failed");
 
  all_done:
 	if (negotiator)
@@ -1587,7 +1572,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
-	struct oidset gitmodules_oids = OIDSET_INIT;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1678,7 +1662,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfiles,
 				     packfile_uris.nr ? &index_pack_args : NULL,
-				     sought, nr_sought, &gitmodules_oids))
+				     sought, nr_sought, &fsck_options.gitmodules_found))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args, &reader);
 
@@ -1721,7 +1705,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		packname[the_hash_algo->hexsz] = '\0';
 
-		parse_gitmodules_oids(cmd.out, &gitmodules_oids);
+		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
 
 		close(cmd.out);
 
@@ -1742,7 +1726,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
-	fsck_gitmodules_oids(&gitmodules_oids);
+	if (fsck_finish(&fsck_options))
+		die("fsck failed");
 
 	if (negotiator)
 		negotiator->release(negotiator);
diff --git a/fsck.c b/fsck.c
index 642bd2ef9da..f5ed6a26358 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1196,11 +1196,6 @@ int fsck_error_function(struct fsck_options *o,
 	return 1;
 }
 
-void register_found_gitmodules(struct fsck_options *options, const struct object_id *oid)
-{
-	oidset_insert(&options->gitmodules_found, oid);
-}
-
 int fsck_finish(struct fsck_options *options)
 {
 	int ret = 0;
@@ -1266,3 +1261,21 @@ int git_fsck_config(const char *var, const char *value, void *cb)
 
 	return git_default_config(var, value, cb);
 }
+
+/*
+ * Custom error callbacks that are used in more than one place.
+ */
+
+int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
+					   const struct object_id *oid,
+					   enum object_type object_type,
+					   enum fsck_msg_type msg_type,
+					   enum fsck_msg_id msg_id,
+					   const char *message)
+{
+	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
+		puts(oid_to_hex(oid));
+		return 0;
+	}
+	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+}
diff --git a/fsck.h b/fsck.h
index e20f9bcb394..7202c3c87e8 100644
--- a/fsck.h
+++ b/fsck.h
@@ -111,6 +111,12 @@ int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
+int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
+					   const struct object_id *oid,
+					   enum object_type object_type,
+					   enum fsck_msg_type msg_type,
+					   enum fsck_msg_id msg_id,
+					   const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
@@ -135,6 +141,12 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.error_func = fsck_error_function, \
 }
+#define FSCK_OPTIONS_MISSING_GITMODULES { \
+	.strict = 1, \
+	.gitmodules_found = OIDSET_INIT, \
+	.gitmodules_done = OIDSET_INIT, \
+	.error_func = fsck_error_cb_print_missing_gitmodules, \
+}
 
 /* descend in all linked child objects
  * the return value is:
@@ -152,9 +164,6 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
-void register_found_gitmodules(struct fsck_options *options,
-			       const struct object_id *oid);
-
 /*
  * fsck a tag, and pass info about it back to the caller. This is
  * exposed fsck_object() internals for git-mktag(1).
-- 
2.31.1.445.g087790d4945

