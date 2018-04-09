Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1271F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeDIIc2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:43267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbeDIIcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:25 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjqLx-1eTvY12Bh3-00bt5Z; Mon, 09
 Apr 2018 10:32:16 +0200
Date:   Mon, 9 Apr 2018 10:32:17 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 12/15] git_config_set: do not use a state machine
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <3e792cdb73935da823175ce745715fa77c376402.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FAZN+yE7x7WJ7ubQIwAH+AtH8HJeY8fbu7j+YcNVjTYLVxXSjUB
 tHz2U5MpuJ4U97k5AomdzMWcVCU/bkwh87sM5fQEK3CsHZ+II4c0iebqtygQp6OaNwyKfyy
 bNh/Rx2+7GZ4i4l//foE2ZELt/0CWDQDRYU8xSItgtLxRs0MZhI22x5d2Ib+LjD7eGRCx2L
 1MtwcR665SO3W7zjmRSIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JFnkpsHShZ8=:RG75Am5fjZloYdCKPDvZi4
 OjXuPrj17GA3kEo87hz/lrd8V8vaCmVZPCI6wO3GrUc9U1XY83FsVEMKat+1jj6JxVP5WnlPQ
 uBulgByBg0Fyl2+ObejyqfHDewuN0waTymc73frPAPqOjJJ0h97Oi7wDprQpV3EEoPskWVVtN
 ecNOmj4ZHBo3NoVYbzi7p82KQTXbxoIvRdsf9GhMmyNh/reQS7eajsWMP83Tize+emfqDvs1b
 iG/PYn3haRpo5zPCNjsfIFnzAfj326/0UEJHd7BccUVbIM2Ej5UQaDydcLO7Rp4Wsp6TR/iQ4
 IJqgPiiuWhZs9Yzbm/vSP8Q+mDV3JfqnzbH+mXBysgirlDVNg84Z7VQuaRivw/MWxOut0tmaO
 tpsaTRChDcTFV9uUWwc3tftqJzAFOOHmGLihAH7mx8u+GTNwzsBSZIRWOA7f/+sKV/j2ceWAe
 qtfNqe7LzTe9YzXg8WmJV10XH1ICT1IYjaoGXM2tMpsbrsCPVo2Jt+i2vYvA/tP3EAqXyafbw
 fQzDJ/lKB50vDuFmf1ecdfo5vPg2jst0LFzP3kQNO6FM4Ckd933SoYkY+Z+w4uTM2KxQq22cs
 mnCWOvvEXL/3qtEa0yv0U/bSQhEcn/gMzohbgaiD8LvJZL+sWq+CoClD/WcvcSXwJAx4Oy/qT
 XmDac61NXR6Pq+j9FbbW+FErnvajYsHo143m0jTv45fjeRBMu9J420OMpLOQ8iDjG9oZDkL7l
 AWQzzCQAc7eh36S+Bn/5u9uJhwdwq0f1eTrgA9aW9d0VTGX6UC96LpxDvM7q86vQRxUIXWQRB
 N7iAEGqKMqPaBmQiWrznV/0qNQeLvTQqCtABMCukWsZFin+C4k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While a neat theoretical construct, state machines are hard to read. In
this instance, it does not even make a whole lot of sense because we are
more interested in flags, anyway: has the section been seen? Has the key
been seen? Does the current section match the key we are looking for?

Besides, the state `SECTION_SEEN` was named in a misleading way: it did
not indicate that we saw the section matching the key we are looking
for, but it instead indicated that we are *currently* in that section.

Let's just replace the state machine logic by clear and obvious flags.

This will also make it easier to review the upcoming patches to use the
newly-introduced `event_fn` callback of the config parser.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 59 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/config.c b/config.c
index 2341620c11a..3f1cbfa181e 100644
--- a/config.c
+++ b/config.c
@@ -2304,7 +2304,7 @@ struct config_store_data {
 	int multi_replace;
 	size_t *seen;
 	unsigned int seen_nr, seen_alloc;
-	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
+	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
 
 static int matches(const char *key, const char *value,
@@ -2327,8 +2327,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 	size_t section_len;
 	struct config_store_data *store = cb;
 
-	switch (store->state) {
-	case KEY_SEEN:
+	if (store->key_seen) {
 		if (matches(key, value, store)) {
 			if (store->seen_nr == 1 && store->multi_replace == 0) {
 				warning(_("%s has multiple values"), key);
@@ -2340,8 +2339,8 @@ static int store_aux(const char *key, const char *value, void *cb)
 			store->seen[store->seen_nr] = cf->do_ftell(cf);
 			store->seen_nr++;
 		}
-		break;
-	case SECTION_SEEN:
+		return 0;
+	} else if (store->is_keys_section) {
 		/*
 		 * What we are looking for is in store->key (both
 		 * section and var), and its section part is baselen
@@ -2356,10 +2355,9 @@ static int store_aux(const char *key, const char *value, void *cb)
 
 		if ((section_len != store->baselen) ||
 		    memcmp(key, store->key, section_len+1)) {
-			store->state = SECTION_END_SEEN;
-			break;
+			store->is_keys_section = 0;
+			return 0;
 		}
-
 		/*
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
@@ -2367,27 +2365,29 @@ static int store_aux(const char *key, const char *value, void *cb)
 		ALLOC_GROW(store->seen, store->seen_nr + 1,
 			   store->seen_alloc);
 		store->seen[store->seen_nr] = cf->do_ftell(cf);
-		/* fallthru */
-	case SECTION_END_SEEN:
-	case START:
-		if (matches(key, value, store)) {
-			ALLOC_GROW(store->seen, store->seen_nr + 1,
-				   store->seen_alloc);
-			store->seen[store->seen_nr] = cf->do_ftell(cf);
-			store->state = KEY_SEEN;
-			store->seen_nr++;
-		} else {
-			if (strrchr(key, '.') - key == store->baselen &&
-			      !strncmp(key, store->key, store->baselen)) {
-					store->state = SECTION_SEEN;
-					ALLOC_GROW(store->seen,
-						   store->seen_nr + 1,
-						   store->seen_alloc);
-					store->seen[store->seen_nr] =
-						cf->do_ftell(cf);
-			}
+	}
+
+	if (matches(key, value, store)) {
+		ALLOC_GROW(store->seen, store->seen_nr + 1,
+			   store->seen_alloc);
+		store->seen[store->seen_nr] = cf->do_ftell(cf);
+		store->seen_nr++;
+		store->key_seen = 1;
+		store->section_seen = 1;
+		store->is_keys_section = 1;
+	} else {
+		if (strrchr(key, '.') - key == store->baselen &&
+		      !strncmp(key, store->key, store->baselen)) {
+				store->section_seen = 1;
+				store->is_keys_section = 1;
+				ALLOC_GROW(store->seen,
+					   store->seen_nr + 1,
+					   store->seen_alloc);
+				store->seen[store->seen_nr] =
+					cf->do_ftell(cf);
 		}
 	}
+
 	return 0;
 }
 
@@ -2645,7 +2645,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		ALLOC_GROW(store.seen, 1, store.seen_alloc);
 		store.seen[0] = 0;
-		store.state = START;
 		store.seen_nr = 0;
 
 		/*
@@ -2713,7 +2712,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			new_line = 0;
 			if (store.seen[i] == 0) {
 				store.seen[i] = copy_end = contents_sz;
-			} else if (store.state != KEY_SEEN) {
+			} else if (!store.key_seen) {
 				copy_end = store.seen[i];
 			} else
 				copy_end = find_beginning_of_line(
@@ -2737,7 +2736,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
-			if (store.state == START) {
+			if (!store.section_seen) {
 				if (write_section(fd, key, &store) < 0)
 					goto write_err_out;
 			}
-- 
2.17.0.windows.1.4.g7e4058d72e3


