Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454301F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeBGBO6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:58 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:48505 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbeBGBNv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:51 -0500
Received: by mail-vk0-f74.google.com with SMTP id o64so2158550vka.15
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=cK513e6BNKPqiS3G2kqkCEVEcpHWayMuq0BwUJqt23M=;
        b=JVDLVRwv5CFfhAEACh+zy6nJY6dOi8Viz7hT3+qJ3oS0QPFxCEQTDw1AtQ1chN5/lB
         +65Mx0EWGnW67vTZf0CdmLshY8sr5aHs0A9stasZBgTdt1G2tA2wPmIrmL3C680C38Vi
         NrzFhsk9NXkK1br3tF6zI6VhuVpYWB++WrAK9rxnedYma0jOor9GlFd8jhW5CCLpO7G6
         dsG2Kh0deiaHN0V/hefchN4cZeDU2iJPRVhtM3hXTbzB1Q8DdaGUkHaDvRgRRIqzbNjQ
         AvgQudlu68BWk6kP6r9r9e5gl/BCojeIi5295a7fRTLDM1MO19S1a25nNXLZv22XEH1n
         U74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=cK513e6BNKPqiS3G2kqkCEVEcpHWayMuq0BwUJqt23M=;
        b=rG0H/9/Ndud62cOn66unTbOPbWkRyX6WVezV1qZMrh95dJSVPshUbfx60mb+VMpAko
         755rKpt3GSoZDp1yDTFJ2wYX20dSyLu5862+VzmtlzaCHfeLwRgLWXHTeWQ3hWockJQo
         3kce2E+93K6L+DfHHzmP+AB/nq0YPlGPPXDIi5RwNvpsBRLlcr/o+wmGqWVqpCFIaLDa
         gbLEA1zoY1DQY6Jx7svfmil1K0o+eW32UWvpR2hoyUEpkMLFvXRZF4rO2ffRbJWYDeVE
         viCJMgSEHSH5xtRapfYZH2j0oJ+sPBfYXbyhxqHLyD0E5KcKcA+shHkCMHaLqy3t/dgc
         25eA==
X-Gm-Message-State: APf1xPCcaqzq9oJ3EdRuk6Cki7HZMHeMrCGHdjnQ4g/RAB1pMO4iF4XM
        LcHpHKrCpNeFhUbtpscNR1hCRE+l1PyxzW315wleDHXPgk13jK0b5Yb58+PTQcvYanNMBWxT9zO
        8/nVzo0K028z5gsl/6i5tKi09CrfbPolTkShVmAet9/ez+pJYI3RfiCtmBw==
X-Google-Smtp-Source: AH8x2240F6mbWu1Wd6Qm/lAi9LDHjfpQit7BwSGJx+vqbmg5EQDxNsoChrOVOg6Fsflr8+W1tVqhp4vYX4I=
MIME-Version: 1.0
X-Received: by 10.159.51.100 with SMTP id a36mr2105051uac.97.1517966030528;
 Tue, 06 Feb 2018 17:13:50 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:52 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-16-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 15/35] transport: convert get_refs_list to take a list of
 ref patterns
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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

