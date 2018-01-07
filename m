Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF9F1F434
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbeAGSPe (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:34 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44203 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754465AbeAGSPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:31 -0500
Received: by mail-qt0-f193.google.com with SMTP id m59so11277291qte.11
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JsWmDYOTzWmXO6QnohGk6Utx9+PuAkCXnVOOsnQX3Xg=;
        b=lTvkjrB2btaS3cTSbYHQ3MSYVzMq/xbW3eN7OgkxjqbOO1iyXMSeXZ7iZGvywo41wy
         0WZzhhyHCRpv91RVHLtpO5KGXQS+hOxLWs8+t5rRY0XoQraZEJJ95Pqqdnb2GMs3PFIX
         0gIIRi+ULEsxO/F0TwxyfI7SKN3k9SlmnDpb4yIKdJ7NQfXd6tmuQWPbCVP7b2V+dDmR
         RRIF1q19FK4BymP2OwT+wwwJ8R6PPj2N6FU2FqVKAuyYJAOdjixW7ON0zLTrnvEFF2tX
         cRajZYRgOnpm5nbYg5pC9txk7MyWjd6D8FW2K0CfQDq0x5eY2GXnLLx+8e+LwDYupMJ+
         bmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JsWmDYOTzWmXO6QnohGk6Utx9+PuAkCXnVOOsnQX3Xg=;
        b=BujWiaEQwj4eFL2m6zgGTFjVv7oD6ZXvVtGEYpgoxFaYrmzf/wj2oXiJdtIQIaC+LB
         nwVw5nUrRyZrfAKKTCDwRZ1cuQJsSVlN1r3qrQg9WchZUToUuVIJ44rE1+T2sk2Uoc25
         DZquduAC7TjFyEGabQNZw12OFvB58mQLoqXDOuXVvUSkYFNuIn+lzTnyQHcw223soLdV
         OzRCRLQo1v05NSobTK13obHXoGdRl3Ln84LvWB7edCuODRqW+zfJRscZVPxPo/jT1Nlz
         m3asc6460Gxnn8iYpA3fZoH477IVphgWDjCFVYY3Snkeu6jsPVUdTRb8xEjCeLWjTdgQ
         Rgdw==
X-Gm-Message-State: AKwxytdQ7JI8swVI8ytTQgOaCHZSOEotuOitQLpb4t1U+6Q0ObFYYgWw
        KZCJZQOe2Wk12M1KbYzWED8J46J33S4=
X-Google-Smtp-Source: ACJfBoupOYI0ZDmJtnEWlQpYoU9atioOim9qli5Iv4mHS79nv30RRaadLtAs0xLnaif/g57uYmtDXw==
X-Received: by 10.200.36.150 with SMTP id s22mr6579170qts.0.1515348930701;
        Sun, 07 Jan 2018 10:15:30 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:30 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 17/18] sha1_name: use midx for abbreviations
Date:   Sun,  7 Jan 2018 13:14:58 -0500
Message-Id: <20180107181459.222909-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create unique_in_midx() to mimic behavior of unique_in_pack().

Create find_abbrev_len_for_midx() to mimic behavior of
find_abbrev_len_for_pack().

Consume these methods when interacting with abbreviations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..2f426e136e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "midx.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -190,11 +191,40 @@ static void unique_in_pack(struct packed_git *p,
 	}
 }
 
+static void unique_in_midx(struct midxed_git *m,
+			   struct disambiguate_state *ds)
+{
+	uint32_t num, i, first = 0;
+	const struct object_id *current = NULL;
+
+	if (!m->num_objects)
+		return;
+
+	num = m->num_objects;
+	bsearch_midx(m, ds->bin_pfx.hash, &first);
+
+	/*
+	 * At this point, "first" is the location of the lowest object
+	 * with an object name that could match "bin_pfx".  See if we have
+	 * 0, 1 or more objects that actually match(es).
+	 */
+	for (i = first; i < num && !ds->ambiguous; i++) {
+		struct object_id oid;
+		current = nth_midxed_object_oid(&oid, m, i);
+		if (!match_sha(ds->len, ds->bin_pfx.hash, current->hash))
+			break;
+		update_candidates(ds, current);
+	}
+}
+
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
+	struct midxed_git *m;
 
-	prepare_packed_git();
+	prepare_packed_git_internal(1);
+	for (m = midxed_git; m && !ds->ambiguous; m = m->next)
+		unique_in_midx(m, ds);
 	for (p = packed_git; p && !ds->ambiguous; p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -508,6 +538,39 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_midx(struct midxed_git *m,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t first = 0;
+	struct object_id oid;
+
+	if (!m->num_objects)
+		return;
+
+	match = bsearch_midx(m, mad->hash, &first);
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * mad->hash if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of three objects
+	 * nearby for the abbreviation length.
+	 */
+	mad->init_len = 0;
+	if (!match) {
+		nth_midxed_object_oid(&oid, m, first);
+		extend_abbrev_len(&oid, mad);
+	} else if (first < m->num_objects - 1) {
+		nth_midxed_object_oid(&oid, m, first + 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	if (first > 0) {
+		nth_midxed_object_oid(&oid, m, first - 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	mad->init_len = mad->cur_len;
+}
+
 static void find_abbrev_len_for_pack(struct packed_git *p,
 				     struct min_abbrev_data *mad)
 {
@@ -563,8 +626,11 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
+	struct midxed_git *m;
 
-	prepare_packed_git();
+	prepare_packed_git_internal(1);
+	for (m = midxed_git; m; m = m->next)
+		find_abbrev_len_for_midx(m, mad);
 	for (p = packed_git; p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.15.0

