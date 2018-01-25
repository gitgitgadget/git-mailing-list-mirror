Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FAA1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeAYX7W (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:22 -0500
Received: from mail-vk0-f73.google.com ([209.85.213.73]:48938 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeAYX7V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:21 -0500
Received: by mail-vk0-f73.google.com with SMTP id o64so5015938vka.15
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iGYSa+Us8LmLwPYBHW5z4jBOfVZTlLOQ7ckZ2uFlBWA=;
        b=YpHx3xKhP+6rWygyvPoUEwEO0sJCU1p8WY8xxF8TwyOTEd/j05quriqmrS/O5m+z79
         A9yxcENcw33hE6gCTOO+5bSYYjq3ICq4/G9MAP5aRJagrBsJ+LmW2J0umIb7NjNKIP5d
         Dpi5+mniYIUyiuBv2Mlh4OTTyTiavTyBSU7MI7ozqwMhqcx1XwijdN4ovFkkKUyR0RKx
         QBNvq+cx88KyH+oHnr+TlUbn/W+QaYmObj/JE7G6vFH6u1aQBZg0VXoDN6zMQZwOx1uA
         DcV9TtDPa54/1opJaEFiANu7UmhcriVwfARBSyOOx9TCzid01e/kUDdG1A9GX1UIz4Zu
         Lw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iGYSa+Us8LmLwPYBHW5z4jBOfVZTlLOQ7ckZ2uFlBWA=;
        b=g5vxCs1wVAv5Rum08UCAkAGWVJSCzALD4Wtw/lTt1kw5LUNdkWQhotzf1M94xAiNZC
         qhW0EelQ/4BZty8lJQenbjlhbtJeh3J4cDIe6YX4l5aNaMMQIfJWwidSVojhRCYPf5Ir
         SINF/mWXDW0cZkk9vbgNwps/hYiFONuh35x4VEZuS+FvUGIFp+JMelRT/8XRPaPCTQ9r
         fEnjM5VEl7G/dE5Bv1BgBOMaSch+Rh0XxgnVKfRm4SeBweuXPZOLw3UeIqLR839QhC5k
         +0ExpPW+GjIV+xu/wvE0PbgRVgGIPp/UICSraDImKQ3xvyVCxP7Mo25/bPdEhh+dPDAH
         7ZOA==
X-Gm-Message-State: AKwxytep7MHBdU1V9OMReZmYPA+f3p1DVs/CviRzLrXmtLFiuy8bQPK/
        cLbUpdCpqIUYBVfr7yk2fnhYW/vN626nYuzej22DSi+vnTIlEUdmzbngtyrpq0/H03GmUzu3XNc
        7kQu1Sm7pgzmWiWmBIvHIY4/BSDdZv7alprDCOKoHiGtnENuB2RtM231fAw==
X-Google-Smtp-Source: AH8x22565DURAh2gTONI7adg7vQOdcn53LvZ4mRjsJdd0hLDdyQu+5dpzjUIF+DtCw5eXjpq1AeAKuQY37Q=
MIME-Version: 1.0
X-Received: by 10.176.10.9 with SMTP id q9mr5999815uah.103.1516924760317; Thu,
 25 Jan 2018 15:59:20 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:27 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-17-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 16/27] transport: convert transport_get_remote_refs to take
 a list of ref patterns
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

Convert 'transport_get_remote_refs()' to optionally take a list of ref
patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c     | 2 +-
 builtin/fetch.c     | 4 ++--
 builtin/ls-remote.c | 2 +-
 builtin/remote.c    | 2 +-
 transport.c         | 7 +++++--
 transport.h         | 3 ++-
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 284651797..6e77d993f 100644
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
index 7bbcd26fa..850382f55 100644
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
index c4be98ab9..c6e9847c5 100644
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
index d95bf904c..d0b6ff6e2 100644
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
index c54a44630..dfc603b36 100644
--- a/transport.c
+++ b/transport.c
@@ -1136,10 +1136,13 @@ int transport_push(struct transport *transport,
 	return 1;
 }
 
-const struct ref *transport_get_remote_refs(struct transport *transport)
+const struct ref *transport_get_remote_refs(struct transport *transport,
+					    const struct argv_array *ref_patterns)
 {
 	if (!transport->got_remote_refs) {
-		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
+		transport->remote_refs =
+			transport->vtable->get_refs_list(transport, 0,
+							 ref_patterns);
 		transport->got_remote_refs = 1;
 	}
 
diff --git a/transport.h b/transport.h
index 731c78b67..4b656f315 100644
--- a/transport.h
+++ b/transport.h
@@ -178,7 +178,8 @@ int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   unsigned int * reject_reasons);
 
-const struct ref *transport_get_remote_refs(struct transport *transport);
+const struct ref *transport_get_remote_refs(struct transport *transport,
+					    const struct argv_array *ref_patterns);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
2.16.0.rc1.238.g530d649a79-goog

