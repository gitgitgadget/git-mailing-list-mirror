Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D971F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965007AbeB1XYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:08 -0500
Received: from mail-qt0-f202.google.com ([209.85.216.202]:38536 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeB1XX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:57 -0500
Received: by mail-qt0-f202.google.com with SMTP id x35so3328663qtx.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=X+er8dGyLcN/Sq+DYxKPoZPqCs9VUaBh3uUM3bcdeO0=;
        b=U4pZnJ6fLxTTxOlYxR2hOSly8XY/UFj4bHaoCVUcfpIaesdXCHbJRowEkBKQBHa/eQ
         q4R1gyePMNXxaF98yxMOCrisVA3Jjx9lLvafdS5mGmrXaCSunVsJRvPIl78LJ9aMRCW8
         0pnj2mx/SIxkUA5dTmWv5w6IlLW1uDzF93Jcj0Yyz7z4xdv6PMZd40slm+h1qQwG84XS
         yFwpddFcJgHT1e+Fwq/cIKN6ErFb74NjlVlZNrdh30yJQWPQDeJNxxuKtNU6ytKihY1t
         41FgkiPSOboSNaj6ijL98W963ELBktEaDieBRoZQ4rFge/JgZNqHkuQWOTorYb4gA+IX
         UOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=X+er8dGyLcN/Sq+DYxKPoZPqCs9VUaBh3uUM3bcdeO0=;
        b=et/iutPuIwiNzmo8zw7dsLca2kwHIHDRZsQ5ud5usGa4esKGbuyMQea1mH7yYQDBhP
         WXt+tPYlKFaCJc5d037GP/T4VTGsEQ7c7LABgcr6DqZ6lvetcYvIdpbD9Cn3IcF3qWLJ
         x6/g207VZHBkqtf095oE4wpHmeabFk/3OWpg/ctq+6EgHrlycVg0ON5qJb1bfx8D7eHo
         vBS6bq4cDlzGYS55gPqTsV1cVy37FDJ1g/c7y/kOLa0L3hKfP5+3BCNULiyogFk299G6
         o4KxDJMzt7yQcHur8NEaPWCBHLb1nRaO1LvXHan0XplgzEhBKgpKWRxZc+calJbLY9aC
         0moA==
X-Gm-Message-State: APf1xPCzXq1ztlPdU3oHWyIMcTf5keZKz+clAg6Q6WbNoA6mLqANzdnH
        K0DMMvZK8j40fF275cIhV8rkgLP7DxiRUYmnyxe5MfJ1MganC0uXRm5ONnia19+yR2V0G2Bg8T7
        OlXIXtcy8X+BgND5bkFlMimIKax9ASoVIsYASjbtQPodMxfcOzxxNrN+frw==
X-Google-Smtp-Source: AG47ELsnWGU3HtnBuiPP8y+8LvAkAh4+GswY80BH31r2GuIJ6g/cohTkjSnG8W4CbUJGhYz2B+jrcblgA5k=
MIME-Version: 1.0
X-Received: by 10.200.82.134 with SMTP id s6mr14243925qtn.60.1519860237028;
 Wed, 28 Feb 2018 15:23:57 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:32 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-16-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 15/35] transport: convert get_refs_list to take a list of
 ref patterns
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the 'struct transport' virtual function 'get_refs_list()' to
optionally take an argv_array of ref patterns.  When communicating with
a server using protocol v2 these ref patterns can be sent when
requesting a listing of their refs allowing the server to filter the
refs it sends based on the sent patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c   |  5 +++--
 transport-internal.h |  9 ++++++++-
 transport.c          | 16 +++++++++-------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 508015023..4c334b5ee 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1026,7 +1026,8 @@ static int has_attribute(const char *attrs, const char *attr) {
 	}
 }
 
-static struct ref *get_refs_list(struct transport *transport, int for_push)
+static struct ref *get_refs_list(struct transport *transport, int for_push,
+				 const struct argv_array *ref_patterns)
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper;
@@ -1039,7 +1040,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->vtable->get_refs_list(transport, for_push);
+		return transport->vtable->get_refs_list(transport, for_push, ref_patterns);
 	}
 
 	if (data->push && for_push)
diff --git a/transport-internal.h b/transport-internal.h
index 3c1a29d72..36fcee437 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -3,6 +3,7 @@
 
 struct ref;
 struct transport;
+struct argv_array;
 
 struct transport_vtable {
 	/**
@@ -17,11 +18,17 @@ struct transport_vtable {
 	 * the transport to try to share connections, for_push is a
 	 * hint as to whether the ultimate operation is a push or a fetch.
 	 *
+	 * If communicating using protocol v2 a list of patterns can be
+	 * provided to be sent to the server to enable it to limit the ref
+	 * advertisement.  Since ref filtering is done on the server's end,
+	 * this can return refs which don't match the provided ref_patterns.
+	 *
 	 * If the transport is able to determine the remote hash for
 	 * the ref without a huge amount of effort, it should store it
 	 * in the ref's old_sha1 field; otherwise it should be all 0.
 	 **/
-	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
+	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
+				     const struct argv_array *ref_patterns);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
diff --git a/transport.c b/transport.c
index ffc6b2614..c54a44630 100644
--- a/transport.c
+++ b/transport.c
@@ -72,7 +72,7 @@ struct bundle_transport_data {
 	struct bundle_header header;
 };
 
-static struct ref *get_refs_from_bundle(struct transport *transport, int for_push)
+static struct ref *get_refs_from_bundle(struct transport *transport, int for_push, const struct argv_array *ref_patterns)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -189,7 +189,8 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
-static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
+static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
+					const struct argv_array *ref_patterns)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs = NULL;
@@ -204,7 +205,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
-		get_remote_refs(data->fd[1], &reader, &refs, for_push, NULL);
+		get_remote_refs(data->fd[1], &reader, &refs, for_push,
+				ref_patterns);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -250,7 +252,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 
 	if (!data->got_remote_heads)
-		refs_tmp = get_refs_via_connect(transport, 0);
+		refs_tmp = get_refs_via_connect(transport, 0, NULL);
 
 	switch (data->version) {
 	case protocol_v2:
@@ -568,7 +570,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	int ret = 0;
 
 	if (!data->got_remote_heads)
-		get_refs_via_connect(transport, 1);
+		get_refs_via_connect(transport, 1, NULL);
 
 	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
@@ -1028,7 +1030,7 @@ int transport_push(struct transport *transport,
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1);
+		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1137,7 +1139,7 @@ int transport_push(struct transport *transport,
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->got_remote_refs) {
-		transport->remote_refs = transport->vtable->get_refs_list(transport, 0);
+		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
 		transport->got_remote_refs = 1;
 	}
 
-- 
2.16.2.395.g2e18187dfd-goog

