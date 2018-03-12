Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304451F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCLC20 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932516AbeCLC2Y (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6166060988;
        Mon, 12 Mar 2018 02:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821702;
        bh=oLTXwBkylHzwZoZr6HFZd41uJ86CYOw9jkj6GLkr+xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AlXbCGiYRoh3MLFIhNccqmCPsrcxEPtI3Ww9zY57xqirHSxoXW94dR6YX2L9fWlZ3
         2j/u9VkFchlRjbRdxfN0Ndh9UXVaDHEtgHaWJ8jYcuTlBtyxJXC8lk0wHCt02HOIPV
         V7l65LRcEFQBpBK3dSBOfhGSKMpsjpgFFyrCx701uw/pIq3KpfatSZ/kGY9mQeZwHf
         EPGDLQgIlucQ9nq8j5c549h0fpSg1WZTyyjb56z0Y/Dz8PvprYv5HL0abytQ6TYSFi
         UK9LZqIGBJgrITpQvKSUKs9kiy5SDoSHBX1oLWEWChZ8maKPRQ9CkEWxbNnwTmwhcc
         K47ljYbSAQFBU5ogKTw+VxCN4wqfbyz+ETdg39o4OJJpBKvj74hWcRtlssUQreB+Hl
         x6vjaMGuxD+v2WuMqNGZmkxaYD6YmpjS8m1EORoyk0qe8cP/v39V4NfyoV3V/lCoI7
         nvP6dfHO6F5WTPwavcK9gQ+Rn1TKIBmYscZdY9fjTptuAa1Ljt2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/36] wt-status: convert struct wt_status_state to object_id
Date:   Mon, 12 Mar 2018 02:27:29 +0000
Message-Id: <20180312022756.483934-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the various *_sha1 members to use struct object_id instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 wt-status.c | 12 ++++++------
 wt-status.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5c685b6165..78be89a422 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1350,7 +1350,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(state->cherry_pick_head_sha1, DEFAULT_ABBREV));
+			find_unique_abbrev(state->cherry_pick_head_oid.hash, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1369,7 +1369,7 @@ static void show_revert_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
-			 find_unique_abbrev(state->revert_head_sha1, DEFAULT_ABBREV));
+			 find_unique_abbrev(state->revert_head_oid.hash, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1490,9 +1490,9 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	} else
 		state->detached_from =
 			xstrdup(find_unique_abbrev(cb.noid.hash, DEFAULT_ABBREV));
-	hashcpy(state->detached_sha1, cb.noid.hash);
+	oidcpy(&state->detached_oid, &cb.noid);
 	state->detached_at = !get_oid("HEAD", &oid) &&
-			     !hashcmp(oid.hash, state->detached_sha1);
+			     !oidcmp(&oid, &state->detached_oid);
 
 	free(ref);
 	strbuf_release(&cb.buf);
@@ -1551,13 +1551,13 @@ void wt_status_get_state(struct wt_status_state *state,
 	} else if (!stat(git_path_cherry_pick_head(), &st) &&
 			!get_oid("CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
-		hashcpy(state->cherry_pick_head_sha1, oid.hash);
+		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
 	wt_status_check_bisect(NULL, state);
 	if (!stat(git_path_revert_head(), &st) &&
 	    !get_oid("REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
-		hashcpy(state->revert_head_sha1, oid.hash);
+		oidcpy(&state->revert_head_oid, &oid);
 	}
 
 	if (get_detached_from)
diff --git a/wt-status.h b/wt-status.h
index ea2456daf2..430770b854 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -118,9 +118,9 @@ struct wt_status_state {
 	char *branch;
 	char *onto;
 	char *detached_from;
-	unsigned char detached_sha1[20];
-	unsigned char revert_head_sha1[20];
-	unsigned char cherry_pick_head_sha1[20];
+	struct object_id detached_oid;
+	struct object_id revert_head_oid;
+	struct object_id cherry_pick_head_oid;
 };
 
 size_t wt_status_locate_end(const char *s, size_t len);
