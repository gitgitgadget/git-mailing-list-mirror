Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E38C20248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCHVzz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:55 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:41680 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfCHVzy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:54 -0500
Received: by mail-io1-f73.google.com with SMTP id p17so16359980ios.8
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lDFD+TBuX2saSYWMi+3YBajmy8MmuHY9+Sgg+cYhDHY=;
        b=WLcmxEXIYlRbGdcwwXOSIBFN2GFD0Lx/gIBRPomdyhtXe3fxDSm43+bEpv9/4yQvWe
         o+0Gq5G+aoesfsEk5S5vW+cbs+h0Xw0a3A/h9dHQolQS4sMiEhhfPqiAa0tKZfEenr3D
         PYszG4uP6uOltLtYSWJWdtnRaAVF7gAZhlrPlGrxqkyit00Q5z+iVjcyXaU2+AsX+zr2
         K2hUx5g7wI4/3oohKN83fChqpxemm4M0tWA/XZNlC7+46HtWWBh4zl5Cd/I9sspuhB6f
         VPQ+RfE8X2BO8STxBiNX8ufvuVT5syahfm06xWOaA/PbVBDvCzlqd+IerU3O+UmPn81/
         0TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lDFD+TBuX2saSYWMi+3YBajmy8MmuHY9+Sgg+cYhDHY=;
        b=DiRy+II40gtLoAewkibW/pmlzj8S34P7noLSpW/nFwWi/hYMT2q2QBGXGqlKdMCUHv
         7qm2GwE0Kxv+qjHLmaKdt40IELt31gx2nR2wxVzB+fxis0eWzR4WtKhfMsfpw9csbuWE
         N92QLrRTginSjLPMFLfL20y8L+dkrsyhmY7kx2t+0XJ/53gQCWJyiP9sfOaBZR+ei+7B
         qXixQ/V7YraWwOZfFETrmiUJ2KfV6TE5peMP3kp05mfDUmdbJfl8fm3SRYuzRtryfHcg
         nFwFOqBGYAePxqbSalS7iyrbj/fZjwBcEU+0Xaex5Q7nuq6TJga/6gNNqpU/libbjrD9
         o7Ww==
X-Gm-Message-State: APjAAAUfH9OOUMFrrpc2MXiGIHyhfI4cto1PS/jO6c2Lf5QhEtZ4Xz2D
        VKFQd+7hRWOS42eoDq2IVY8vDZKOYCNbaWRKZvZW
X-Google-Smtp-Source: APXvYqwdBZd5nu0USjXGvzD2JkWhlcfnhRxhiiNhcnHVKigRfX2x2+2EhSssCrGecwqYCrH2WybHoF/MEITXFxFTy3M2
X-Received: by 2002:a24:78cb:: with SMTP id p194mr13591840itc.7.1552082153566;
 Fri, 08 Mar 2019 13:55:53 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:19 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <f46504a1669172fe6caf314f21395c77de54c855.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 7/8] fetch-pack: support more than one pack lockfile
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
 fetch-pack.c         | 23 ++++++++++++-----------
 fetch-pack.h         |  2 +-
 transport-helper.c   |  5 +++--
 transport.c          | 14 ++++++++------
 transport.h          |  6 +++---
 7 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 153a2bd282..709fc4c44b 100644
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
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
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
index 1bba888eff..a866fcf9e8 100644
--- a/connected.c
+++ b/connected.c
@@ -40,10 +40,12 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 
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
index 812be15d7e..cf89af21d9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -755,7 +755,7 @@ static int sideband_demux(int in, int out, void *data)
 }
 
 static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], char **pack_lockfile)
+		    int xd[2], struct string_list *pack_lockfiles)
 {
 	struct async demux;
 	int do_keep = args->keep_pack;
@@ -798,7 +798,7 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 
 	if (do_keep || args->from_promisor) {
-		if (pack_lockfile)
+		if (pack_lockfiles)
 			cmd.out = -1;
 		cmd_name = "index-pack";
 		argv_array_push(&cmd.args, cmd_name);
@@ -853,8 +853,9 @@ static int get_pack(struct fetch_pack_args *args,
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
 
@@ -886,7 +887,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 const struct ref *orig_ref,
 				 struct ref **sought, int nr_sought,
 				 struct shallow_info *si,
-				 char **pack_lockfile)
+				 struct string_list *pack_lockfiles)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
 	struct object_id oid;
@@ -992,7 +993,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfile))
+	if (get_pack(args, fd, pack_lockfiles))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1334,7 +1335,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
 				    struct ref **sought, int nr_sought,
-				    char **pack_lockfile)
+				    struct string_list *pack_lockfiles)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
@@ -1415,7 +1416,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
-			if (get_pack(args, fd, pack_lockfile))
+			if (get_pack(args, fd, pack_lockfiles))
 				die(_("git fetch-pack: fetch failed."));
 
 			state = FETCH_DONE;
@@ -1617,7 +1618,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile,
+		       struct string_list *pack_lockfiles,
 		       enum protocol_version version)
 {
 	struct ref *ref_cpy;
@@ -1648,10 +1649,10 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	prepare_shallow_info(&si, shallow);
 	if (version == protocol_v2)
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
-					   pack_lockfile);
+					   pack_lockfiles);
 	else
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
-					&si, pack_lockfile);
+					&si, pack_lockfiles);
 	reprepare_packed_git(the_repository);
 
 	if (!args->cloning && args->deepen) {
diff --git a/fetch-pack.h b/fetch-pack.h
index 43ec344d95..47af3c1d1e 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -84,7 +84,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct ref **sought,
 		       int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile,
+		       struct string_list *pack_lockfiles,
 		       enum protocol_version version);
 
 /*
diff --git a/transport-helper.c b/transport-helper.c
index 1f52c95fd8..94c0e37778 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -397,10 +397,11 @@ static int fetch_with_fetch(struct transport *transport,
 
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
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
index e078812897..80c7903fa7 100644
--- a/transport.c
+++ b/transport.c
@@ -359,14 +359,14 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs = fetch_pack(&args, data->fd, data->conn,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  dest, to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
+				  &transport->pack_lockfiles, data->version);
 		break;
 	case protocol_v1:
 	case protocol_v0:
 		refs = fetch_pack(&args, data->fd, data->conn,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  dest, to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
+				  &transport->pack_lockfiles, data->version);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
@@ -909,6 +909,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->progress = isatty(2);
+	string_list_init(&ret->pack_lockfiles, 1);
 
 	if (!remote)
 		BUG("No remote provided to transport_get()");
@@ -1302,10 +1303,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
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
index f2ee7c4f49..e430677217 100644
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
2.19.0.271.gfe8321ec05.dirty

