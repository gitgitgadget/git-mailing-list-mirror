Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF134C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A4264E12
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBVT0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhBVTVB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:21:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A481C0617AA
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:21 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d8so8805680plo.23
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xitqUwzrxhQSO3dxHXeN6x3qwhk1jd2vlyo92hbbClQ=;
        b=tTWwM9ehk2GwihQkO2GWGCAlkkhuw28uMPa5UEWYVxZS1smYYKBohgTEeXzyG9y2yG
         AMb1fEhtA0RqJXXx+oVAmJb0wwY+A6GaxvPp5G4lqT5vNErA6TW98ad0r+xJf5jzlp/+
         LlaX6AxrMd397RDg6mmBH3aF1lSNkEPNHbc1zbEppVfXPZnQDRVqJwN9lx9F314aN6xB
         1kVBH5AD/Wrq/+OK6FTktcI8Rwwe9H4UHCaAE8HZkXACRTmT21L+CfNR+X8/7bWwQtCk
         g1FINPI8e8FEEGChndAsJYzYnkbGdCwYMjSVcZbWgnMMF9l5BkLqmO10qMddLeY38mIT
         jZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xitqUwzrxhQSO3dxHXeN6x3qwhk1jd2vlyo92hbbClQ=;
        b=h2g2yC2sHD6vWBXYkktdLEvEL8ucdt/HiRZlmghJjNRTnm98Jh4LpT3xadnhrYchZu
         QYFYs8Z+/g1DrdeeUZHSZPF3l1K0KjRSU6OEaSQQV6hyhpbpFigBguUlwFQfekslG8BR
         ZRaqwioJoo3LR39WwXaEm6coXrL8fkm6xX69VpyuVUgsDtWFxa0P+FRe7tDSYbCx6QHk
         AkaduPAnyQ8fuc3IJU1zmPoHc2muCAOp0CgPPrnjpqxGnCiiEAGCO4SU2vO4wyu9wxMs
         auLDclzqE8wdO54RLydb9YqUgY2ZEc92uGky2Zx6cEpRrzWYDHR7dU+3MCdimqVg7guq
         OL7A==
X-Gm-Message-State: AOAM533vqeaKqBQO8zwNDmeUst0bk5BXm/rzmfXrefaIWnXLpQIndlru
        F1HZa+/Ga/CWR6oTzXtSvTKTWtp0KSjD1/9zezGUGqreIu74+DNOuOIfnZ+R1pT0g4I/gqYip9W
        sPW/wHdSymCHsTMILuK3WKymyBVL1qsi7Sno6rKSfZ0bgaLwNdStExD3QdLyQGnr3eJro/e/o9j
        vv
X-Google-Smtp-Source: ABdhPJywtzCFnxnvDr8OvEhErZq3zVOuRr3mAeGD0llZ7KbBJ60yJBWEsIcOdyaIcBRhFPc41gXoawwAGE9hORjZMIW7
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:5bc5:: with SMTP id
 o5mr20704556pgr.17.1614021620473; Mon, 22 Feb 2021 11:20:20 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:20:09 -0800
In-Reply-To: <cover.1614021092.git.jonathantanmy@google.com>
Message-Id: <e8b18d02e61e4307af859e74789b0c191d8e75f7.1614021093.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1614021092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach index-pack to print dangling .gitmodules links after its "keep" or
"pack" line instead of declaring an error, and teach fetch-pack to check
such lines printed.

This allows the tree side of the .gitmodules link to be in one packfile
and the blob side to be in another without failing the fsck check,
because it is now fetch-pack which checks such objects after all
packfiles have been downloaded and indexed (and not index-pack on an
individual packfile, as it is before this commit).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-pack.txt |  7 ++-
 builtin/index-pack.c             | 25 +++++++++-
 builtin/receive-pack.c           |  2 +-
 fetch-pack.c                     | 78 +++++++++++++++++++++++++++-----
 fsck.c                           |  5 ++
 fsck.h                           |  2 +
 pack-write.c                     |  8 +++-
 pack.h                           |  2 +-
 t/t5702-protocol-v2.sh           | 58 ++++++++++++++++++++++--
 9 files changed, 165 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index af0c26232c..e74a4a1eda 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -78,7 +78,12 @@ OPTIONS
 	Die if the pack contains broken links. For internal use only.
 
 --fsck-objects::
-	Die if the pack contains broken objects. For internal use only.
+	For internal use only.
++
+Die if the pack contains broken objects. If the pack contains a tree
+pointing to a .gitmodules blob that does not exist, prints the hash of
+that blob (for the caller to check) after the hash that goes into the
+name of the pack/idx file (see "Notes").
 
 --threads=<n>::
 	Specifies the number of threads to spawn when resolving
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 557bd2f348..0444febeee 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1693,6 +1693,22 @@ static void show_pack_info(int stat_only)
 	}
 }
 
+static int print_dangling_gitmodules(struct fsck_options *o,
+				     const struct object_id *oid,
+				     enum object_type object_type,
+				     int msg_type, const char *message)
+{
+	/*
+	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
+	 * instead of relying on this string check.
+	 */
+	if (starts_with(message, "gitmodulesMissing")) {
+		printf("%s\n", oid_to_hex(oid));
+		return 0;
+	}
+	return fsck_error_function(o, oid, object_type, msg_type, message);
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
@@ -1888,8 +1904,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object && fsck_finish(&fsck_options))
-		die(_("fsck error in pack objects"));
+	if (do_fsck_object) {
+		struct fsck_options fo = fsck_options;
+
+		fo.error_func = print_dangling_gitmodules;
+		if (fsck_finish(&fo))
+			die(_("fsck error in pack objects"));
+	}
 
 	free(objects);
 	strbuf_release(&index_name_buf);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d49d050e6e..ed2c9b42e9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2275,7 +2275,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		status = start_command(&child);
 		if (status)
 			return "index-pack fork failed";
-		pack_lockfile = index_pack_lockfile(child.out);
+		pack_lockfile = index_pack_lockfile(child.out, NULL);
 		close(child.out);
 		status = finish_command(&child);
 		if (status)
diff --git a/fetch-pack.c b/fetch-pack.c
index dd0a6c4b34..f9def5ac74 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -796,6 +796,26 @@ static void write_promisor_file(const char *keep_name,
 	strbuf_release(&promisor_name);
 }
 
+static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
+{
+	int len = the_hash_algo->hexsz + 1; /* hash + NL */
+
+	do {
+		char hex_hash[GIT_MAX_HEXSZ + 1];
+		int read_len = read_in_full(fd, hex_hash, len);
+		struct object_id oid;
+		const char *end;
+
+		if (!read_len)
+			return;
+		if (read_len != len)
+			die("invalid length read %d", read_len);
+		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
+			die("invalid hash");
+		oidset_insert(gitmodules_oids, &oid);
+	} while (1);
+}
+
 /*
  * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
  * The strings to pass as the --index-pack-arg arguments to http-fetch will be
@@ -804,7 +824,8 @@ static void write_promisor_file(const char *keep_name,
 static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], struct string_list *pack_lockfiles,
 		    struct strvec *index_pack_args,
-		    struct ref **sought, int nr_sought)
+		    struct ref **sought, int nr_sought,
+		    struct oidset *gitmodules_oids)
 {
 	struct async demux;
 	int do_keep = args->keep_pack;
@@ -812,6 +833,7 @@ static int get_pack(struct fetch_pack_args *args,
 	struct pack_header header;
 	int pass_header = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	int fsck_objects = 0;
 	int ret;
 
 	memset(&demux, 0, sizeof(demux));
@@ -846,8 +868,15 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (do_keep || args->from_promisor || index_pack_args) {
-		if (pack_lockfiles)
+	if (fetch_fsck_objects >= 0
+	    ? fetch_fsck_objects
+	    : transfer_fsck_objects >= 0
+	    ? transfer_fsck_objects
+	    : 0)
+		fsck_objects = 1;
+
+	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
+		if (pack_lockfiles || fsck_objects)
 			cmd.out = -1;
 		cmd_name = "index-pack";
 		strvec_push(&cmd.args, cmd_name);
@@ -897,11 +926,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
 			     ntohl(header.hdr_version),
 				 ntohl(header.hdr_entries));
-	if (fetch_fsck_objects >= 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >= 0
-	    ? transfer_fsck_objects
-	    : 0) {
+	if (fsck_objects) {
 		if (args->from_promisor || index_pack_args)
 			/*
 			 * We cannot use --strict in index-pack because it
@@ -925,10 +950,15 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
-	if (do_keep && pack_lockfiles) {
-		char *pack_lockfile = index_pack_lockfile(cmd.out);
+	if (do_keep && (pack_lockfiles || fsck_objects)) {
+		int is_well_formed;
+		char *pack_lockfile = index_pack_lockfile(cmd.out, &is_well_formed);
+
+		if (!is_well_formed)
+			die(_("fetch-pack: invalid index-pack output"));
 		if (pack_lockfile)
 			string_list_append_nodup(pack_lockfiles, pack_lockfile);
+		parse_gitmodules_oids(cmd.out, gitmodules_oids);
 		close(cmd.out);
 	}
 
@@ -963,6 +993,22 @@ static int cmp_ref_by_name(const void *a_, const void *b_)
 	return strcmp(a->name, b->name);
 }
 
+static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+	struct fsck_options fo = FSCK_OPTIONS_STRICT;
+
+	if (!oidset_size(gitmodules_oids))
+		return;
+
+	oidset_iter_init(gitmodules_oids, &iter);
+	while ((oid = oidset_iter_next(&iter)))
+		register_found_gitmodules(oid);
+	if (fsck_finish(&fo))
+		die("fsck failed");
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
@@ -977,6 +1023,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	int agent_len;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
+	struct oidset gitmodules_oids = OIDSET_INIT;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1092,8 +1139,10 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought))
+	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
+		     &gitmodules_oids))
 		die(_("git fetch-pack: fetch failed."));
+	fsck_gitmodules_oids(&gitmodules_oids);
 
  all_done:
 	if (negotiator)
@@ -1544,6 +1593,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
+	struct oidset gitmodules_oids = OIDSET_INIT;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1634,7 +1684,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfiles,
 				     packfile_uris.nr ? &index_pack_args : NULL,
-				     sought, nr_sought))
+				     sought, nr_sought, &gitmodules_oids))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args, &reader);
 
@@ -1677,6 +1727,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		packname[the_hash_algo->hexsz] = '\0';
 
+		parse_gitmodules_oids(cmd.out, &gitmodules_oids);
+
 		close(cmd.out);
 
 		if (finish_command(&cmd))
@@ -1696,6 +1748,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
+	fsck_gitmodules_oids(&gitmodules_oids);
+
 	if (negotiator)
 		negotiator->release(negotiator);
 
diff --git a/fsck.c b/fsck.c
index f82e2fe9e3..49ef6569e8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1243,6 +1243,11 @@ int fsck_error_function(struct fsck_options *o,
 	return 1;
 }
 
+void register_found_gitmodules(const struct object_id *oid)
+{
+	oidset_insert(&gitmodules_found, oid);
+}
+
 int fsck_finish(struct fsck_options *options)
 {
 	int ret = 0;
diff --git a/fsck.h b/fsck.h
index 69cf715e79..d75b723bd5 100644
--- a/fsck.h
+++ b/fsck.h
@@ -62,6 +62,8 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
+void register_found_gitmodules(const struct object_id *oid);
+
 /*
  * Some fsck checks are context-dependent, and may end up queued; run this
  * after completing all fsck_object() calls in order to resolve any remaining
diff --git a/pack-write.c b/pack-write.c
index 3513665e1e..f66ea8e5a1 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -272,7 +272,7 @@ void fixup_pack_header_footer(int pack_fd,
 	fsync_or_die(pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(int ip_out)
+char *index_pack_lockfile(int ip_out, int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
 	const int len = the_hash_algo->hexsz + 6;
@@ -286,11 +286,17 @@ char *index_pack_lockfile(int ip_out)
 	 */
 	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
 		const char *name;
+
+		if (is_well_formed)
+			*is_well_formed = 1;
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
 				       get_object_directory(), name);
+		return NULL;
 	}
+	if (is_well_formed)
+		*is_well_formed = 0;
 	return NULL;
 }
 
diff --git a/pack.h b/pack.h
index 9fc0945ac9..09cffec395 100644
--- a/pack.h
+++ b/pack.h
@@ -85,7 +85,7 @@ int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
-char *index_pack_lockfile(int fd);
+char *index_pack_lockfile(int fd, int *is_well_formed);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..b1bc73a9a9 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -847,8 +847,9 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f hfound &&
 	test -f h2found &&
 
-	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 6 filelist
 '
 
@@ -901,8 +902,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
-	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 4 filelist
 '
 
@@ -936,6 +938,54 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 	test_i18ngrep "invalid author/committer line - missing email" error
 '
 
+test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmodules is separate from tree' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo "[submodule libfoo]" >"$P/.gitmodules" &&
+	echo "path = include/foo" >>"$P/.gitmodules" &&
+	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
+	git -C "$P" add .gitmodules &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" .gitmodules >h &&
+
+	sane_unset GIT_TEST_SIDEBAND_ALL &&
+	git -c protocol.version=2 -c transfer.fsckobjects=1 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodules separate from tree is invalid' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child err &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo "[submodule \"..\"]" >"$P/.gitmodules" &&
+	echo "path = include/foo" >>"$P/.gitmodules" &&
+	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
+	git -C "$P" add .gitmodules &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" .gitmodules >h &&
+
+	sane_unset GIT_TEST_SIDEBAND_ALL &&
+	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
+	test_i18ngrep "disallowed submodule name" err
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
2.30.0.617.g56c4b15f3c-goog

