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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA0FC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD78207D0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhACJzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 04:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACJzn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 04:55:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A309C061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 01:55:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a188so1881876pfa.11
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGTnW52jG351SNyqe+7CQt8RZOQhTJEhLj7G1F9MvCE=;
        b=lxDE9EnAfACm5Q5Ad4hzdSj0GgirF7TOal7MGlTTcsqcYEd5m5FLgNsHjy0KPJ1KZx
         gmRNA0XFqkiavEaaL+CHQGkpV2hzGnm/LiiDDwLMiItdEpJbskqjmOuGxaAvn6eYgJWl
         X9Xwb6m7mq7XNQbB9V5XuTBv/ZCo0ueZ3zBHzyfklj4tN/v0sxv7vj1Yc9+sbn9r3VOs
         M9Cl1zEVoLt3ZKQvuGEieBmxYNvnGYYW07TSqHaaaj/CtugMPbE9Pj4IiktswtJqWiiq
         mWQAr5AKQOqghspdgckZb8Pow3PiLBt4pNshbVCBoWPbKKJ1nYpFr5mi0ETXWiAw+te7
         6c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGTnW52jG351SNyqe+7CQt8RZOQhTJEhLj7G1F9MvCE=;
        b=EmAeRDiw+5SHceRuDAeWqezQTKsCAp+GyvH5UMebF+uWCpvoszQ+fg2a95TL/m7Mqf
         drxWokYdEgijVeG0VhEODrjVtgeYigbDP347tJspkaXacpGmtSFtM4IRqvKdV0Y0B/kf
         60buSZXeef0czLoNVh67zZj6wCepOHq8A7gRt336ymVlTvzIm94jttRAAXKu9h8TxpAG
         FDaxjbPZ0X207A8B5V+o24Pu2GAofOhnEu0jk6JS5xdZs64bW9Dr25wSNRGoH8qmQb4l
         yqKkuc3L1Iisj5G56Xzojoa10B+W8mttDBZ/YJvufVe6+h4gAgNojcAXdMq1E3tFa785
         l1ew==
X-Gm-Message-State: AOAM533NjXSB18V5W8RWuxkYBvfE6cU2Q7rvrYjgaWQC/2mlg8UrQZ0J
        RgtuhnXDwzj/j/OUGihv7lrgz1qHr1k=
X-Google-Smtp-Source: ABdhPJzrWZA81axM8c1uGGQLAA3x9+EAI6r9ytHtKYebGUKjMizTlyn8EQ0vCoSVcYkoPCTytcmkww==
X-Received: by 2002:aa7:9738:0:b029:19d:dce0:d8e7 with SMTP id k24-20020aa797380000b029019ddce0d8e7mr41770231pfg.14.1609667701583;
        Sun, 03 Jan 2021 01:55:01 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id o62sm17666050pjo.17.2021.01.03.01.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 01:55:01 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH] bundle: arguments can be read from stdin
Date:   Sun,  3 Jan 2021 04:54:57 -0500
Message-Id: <20210103095457.6894-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
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

Remove the entire `compute_and_write_prerequisites()` function, and
parse the args once by `setup_revisions()`.  The first step for creating
a bundle is to write prerequisites ("-" obj-id SP comment LF), but after
calling `prepare_revision_walk()`, the `revs.pending` is left empty.
Following steps could not work properly without data in `revs.pending`.
Therefore, before calling `prepare_revision_walk()` function, make a
copy on `revs.pending` for later use.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 bundle.c                | 109 ++++++++++++++++++++++------------------
 t/t5607-clone-bundle.sh |   4 +-
 2 files changed, 61 insertions(+), 52 deletions(-)

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
-- 
2.30.0.1.gade423aef4

