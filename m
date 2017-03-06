Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B471FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbdCFJve (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33568 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbdCFJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:14 -0500
Received: by mail-wr0-f194.google.com with SMTP id g10so20964738wrg.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4agz2l3YgzL4htslETVtzarjBp3aavEakN88tJF5jpY=;
        b=OWR7rfcZ2CW3Gf72a6ZuJX80NJfyYOzQSrEot6ILg4bzPCfiT6S7Qcfgip6lgnlnOp
         r7+VHBdrmJQg7ciN+xQ7EmBbK4VJtJ3Q3W+nqyTxYznj9qk89rUIZ9DSIijdRY1eEkbm
         VUHYrXgcbHYqUSLzD1Mjq2PKVQ7XQZ/8NpiwegIpCsQ2EWxaLC58RH3TJulQ8dT4hi2V
         dltQH2v0Vi5c4M4hkARdLN1ItpQTpvxsF0v6PAXD75HiuUNmbdnvD4Dsbcay2ZLq/IhK
         7knT5C1sVqz4Vmoxn6YiETqZ+mjGn8uOAVQnF90M30E/PF/Iex3ejJdX55sForP2bLY+
         Cy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4agz2l3YgzL4htslETVtzarjBp3aavEakN88tJF5jpY=;
        b=SpDvF+KwT29fLtVSgeOjLFTcmpGZIH9eSa+UlzUtVhxrrRoG6SYHB4kTtBLur4BIaA
         bdj0dySyhwGPxnJ4vVSTAP0suqnHC0oJm8CdWsoHE3oov6qlyJhuh4NkpctTGS0jnk9h
         s3vZIyWsdM0loGiEzMQlzolzO4qC77XSo14gzO6mf2FB4LosIAF7KpTqTcUos+BTTSjS
         H5tvamQnetGamVZh3LqF1AGrG2wugrPh0SCM2GY16Mv6GSu+bpxbZyiUmgAw7bcP5IcU
         a/3y9ItcT9v1/7ixVPUt+lKmsWeE3tEAe5su+0lIIFJbA48UB44qy22FNJ+2kXM1yn/r
         lMsA==
X-Gm-Message-State: AMke39mqSjEUouZ/pB46ICJ7imCzJ4PdatdJwbcWRVY8TySj+jHLjH57yM7kLxTtpX4Mcw==
X-Received: by 10.223.155.135 with SMTP id d7mr12336811wrc.99.1488793363686;
        Mon, 06 Mar 2017 01:42:43 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:42 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 19/22] read-cache: refactor read_index_from()
Date:   Mon,  6 Mar 2017 10:42:00 +0100
Message-Id: <20170306094203.28250-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks better and is simpler to review when we don't compute
the same things many times in the function.

It will also help make the following commit simpler.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 16c05f359b..89c95d59b3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1691,6 +1691,8 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	char *base_sha1_hex;
+	const char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
@@ -1708,15 +1710,15 @@ int read_index_from(struct index_state *istate, const char *path)
 		discard_index(split_index->base);
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
-	ret = do_read_index(split_index->base,
-			    git_path("sharedindex.%s",
-				     sha1_to_hex(split_index->base_sha1)), 1);
+
+	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
+	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
-		    sha1_to_hex(split_index->base_sha1),
-		    git_path("sharedindex.%s",
-			     sha1_to_hex(split_index->base_sha1)),
+		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
+
 	merge_base_index(istate);
 	post_read_index_from(istate);
 	return ret;
-- 
2.12.0.206.g74921e51d6.dirty

