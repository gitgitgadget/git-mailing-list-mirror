Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821CC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386572AbiEBRNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386558AbiEBRNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:35 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B65F76
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:10:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b184-20020a62cfc1000000b0050d209cb8dcso8346964pfg.3
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gIGDHPziLWSVgKkyF2vUur9VylGh6NVOnERCjmA4MhA=;
        b=Mi0zT+HE/noM7lTy07tbBYupqPRehpPflyJ0rVStliz073aLEIABvcI2SgvvV4WLGq
         LAM1nNOeiZ/NN0X0GTqB3ygtiQ0M7aewHF1hoZ1cMAL8HpZokiqXkuVz0VGzFlKqHY+1
         viLPaCRK7CgKpDStQdVmjnZyd851mKX9Pls6G9ZtHdEx/4OrnIvgtdxgijfZgT9xgjAR
         miNR9tDZB15AAoxt9WvQ6dhdFH6oCUPu3wdNAum7O/afzrDlpGJFB6OsXShP+WjjeuiD
         r/rvbqqSVY0lrfpr47O8viOT4ErvGK6ISZgxwGMbxsExEPigCAhPG5GxPlZQiS5ywnZH
         lqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gIGDHPziLWSVgKkyF2vUur9VylGh6NVOnERCjmA4MhA=;
        b=ODtdIgjLeCkgIxFTX7kputPJxPR5d/6VcxbvHfiu+0LNsfwyMOg3jLbr5FWXci5UZi
         S91grx2KezCInTM9D48eL4+3WUqtszaTE/yrTvismgM6DIgXUMWxj4LvSh7NXMFE1FEB
         3ZGuhLdGIvts5cyndJfH06EjBGezuIVO+CO+PSLGV9jd0aNQ1tKalXaFLozlFaxhyL7s
         9Z5pJ2+GinFxFyQvUDxKxoIXCG796JsEsI/aU/h4czuLMlW6ejMepQ9C90t8YwHwrZmt
         8FBY0lSX58PoyJwh4KEvxay6LKPvg0opiFqNOtXD4EWBVt6WTHOpJUplnU+LEp/5b03+
         jMrA==
X-Gm-Message-State: AOAM532JJ85BQLdTsXhMCLh91pdmoYl7yROOCiRjEfMZvwONE+Hf6lvQ
        STHoTceOpqEbPIznvRJr73JQ1H7uHZMVMcVV54aUlXos+WGKiDDcFWdKH2wDTt2de+0kDKOzTH4
        yoB/ZolGFraFROqmaXssNs0DnoXHn51UNEjd21tQ/+yEdN3LMKPBUlF7kGnvUdOyiJQ==
X-Google-Smtp-Source: ABdhPJzGX0txm4lXKPpVRcrIZpIm4cyZPU1X2oJ7jqPjVobmleNTq1/9ieX4ZbTPPjMggInjL7ArgwlOYenCgR0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:8c8f:b0:15e:ab1c:591b with SMTP
 id t15-20020a1709028c8f00b0015eab1c591bmr3877301plo.171.1651511404766; Mon,
 02 May 2022 10:10:04 -0700 (PDT)
Date:   Mon,  2 May 2022 17:09:01 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-6-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 5/8] transport: add client side capability to request object-info
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to get information about an object without having
to download it completely. The server logic has already been implemented
as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,
2021-04-20)=E2=80=9D. This patch implements the client option for it. Curre=
ntly,
only 'size' is supported and the server must be v2, however future
patches can implement additional options.

The question of version mismatch often comes up with client/server
relationships. There are two cases to consider here (assuming either
client or server functionality for object-info changes between the
different versions):

 1. client version > server version
 	- client can request additional attributes from server
 2. server version > client version
 	- server can return additional info to the client

The second case is a non-issue since the client would never be able to
request additional info from the server.  In order to solve the first
case, recall an earlier patch where the server sends back the attributes
even if no object ids are sent by the client. This allows the client to
first check whether the server can accept the requested attributes
before sending the entire request.

---
 fetch-pack.c       | 23 +++++++++++++
 fetch-pack.h       |  8 +++++
 transport-helper.c |  7 ++--
 transport.c        | 81 +++++++++++++++++++++++++++++++++++++++++++++-
 transport.h        | 11 +++++++
 5 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 45473b4602..506ca28e05 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1278,6 +1278,29 @@ static void write_command_and_capabilities(struct st=
rbuf *req_buf,
 	packet_buf_delim(req_buf);
 }
=20
+void send_object_info_request(int fd_out, struct object_info_args *args)
+{
+	struct strbuf req_buf =3D STRBUF_INIT;
+	struct string_list unsorted_object_info_options =3D *args->object_info_op=
tions;
+	size_t i;
+
+	write_command_and_capabilities(&req_buf, args->server_options, "object-in=
fo");
+
+	if (unsorted_string_list_has_string(&unsorted_object_info_options, "size"=
))
+		packet_buf_write(&req_buf, "size");
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
diff --git a/fetch-pack.h b/fetch-pack.h
index 8c7752fc82..c27018d48c 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -69,6 +69,12 @@ struct fetch_pack_args {
 	unsigned connectivity_checked:1;
 };
=20
+struct object_info_args {
+	const struct string_list *object_info_options;
+	const struct string_list *server_options;
+	const struct oid_array *oids;
+};
+
 /*
  * sought represents remote references that should be updated from.
  * On return, the names that were found on the remote will have been
@@ -102,4 +108,6 @@ void negotiate_using_fetch(const struct oid_array *nego=
tiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
=20
+void send_object_info_request(int fd_out, struct object_info_args *args);
+
 #endif
diff --git a/transport-helper.c b/transport-helper.c
index b4dbbabb0c..093946f7fd 100644
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
index 3d64a43ab3..08c505e1d0 100644
--- a/transport.c
+++ b/transport.c
@@ -353,6 +353,79 @@ static struct ref *handshake(struct transport *transpo=
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
+	struct string_list server_attributes =3D STRING_LIST_INIT_DUP;
+
+	memset(&args, 0, sizeof(args));
+	args.server_options =3D transport->server_options;
+	args.object_info_options =3D transport->smart_options->object_info_option=
s;
+
+	connect_setup(transport, 0);
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_DIE_ON_ERR_PACKET);
+	data->version =3D discover_version(&reader);
+
+	transport->hash_algo =3D reader.hash_algo;
+
+	switch (data->version) {
+	case protocol_v2:
+		if (!server_supports_v2("object-info", 0))
+			return -1;
+		/**
+		 * Send a request with only attributes first. If server can return all
+		 * of the requested attributes, then send request with object ids
+		 */
+		send_object_info_request(data->fd[1], &args);
+		if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) {
+			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless=
 delimiter expected");
+			return -1;
+		}
+		string_list_split(&server_attributes, reader.line, ' ', -1);
+		packet_reader_read(&reader);
+		check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless =
delimiter expected");
+		if (server_attributes.nr !=3D args.object_info_options->nr)
+			return -1;
+		for (i =3D 0; i < server_attributes.nr; i++) {
+			if (!strcmp(server_attributes.items[i].string, "size"))
+				size_index =3D i + 1;
+		}
+		args.oids =3D transport->smart_options->object_info_oids;
+		send_object_info_request(data->fd[1], &args);
+		break;
+	case protocol_v1:
+	case protocol_v0:
+		die(_("wrong protocol version. expected v2"));
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL)
+		die(_("error reading object info header"));
+	i =3D 0;
+	while (packet_reader_read(&reader) =3D=3D PACKET_READ_NORMAL) {
+		struct string_list object_info_values =3D STRING_LIST_INIT_DUP;
+
+		string_list_split(&object_info_values, reader.line, ' ', -1);
+		if (size_index > 0) {
+			if (!strcmp(object_info_values.items[size_index].string, ""))
+				die("object-info: not our ref %s",
+					object_info_values.items[0].string);
+			*(*object_info_data)[i].sizep =3D strtoul(object_info_values.items[size=
_index].string, NULL, 10);
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
@@ -392,8 +465,14 @@ static int fetch_refs_via_pack(struct transport *trans=
port,
 	args.server_options =3D transport->server_options;
 	args.negotiation_tips =3D data->options.negotiation_tips;
 	args.reject_shallow_remote =3D transport->smart_options->reject_shallow;
+	args.object_info =3D transport->smart_options->object_info;
=20
-	if (!data->got_remote_heads) {
+	if (transport->smart_options && transport->smart_options->object_info) {
+		if (!fetch_object_info(transport, data->options.object_info_data))
+			goto cleanup;
+		ret =3D -1;
+		goto cleanup;
+	} else if (!data->got_remote_heads) {
 		int i;
 		int must_list_refs =3D 0;
 		for (i =3D 0; i < nr_heads; i++) {
diff --git a/transport.h b/transport.h
index 12bc08fc33..dbf60bb710 100644
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
2.36.0.rc2.10170.gb555eefa6f

