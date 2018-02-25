Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1571F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeBYVOF (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:14:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33888 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751878AbeBYVMe (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:34 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E51B60E52;
        Sun, 25 Feb 2018 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593153;
        bh=8HMeKP+PdqJ8mV1xGu02+V73pQQwc/nyFMlxpI9nP4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=T/NyFJmMCoSY7mqYg5d9xHqlTEe0zl+0talDGYHkoTc9/B1260LtSXgPCoshNRGDa
         HLWLWZURzf8IhCN62cKBdQS+uD4jHMZipt1zntIUozLACAh6ayK6JbhdDcnNTGBfHn
         TbTla+GPbIzH30JIguSopL0Eah6O4C3PHHWiCxnSMwEkAeGgC4PIspfvpX+D+hCOzb
         qm5/62AKIxl6rC/pBnb/LIhpRStaDfQDa8oamMJep/MbQWyS7j6kHC/3T6HhCqKLUh
         IwLrx5lEBVBJSx5XfENbBHEH6G8rGSYZsTgQGJZuW+24YF18MTHL/bNS+vMvC3WIYH
         SoA+xtJcO0kVmAZIyDp/swxKrXl44y2IOz9rBi51wv7V51kAeACYMwGqurt+uvj7IW
         oQmOduNmmoJAN3faPOjHByE6SNZCwVlM19sWwldP7k/ZFB4hWrne6tf/38Q9y5qqVI
         /iZtCODJhqs2YEmXiBZY70sYbsFKth8uWbk/+21EHGTCdPYwinR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/36] wt-status: convert struct wt_status_state to object_id
Date:   Sun, 25 Feb 2018 21:11:45 +0000
Message-Id: <20180225211212.477570-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
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
index 98e558a70b..698fa1d42a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1349,7 +1349,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(state->cherry_pick_head_sha1, DEFAULT_ABBREV));
+			find_unique_abbrev(state->cherry_pick_head_oid.hash, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1368,7 +1368,7 @@ static void show_revert_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
-			 find_unique_abbrev(state->revert_head_sha1, DEFAULT_ABBREV));
+			 find_unique_abbrev(state->revert_head_oid.hash, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1489,9 +1489,9 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
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
@@ -1550,13 +1550,13 @@ void wt_status_get_state(struct wt_status_state *state,
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
index 3f84d5c29f..c7ef173284 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -116,9 +116,9 @@ struct wt_status_state {
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
