Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619C71F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeCNSeR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:34:17 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:48450 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCNScz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:55 -0400
Received: by mail-vk0-f73.google.com with SMTP id z186so2670769vkd.15
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=1W4xBbqM1o45C/4bjSTbGa8R5NeK9wGH3y2+D6QFJ88=;
        b=lMFssBYNJrH90NKxbCzg9STw8iUTyjxET5pDgn8shOCOdKMlTwjn7Lg6YUj6ntLQjD
         IKhFVOZDAMfJLIKnAzCMBiEtAbjWPJi7qf+gb+RBZeLUL/2Ttt/IhmUFCjpg+m06VAjL
         RYr1DzeNh0G4VvY4wZbWkidvonDtR+20xglmsdVzGzP9M1nOfbWmnNwTbVP9q1bjhBq+
         iLtGLK7rqMYVpdWF5e9AX2TBs8zxxtWtXnr4J+Y5zwu2IebJO/AcSPmpU3se8Zh2chDC
         IAv+5Fnw487+4A9qZzKmfOEgmXIwIYPyDoP57nqT7O3RxL4KB5YATkCNtKZRW2r8q0PK
         a3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=1W4xBbqM1o45C/4bjSTbGa8R5NeK9wGH3y2+D6QFJ88=;
        b=DzfZEept4RcqaiSCxob6DKcXyVTwAHMlQ9zH+2jdbXWQKT0+Z/96nQbely+HamiqAk
         fSgrCE8avX16+DUj1zOmADSX5kZ00StadiH/JPWBRHPILcyJbGLiKl4Juytg2hfW9akR
         /ynCg1DRKuIU/AhCJ5c1XwxWnBiFjuu/xOE7G4YBdhQO8zV/GH94PDes/kyv1GMvL4HD
         EERYFOljJFtVRc5aKn4XDovKU3t3NyFZifzitlbMmneS4bBFm8/VXioaXNKHR001TvUH
         UAXY7IH0+hajxSNHaOxVAhKNmfigdqbm/jJirpRv0eH8lOhlFx0d2pE3e2nXv0ZLR89o
         puRg==
X-Gm-Message-State: AElRT7HiqAPTjCTPtuK9L2kuy+ntslMj9i+4J9niInS0JPOQzvc4sIpr
        DVuj4EK6yV5+eJNnikCHxua8Gno3HTez5tJI5c4fnOpMGUTJucyqlUn+IoaUswY6YVdCaF/d+94
        lSfhuNdCm90GQrCcUEzr/qas4PlLequKTi3qHigeEmNiHgXafiEE6YKXgPQ==
X-Google-Smtp-Source: AG47ELsXGyYDlkw0bRomyRGRLrEOSl2nHCabsm3HoaXB7Crm+f+YIQkBIp0uA5yg2vo0UDijtSvxS10Dt2U=
MIME-Version: 1.0
X-Received: by 10.31.226.132 with SMTP id z126mr2568711vkg.26.1521052374221;
 Wed, 14 Mar 2018 11:32:54 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:53 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-17-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 16/35] transport: convert transport_get_remote_refs to take
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

