Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767291F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeCORc1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:27 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:39822 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeCORc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:26 -0400
Received: by mail-it0-f73.google.com with SMTP id 140-v6so2141535itg.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=1W4xBbqM1o45C/4bjSTbGa8R5NeK9wGH3y2+D6QFJ88=;
        b=k+nwwHEpy3SZky2zkxoEbB8wTbraMgoM8mbgAMv5+mSAdLuAjKZo+tvaYIQsgI1vpy
         BUExoLHFIDyXHzQVX6C8mfBzqFSqRs9pjxb3IQpQp+cST+TwjEQZMA/XhpH0h/GI3n6E
         TR0Nh978k9KnXpvFCrEueKMb1WwOezWtdecjyhz0+es2bqGmk/c/sIXQL8FiZaDV0m33
         8n74a/S032FQ7v8jDnDTghFQ+0GAf9Gl2MpBNNvyPtnJBFl59E47Z0pxJrVYfYMLJJ3S
         CiPOpuT8VTxQsGROf00onTnzWdSDTtDa6eevHx+g4niOAUcm4LYSVMNPMwcvjJXV+gIz
         zLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=1W4xBbqM1o45C/4bjSTbGa8R5NeK9wGH3y2+D6QFJ88=;
        b=bEJ9uc5Xeh0fU7yrIeJ77Uuro7BRMIgG1Cp//abJxRB0uVuhfSn8+SbdGHBTNhIaIr
         1rO3vQDHqIhv2NDFrx1IOSN8euOQz+sVh1X2kiuZOBoj7EpNi4Xl5eejHSDi/KFDLQqw
         dblzKNc7iOpuq25nchSh6OFbOmzZZgV802iKQSNjpkkku+xq0Y94V9ZsaG5fZSfGXd63
         +K7Akpuyuo8GrnlTp8BkcY+moCsao8hMANRycHRH6og1taGQHyFkZJXebaSeWCdgOGeI
         3YthmIAlswJBrMt3p/KosIObGuJUkUwM1LGYDu/DTfnMyUBKF26/faNqtXHBkfYj+rvU
         1Kgg==
X-Gm-Message-State: AElRT7Fw0UBgHrbt2p/9U9ANY56bR7Hr+JlMk2k3MWfmETKZPAGnaHcc
        X58xO8qEL6wfD0sPNrbBR7tjgQ1LliofxdSB4TG5GulYR+72t+FfCpoZJxz1kx1umy8QsY0RPwQ
        BmwwRntMgu0Ru3xXqYcAvDAoiRY5GQ4pbMAgsGiqCy2ij1Vf+gXGZnvaEHg==
X-Google-Smtp-Source: AG47ELtj0xdNA1EXdeVEidI3eB6vfgxk7jgY1w0ZokiqQIVjjQBDwEeRjjcv7cs5nW43lASTxxohtIItL6E=
MIME-Version: 1.0
X-Received: by 2002:a24:6c7:: with SMTP id 190-v6mr3348716itv.28.1521135145394;
 Thu, 15 Mar 2018 10:32:25 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:23 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-17-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 16/35] transport: convert transport_get_remote_refs to take
 a list of ref prefixes
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

Teach transport_get_remote_refs() to accept a list of ref prefixes,
which will be sent to the server for use in filtering when using
protocol v2. (This list will be ignored when not using protocol v2.)

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c     |  2 +-
 builtin/fetch.c     |  4 ++--
 builtin/ls-remote.c |  2 +-
 builtin/remote.c    |  2 +-
 transport.c         |  7 +++++--
 transport.h         | 12 +++++++++++-
 6 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 284651797e..6e77d993fa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1121,7 +1121,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !deepen)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	refs = transport_get_remote_refs(transport);
+	refs = transport_get_remote_refs(transport, NULL);
 
 	if (refs) {
 		mapped_refs = wanted_peer_refs(refs, refspec);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..850382f559 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -250,7 +250,7 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list_item *item = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
+	for (ref = transport_get_remote_refs(transport, NULL); ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 
@@ -336,7 +336,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport);
+	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c4be98ab9e..c6e9847c5c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -96,7 +96,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
-	ref = transport_get_remote_refs(transport);
+	ref = transport_get_remote_refs(transport, NULL);
 	if (transport_disconnect(transport))
 		return 1;
 
diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3..d0b6ff6e29 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -862,7 +862,7 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		remote_refs = transport_get_remote_refs(transport);
+		remote_refs = transport_get_remote_refs(transport, NULL);
 		transport_disconnect(transport);
 
 		states->queried = 1;
diff --git a/transport.c b/transport.c
index 2e68010dd0..3f130518d2 100644
--- a/transport.c
+++ b/transport.c
@@ -1138,10 +1138,13 @@ int transport_push(struct transport *transport,
 	return 1;
 }
 
-const struct ref *transport_get_remote_refs(struct transport *transport)
+const struct ref *transport_get_remote_refs(struct transport *transport,
+					    const struct argv_array *ref_prefixes)
 {
 	if (!transport->got_remote_refs) {
-		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
+		transport->remote_refs =
+			transport->vtable->get_refs_list(transport, 0,
+							 ref_prefixes);
 		transport->got_remote_refs = 1;
 	}
 
diff --git a/transport.h b/transport.h
index 731c78b679..83992a4257 100644
--- a/transport.h
+++ b/transport.h
@@ -178,7 +178,17 @@ int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   unsigned int * reject_reasons);
 
-const struct ref *transport_get_remote_refs(struct transport *transport);
+/*
+ * Retrieve refs from a remote.
+ *
+ * Optionally a list of ref prefixes can be provided which can be sent to the
+ * server (when communicating using protocol v2) to enable it to limit the ref
+ * advertisement.  Since ref filtering is done on the server's end (and only
+ * when using protocol v2), this can return refs which don't match the provided
+ * ref_prefixes.
+ */
+const struct ref *transport_get_remote_refs(struct transport *transport,
+					    const struct argv_array *ref_prefixes);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
2.16.2.804.g6dcf76e118-goog

