Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831D71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965005AbeB1XYH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:07 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:57089 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964927AbeB1XYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:00 -0500
Received: by mail-yb0-f201.google.com with SMTP id p198-v6so2352217ybc.23
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UUebQ1jAxbYTYLWWFfJ0OVhqolB7UpU+QPDywg5pdx8=;
        b=u5QxLo73d6Y/JaSO3MPSbpk3gppWW1e14mN2q7Sy17B7trj+sMwLhBRlZD5Cj4CZwL
         3nln2qLUGAVPb/bxA3x3KZUAAZ/umVAirpWtUYI/cy/6T8aw0juHk1nsfq2ZNrp0B+RI
         i9PWXEBx6Pi3h4zd9RAt8SWEymwKTO8AMmHPKeDFuC4XQDlWfL5zzm8YthllKRe+mBQ4
         cyD4AQ+jsKncguj4vdsOy42AM+LA1alw4dAkqlhsDXURpLBDvog603hurLU5JAf6v9I3
         KjHlNEkqd628oYV8fduKWKis7HQWb/3kXmQbmFAOK+FJymZQdGl6hAueB1l2UlqTRJqa
         V+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UUebQ1jAxbYTYLWWFfJ0OVhqolB7UpU+QPDywg5pdx8=;
        b=Zp44jTvTpl3nK5lNJb3UUwC3FHiQQWMcAfCqS4u3i6NHMF5/Csfx2yDOmYMYybLFbR
         mQwCBtUhYbPxFVXa0BAy2KT1OeXy9cCclOcIkmYUPduhq66v0NtQpmWytd5ZF3K4PXEr
         11H650dYQ9ErSR+FrYNNMF5E4GRirZNz7t6G/TM28g0lUwk7T7PmaBnWP0NQQgc8poht
         6zS0J9/IDKdT8JUg/VcRSnoPUFK6neWPetczHdT1tqDkmpKb/aWHC+5F6Syfyq+6PBGL
         KzVFcJxCF9SjX4ZZ2RrdojJ2EDFOqsLx1eRwBnuBQFWZ66/etyAjfyAIUJKW0X7Z3ygJ
         GbtQ==
X-Gm-Message-State: APf1xPCgmyAYV1Pd+PIShinSxcqNEHgmkF3zzfZH5VNESkuxzQiYO4Pl
        sYGdvX5SHLwG1wwlLV1Fp7mks2StuIlXU12g945sJ+o6NGenVXIQLE7jMadHbce6z5+BYFNy5yP
        ao9QgLanYhV288O5wrVtLlEdEEwEcs5Z6n6oDTCBksu50TnwhBkoJT2zWRg==
X-Google-Smtp-Source: AH8x226WyWuKiuTMiTs8GbDU/1J1MV0CiVhbzyQooEB65ToZE6Pty/lVw7UGXGpJp4Jf7WEYIW/YF5PfJqA=
MIME-Version: 1.0
X-Received: by 10.13.237.130 with SMTP id w124mr9212658ywe.130.1519860239779;
 Wed, 28 Feb 2018 15:23:59 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:33 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-17-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 16/35] transport: convert transport_get_remote_refs to take
 a list of ref patterns
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

Convert 'transport_get_remote_refs()' to optionally take a list of ref
patterns.

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
index 731c78b67..daea4770c 100644
--- a/transport.h
+++ b/transport.h
@@ -178,7 +178,17 @@ int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   unsigned int * reject_reasons);
 
-const struct ref *transport_get_remote_refs(struct transport *transport);
+/*
+ * Retrieve refs from a remote.
+ *
+ * Optionally a list of ref patterns can be provided which can be sent to the
+ * server (when communicating using protocol v2) to enable it to limit the ref
+ * advertisement.  Since ref filtering is done on the server's end (and only
+ * when using protocol v2), this can return refs which don't match the provided
+ * ref_patterns.
+ */
+const struct ref *transport_get_remote_refs(struct transport *transport,
+					    const struct argv_array *ref_patterns);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
2.16.2.395.g2e18187dfd-goog

