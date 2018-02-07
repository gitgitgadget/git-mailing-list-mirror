Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AF91F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeBGBOE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:04 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:34700 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932226AbeBGBNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:53 -0500
Received: by mail-qk0-f201.google.com with SMTP id l193so3160892qke.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iGYSa+Us8LmLwPYBHW5z4jBOfVZTlLOQ7ckZ2uFlBWA=;
        b=go2dXRXZlNmaTcCDYyZ7SCw8NDv6RgjU0k+ki1PfitBT6mw91xWuHzjPjMqdbitmZN
         VtiWndXkY+ZNRC9tGeUFjv5CYuxRVWCQB28CYHZeKAHwSz44W9LnOkig/f5ZB0LbMdpw
         iaXvyUyCtVQbIM1eLp5iPTGdMRUJpGsp5yKIckTCUTkahJOkuOrz2qosSR6wUZEOeWCP
         xOYhpSCIT+2Q3eE69q9VpRLK5cqYBKnsowERc5umyGJRI4EsfV+6TvlyxjEJItuOF06B
         6GeJuH9xY9Z+4mrgH7EUcq9fdZuLC8G2FKP+XMvE6l/cvJ16ess1mnO2grmzLWQ8oNti
         5/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iGYSa+Us8LmLwPYBHW5z4jBOfVZTlLOQ7ckZ2uFlBWA=;
        b=RQ9kkdHhl/2V31vzAdP7wK2TTC0oLvxiQLSsvkdV6SqgE+PUqx/wenTDTcPsQEwFf1
         +fC18Vnu68Y5aopRr886c/TN7xMrJJwVa4oEzc4hT5kqmmLe0Pj0sIvlBqjpBQKs0EWL
         OX+aEfJjHhMPVThf/TpC3P89NggGNcHw++hIYuNpWJb+jYteGWLd+F94/+V7YRtQeVG+
         0i3kaQp1Aw4WzAt0KbJ8phJlno8oaqBSBiL4nTjfitpPeT13LN7VOHxxy3gLBpu+Pe3J
         Y7u2FPP0xhurP3a7G/YMWgn/1umNdd4d84qWS3d0oSZlCB0BZXU8c4f+NTb2wkQvOmRg
         OReQ==
X-Gm-Message-State: APf1xPC1SSrkeLXdaRGhRQqRt/5gK+CzStaIXUmZEGvkSkXxcwgQH6yf
        qSybco3p8pC8uO9fSOJ+izpD7ZdxKnhfz5Ulitmh30LxnGs19MbxKK5iADVNHSXFVeVGvP42bON
        BgV8OMcvUx7qu+FmiUtYZCBHg/zmZPpzzauWl8BtnCHKZjoorjEeZyYFtTw==
X-Google-Smtp-Source: AH8x226ayPpDZfSALpnObuujgF2+IkQkNUiQ5z9AmYuSokeYETh5Bh2O4WtwqPN1QkiVrAn+QsisPotNnVg=
MIME-Version: 1.0
X-Received: by 10.200.10.206 with SMTP id g14mr3202694qti.6.1517966032764;
 Tue, 06 Feb 2018 17:13:52 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:53 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-17-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 16/35] transport: convert transport_get_remote_refs to take
 a list of ref patterns
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

