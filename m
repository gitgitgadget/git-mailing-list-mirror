Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539EB20960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbdDJUq2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:46:28 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34050 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdDJUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:46:26 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so111515775pgg.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PmfrtEjFul6GqqVaBK/lHWATtSwVUKlJc2LKlTdDQWk=;
        b=UMfYF4gqylSL4AM0oa11YydkGK4Xv422Rdai0VxZ9VU5/oBmqwtFi5iUgWOBVqQoT+
         qEQCYsnb+8OIfE8dURvPDtzOE0qiGJDrP/K2eJzGMCiWyF25LjiQAwLo2hGbJVAH+hjR
         0P03Plt0M51e+9vbkSPuWHEgMf4zXWHEBNvLtWKNYDfVCi/JpOUoxZsQG1SUL/0Mu9ZY
         DgYBIuwueWFT7wSyD97UGxK3TATbiYo2bn5Fw0/NwHFK4svqEqQhKcQgCZyER0HxETTy
         EsRiNFqsoKPk0zvFRUl8lgIkkVKtDm8I8Dvv7Fjrk71RvVWetsQY5ygxLfTL18QxoBl6
         zcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PmfrtEjFul6GqqVaBK/lHWATtSwVUKlJc2LKlTdDQWk=;
        b=arLN/8dFubwbtcN1pH01bzDVk3suTKa/529iEMh8Xq7wnIACFiH/oSoK+4HTL1bpFM
         +1ci9kYuldWZIjm81dNiCkLu9q+fcJOibQ/n+3GSDkqO9grCn8RL1JySykJ5NDm+R/r0
         ZxyAFKMv9j07C7g8IPiZw9X5bMkeermmnNFj/cif/6Q7OmqYCHG5qrtkAgsmd3TNYu+1
         Ri+f28Z0MvK8z4w0bpiYi/5hw6kFGXXwLOvn35Pi8U/hp0HCcg1UL/YhqXKt2J1+Ci92
         Fcnx289BsYfLfXwycdVvhuZqDEMIkTQxChyw3sssl6NFJagUnoalCEN3nJddKQA8i7JX
         3ttw==
X-Gm-Message-State: AFeK/H1A/z43RN314ZRSELNJtYX98STrebBapcoRpFbFrzxNvbXYoCUyoBvnZJY9frpH2gqm
X-Received: by 10.99.9.66 with SMTP id 63mr58838468pgj.22.1491857185239;
        Mon, 10 Apr 2017 13:46:25 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id r90sm6709414pfl.120.2017.04.10.13.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 13:46:23 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 2/4] fetch-pack: refactor "want" pkt-line generation
Date:   Mon, 10 Apr 2017 13:46:08 -0700
Message-Id: <dca51f5f394df376162a4cd716688ad14802e3fe.1491851452.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fetch-pack, refactor the generation of the initial request
(containing the "want" lines) into its own function. This cleans up the
code slightly in that the scopes of certain variables are reduced, but
this commit mainly is in preparation for a subsequent one.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 58 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce3..74771a283 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -314,29 +314,14 @@ static int next_flush(struct fetch_pack_args *args, int count)
 	return count;
 }
 
-static int find_common(struct fetch_pack_args *args,
-		       int fd[2], unsigned char *result_sha1,
-		       struct ref *refs)
+/*
+ * Generate the "want" lines to be sent. If there are no "want" lines to be
+ * sent, return NULL.
+ */
+static char *get_wants(const struct fetch_pack_args *args, struct ref *refs)
 {
-	int fetching;
-	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
-	const unsigned char *sha1;
-	unsigned in_vain = 0;
-	int got_continue = 0;
-	int got_ready = 0;
 	struct strbuf req_buf = STRBUF_INIT;
-	size_t state_len = 0;
 
-	if (args->stateless_rpc && multi_ack == 1)
-		die(_("--stateless-rpc requires multi_ack_detailed"));
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
-
-	for_each_ref(rev_list_insert_ref_oid, NULL);
-	for_each_cached_alternate(insert_one_alternate_object);
-
-	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_oid.hash;
 		const char *remote_hex;
@@ -358,7 +343,7 @@ static int find_common(struct fetch_pack_args *args,
 		}
 
 		remote_hex = sha1_to_hex(remote);
-		if (!fetching) {
+		if (!req_buf.len) {
 			struct strbuf c = STRBUF_INIT;
 			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
 			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
@@ -378,14 +363,37 @@ static int find_common(struct fetch_pack_args *args,
 			strbuf_release(&c);
 		} else
 			packet_buf_write(&req_buf, "want %s\n", remote_hex);
-		fetching++;
 	}
 
-	if (!fetching) {
-		strbuf_release(&req_buf);
+	return req_buf.len ? strbuf_detach(&req_buf, NULL) : NULL;
+}
+
+static int find_common(struct fetch_pack_args *args,
+		       int fd[2], unsigned char *result_sha1,
+		       char *wants)
+{
+	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
+	const unsigned char *sha1;
+	unsigned in_vain = 0;
+	int got_continue = 0;
+	int got_ready = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+	size_t state_len = 0;
+
+	if (args->stateless_rpc && multi_ack == 1)
+		die(_("--stateless-rpc requires multi_ack_detailed"));
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
+
+	for_each_ref(rev_list_insert_ref_oid, NULL);
+	for_each_cached_alternate(insert_one_alternate_object);
+
+	if (!wants) {
 		packet_flush(fd[1]);
 		return 1;
 	}
+	strbuf_attach(&req_buf, wants, strlen(wants), strlen(wants));
 
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1, NULL);
@@ -943,7 +951,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(args, fd, sha1, ref) < 0)
+	if (find_common(args, fd, sha1, get_wants(args, ref)) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
-- 
2.12.2.715.g7642488e1d-goog

