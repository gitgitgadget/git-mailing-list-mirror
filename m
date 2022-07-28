Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C565C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiG1XCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiG1XCn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:02:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCDD73938
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f3959ba41so28204037b3.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=GS5eDn4YdEh1PlE4c5v2Ab58gsl8H/MZbRe10SceZQA=;
        b=isBushsJvjfj4BwjCCkLIwlIEquAyrgrsogaEC4EmaeMzeRF/aUOTvPgeWHhie6IUJ
         048qs9elxfdD/NIWBGRqAOLRHGRvU6MMi/Fkerlnmgd5V4H1bjfNkhC+GQEQvriw3+Jo
         C6nVqZRJwG3e+O2FAe78VAMS3ayJH2nsvFBf9ySV/CqoR5E1/6gU2DAncltU2qPuvy7+
         RxZU2/IevOgxwVYbWnM311NgM5YaJpb4zhaLwEtZXk3gLr3GCkW67aDuU+kcrtwEU5IN
         VSPKatMDtSTkf+IRqOfPWTCnI0ShpamIoICk2E265Z+dZpEXT+z5d7nURmkjq94OL3VK
         B51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=GS5eDn4YdEh1PlE4c5v2Ab58gsl8H/MZbRe10SceZQA=;
        b=UuWbBrQXyq/AfEotpL1AxMK5jgYIc9eAqqD+jmWy6ilN08OnnY9CF5YH59Pm+hAZvs
         KTW3+lZSNbnnTeqHINb9yygPNUCfY8HQLdXMjylJcDNbTseo43Trp9ZcR0UHo7cBgtol
         BS9EEdLvZMe/V8kjQXmFc2HPkZxcSj/O4etBEaeh9B5ZJTD4wiLFcSUzhBh4fGBXbNHV
         yURf6JjNTzi1y+aC4EmM7KL72p0Cba8+3shXtaPse10JICWey39IZXD0dQrHDujIz6PJ
         81uWWhJMGKnCGTORPplpenp4M19/VMmSRpYnBVzSbmTATz4c26gGEYEA4DT+s1MI+57y
         j9TA==
X-Gm-Message-State: ACgBeo24EL9svBBk3VTa8erUDMfIDw+0lgcwzcKmNMJGUPVrjYHZk1Up
        j+MXdEecyYMaT45/Er9vyNOHmaGAJV3B4BV2LT1DtS8C3Lpl3sIRxVPaTi7yFiK2reeMGuCcVwC
        WfkufO7Kc081Nx87PRfoS46RRlPVRJJl825NEfm6ay7G4/VOZlNuNLEGO1ZGntwOoEQ==
X-Google-Smtp-Source: AA6agR5F+5ewk1R4TFnHR3m6Q7Ca1sgn4sCZh/G/eS8mte8e+vgTuoRPlU0jn4wk2cnbRW9uQ6jbDmmmlGemYII=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a0d:dac6:0:b0:320:2d6b:4d3d with SMTP id
 c189-20020a0ddac6000000b003202d6b4d3dmr856630ywe.367.1659049356224; Thu, 28
 Jul 2022 16:02:36 -0700 (PDT)
Date:   Thu, 28 Jul 2022 23:02:09 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220728230210.2952731-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 5/6] transport: add client support for object-info
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to get information about an object without having
to download it completely. The server logic has already been implemented
as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,
2021-04-20)=E2=80=9D. This patch adds client functions to communicate with =
the
server.

The client currently supports requesting a list of object ids with
features 'size' and 'type' from a v2 server. If a server does not
advertise either of the requested features, then the client falls back
to making the request through 'fetch'.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c       |  28 ++++++++++++
 fetch-pack.h       |  10 +++++
 transport-helper.c |   7 ++-
 transport.c        | 110 +++++++++++++++++++++++++++++++++++++++++++--
 transport.h        |  11 +++++
 5 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 8c862b017e..d373aed775 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1293,6 +1293,31 @@ static void write_command_and_capabilities(struct st=
rbuf *req_buf,
 	packet_buf_delim(req_buf);
 }
=20
+void send_object_info_request(int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf =3D STRBUF_INIT;
+	size_t i;
+
+	write_command_and_capabilities(&req_buf, args->server_options, "object-in=
fo");
+
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
+		packet_buf_write(&req_buf, "size");
+
+	if (unsorted_string_list_has_string(args->object_info_options, "type"))
+		packet_buf_write(&req_buf, "type");
+
+	if (args->oids) {
+		for (i =3D 0; i < args->oids->nr; i++)
+			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
+	}
+
+	packet_buf_flush(&req_buf);
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+
+	strbuf_release(&req_buf);
+}
+
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_=
out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
@@ -1634,6 +1659,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack=
_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen =3D 1;
=20
+	if (args->object_info)
+		state =3D FETCH_SEND_REQUEST;
+
 	while (state !=3D FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
diff --git a/fetch-pack.h b/fetch-pack.h
index 8c7752fc82..11c513f748 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -17,6 +17,7 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+	struct object_info **object_info_data;
=20
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
@@ -43,6 +44,7 @@ struct fetch_pack_args {
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 	unsigned refetch:1;
+	unsigned object_info:1;
=20
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
@@ -69,6 +71,12 @@ struct fetch_pack_args {
 	unsigned connectivity_checked:1;
 };
=20
+struct object_info_args {
+	struct string_list *object_info_options;
+	const struct string_list *server_options;
+	struct oid_array *oids;
+};
+
 /*
  * sought represents remote references that should be updated from.
  * On return, the names that were found on the remote will have been
@@ -102,4 +110,6 @@ void negotiate_using_fetch(const struct oid_array *nego=
tiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
=20
+void send_object_info_request(int fd_out, struct object_info_args *args);
+
 #endif
diff --git a/transport-helper.c b/transport-helper.c
index 322c722478..48a6680200 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -686,13 +686,16 @@ static int fetch_refs(struct transport *transport,
=20
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
-	 * helper does not support protocol v2. --negotiate-only requires
-	 * protocol v2.
+	 * helper does not support protocol v2. --negotiate-only and --object-inf=
o
+	 * require protocol v2.
 	 */
 	if (data->transport_options.acked_commits) {
 		warning(_("--negotiate-only requires protocol v2"));
 		return -1;
 	}
+	if (transport->smart_options->object_info) {
+		die(_("--object-info requires protocol v2"));
+	}
=20
 	if (!data->get_refs_list_called)
 		get_refs_list_using_list(transport, 0);
diff --git a/transport.c b/transport.c
index 52db7a3cb0..2d503e2fbd 100644
--- a/transport.c
+++ b/transport.c
@@ -353,6 +353,80 @@ static struct ref *handshake(struct transport *transpo=
rt, int for_push,
 	return refs;
 }
=20
+static int fetch_object_info(struct transport *transport, struct object_in=
fo **object_info_data)
+{
+	size_t i;
+	int size_index =3D -1;
+	struct git_transport_data *data =3D transport->data;
+	struct object_info_args args;
+	struct packet_reader reader;
+
+	memset(&args, 0, sizeof(args));
+	args.server_options =3D transport->server_options;
+	args.object_info_options =3D transport->smart_options->object_info_option=
s;
+	args.oids =3D transport->smart_options->object_info_oids;
+
+	connect_setup(transport, 0);
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_GENTLE_ON_EOF |
+			PACKET_READ_DIE_ON_ERR_PACKET);
+	data->version =3D discover_version(&reader);
+
+	transport->hash_algo =3D reader.hash_algo;
+
+	switch (data->version) {
+	case protocol_v2:
+		if (!server_supports_v2("object-info", 0))
+			return -1;
+		if (unsorted_string_list_has_string(args.object_info_options, "size")
+				&& !server_supports_feature("object-info", "size", 0)) {
+			return -1;
+		}
+		if (unsorted_string_list_has_string(args.object_info_options, "type")
+				&& !server_supports_feature("object-info", "type", 0)) {
+			return -1;
+		}
+		send_object_info_request(data->fd[1], &args);
+		break;
+	case protocol_v1:
+	case protocol_v0:
+		die(_("wrong protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	for (i =3D 0; i < args.object_info_options->nr; i++) {
+		if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) {
+			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless=
 delimiter expected");
+			return -1;
+		}
+		if (unsorted_string_list_has_string(args.object_info_options, reader.lin=
e)) {
+			if (!strcmp(reader.line, "size"))
+				size_index =3D i;
+			continue;
+		}
+		return -1;
+	}
+
+	i =3D 0;
+	while (packet_reader_read(&reader) =3D=3D PACKET_READ_NORMAL && i < args.=
oids->nr) {
+		struct string_list object_info_values =3D STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader.line, ' ', -1);
+		if (0 <=3D size_index) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
+				die("object-info: not our ref %s",
+					object_info_values.items[0].string);
+			*(*object_info_data)[i].sizep =3D strtoul(object_info_values.items[1 + =
size_index].string, NULL, 10);
+		}
+		i++;
+	}
+	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless d=
elimiter expected");
+
+	return 0;
+}
+
 static struct ref *get_refs_via_connect(struct transport *transport, int f=
or_push,
 					struct transport_ls_refs_options *options)
 {
@@ -363,10 +437,12 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	int ret =3D 0;
+	size_t i;
 	struct git_transport_data *data =3D transport->data;
 	struct ref *refs =3D NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp =3D NULL;
+	struct ref *object_info_refs =3D xcalloc(1, sizeof (struct ref));
=20
 	memset(&args, 0, sizeof(args));
 	args.uploadpack =3D data->options.uploadpack;
@@ -392,8 +468,25 @@ static int fetch_refs_via_pack(struct transport *trans=
port,
 	args.server_options =3D transport->server_options;
 	args.negotiation_tips =3D data->options.negotiation_tips;
 	args.reject_shallow_remote =3D transport->smart_options->reject_shallow;
-
-	if (!data->got_remote_heads) {
+	args.object_info =3D transport->smart_options->object_info;
+
+	if (transport->smart_options && transport->smart_options->object_info) {
+		struct ref *ref =3D object_info_refs;
+
+		if (!fetch_object_info(transport, data->options.object_info_data))
+			goto cleanup;
+		args.object_info_data =3D data->options.object_info_data;
+		args.quiet =3D 1;
+		args.no_progress =3D 1;
+		for (i =3D 0; i < transport->smart_options->object_info_oids->nr; i++) {
+			struct ref *temp_ref =3D xcalloc(1, sizeof (struct ref));
+			temp_ref->old_oid =3D *(transport->smart_options->object_info_oids->oid=
 + i);
+			temp_ref->exact_oid =3D 1;
+			ref->next =3D temp_ref;
+			ref =3D ref->next;
+		}
+		transport->remote_refs =3D object_info_refs->next;
+	} else if (!data->got_remote_heads) {
 		int i;
 		int must_list_refs =3D 0;
 		for (i =3D 0; i < nr_heads; i++) {
@@ -433,12 +526,22 @@ static int fetch_refs_via_pack(struct transport *tran=
sport,
 			  to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfiles, data->version);
=20
+	if (args.object_info) {
+		struct ref *ref_cpy_reader =3D object_info_refs->next;
+		int i =3D 0;
+		while (ref_cpy_reader) {
+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*a=
rgs.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
+			ref_cpy_reader =3D ref_cpy_reader->next;
+			i++;
+		}
+	}
+
 	data->got_remote_heads =3D 0;
 	data->options.self_contained_and_connected =3D
 		args.self_contained_and_connected;
 	data->options.connectivity_checked =3D args.connectivity_checked;
=20
-	if (!refs)
+	if (refs =3D=3D NULL && !args.object_info)
 		ret =3D -1;
 	if (report_unmatched_refs(to_fetch, nr_heads))
 		ret =3D -1;
@@ -453,6 +556,7 @@ static int fetch_refs_via_pack(struct transport *transp=
ort,
=20
 	free_refs(refs_tmp);
 	free_refs(refs);
+	free_refs(object_info_refs);
 	return ret;
 }
=20
diff --git a/transport.h b/transport.h
index b5bf7b3e70..5512fdb140 100644
--- a/transport.h
+++ b/transport.h
@@ -6,6 +6,7 @@
 #include "remote.h"
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "object-store.h"
=20
 struct git_transport_options {
 	unsigned thin : 1;
@@ -31,6 +32,12 @@ struct git_transport_options {
 	 */
 	unsigned connectivity_checked:1;
=20
+	/*
+	 * Transport will attempt to pull only object-info. Fallbacks
+	 * to pulling entire object if object-info is not supported
+	 */
+	unsigned object_info : 1;
+
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -54,6 +61,10 @@ struct git_transport_options {
 	 * common commits to this oidset instead of fetching any packfiles.
 	 */
 	struct oidset *acked_commits;
+
+	struct oid_array *object_info_oids;
+	struct object_info **object_info_data;
+	struct string_list *object_info_options;
 };
=20
 enum transport_family {
--=20
2.37.1.455.g008518b4e5-goog

