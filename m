Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E15F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeGPBx3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59012 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbeGPBx2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 271376077F;
        Mon, 16 Jul 2018 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704510;
        bh=5GKqYD+Qjg6NCuj33n6oL/9O+atTLH+x2Qzp4236Xhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=h/aDfswFhgm2F1ajvYSxAaTtNN+ZGbZTZ5Y7qanCOzJGWBVLyEMRSQu2I6XRhUrDc
         iipwld/Z+9x9z+sEBoD9PdyWqv433MhZL+rrWpj3UdQRtHQge8OMoTlXQJYgw7m6r8
         RmvHjyf5rWAiGBBY22J8Z3fFGNy4/FzfrRfUz3lzzN29zJdJJbToxIWet2qbyT7c5O
         EFC9GJyaHsK3R+1+LdSpsyWa0HSr725KJYgy81l6vW9F5rolume7rOQOuOLrOSn597
         lS3dCpoMIt2uzGgCWf5tYEuAeNIaIb36TTmqyi222vQ8gULf76kXSVc2bPr8+2TMBh
         XUzJ0kQvmw1kSrKrFbCaHL6Xq0enK5Qd3gc2iiO9gQtjBTMa+KmQocx2mO64VnXBfC
         kVdN6TgQiUT0sMUZNNFhPpMu4akczj9TQIfcVktHnqTtQdgWFpNa+Ex8zGrdymYMqM
         Ay7xkUKw+nvbyMp1j7UNYO/Y8x3ihqUz3T/abrrdX9W18NyZGAy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 11/16] builtin/merge: switch to use the_hash_algo
Date:   Mon, 16 Jul 2018 01:28:03 +0000
Message-Id: <20180716012808.961328-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch uses of GIT_SHA1_HEXSZ to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4a4c09496c..916c9f0569 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1034,6 +1034,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 	const char *filename;
 	int fd, pos, npos;
 	struct strbuf fetch_head_file = STRBUF_INIT;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (!merge_names)
 		merge_names = &fetch_head_file;
@@ -1059,16 +1060,16 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 		else
 			npos = merge_names->len;
 
-		if (npos - pos < GIT_SHA1_HEXSZ + 2 ||
+		if (npos - pos < hexsz + 2 ||
 		    get_oid_hex(merge_names->buf + pos, &oid))
 			commit = NULL; /* bad */
-		else if (memcmp(merge_names->buf + pos + GIT_SHA1_HEXSZ, "\t\t", 2))
+		else if (memcmp(merge_names->buf + pos + hexsz, "\t\t", 2))
 			continue; /* not-for-merge */
 		else {
-			char saved = merge_names->buf[pos + GIT_SHA1_HEXSZ];
-			merge_names->buf[pos + GIT_SHA1_HEXSZ] = '\0';
+			char saved = merge_names->buf[pos + hexsz];
+			merge_names->buf[pos + hexsz] = '\0';
 			commit = get_merge_parent(merge_names->buf + pos);
-			merge_names->buf[pos + GIT_SHA1_HEXSZ] = saved;
+			merge_names->buf[pos + hexsz] = saved;
 		}
 		if (!commit) {
 			if (ptr)
