Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B40020445
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdJOWHz (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751607AbdJOWHy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1C2D56045F;
        Sun, 15 Oct 2017 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105273;
        bh=lslO8BpfHGm6JBWrDREBYTTlE1umyOCh6QjIs2588OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kkEgCov9gF2TifDX68g9fjGNCdqgIVNoSHG8sjMXwMuNV8jO3tXoHswj0UdCacihB
         MdH2ycfYpACfW0s3htQT7EhYhCqHPeZ3JsKIMGjSe4x5ZCDUOS21avXl3/CL2Nhse9
         LcVRCEYHNhVLRYy7j7kBWyLBVEPLWrc+0eO9+aceWCXn5zlIn+glXo9xDDaj0ptwU7
         /KUMxxFnNES/udrGrjS0E1tqqlFCbMZjY1UebVmV1gkWG2+eCMVjGfRfrRJ1aydbyq
         wpkneUAqFM4nRNBoaKO26j7L0+7sXTrwnpXVynOm/IOM3UXV2IyhCKlIydioVIlwhL
         xN02PuBnMjQCvb/OJb7wsc8B9pOBXif/V2qrw6MUplVhnGrz+CuuMbCYTKKzAJeMHD
         /6Dku7MzKxNoTnaHPhxIPqzNQeU1GTCyNs5GfQsvP52Ddz1kR68iB/SuX/w5Cd/k3+
         p8kgdLCXbWX3JsB9gsVzWi97Tla/MXn6Ly1NSGPUNinBGhcOTDy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 16/25] refs: convert read_ref_at to struct object_id
Date:   Sun, 15 Oct 2017 22:07:03 +0000
Message-Id: <20171015220712.97308-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the callers and internals, including struct read_ref_at_cb, of
read_ref_at to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c |  4 ++--
 refs.c                | 34 +++++++++++++++++-----------------
 refs.h                |  2 +-
 sha1_name.c           |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 722a7f4bec..8bf42e529d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -731,7 +731,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				timestamp_t at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
+				read_ref_at(ref, flags, at, -1, &oid, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -743,7 +743,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			timestamp_t timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
+			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
diff --git a/refs.c b/refs.c
index f8a2d98666..d19fae5077 100644
--- a/refs.c
+++ b/refs.c
@@ -738,11 +738,11 @@ struct read_ref_at_cb {
 	timestamp_t at_time;
 	int cnt;
 	int reccnt;
-	unsigned char *sha1;
+	struct object_id *oid;
 	int found_it;
 
-	unsigned char osha1[20];
-	unsigned char nsha1[20];
+	struct object_id ooid;
+	struct object_id noid;
 	int tz;
 	timestamp_t date;
 	char **msg;
@@ -774,25 +774,25 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		 * we have not yet updated cb->[n|o]sha1 so they still
 		 * hold the values for the previous record.
 		 */
-		if (!is_null_sha1(cb->osha1)) {
-			hashcpy(cb->sha1, noid->hash);
-			if (hashcmp(cb->osha1, noid->hash))
+		if (!is_null_oid(&cb->ooid)) {
+			oidcpy(cb->oid, noid);
+			if (oidcmp(&cb->ooid, noid))
 				warning("Log for ref %s has gap after %s.",
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
-			hashcpy(cb->sha1, noid->hash);
-		else if (hashcmp(noid->hash, cb->sha1))
+			oidcpy(cb->oid, noid);
+		else if (oidcmp(noid, cb->oid))
 			warning("Log for ref %s unexpectedly ended on %s.",
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
-		hashcpy(cb->osha1, ooid->hash);
-		hashcpy(cb->nsha1, noid->hash);
+		oidcpy(&cb->ooid, ooid);
+		oidcpy(&cb->noid, noid);
 		cb->found_it = 1;
 		return 1;
 	}
-	hashcpy(cb->osha1, ooid->hash);
-	hashcpy(cb->nsha1, noid->hash);
+	oidcpy(&cb->ooid, ooid);
+	oidcpy(&cb->noid, noid);
 	if (cb->cnt > 0)
 		cb->cnt--;
 	return 0;
@@ -812,15 +812,15 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 		*cb->cutoff_tz = tz;
 	if (cb->cutoff_cnt)
 		*cb->cutoff_cnt = cb->reccnt;
-	hashcpy(cb->sha1, ooid->hash);
-	if (is_null_sha1(cb->sha1))
-		hashcpy(cb->sha1, noid->hash);
+	oidcpy(cb->oid, ooid);
+	if (is_null_oid(cb->oid))
+		oidcpy(cb->oid, noid);
 	/* We just want the first entry */
 	return 1;
 }
 
 int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
-		unsigned char *sha1, char **msg,
+		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	struct read_ref_at_cb cb;
@@ -833,7 +833,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	cb.cutoff_time = cutoff_time;
 	cb.cutoff_tz = cutoff_tz;
 	cb.cutoff_cnt = cutoff_cnt;
-	cb.sha1 = sha1;
+	cb.oid = oid;
 
 	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
 
diff --git a/refs.h b/refs.h
index 89f28d482d..5f329d6618 100644
--- a/refs.h
+++ b/refs.h
@@ -363,7 +363,7 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
 /** Reads log for the value of ref during at_time. **/
 int read_ref_at(const char *refname, unsigned int flags,
 		timestamp_t at_time, int cnt,
-		unsigned char *sha1, char **msg,
+		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
diff --git a/sha1_name.c b/sha1_name.c
index 514915460f..8d903a74d4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -697,7 +697,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid->hash, NULL,
+		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
-- 
2.15.0.rc0.271.g36b669edcc

