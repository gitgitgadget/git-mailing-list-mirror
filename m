Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5134F1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeACATJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:09 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36549 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeACATD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:03 -0500
Received: by mail-it0-f68.google.com with SMTP id d16so53619itj.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E5s0THBKm+GP9clZVdJNaLZEy0t9BEiNJjcxvgzOYn4=;
        b=CrY8l2Lfj3ugMM/iIWaNYWmr3CjGQSjjFpRMoslcaUpoRBH/RcvdPK2qxvZa+sH7L0
         gL2dgeTjb7e9d8CCvHfN52YN/LRVOYlXQa9HrfjGiIY6Yhk2wi+wTIbNjyzjsoQ/CH4z
         qKLf9v4k21AIPy4txFLX2eRNA8o+KLdutbnszvIBNdH74UzGgk71ScCOjREQKsp8Q08p
         P8zPgpk3XB+LmdH5LAl3szmDmiEtsrYGuWcodwqOTOhlwrEW+4ewqNrQt3txtqIDETRf
         iHZqkU/Opiqo9dVOri516nbNIilA5GrN1MvOU7DbbecZWkwERQPkL/WtyF5dKKM6N+7w
         sgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E5s0THBKm+GP9clZVdJNaLZEy0t9BEiNJjcxvgzOYn4=;
        b=EB5ZQDan82ebA3y39ElGkr2vZsAJzdzpt7ejp/lrzeDUM48qJxf6FuUOIMI1y0qGSg
         DfU/1S+vvRGcod+rEPac1cp5iNSn65XVE+MHcUPHXwsOVtZobBgD3hDocrK+CgeRVs4h
         lFPwtcj2cpJ7zdmq7UfAuRq2bgKfCZ/+JRG2E8BFlwWtkQ0VzIWSSqB3CMu0S793gbyf
         gf7ZxIIjjf9FrKMXsgzTNe5u+t4lZcyhBWFq4/wcmayIO64xrzxewzMISBJi2qjcqoFE
         PnxEjERPzbKhZ1Wx1b7v0hJuwv8jbRvReBn6+zPwT0swkjvufvpJpbgw5DX/f3CCHfYR
         Vnlw==
X-Gm-Message-State: AKGB3mJ7L3ENVidaaBDA3cfeaP1bSNho7kIc1dQc3x+v50sxrmksuzM0
        vLLqVsYf73FWCfope7VPaS+u+iDiwKo=
X-Google-Smtp-Source: ACJfBoukCdYhLj575z0XtSfLEwLtBo+rZ23Oek/OdTW0cNIRlnjZYkobVUm0DLMZ6eKGwkiChh5gQg==
X-Received: by 10.36.80.148 with SMTP id m142mr29060itb.6.1514938741879;
        Tue, 02 Jan 2018 16:19:01 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/26] transport: convert get_refs_list to take a list of ref patterns
Date:   Tue,  2 Jan 2018 16:18:16 -0800
Message-Id: <20180103001828.205012-15-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
 transport-internal.h |  4 +++-
 transport.c          | 16 +++++++++-------
 3 files changed, 15 insertions(+), 10 deletions(-)

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
index 3c1a29d72..a67657ce3 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -3,6 +3,7 @@
 
 struct ref;
 struct transport;
+struct argv_array;
 
 struct transport_vtable {
 	/**
@@ -21,7 +22,8 @@ struct transport_vtable {
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
2.15.1.620.gb9897f4670-goog

