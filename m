Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BECE1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCNSeS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:34:18 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:33795 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbeCNScw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:52 -0400
Received: by mail-qk0-f202.google.com with SMTP id a22so2716270qkc.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3KwKss0yiImv+LpOoBm6nnu/wpCXcvG9K6sVQ4IEBrQ=;
        b=qPsnZmYDRRQKzVOyFo9PMmcranKZoTFK6gg6q4xDpiadcNqPnbL1NGpWqBlrOP5WdV
         bJH2STSAE3Kezk+WUoN2ttyFTzo4bKBHsJw7KveWj3np5NmyZbci0KHCiH3gJG2b7DfL
         pW51HtriEFbTcm4EQV10gtyWqjIJz6b00Kj+h63O2+PtWpI3ox53KoQMnSLYocgiEatA
         KElmeN+RSZZ9/cb4o2EJxj6QRmEl64SHmRrV3WFF88KmBF2/15s2E0873sGOuKIfJBZe
         V+upe/SjT6gftx4xmUmkDFUi4FPqO1WIEY1Qy2/6c2SpainDt17ght9T8bD41Or7DYS1
         unkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3KwKss0yiImv+LpOoBm6nnu/wpCXcvG9K6sVQ4IEBrQ=;
        b=MAVAfCisRM+9ygjiqEoiiWEZ4SEF4I4gEa1cefRSIWbFe+uyiMHgxLHo6jrv02Rtgz
         NFGXNqVicodlBusJvev0SuKifLQFrPFFVerkocL4X9vQlnwQ5qwA8q2ulIV0DErkTcNe
         S8/EnoHC9fH7HuMj2Dx7K1xzybdtccYqcqNrqpJ2wtOj86ohSOnzou1ar9H2meVMKTjI
         U0lDnmhQqxLbijArI6m2Xg4UaGZoYl6cpVchUbPwWI3eNptFZp2QHUAg1c+T0g4oHTWF
         7//2U2BPDOEW9jue7XtnE56DuSzl/PQkc0yqMZ9ve/KS0LTg/lTqPeapaBjzhK1CTVrf
         PYCg==
X-Gm-Message-State: AElRT7F3AVD+wrRTC3tQh3nXs4yXslh2Rc+V19NzEfYUjqmTqcOr4BTC
        wKWXyTWvCRXAmtKeKs22VkC4/RVIlHmiEcLofOUfU+izklUhF5MsRrEOsleQ2SBfj8kx4KiK/TY
        R5+qB/qYWcRh0Js+GvwXlFrqNvMmhHbKT7khshbe4EnjNFMfShPofR/DUdQ==
X-Google-Smtp-Source: AG47ELtYIKtePd6eIeX9NQWQh2IVn8xqc3zT8D/pH2yoSyanWrXt9FRHCIJKzHYSME3qk+sNQkz6xo82V3w=
MIME-Version: 1.0
X-Received: by 10.200.97.9 with SMTP id a9mr3753371qtm.22.1521052371873; Wed,
 14 Mar 2018 11:32:51 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:52 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-16-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 15/35] transport: convert get_refs_list to take a list of
 ref prefixes
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the 'struct transport' virtual function 'get_refs_list()' to
optionally take an argv_array of ref prefixes.  When communicating with
a server using protocol v2 these ref prefixes can be sent when
requesting a listing of their refs allowing the server to filter the
refs it sends based on the sent prefixes.  This list will be ignored
when not using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c   |  5 +++--
 transport-internal.h | 11 ++++++++++-
 transport.c          | 18 +++++++++++-------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 5080150231..8774ab3013 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1026,7 +1026,8 @@ static int has_attribute(const char *attrs, const char *attr) {
 	}
 }
 
-static struct ref *get_refs_list(struct transport *transport, int for_push)
+static struct ref *get_refs_list(struct transport *transport, int for_push,
+				 const struct argv_array *ref_prefixes)
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper;
@@ -1039,7 +1040,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->vtable->get_refs_list(transport, for_push);
+		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
 	}
 
 	if (data->push && for_push)
diff --git a/transport-internal.h b/transport-internal.h
index 3c1a29d727..1cde6258a7 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -3,6 +3,7 @@
 
 struct ref;
 struct transport;
+struct argv_array;
 
 struct transport_vtable {
 	/**
@@ -17,11 +18,19 @@ struct transport_vtable {
 	 * the transport to try to share connections, for_push is a
 	 * hint as to whether the ultimate operation is a push or a fetch.
 	 *
+	 * If communicating using protocol v2 a list of prefixes can be
+	 * provided to be sent to the server to enable it to limit the ref
+	 * advertisement.  Since ref filtering is done on the server's end, and
+	 * only when using protocol v2, this list will be ignored when not
+	 * using protocol v2 meaning this function can return refs which don't
+	 * match the provided ref_prefixes.
+	 *
 	 * If the transport is able to determine the remote hash for
 	 * the ref without a huge amount of effort, it should store it
 	 * in the ref's old_sha1 field; otherwise it should be all 0.
 	 **/
-	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
+	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
+				     const struct argv_array *ref_prefixes);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
diff --git a/transport.c b/transport.c
index ffc6b2614f..2e68010dd0 100644
--- a/transport.c
+++ b/transport.c
@@ -72,7 +72,9 @@ struct bundle_transport_data {
 	struct bundle_header header;
 };
 
-static struct ref *get_refs_from_bundle(struct transport *transport, int for_push)
+static struct ref *get_refs_from_bundle(struct transport *transport,
+					int for_push,
+					const struct argv_array *ref_prefixes)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -189,7 +191,8 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
-static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
+static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
+					const struct argv_array *ref_prefixes)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
@@ -204,7 +207,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
-		get_remote_refs(data->fd[1], &reader, &refs, for_push, NULL);
+		get_remote_refs(data->fd[1], &reader, &refs, for_push,
+				ref_prefixes);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -250,7 +254,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 
 	if (!data->got_remote_heads)
-		refs_tmp = get_refs_via_connect(transport, 0);
+		refs_tmp = get_refs_via_connect(transport, 0, NULL);
 
 	switch (data->version) {
 	case protocol_v2:
@@ -568,7 +572,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	int ret = 0;
 
 	if (!data->got_remote_heads)
-		get_refs_via_connect(transport, 1);
+		get_refs_via_connect(transport, 1, NULL);
 
 	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
@@ -1028,7 +1032,7 @@ int transport_push(struct transport *transport,
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1);
+		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1137,7 +1141,7 @@ int transport_push(struct transport *transport,
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->got_remote_refs) {
-		transport->remote_refs = transport->vtable->get_refs_list(transport, 0);
+		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
 		transport->got_remote_refs = 1;
 	}
 
-- 
2.16.2.804.g6dcf76e118-goog

