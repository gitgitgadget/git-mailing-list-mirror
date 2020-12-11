Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF52C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 21:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF3C23B31
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 21:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394849AbgLKVG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 16:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392579AbgLKVFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 16:05:53 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B9CC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 13:05:13 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id bj5so2794270pjb.9
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rmKu0tfmeCvRkg4KONYVLrLJneBXq+6Gdy/BdkvtjCA=;
        b=rRqykn1V7yXPT6+T2BxPDChagSTMgK58Up1vgWik0U5Ml36XJ77TDaenC5lj0Kr0Ly
         RdiMJsw2FydiTYcHCggvC1b++KYOU7MyuNSOr5uIvLRiDdMAkY0lAUwTWQ3ngrngIjuG
         992RgM5SCKmZZ/5Hf+f6V6vxMHmviSfdazF6wBdisfYEy+pFwqfsfQNmvSBx9MeORY1V
         FkoKLeoA6zPRZkYwCxFw0Hy/RC4hFHvqLV7sPBtAYJeqbPjBw/1Whj88FeQIf3FPYDic
         gDC3VsykpAdDJ+IrUbUhcORPyDRdDmkMh/wtbVx4jGPhfOuRYNAYZ9DXhK6gwIJ+OmSF
         UErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rmKu0tfmeCvRkg4KONYVLrLJneBXq+6Gdy/BdkvtjCA=;
        b=m619NiaUbq5waAZrUnJeAAnE5YgcmdhVtndXGech4dljog3d4JjH+pOYD9ybbZCsTf
         Of3C4lsIRUUujqcqjaZsRpwPoeLU06vIJrmQwRc9t1whuzOfMsDSJygokIez4T7MNy3w
         hsRlRs5zNQ/+Rx6ilrVD6F0IKAuzO4nXML4X0IyiPKlVWmXFpvBfS+DEzgxw6UgnY9d3
         NbNO6v/5pw4OQ5+N2PhNwfwwo/wlubTDp/TKcDJPSNbQYo+G/zXzLB27yL5iptYaJPsx
         mDjaoz+tOf/bEt06ML3YwKe2sUMNY8Pg2o/kvxs05+VLYqYwu8Tm+RwtEkzadIXjmTVd
         8AEg==
X-Gm-Message-State: AOAM531dpUXMZ/9MG1vxuCATrYqXAfj2e/G6cisdnVm1tFvyQrYL1zU1
        qLtuNmom5B3iQZL44DkpVlUzXV7uWsYc8PSDecJWMB9+cmmRMqR1T00U5sc+6b85T/cY3VgcKOS
        4rjRwWEQou9+EAUXKWAoOhUZC/IuQHnzLGoVAPXECj0mjaqo8PQy3E/3kBHJISba2EZRj9CFt6D
        4i
X-Google-Smtp-Source: ABdhPJyaE+uMyegFzLtgEsS5yX2vZBa5YJ92ltPCcSXEgni2YfhytbvF0cmUjgYaKSlranMKqNBG64ALw7UVkvzI4K53
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:de0c:: with SMTP id
 m12mr14569960pjv.224.1607720712670; Fri, 11 Dec 2020 13:05:12 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:05:08 -0800
In-Reply-To: <20201208013121.677494-1-jonathantanmy@google.com>
Message-Id: <20201211210508.2337494-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] clone: in protocol v2, use remote's default branch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning an empty repository, a default branch is created. However,
it is named after the locally configured init.defaultBranch, not the
default branch of the remote repository.

To solve this, the remote needs to communicate the target of the HEAD
symref, and "git clone" needs to use this information.

Currently, symrefs that have unborn targets (such as in this case) are
not communicated by the protocol. Teach Git to advertise and support the
"unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
This feature indicates that "ls-refs" supports the "unborn" argument;
when it is specified, "ls-refs" will send the HEAD symref with the name
of its unborn target.

On the client side, Git will always send the "unborn" argument if it is
supported by the server. During "git clone", if cloning an empty
repository, Git will use the new information to determine the local
branch to create. In all other cases, Git will ignore it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt | 10 ++++-
 builtin/clone.c                         | 19 +++++++--
 builtin/fetch-pack.c                    |  3 +-
 builtin/fetch.c                         |  2 +-
 builtin/ls-remote.c                     |  2 +-
 builtin/remote.c                        |  2 +-
 connect.c                               | 29 +++++++++++--
 ls-refs.c                               | 54 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 remote.h                                |  3 +-
 serve.c                                 |  2 +-
 t/t5606-clone-options.sh                |  7 ++--
 t/t5702-protocol-v2.sh                  | 17 ++++++++
 transport-helper.c                      |  7 +++-
 transport-internal.h                    | 13 +++---
 transport.c                             | 29 ++++++++-----
 transport.h                             |  7 +++-
 17 files changed, 165 insertions(+), 42 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index e597b74da3..dfe03aa114 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
 	When specified, only references having a prefix matching one of
 	the provided prefixes are displayed.
 
+If the 'unborn' feature is advertised the following argument can be
+included in the client's request.
+
+    unborn
+	The server may send symrefs pointing to unborn branches in the form
+	"unborn <refname> symref-target:<target>".
+
 The output of ls-refs is as follows:
 
     output = *ref
 	     flush-pkt
-    ref = PKT-LINE(obj-id SP refname *(SP ref-attribute) LF)
+    obj-id-or-unborn = (obj-id | "unborn")
+    ref = PKT-LINE(obj-id-or-unborn SP refname *(SP ref-attribute) LF)
     ref-attribute = (symref | peeled)
     symref = "symref-target:" symref-target
     peeled = "peeled:" obj-id
diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..217c87fddf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -980,6 +980,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int submodule_progress;
 
 	struct strvec ref_prefixes = STRVEC_INIT;
+	char *unborn_head_target = NULL;
 
 	packet_trace_identity("clone");
 
@@ -1264,7 +1265,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_no_tags)
 		strvec_push(&ref_prefixes, "refs/tags/");
 
-	refs = transport_get_remote_refs(transport, &ref_prefixes);
+	refs = transport_get_remote_refs(transport, &ref_prefixes,
+					 &unborn_head_target);
 
 	if (refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
@@ -1323,10 +1325,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare) {
-			const char *branch = git_default_branch_name();
-			char *ref = xstrfmt("refs/heads/%s", branch);
+			const char *branch;
+			char *ref;
+
+			if (unborn_head_target &&
+			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
+				ref = unborn_head_target;
+				unborn_head_target = NULL;
+			} else {
+				branch = git_default_branch_name();
+				ref = xstrfmt("refs/heads/%s", branch);
+			}
 
 			install_branch_config(0, branch, remote_name, ref);
+			create_symref("HEAD", ref, "");
 			free(ref);
 		}
 	}
@@ -1373,6 +1385,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	junk_mode = JUNK_LEAVE_ALL;
 
+	free(unborn_head_target);
 	strvec_clear(&ref_prefixes);
 	return err;
 }
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 58b7c1fbdc..9f921dfab4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -220,7 +220,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	version = discover_version(&reader);
 	switch (version) {
 	case protocol_v2:
-		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL,
+				args.stateless_rpc, NULL);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..a7ef59acfc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1393,7 +1393,7 @@ static int do_fetch(struct transport *transport,
 
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
-		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+		remote_refs = transport_get_remote_refs(transport, &ref_prefixes, NULL);
 		trace2_region_leave("fetch", "remote_refs", the_repository);
 	} else
 		remote_refs = NULL;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 092917eca2..4cf3f60b1b 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -118,7 +118,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (server_options.nr)
 		transport->server_options = &server_options;
 
-	ref = transport_get_remote_refs(transport, &ref_prefixes);
+	ref = transport_get_remote_refs(transport, &ref_prefixes, NULL);
 	if (ref) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
diff --git a/builtin/remote.c b/builtin/remote.c
index c1b211b272..246e62f118 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -950,7 +950,7 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		remote_refs = transport_get_remote_refs(transport, NULL);
+		remote_refs = transport_get_remote_refs(transport, NULL, NULL);
 		transport_disconnect(transport);
 
 		states->queried = 1;
diff --git a/connect.c b/connect.c
index 8b8f56cf6d..3c35324b4c 100644
--- a/connect.c
+++ b/connect.c
@@ -376,7 +376,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 }
 
 /* Returns 1 when a valid ref has been added to `list`, 0 otherwise */
-static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
+static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
+			  char **unborn_head_target)
 {
 	int ret = 1;
 	int i = 0;
@@ -397,6 +398,25 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list)
 		goto out;
 	}
 
+	if (!strcmp("unborn", line_sections.items[i].string)) {
+		i++;
+		if (unborn_head_target &&
+		    !strcmp("HEAD", line_sections.items[i++].string)) {
+			/*
+			 * Look for the symref target (if any). If found,
+			 * return it to the caller.
+			 */
+			for (; i < line_sections.nr; i++) {
+				const char *arg = line_sections.items[i].string;
+
+				if (skip_prefix(arg, "symref-target:", &arg)) {
+					*unborn_head_target = xstrdup(arg);
+					break;
+				}
+			}
+		}
+		goto out;
+	}
 	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
 	    *end) {
 		ret = 0;
@@ -455,7 +475,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct strvec *ref_prefixes,
 			     const struct string_list *server_options,
-			     int stateless_rpc)
+			     int stateless_rpc,
+			     char **unborn_head_target)
 {
 	int i;
 	const char *hash_name;
@@ -488,6 +509,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (!for_push)
 		packet_write_fmt(fd_out, "peel\n");
 	packet_write_fmt(fd_out, "symrefs\n");
+	if (server_supports_feature("ls-refs", "unborn", 0))
+		packet_write_fmt(fd_out, "unborn\n");
 	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
 		packet_write_fmt(fd_out, "ref-prefix %s\n",
 				 ref_prefixes->v[i]);
@@ -496,7 +519,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-		if (!process_ref_v2(reader, &list))
+		if (!process_ref_v2(reader, &list, unborn_head_target))
 			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..fdb644b482 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -32,6 +32,8 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	unsigned allow_unborn : 1;
+	unsigned unborn : 1;
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
@@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	if (!ref_match(&data->prefixes, refname_nons))
 		return 0;
 
-	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	if (oid)
+		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	else
+		strbuf_addf(&refline, "unborn %s", refname_nons);
 	if (data->symrefs && flag & REF_ISSYMREF) {
 		struct object_id unused;
 		const char *symref_target = resolve_ref_unsafe(refname, 0,
@@ -74,8 +79,28 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int ls_refs_config(const char *var, const char *value, void *data)
+static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
+	struct strbuf namespaced = STRBUF_INIT;
+	struct object_id oid;
+	int flag;
+	int null_oid;
+
+	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
+	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
+	null_oid = is_null_oid(&oid);
+	if (!null_oid || (data->symrefs && (flag & REF_ISSYMREF)))
+		send_ref(namespaced.buf, null_oid ? NULL : &oid, flag, data);
+	strbuf_release(&namespaced);
+}
+
+static int ls_refs_config(const char *var, const char *value, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+
+	if (!strcmp("lsrefs.unborn", var))
+		data->allow_unborn = !strcmp(value, "allow") ||
+			!strcmp(value, "advertise");
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
 	 * config. This may need to eventually be expanded to "receive", but we
@@ -91,7 +116,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 
-	git_config(ls_refs_config, NULL);
+	git_config(ls_refs_config, &data);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
@@ -103,14 +128,35 @@ int ls_refs(struct repository *r, struct strvec *keys,
 			data.symrefs = 1;
 		else if (skip_prefix(arg, "ref-prefix ", &out))
 			strvec_push(&data.prefixes, out);
+		else if (data.allow_unborn && !strcmp("unborn", arg))
+			data.unborn = 1;
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ls-refs arguments"));
 
-	head_ref_namespaced(send_ref, &data);
+	if (data.unborn)
+		send_possibly_unborn_head(&data);
+	else
+		head_ref_namespaced(send_ref, &data);
 	for_each_namespaced_ref(send_ref, &data);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
+
+int ls_refs_advertise(struct repository *r, struct strbuf *value)
+{
+	if (value) {
+		char *str = NULL;
+
+		if (!repo_config_get_string(the_repository, "lsrefs.unborn",
+					    &str) &&
+		    !strcmp("advertise", str)) {
+			strbuf_addstr(value, "unborn");
+			free(str);
+		}
+	}
+
+	return 1;
+}
diff --git a/ls-refs.h b/ls-refs.h
index 7b33a7c6b8..a99e4be0bd 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -6,5 +6,6 @@ struct strvec;
 struct packet_reader;
 int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request);
+int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
 #endif /* LS_REFS_H */
diff --git a/remote.h b/remote.h
index 3211abdf05..967f2178d8 100644
--- a/remote.h
+++ b/remote.h
@@ -198,7 +198,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct strvec *ref_prefixes,
 			     const struct string_list *server_options,
-			     int stateless_rpc);
+			     int stateless_rpc,
+			     char **unborn_head_target);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
diff --git a/serve.c b/serve.c
index f6341206c4..30cb56d507 100644
--- a/serve.c
+++ b/serve.c
@@ -62,7 +62,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
-	{ "ls-refs", always_advertise, ls_refs },
+	{ "ls-refs", ls_refs_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b..d3bd79987b 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -102,11 +102,12 @@ test_expect_success 'redirected clone -v does show progress' '
 '
 
 test_expect_success 'chooses correct default initial branch name' '
-	git init --bare empty &&
+	git -c init.defaultBranch=foo init --bare empty &&
+	test_config -C empty lsrefs.unborn advertise &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
 	git -c init.defaultBranch=up clone empty whats-up &&
-	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
-	test refs/heads/up = $(git -C whats-up config branch.up.merge)
+	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
+	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
 '
 
 test_expect_success 'guesses initial branch name correctly' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..380333b662 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -209,6 +209,23 @@ test_expect_success 'clone with file:// using protocol v2' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'clone of empty repo propagates name of default branch' '
+	git -c init.defaultbranch=mydefaultbranch init file_empty_parent &&
+	test_config -C file_empty_parent lsrefs.unborn advertise &&
+
+	git -c init.defaultbranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
+	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
+'
+
+test_expect_success '...but not if it is not advertised' '
+	test_config -C file_empty_parent lsrefs.unborn none &&
+
+	git -c init.defaultbranch=main -c protocol.version=2 \
+		clone "file://$(pwd)/file_empty_parent" file_empty_child_2 &&
+	grep "refs/heads/main" file_empty_child_2/.git/HEAD
+'
+
 test_expect_success 'fetch with file:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
diff --git a/transport-helper.c b/transport-helper.c
index 5f6e0b3bd8..5d97eba935 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1162,13 +1162,16 @@ static int has_attribute(const char *attrs, const char *attr)
 }
 
 static struct ref *get_refs_list(struct transport *transport, int for_push,
-				 const struct strvec *ref_prefixes)
+				 const struct strvec *ref_prefixes,
+				 char **unborn_head_target)
 {
 	get_helper(transport);
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
+		return transport->vtable->get_refs_list(transport, for_push,
+							ref_prefixes,
+							unborn_head_target);
 	}
 
 	return get_refs_list_using_list(transport, for_push);
diff --git a/transport-internal.h b/transport-internal.h
index 27c9daffc4..5037f6197d 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -18,19 +18,16 @@ struct transport_vtable {
 	 * the transport to try to share connections, for_push is a
 	 * hint as to whether the ultimate operation is a push or a fetch.
 	 *
-	 * If communicating using protocol v2 a list of prefixes can be
-	 * provided to be sent to the server to enable it to limit the ref
-	 * advertisement.  Since ref filtering is done on the server's end, and
-	 * only when using protocol v2, this list will be ignored when not
-	 * using protocol v2 meaning this function can return refs which don't
-	 * match the provided ref_prefixes.
-	 *
 	 * If the transport is able to determine the remote hash for
 	 * the ref without a huge amount of effort, it should store it
 	 * in the ref's old_sha1 field; otherwise it should be all 0.
+	 *
+	 * See transport_get_remote_refs() for information on ref_prefixes and
+	 * unborn_head_target.
 	 **/
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
-				     const struct strvec *ref_prefixes);
+				     const struct strvec *ref_prefixes,
+				     char **unborn_head_target);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
diff --git a/transport.c b/transport.c
index 47da955e4f..815e175017 100644
--- a/transport.c
+++ b/transport.c
@@ -127,7 +127,8 @@ struct bundle_transport_data {
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
-					const struct strvec *ref_prefixes)
+					const struct strvec *ref_prefixes,
+					char **unborn_head_target)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -163,7 +164,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	int ret;
 
 	if (!data->get_refs_from_bundle_called)
-		get_refs_from_bundle(transport, 0, NULL);
+		get_refs_from_bundle(transport, 0, NULL, NULL);
 	ret = unbundle(the_repository, &data->header, data->fd,
 			   transport->progress ? BUNDLE_VERBOSE : 0);
 	transport->hash_algo = data->header.hash_algo;
@@ -281,7 +282,7 @@ static void die_if_server_options(struct transport *transport)
  */
 static struct ref *handshake(struct transport *transport, int for_push,
 			     const struct strvec *ref_prefixes,
-			     int must_list_refs)
+			     int must_list_refs, char **unborn_head_target)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
@@ -301,7 +302,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 			get_remote_refs(data->fd[1], &reader, &refs, for_push,
 					ref_prefixes,
 					transport->server_options,
-					transport->stateless_rpc);
+					transport->stateless_rpc,
+					unborn_head_target);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -324,9 +326,11 @@ static struct ref *handshake(struct transport *transport, int for_push,
 }
 
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
-					const struct strvec *ref_prefixes)
+					const struct strvec *ref_prefixes,
+					char **unborn_head_target)
 {
-	return handshake(transport, for_push, ref_prefixes, 1);
+	return handshake(transport, for_push, ref_prefixes, 1,
+			 unborn_head_target);
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
@@ -370,7 +374,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 				break;
 			}
 		}
-		refs_tmp = handshake(transport, 0, NULL, must_list_refs);
+		refs_tmp = handshake(transport, 0, NULL, must_list_refs, NULL);
 	}
 
 	if (data->version == protocol_unknown_version)
@@ -765,7 +769,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		return -1;
 
 	if (!data->got_remote_heads)
-		get_refs_via_connect(transport, 1, NULL);
+		get_refs_via_connect(transport, 1, NULL, NULL);
 
 	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
@@ -1251,7 +1255,8 @@ int transport_push(struct repository *r,
 
 		trace2_region_enter("transport_push", "get_refs_list", r);
 		remote_refs = transport->vtable->get_refs_list(transport, 1,
-							       &ref_prefixes);
+							       &ref_prefixes,
+							       NULL);
 		trace2_region_leave("transport_push", "get_refs_list", r);
 
 		strvec_clear(&ref_prefixes);
@@ -1370,12 +1375,14 @@ int transport_push(struct repository *r,
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct strvec *ref_prefixes)
+					    const struct strvec *ref_prefixes,
+					    char **unborn_head_target)
 {
 	if (!transport->got_remote_refs) {
 		transport->remote_refs =
 			transport->vtable->get_refs_list(transport, 0,
-							 ref_prefixes);
+							 ref_prefixes,
+							 unborn_head_target);
 		transport->got_remote_refs = 1;
 	}
 
diff --git a/transport.h b/transport.h
index 24558c027d..65de0c9c00 100644
--- a/transport.h
+++ b/transport.h
@@ -241,9 +241,14 @@ int transport_push(struct repository *repo,
  * advertisement.  Since ref filtering is done on the server's end (and only
  * when using protocol v2), this can return refs which don't match the provided
  * ref_prefixes.
+ *
+ * If unborn_head_target is not NULL, and the remote reports HEAD as pointing
+ * to an unborn branch, this function stores the unborn branch in
+ * unborn_head_target. It should be freed by the caller.
  */
 const struct ref *transport_get_remote_refs(struct transport *transport,
-					    const struct strvec *ref_prefixes);
+					    const struct strvec *ref_prefixes,
+					    char **unborn_head_target);
 
 /*
  * Fetch the hash algorithm used by a remote.
-- 
2.29.2.576.ga3fc446d84-goog

