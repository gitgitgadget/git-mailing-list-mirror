Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1072DC433E1
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A312078D
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8deqSKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFJU5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFJU5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A16C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a188so3871879ybg.20
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wtLlvTPR/pzYqSCOhrRcN6sn2AwwVEzAl3uvLKVMaOE=;
        b=W8deqSKYBecbuI/0UbHlFBrDkUBcemXe3lMKYpFHxG6LryWdYDyqX9qoe8Q4JqZAIt
         DMKzYUloZw56MEN1BDvZNkRNvAYzZmkldNKYS5NJwGiHyIiJMVd3PXAdJfEhw8ujRjuj
         pcNEHlMf1NXDgqUdH05f86MKf7jitZQC2aEctWzS0XZUJEA0IoGTopsPDuMf4bNF1wCa
         4gwA4Frcui89Nk6chC1dE0/S+S6uqnZ9XHnj4uVJt6vUQdX5RIdgxI2vldDKODHHYZqV
         c4NyFpJM+8n372zWzmgNEv7OeXfOg+Ud6VLS57LoURivmxi/lWrhnIOMqW8L573Igkzk
         qOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wtLlvTPR/pzYqSCOhrRcN6sn2AwwVEzAl3uvLKVMaOE=;
        b=DpMeD97QuHuyh2RG4xWsCzjajRRuzQJLmjykrRZAvKBaEofP68OpLaKoR64GvPG6Q1
         oHuN3doC3hF5f97Ht5YOkuDNPy4VkhGlrSh3D3xJmc8eD+TJkvkVqjIBCZZCj/vrneDJ
         FeXxg7Tybw728Qd57b3FTtxeZKB/IX/Va82Oo0sywmUf+mkC1iQovWBTBEq3WpCx1Gso
         Y8UpX8P/NsdChKz0uSrxOHMAfJ8b4pqvLf32/0GfIL/D0HxzJo7TScqqEzOaNVaJ82SD
         kKJ9Roi9yZ4quqwwjL/dMPxsKjs9O8BK934BbQKwWipKEzGRrKKjtmTTPs2FeDpB8Qg9
         tbsw==
X-Gm-Message-State: AOAM531YdXMvglHBQ2dkorOPOtxmS/pnCyPM94vPRjp1PQRHUldge5QE
        gl6zY4AbpRopQowdDQYvVqQ7gZ5qrtCOI/V3sqruuZ2CU/5XaWIXnvPGiLyXCPj/Ye2qQA/Gkaf
        HztUzznIVF0VQgqurA32QAcJAI1ZR8SK8VJDAHYRR8Pz1Px0EyCgsKSKKVQiidz462cAPocb88V
        qP
X-Google-Smtp-Source: ABdhPJw/rP+6t7ECj3wXd0i+eKbtTwgdFSNNeYZgJRkN1wqXNCS8wjbf+lpad9ES/bGupiMeFbVkt3oxYhYAUTe3Ngfp
X-Received: by 2002:a25:b0f:: with SMTP id 15mr8521270ybl.258.1591822660088;
 Wed, 10 Jun 2020 13:57:40 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:22 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <566419ae74348ad3f7b1e5d484cf986fea29af73.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 8/9] fetch-pack: support more than one pack lockfile
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a fetch results in a packfile being downloaded, a .keep file is
generated, so that the packfile can be preserved (from, say, a running
"git repack") until refs are written referring to the contents of the
packfile.

In a subsequent patch, a successful fetch using protocol v2 may result
in more than one .keep file being generated. Therefore, teach
fetch_pack() and the transport mechanism to support multiple .keep
files.

Implementation notes:

 - builtin/fetch-pack.c normally does not generate .keep files, and thus
   is unaffected by this or future changes. However, it has an
   undocumented "--lock-pack" feature, used by remote-curl.c when
   implementing the "fetch" remote helper command. In keeping with the
   remote helper protocol, only one "lock" line will ever be written;
   the rest will result in warnings to stderr. However, in practice,
   warnings will never be written because the remote-curl.c "fetch" is
   only used for protocol v0/v1 (which will not generate multiple .keep
   files). (Protocol v2 uses the "stateless-connect" command, not the
   "fetch" command.)

 - connected.c has an optimization in that connectivity checks on a ref
   need not be done if the target object is in a pack known to be
   self-contained and connected. If there are multiple packfiles, this
   optimization can no longer be done.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c | 17 +++++++++++------
 connected.c          |  8 +++++---
 fetch-pack.c         | 29 +++++++++++++++--------------
 fetch-pack.h         |  2 +-
 transport-helper.c   |  5 +++--
 transport.c          | 14 ++++++++------
 transport.h          |  6 +++---
 7 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4771100072..f66891b010 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -48,8 +48,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct ref **sought = NULL;
 	int nr_sought = 0, alloc_sought = 0;
 	int fd[2];
-	char *pack_lockfile = NULL;
-	char **pack_lockfile_ptr = NULL;
+	struct string_list pack_lockfiles = STRING_LIST_INIT_DUP;
+	struct string_list *pack_lockfiles_ptr = NULL;
 	struct child_process *conn;
 	struct fetch_pack_args args;
 	struct oid_array shallow = OID_ARRAY_INIT;
@@ -134,7 +134,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp("--lock-pack", arg)) {
 			args.lock_pack = 1;
-			pack_lockfile_ptr = &pack_lockfile;
+			pack_lockfiles_ptr = &pack_lockfiles;
 			continue;
 		}
 		if (!strcmp("--check-self-contained-and-connected", arg)) {
@@ -235,10 +235,15 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr, version);
-	if (pack_lockfile) {
-		printf("lock %s\n", pack_lockfile);
+			 &shallow, pack_lockfiles_ptr, version);
+	if (pack_lockfiles.nr) {
+		int i;
+
+		printf("lock %s\n", pack_lockfiles.items[0].string);
 		fflush(stdout);
+		for (i = 1; i < pack_lockfiles.nr; i++)
+			warning(_("Lockfile created but not reported: %s"),
+				pack_lockfiles.items[i].string);
 	}
 	if (args.check_self_contained_and_connected &&
 	    args.self_contained_and_connected) {
diff --git a/connected.c b/connected.c
index 3135b71e19..937b4bae38 100644
--- a/connected.c
+++ b/connected.c
@@ -43,10 +43,12 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 
 	if (transport && transport->smart_options &&
 	    transport->smart_options->self_contained_and_connected &&
-	    transport->pack_lockfile &&
-	    strip_suffix(transport->pack_lockfile, ".keep", &base_len)) {
+	    transport->pack_lockfiles.nr == 1 &&
+	    strip_suffix(transport->pack_lockfiles.items[0].string,
+			 ".keep", &base_len)) {
 		struct strbuf idx_file = STRBUF_INIT;
-		strbuf_add(&idx_file, transport->pack_lockfile, base_len);
+		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
+			   base_len);
 		strbuf_addstr(&idx_file, ".idx");
 		new_pack = add_packed_git(idx_file.buf, idx_file.len, 1);
 		strbuf_release(&idx_file);
diff --git a/fetch-pack.c b/fetch-pack.c
index 7eaa19d7c1..bc3af3c726 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -794,7 +794,7 @@ static void write_promisor_file(const char *keep_name,
 }
 
 static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], char **pack_lockfile,
+		    int xd[2], struct string_list *pack_lockfiles,
 		    struct ref **sought, int nr_sought)
 {
 	struct async demux;
@@ -838,7 +838,7 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 
 	if (do_keep || args->from_promisor) {
-		if (pack_lockfile)
+		if (pack_lockfiles)
 			cmd.out = -1;
 		cmd_name = "index-pack";
 		argv_array_push(&cmd.args, cmd_name);
@@ -863,7 +863,7 @@ static int get_pack(struct fetch_pack_args *args,
 		 * information below. If not, we need index-pack to do it for
 		 * us.
 		 */
-		if (!(do_keep && pack_lockfile) && args->from_promisor)
+		if (!(do_keep && pack_lockfiles) && args->from_promisor)
 			argv_array_push(&cmd.args, "--promisor");
 	}
 	else {
@@ -899,8 +899,9 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
-	if (do_keep && pack_lockfile) {
-		*pack_lockfile = index_pack_lockfile(cmd.out);
+	if (do_keep && pack_lockfiles) {
+		string_list_append_nodup(pack_lockfiles,
+					 index_pack_lockfile(cmd.out));
 		close(cmd.out);
 	}
 
@@ -922,8 +923,8 @@ static int get_pack(struct fetch_pack_args *args,
 	 * Now that index-pack has succeeded, write the promisor file using the
 	 * obtained .keep filename if necessary
 	 */
-	if (do_keep && pack_lockfile && args->from_promisor)
-		write_promisor_file(*pack_lockfile, sought, nr_sought);
+	if (do_keep && pack_lockfiles && pack_lockfiles->nr && args->from_promisor)
+		write_promisor_file(pack_lockfiles->items[0].string, sought, nr_sought);
 
 	return 0;
 }
@@ -940,7 +941,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 const struct ref *orig_ref,
 				 struct ref **sought, int nr_sought,
 				 struct shallow_info *si,
-				 char **pack_lockfile)
+				 struct string_list *pack_lockfiles)
 {
 	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -1067,7 +1068,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
+	if (get_pack(args, fd, pack_lockfiles, sought, nr_sought))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1457,7 +1458,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    struct ref **sought, int nr_sought,
 				    struct oid_array *shallows,
 				    struct shallow_info *si,
-				    char **pack_lockfile)
+				    struct string_list *pack_lockfiles)
 {
 	struct repository *r = the_repository;
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -1559,7 +1560,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
-			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
+			if (get_pack(args, fd, pack_lockfiles, sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
 
 			state = FETCH_DONE;
@@ -1759,7 +1760,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const struct ref *ref,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile,
+		       struct string_list *pack_lockfiles,
 		       enum protocol_version version)
 {
 	struct ref *ref_cpy;
@@ -1794,11 +1795,11 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		memset(&si, 0, sizeof(si));
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
 					   &shallows_scratch, &si,
-					   pack_lockfile);
+					   pack_lockfiles);
 	} else {
 		prepare_shallow_info(&si, shallow);
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
-					&si, pack_lockfile);
+					&si, pack_lockfiles);
 	}
 	reprepare_packed_git(the_repository);
 
diff --git a/fetch-pack.h b/fetch-pack.h
index 67f684229a..85d1e39fe7 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -83,7 +83,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct ref **sought,
 		       int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile,
+		       struct string_list *pack_lockfiles,
 		       enum protocol_version version);
 
 /*
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69d..93a6f50793 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -410,10 +410,11 @@ static int fetch_with_fetch(struct transport *transport,
 			exit(128);
 
 		if (skip_prefix(buf.buf, "lock ", &name)) {
-			if (transport->pack_lockfile)
+			if (transport->pack_lockfiles.nr)
 				warning(_("%s also locked %s"), data->name, name);
 			else
-				transport->pack_lockfile = xstrdup(name);
+				string_list_append(&transport->pack_lockfiles,
+						   name);
 		}
 		else if (data->check_connectivity &&
 			 data->transport_options.check_self_contained_and_connected &&
diff --git a/transport.c b/transport.c
index 15f5ba4e8f..a67e1990bf 100644
--- a/transport.c
+++ b/transport.c
@@ -374,7 +374,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs = fetch_pack(&args, data->fd,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
+				  &transport->pack_lockfiles, data->version);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -382,7 +382,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs = fetch_pack(&args, data->fd,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
+				  &transport->pack_lockfiles, data->version);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
@@ -929,6 +929,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->progress = isatty(2);
+	string_list_init(&ret->pack_lockfiles, 1);
 
 	if (!remote)
 		BUG("No remote provided to transport_get()");
@@ -1324,10 +1325,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 void transport_unlock_pack(struct transport *transport)
 {
-	if (transport->pack_lockfile) {
-		unlink_or_warn(transport->pack_lockfile);
-		FREE_AND_NULL(transport->pack_lockfile);
-	}
+	int i;
+
+	for (i = 0; i < transport->pack_lockfiles.nr; i++)
+		unlink_or_warn(transport->pack_lockfiles.items[i].string);
+	string_list_clear(&transport->pack_lockfiles, 0);
 }
 
 int transport_connect(struct transport *transport, const char *name,
diff --git a/transport.h b/transport.h
index 4298c855be..05efa72db1 100644
--- a/transport.h
+++ b/transport.h
@@ -5,8 +5,7 @@
 #include "run-command.h"
 #include "remote.h"
 #include "list-objects-filter-options.h"
-
-struct string_list;
+#include "string-list.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -98,7 +97,8 @@ struct transport {
 	 */
 	const struct string_list *server_options;
 
-	char *pack_lockfile;
+	struct string_list pack_lockfiles;
+
 	signed verbose : 3;
 	/**
 	 * Transports should not set this directly, and should use this
-- 
2.27.0.278.ge193c7cf3a9-goog

