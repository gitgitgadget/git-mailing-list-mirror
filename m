Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1991F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeACATI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:08 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37584 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeACATE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:04 -0500
Received: by mail-io0-f196.google.com with SMTP id n14so469286iob.4
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXPJUzHM3cBrNFY8vmL8XKJDeamixynt3+qihD/zz5k=;
        b=WUhCRdUDta8wZQKHVlkhiEj87mslvu4Os8zKkxx5T0dJYv9a4jcxQJYuBnzXsM2YFD
         +MVm6LudWPddt/u/qU1yPwkTnhUDnPCWHT+1BLS3xVgTYD4Oz/ugvR56ge7A3HACOazv
         j6PgX0aisbix4T/lZ6/zo23H3jblO1OCul0CN6c9uz1UlSYs1YNnGKbSzedrHfqzsRaX
         NXkTqKTNCSwGf1qGJ4gz5akW9ZEybGThRppv/IIqDJslDWh9Rczby8JqhsDt17yc42cR
         XWjjcGOpAFrbWksXhg3EXLg71L50VVrZXQk6IYRJ00USl2vIBr7O0r5xVrPDpAr5QrwR
         XHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXPJUzHM3cBrNFY8vmL8XKJDeamixynt3+qihD/zz5k=;
        b=JnBIjI3ApFt0NCI5STOVE2kDzQrGIql8uj1cs8AuRgxjXPRypGdDWfLV0JOgweUfvU
         oqaHVEXHfc2Vx7pFYG5H1ImvrE2OUcj3SbFADc3NfJLCPfq0r9L6mlji9K6+gAmtI718
         JYNxEa+5YzDWr0Wc7Gi4+L/L1Rwp2O2Ak9JyZLmuashQBj+Sv3USdF1Pik69/1ODwFlS
         xBGWVF+W6STrHHStpd3jGjbQjCnBcmP8pkBXsaXWPlO6t3dg9+VF44TRpxhAFcGns/ff
         RG40bU2d7GspgbcSTOI98zpDmnjp8XPN0u0vTke0TD7DQfGY8CfCuiLjScmt2XdlPzxl
         YYTw==
X-Gm-Message-State: AKGB3mJIW/R7xvTrgQJV2WpEoBjF2fuovPHYIbp79j146CN0q9XL5dbW
        Q5N1LojMvyLJGrt0dtgdNCdazvHNDzY=
X-Google-Smtp-Source: ACJfBosNIMF0M96MPSbBbfBkZrlIrcx3vTMdhgBoYtP1kF1VMbcmKcgdXoQ1nWYCJ22g/FY3/MyfOQ==
X-Received: by 10.107.36.71 with SMTP id k68mr10933165iok.9.1514938743335;
        Tue, 02 Jan 2018 16:19:03 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:02 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/26] transport: convert transport_get_remote_refs to take a list of ref patterns
Date:   Tue,  2 Jan 2018 16:18:17 -0800
Message-Id: <20180103001828.205012-16-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
index 2da71db10..4db3079ac 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1104,7 +1104,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
2.15.1.620.gb9897f4670-goog

