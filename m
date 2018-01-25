Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349831F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeAYX7e (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:34 -0500
Received: from mail-it0-f74.google.com ([209.85.214.74]:48271 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeAYX7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:18 -0500
Received: by mail-it0-f74.google.com with SMTP id h200so625192itb.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=cK513e6BNKPqiS3G2kqkCEVEcpHWayMuq0BwUJqt23M=;
        b=MB5uBxHrmSMZYb54UmlsqCKR451KznOMb3gJXVvnggdn94g7xIMt8t68fpYK9SJOWv
         dt2ZoWz+vchYMtFDPTey3SYvSqeOThOiLvQ7IVTlgMCxMSrK++N2XotEAZ0T6mF6Bl/8
         4iuG5Jl22pAoEezGZUQuk0ExAAR3OyjyM73DLuesDKYGZpvNgiO0PTrbPd05DJ+n6YYN
         wQja1uwPUNge1I7HetWAnh1tz+rOb7P54m2yhwBGmAjqouUVjHG17x3krvMlpXnjEPt4
         SxVZyv+FuNN09VW6/mZN4NEWUfJlhqtrq7mtT8hlb2Bb3ZOk7z+K3NOY7KNi8yDLFbT4
         Z/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=cK513e6BNKPqiS3G2kqkCEVEcpHWayMuq0BwUJqt23M=;
        b=Q4PxUoKq6DkU+IuVSMdYLBc9TdhzoFdEJ7ltX0ioi7Z34hs4agAiGZdfJWKa8PVxd8
         WsjXhnlvWiiGdlbmSOTiZaTT4CRGepLvql7kZ9K00uwcs5x/PuWKLhuAgt410nqbu60q
         Tj8cXepCu/NK1iCviLt6I43Eef9rVGS7DwnHL6lQG/xa9K35ZVDSqo9SlDGoxFIJ103L
         S2EmEldg6WQ2Ix2miwQz6ABJChfiuUIeacczsMXWH8Jf0UsSeaq4OG4CPkyyT6J/kHK8
         wuI7gqCb1JtB9rOsKhsIGKmp4tvsn+4/BITZRyejuyzmGVO3ptwcjtUKzV4uRPzkv8I8
         ShIg==
X-Gm-Message-State: AKwxytegrI9KaiAtVJ3eSkbenOv9djjbQ0rSU00BDP0Qo1HgKfTDt8cC
        6vNzwW0IadSQGSEr8dW/iq20Rf+Yj411/VEDHQjF3p9PxPi8mztqyUyxggk3BcxUCbKtEzrCm2w
        5do9/OXazPlj3+7zUSajwKwqdSBKvOQX0jWOowaKmZHGArE7R0a6EQEHBqQ==
X-Google-Smtp-Source: AH8x224lVyrLzxeymkn9U0QCtyQRWq3e+OEzfAqDyksSkQVr61wGcyHDlVw0HmFjaJ+Rxr1Jhv2AVR3Q+zo=
MIME-Version: 1.0
X-Received: by 10.36.40.12 with SMTP id h12mr8669106ith.43.1516924757903; Thu,
 25 Jan 2018 15:59:17 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:26 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-16-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 15/27] transport: convert get_refs_list to take a list of
 ref patterns
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
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
2.16.0.rc1.238.g530d649a79-goog

