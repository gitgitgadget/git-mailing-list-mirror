Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9271BC433E9
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C55823719
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJObH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 09:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJObG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 09:31:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625DC0617A2
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j1so8147130pld.3
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Q3AdZoh4QmG9esMVF0p9RLhlh/HiGMCBuObtWGw9zY=;
        b=KeI5uTDOnvBqfbfrozjmeFMa9AOzKgZbuxHsPWtEQP9IH1b611WDOSC+42ybGZr0sE
         MJoTw52tYlyRS+nuFE4GL8pTDoq2p5q4vfaA3qfFcaJINxAcfC4WU+ITe3V7BgVYtpE6
         pSbSHKr2LZmodl5vm53GbnFabr7AjGUK9dVIhD/IvWfciydvJLVckwhk6fo623LxZzgg
         HJJpDQUG/7vPWin41OTLNrHy0owfmBrdpcBL8xcwVmSfO7FSOGiUuJxeLYBAz83lufCw
         8nRYXgO5cxKqj1NWyvyKcUFT1a5TPpn6++ZikztIEyGrvh1kq0j6ga4vTsPz2cvHYbYC
         HLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Q3AdZoh4QmG9esMVF0p9RLhlh/HiGMCBuObtWGw9zY=;
        b=YelHNH/i/x7x/l7dU6o1QDT2qfw2iPwrSg1E4lXJn/K5iZtyeRfyh1JK0Uqt3QiW/b
         S6NPCb7ZywVvYCRJggG+C6/EmDZQIjUJW/gZm5lLPd9szLwarO6KHz6mjKkp5j9bdzhx
         KPpr3p7AflZZ6E7SZL8voSaZ2758MQZeIhuFSajparre7HtGJ2JYyIiWECbV7hMeHC2n
         DZIJP7M7vn8jUcCqSJTCa1k79+NUYdOSXWpIJZiUxVZp8jnpqF90KCa40wq0fr4cxevE
         g0zurrZFdhrI+9L/f5whwdIiQ/4AFyWW4niShV31IjslFU1PiklocXv9ZLe2FIKUZzUf
         C9Ng==
X-Gm-Message-State: AOAM530u1+VzTHFWZuJH3rPgFW137hg4pPwcgoiJdgMtsbZi9/3jPoqw
        90soX0nm22zilILCijrEaPk=
X-Google-Smtp-Source: ABdhPJx7WtGaS1KtpVRnuzEDORofUunZIW3+QE0whUMwhtPvO8BkDbCqthno3U01VM7Ld1B8C5F/DQ==
X-Received: by 2002:a17:902:ee82:b029:dc:78e:6905 with SMTP id a2-20020a170902ee82b02900dc078e6905mr12387631pld.48.1610289025675;
        Sun, 10 Jan 2021 06:30:25 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a13sm16044863pfr.59.2021.01.10.06.30.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 06:30:25 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 3/3] bundle: arguments can be read from stdin
Date:   Sun, 10 Jan 2021 09:30:19 -0500
Message-Id: <20210110143019.5625-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqbldxg466.fsf@gitster.c.googlers.com>
References: <xmqqbldxg466.fsf@gitster.c.googlers.com>
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
 bundle.c                | 109 ++++++++++++++++++++++------------------
 t/t5607-clone-bundle.sh |   4 +-
 t/t6020-bundle-misc.sh  |  77 ++++++++++++++++++++++++++--
 3 files changed, 134 insertions(+), 56 deletions(-)

diff --git a/bundle.c b/bundle.c
index cb0e5931ac..693d619551 100644
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
index 5c9d5ed94d..e9158a22a0 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -244,8 +244,16 @@ test_expect_success 'create bundle with --since option' '
 '
 
 test_expect_success 'create bundle 1 - no prerequisites' '
+	# create bundle from args
 	git bundle create 1.bdl topic/1 topic/2 &&
 
+	# create bundle from stdin
+	cat >input <<-\EOF &&
+	topic/1
+	topic/2
+	EOF
+	git bundle create stdin-1.bdl --stdin <input &&
+
 	cat >expect <<-\EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-D> refs/heads/topic/1
@@ -258,10 +266,16 @@ test_expect_success 'create bundle 1 - no prerequisites' '
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
@@ -269,6 +283,18 @@ test_expect_success 'create bundle 2 - has prerequisites' '
 		^topic/2 \
 		release &&
 
+	# create bundle from stdin
+	# input has a non-exist reference: "topic/deleted"
+	cat >input <<-EOF &&
+	^topic/deleted
+	^$D
+	^topic/2
+	EOF
+	git bundle create stdin-2.bdl \
+		--ignore-missing \
+		--stdin \
+		release <input &&
+
 	cat >expect <<-\EOF &&
 	The bundle contains this ref:
 	<COMMIT-N> refs/heads/release
@@ -282,7 +308,12 @@ test_expect_success 'create bundle 2 - has prerequisites' '
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
@@ -297,10 +328,15 @@ test_expect_success 'fail to verify bundle without prerequisites' '
 
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
@@ -308,6 +344,16 @@ test_expect_success 'create bundle 3 - two refs, same object' '
 		main \
 		HEAD &&
 
+	# create bundle from stdin
+	cat >input <<-\EOF &&
+	^release
+	^topic/1
+	^topic/2
+	EOF
+	git bundle create --version=3 stdin-3.bdl \
+		--stdin \
+		main HEAD <input &&
+
 	cat >expect <<-\EOF &&
 	The bundle contains these 2 refs:
 	<COMMIT-P> refs/heads/main
@@ -321,10 +367,16 @@ test_expect_success 'create bundle 3 - two refs, same object' '
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
@@ -332,6 +384,18 @@ test_expect_success 'create bundle 4 - with tags' '
 		^topic/2 \
 		--all &&
 
+	# create bundle from stdin
+	cat >input <<-\EOF &&
+	^main
+	^release
+	^topic/1
+	^topic/2
+	EOF
+	git bundle create stdin-4.bdl \
+		--ignore-missing \
+		--stdin \
+		--all <input &&
+
 	cat >expect <<-\EOF &&
 	The bundle contains these 3 refs:
 	<TAG-1> refs/tags/v1
@@ -344,7 +408,12 @@ test_expect_success 'create bundle 4 - with tags' '
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

