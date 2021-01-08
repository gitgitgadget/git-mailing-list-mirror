Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A6CC433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820B32388B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbhAHOqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbhAHOqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:46:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01BC0612EA
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 06:45:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so6366591pfm.6
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jF71NQzyY+Jv88VDeTZjo70PX0kpyDd9rsN2k+TLyg=;
        b=dfaJRtZYJhuf7xxXfCVI3FhbtgFJqLUS4uKbdOTjDXRtaIzM2sxtwXgcJ7zvzrYPDd
         erUVknfx8qUmqTUGkg+PqI+ViqPKFMOxUW2AEUTDwPHKAT5leoB4jPqbrkQJdWESrFXB
         YzFN6Lf5vAJ/NpAHM3xax13wuAtc6p1FqbWAk+dDCA89/1zajVl4AkjQLilVo9/v6Lob
         qqFq6cHlObx7eMLlc4qy8FAqCrksK5MmIf/d46ckZcJIDGNl48WbzvNkpO/Pfl71Z1MI
         1SlMSJ1Scy9QqV4oUMJ0N+ABGdEWkYZaEm+R7Xgu96ireG8VtRSvIYagNwqJM+AD0s05
         5aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jF71NQzyY+Jv88VDeTZjo70PX0kpyDd9rsN2k+TLyg=;
        b=sBOUmURIZYefYkPiAX77h5+UNRWeKfG4kK0+I3HW/zf5OrQ2lpWYGTYBkFsx1/C7zi
         fAnLjK1BQgnjh91CaMoh7G7huzF2jgEfUsozdbtoNBl06tyehwutt5tAYg2Z4+IcFKNQ
         /5DLMcGDi7BYodM6juo7Nmhq2H9eDcF1XvmnzLw7dhrAiA+A3JtlmGpPkXNk59fbCyx5
         86X1HaH0Xu6sfhxptDppKZBfGC7DmsVJej/Uu4qkjKLdpdm4VM0AMCExT2cBk4jHyT4m
         5+FGf2mPIq453qq4o9+eA0uH4iu0LZwcstmU4Ol7c2jA/dBxVmLamzVYPK6VBdo49G+F
         dZuw==
X-Gm-Message-State: AOAM532tv8auX0ibMt+S9ZzyYia0S8MxRvXSBKFfZoq2GJr0iVviE7m/
        AcKp5j8V1xrV5icePpzpfMk=
X-Google-Smtp-Source: ABdhPJx+SMdB/dOP1pWcmCRncMKRYske+OyEML7tYEEeXbUK8yH8+MJAE0qYYWc8HCdwIwfq8lDZ3A==
X-Received: by 2002:a63:e24f:: with SMTP id y15mr7222862pgj.366.1610117122363;
        Fri, 08 Jan 2021 06:45:22 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q15sm9471894pgk.11.2021.01.08.06.45.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 06:45:21 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 2/2] bundle: arguments can be read from stdin
Date:   Fri,  8 Jan 2021 09:45:14 -0500
Message-Id: <20210108144514.24805-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <X/cqrTgilKAW9P9G@danh.dev>
References: <X/cqrTgilKAW9P9G@danh.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In order to create an incremental bundle, we need to pass many arguments
to let git-bundle ignore some already packed commits.  It will be more
convenient to pass args via stdin.  But the current implementation does
not allow us to do this.

This is because args are parsed twice when creating bundle.  The first
time for parsing args is in `compute_and_write_prerequisites()` by
running `git-rev-list` command to write prerequisites in bundle file,
and stdin is consumed in this step if "--stdin" option is provided for
`git-bundle`.  Later nothing can be read from stdin when running
`setup_revisions()` in `create_bundle()`.

The solution is to parse args once by removing the entire function
`compute_and_write_prerequisites()` and then calling function
`setup_revisions()`.  In order to write prerequisites for bundle, will
call `prepare_revision_walk()` and `traverse_commit_list()`.  But after
calling `prepare_revision_walk()`, the object array `revs.pending` is
left empty, and the following steps could not work properly with the
empty object array (`revs.pending`).  Therefore, make a copy of `revs`
to `revs_copy` for later use right after calling `setup_revisions()`.

The copy of `revs_copy` is not a deep copy, it shares the same objects
with `revs`. The object array of `revs` has been cleared, but objects
themselves are still kept.  Flags of objects may change after calling
`prepare_revision_walk()`, we can use these changed flags without
calling the `git rev-list` command and parsing its output like the
former implementation.

Also add testcases for git bundle in t6020, which read args from stdin.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 bundle.c                | 111 ++++++++++++++++++++++------------------
 t/t5607-clone-bundle.sh |   4 +-
 t/t6020-bundle-misc.sh  |  77 ++++++++++++++++++++++++++--
 3 files changed, 135 insertions(+), 57 deletions(-)

diff --git a/bundle.c b/bundle.c
index cb0e5931ac..72970d962a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -338,48 +338,6 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 	return 0;
 }
 
-static int compute_and_write_prerequisites(int bundle_fd,
-					   struct rev_info *revs,
-					   int argc, const char **argv)
-{
-	struct child_process rls = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	FILE *rls_fout;
-	int i;
-
-	strvec_pushl(&rls.args,
-		     "rev-list", "--boundary", "--pretty=oneline",
-		     NULL);
-	for (i = 1; i < argc; i++)
-		strvec_push(&rls.args, argv[i]);
-	rls.out = -1;
-	rls.git_cmd = 1;
-	if (start_command(&rls))
-		return -1;
-	rls_fout = xfdopen(rls.out, "r");
-	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
-		struct object_id oid;
-		if (buf.len > 0 && buf.buf[0] == '-') {
-			write_or_die(bundle_fd, buf.buf, buf.len);
-			if (!get_oid_hex(buf.buf + 1, &oid)) {
-				struct object *object = parse_object_or_die(&oid,
-									    buf.buf);
-				object->flags |= UNINTERESTING;
-				add_pending_object(revs, object, buf.buf);
-			}
-		} else if (!get_oid_hex(buf.buf, &oid)) {
-			struct object *object = parse_object_or_die(&oid,
-								    buf.buf);
-			object->flags |= SHOWN;
-		}
-	}
-	strbuf_release(&buf);
-	fclose(rls_fout);
-	if (finish_command(&rls))
-		return error(_("rev-list died"));
-	return 0;
-}
-
 /*
  * Write out bundle refs based on the tips already
  * parsed into revs.pending. As a side effect, may
@@ -425,7 +383,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 		 * constraints.
 		 */
 		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
-			warning(_("ref '%s' is excluded by the rev-list options"),
+			warning(_("ref '%s' is excluded by the limiting options"),
 				e->name);
 			goto skip_write_ref;
 		}
@@ -474,6 +432,38 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 	return ref_count;
 }
 
+struct bundle_prerequisites_info {
+	struct object_array *pending;
+	int fd;
+};
+
+static void write_bundle_prerequisites(struct commit *commit, void *data)
+{
+	struct bundle_prerequisites_info *bpi = data;
+	struct object *object;
+	struct pretty_print_context ctx = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!(commit->object.flags & BOUNDARY))
+		return;
+	strbuf_addf(&buf, "-%s ", oid_to_hex(&commit->object.oid));
+	write_or_die(bpi->fd, buf.buf, buf.len);
+
+	ctx.fmt = CMIT_FMT_ONELINE;
+	ctx.output_encoding = get_log_output_encoding();
+	strbuf_reset(&buf);
+	pretty_print_commit(&ctx, commit, &buf);
+	strbuf_trim(&buf);
+
+	object = (struct object *)commit;
+	object->flags |= UNINTERESTING;
+	add_object_array_with_path(object, buf.buf, bpi->pending, S_IFINVALID,
+				   NULL);
+	strbuf_addch(&buf, '\n');
+	write_or_die(bpi->fd, buf.buf, buf.len);
+	strbuf_release(&buf);
+}
+
 int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options, int version)
 {
@@ -481,8 +471,10 @@ int create_bundle(struct repository *r, const char *path,
 	int bundle_fd = -1;
 	int bundle_to_stdout;
 	int ref_count = 0;
-	struct rev_info revs;
+	struct rev_info revs, revs_copy;
 	int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
+	struct bundle_prerequisites_info bpi;
+	int i;
 
 	bundle_to_stdout = !strcmp(path, "-");
 	if (bundle_to_stdout)
@@ -512,10 +504,6 @@ int create_bundle(struct repository *r, const char *path,
 	save_commit_buffer = 0;
 	repo_init_revisions(r, &revs, NULL);
 
-	/* write prerequisites */
-	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
-		goto err;
-
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	if (argc > 1) {
@@ -523,16 +511,37 @@ int create_bundle(struct repository *r, const char *path,
 		goto err;
 	}
 
-	object_array_remove_duplicates(&revs.pending);
+	/* save revs.pending in revs_copy for later use */
+	memcpy(&revs_copy, &revs, sizeof(revs));
+	revs_copy.pending.nr = 0;
+	revs_copy.pending.alloc = 0;
+	revs_copy.pending.objects = NULL;
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		if (e)
+			add_object_array_with_path(e->item, e->name,
+						   &revs_copy.pending,
+						   e->mode, e->path);
+	}
 
-	ref_count = write_bundle_refs(bundle_fd, &revs);
+	/* write prerequisites */
+	revs.boundary = 1;
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	bpi.fd = bundle_fd;
+	bpi.pending = &revs_copy.pending;
+	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
+	object_array_remove_duplicates(&revs_copy.pending);
+
+	/* write bundle refs */
+	ref_count = write_bundle_refs(bundle_fd, &revs_copy);
 	if (!ref_count)
 		die(_("Refusing to create empty bundle."));
 	else if (ref_count < 0)
 		goto err;
 
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs, pack_options))
+	if (write_pack_data(bundle_fd, &revs_copy, pack_options))
 		goto err;
 
 	if (!bundle_to_stdout) {
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 26985f4b44..425258767d 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -38,13 +38,13 @@ test_expect_success 'die if bundle file cannot be created' '
 	test_must_fail git bundle create adir --all
 '
 
-test_expect_failure 'bundle --stdin' '
+test_expect_success 'bundle --stdin' '
 	echo master | git bundle create stdin-bundle.bdl --stdin &&
 	git ls-remote stdin-bundle.bdl >output &&
 	grep master output
 '
 
-test_expect_failure 'bundle --stdin <rev-list options>' '
+test_expect_success 'bundle --stdin <rev-list options>' '
 	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
 	git ls-remote hybrid-bundle.bdl >output &&
 	grep master output
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index c4447ca88f..ace675a68b 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -325,8 +325,16 @@ test_expect_success 'create bundle with --since option' '
 '
 
 test_expect_success 'create bundle 1 - no prerequisites' '
+	# create bundle from args
 	git bundle create 1.bdl topic/1 topic/2 &&
 
+	# create bundle from stdin
+	cat >input <<-EOF &&
+		topic/1
+		topic/2
+		EOF
+	git bundle create stdin-1.bdl --stdin <input &&
+
 	cat >expect <<-EOF &&
 		The bundle contains these 2 refs:
 		<COMMIT-D> refs/heads/topic/1
@@ -339,10 +347,16 @@ test_expect_success 'create bundle 1 - no prerequisites' '
 		make_user_friendly_and_stable_output >actual &&
 	test_i18ncmp expect actual &&
 
-	test_bundle_object_count 1.bdl 24
+	git bundle verify stdin-1.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count       1.bdl 24 &&
+	test_bundle_object_count stdin-1.bdl 24
 '
 
 test_expect_success 'create bundle 2 - has prerequisites' '
+	# create bundle from args
 	git bundle create 2.bdl \
 		--ignore-missing \
 		^topic/deleted \
@@ -350,6 +364,18 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 		^topic/2 \
 		release &&
 
+	# create bundle from stdin
+	# input has a non-exist reference: "topic/deleted"
+	cat >input <<-EOF &&
+		^topic/deleted
+		^$D
+		^topic/2
+		EOF
+	git bundle create stdin-2.bdl \
+		--ignore-missing \
+		--stdin \
+		release <input &&
+
 	cat >expect <<-EOF &&
 		The bundle contains this ref:
 		<COMMIT-N> refs/heads/release
@@ -363,7 +389,12 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 		make_user_friendly_and_stable_output >actual &&
 	test_i18ncmp expect actual &&
 
-	test_bundle_object_count 2.bdl 16
+	git bundle verify stdin-2.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count       2.bdl 16 &&
+	test_bundle_object_count stdin-2.bdl 16
 '
 
 test_expect_success 'fail to verify bundle without prerequisites' '
@@ -378,10 +409,15 @@ test_expect_success 'fail to verify bundle without prerequisites' '
 
 	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
 		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_must_fail git -C test1.git bundle verify ../stdin-2.bdl 2>&1 |
+		make_user_friendly_and_stable_output >actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'create bundle 3 - two refs, same object' '
+	# create bundle from args
 	git bundle create --version=3 3.bdl \
 		^release \
 		^topic/1 \
@@ -389,6 +425,16 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 		main \
 		HEAD &&
 
+	# create bundle from stdin
+	cat >input <<-EOF &&
+		^release
+		^topic/1
+		^topic/2
+		EOF
+	git bundle create --version=3 stdin-3.bdl \
+		--stdin \
+		main HEAD <input &&
+
 	cat >expect <<-EOF &&
 		The bundle contains these 2 refs:
 		<COMMIT-P> refs/heads/main
@@ -402,10 +448,16 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 		make_user_friendly_and_stable_output >actual &&
 	test_i18ncmp expect actual &&
 
-	test_bundle_object_count 3.bdl 4
+	git bundle verify stdin-3.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count       3.bdl 4 &&
+	test_bundle_object_count stdin-3.bdl 4
 '
 
 test_expect_success 'create bundle 4 - with tags' '
+	# create bundle from args
 	git bundle create 4.bdl \
 		^main \
 		^release \
@@ -413,6 +465,18 @@ test_expect_success 'create bundle 4 - with tags' '
 		^topic/2 \
 		--all &&
 
+	# create bundle from stdin
+	cat >input <<-EOF &&
+		^main
+		^release
+		^topic/1
+		^topic/2
+		EOF
+	git bundle create stdin-4.bdl \
+		--ignore-missing \
+		--stdin \
+		--all <input &&
+
 	cat >expect <<-EOF &&
 		The bundle contains these 3 refs:
 		<TAG-1> refs/tags/v1
@@ -425,7 +489,12 @@ test_expect_success 'create bundle 4 - with tags' '
 		make_user_friendly_and_stable_output >actual &&
 	test_i18ncmp expect actual &&
 
-	test_bundle_object_count 4.bdl 3
+	git bundle verify stdin-4.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count       4.bdl 3 &&
+	test_bundle_object_count stdin-4.bdl 3
 '
 
 test_expect_success 'clone from bundle' '
-- 
2.30.0.2.g06d2f50715

