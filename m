Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC044200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755659AbcLZKXJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:09 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36060 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755665AbcLZKW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:56 -0500
Received: by mail-wj0-f194.google.com with SMTP id j10so48078175wjb.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MhzXpNV+NrsNbHBRET2t+xBouC/NN29Vj5x/NOAtepA=;
        b=ixrPBbWmizTIVHPmsRMTQr0n58x6kalgIVDcO7niY/snw8TfJRT4vvmXbD2kPZMzxi
         AJhXeXkejH2kP7lejc6UU3r1ES7EbZjSYOi1sNq/DHQh9AuZJYJpo5hT7RGFCxlVEt0s
         Wu1dhfv6dEV5GRvZBt6OK+QXNzNXO+i4J6oiBybXk/L7WTzcqfB7gUuNgRUh09UdFXs8
         JC49bAWQzxGbkXs7FnHYChuPA/nfvv8D7fwRI9aq4uhc9MQaPdA9J/VLKEVlOAgSqjRT
         chyTIGH1MNSGznVFuXjWNfrqsmaSSeZGx+K3aMU7RHEWA3K8xTu34nZFoxVSDu2Yks/N
         hAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MhzXpNV+NrsNbHBRET2t+xBouC/NN29Vj5x/NOAtepA=;
        b=SHtamdLW878q+VzqlG341Bo3sYn0d70vpmFZAaiLIIgqHB7gjKPF8HRtkdO20AvmUA
         dioECtKGAzdp/ab0mziYzC/B4kSyjNAJOfy0EhqqPBQzmtGGnCXwsAA/Idwl2tr/KEXu
         +YIojWpvNZkGVPtwaDoEe2/8xPzYhCQJ41PjXzP8TfcE+T9Q7liS3WiqppZeNl4QM75q
         jdMb0/BsURJdCHjVZKwo7XleoND+0m+iPAqYXQv2SR7T325ZhO0AZrRBRXAutJMGIy0t
         eGJkzmsCvYBDRTlQUnyCL3PsWJi5pCr4S2z/tfwzSC55pi8pFUNjeQRdjc0IH50UnZv6
         Q4uA==
X-Gm-Message-State: AIkVDXKKZrV8hor81z89gOJcqZaBFry27YcO/sSYKufeye/aNx73lnJGf5hRIjfDv5SDpQ==
X-Received: by 10.194.222.169 with SMTP id qn9mr22653170wjc.62.1482747774425;
        Mon, 26 Dec 2016 02:22:54 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:53 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 18/21] read-cache: refactor read_index_from()
Date:   Mon, 26 Dec 2016 11:22:19 +0100
Message-Id: <20161226102222.17150-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
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
index e62a6c742d..98ef1323d6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1699,6 +1699,8 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	char *base_sha1_hex;
+	const char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
@@ -1716,15 +1718,15 @@ int read_index_from(struct index_state *istate, const char *path)
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
2.11.0.209.gda91e66374.dirty

