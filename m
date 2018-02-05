Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13D11F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeBEX7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:59:04 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36523 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeBEX6l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:58:41 -0500
Received: by mail-pl0-f68.google.com with SMTP id v3so94453plg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YxSJCF7Vm/Q56SREI5HfGVh3pMnkVsJJYVDNPMOih88=;
        b=m4H7farVEK4StlkAhe/InY0aUK5MuIs6FOahvHgl5mzwd8SorYgwCcFtNU3yXhquV6
         X+AtbZ6BLBEU1e615xgAWVEOiDAx4ESgA1zvYfBxnVTXhig2yXVLK7TiGjJHMxkkKnxe
         jT/hj/HBHOe/CX9SFlsV3LnOnz76Jwj3+NXEwrRxp49YhMT7GSMYmhWrfnbz0QjzN7aD
         1vyLHy2No560PXbz4BnZjA2xDRa/dj1czdxfNijhD/k0CqicGA+xCCxq9EZJJ6+z7gYq
         RfR7Xeqkiyiu/SE53nQNBFo89nO3V5HjyS5WZg+A9Ek2CaMv9a11j7B9FYtlc9YVMOlu
         Fn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YxSJCF7Vm/Q56SREI5HfGVh3pMnkVsJJYVDNPMOih88=;
        b=onbnDaqnfI/jr2Ija1nRORjjnARjJPOZWbN6D6xE/6+LRVzJFniwt7JyE9YhigzjP9
         TRusP8oO2IzJegyw0e11xww/VxbfFtKiX0iPh70gQCzwmsFYV7QlcQHXkTb4cv7s+TpI
         IfWGgGB5Tfd3f5pfPeKIJWGPrSkoH+wr7R5ol5wOjtolXXYInPw/hHwU6TVqq4egOpPc
         L9+INxglTLVo+5VNo+fIvGoBAhrzCuqSo4xMuuVuG5oq9YWG5wOl3B1bxKQCZscnOJ1C
         HNxxYbc7H7nTVXD8oWBU5Z+nq/C5MKXffk3ovYZ1gGTDtVV1/xw06qx7iNselCN+dNEM
         PkHA==
X-Gm-Message-State: APf1xPDd/hGgeqzP82AL9tQfBD96p7oQpkeK+QlYm5XFeFHeWqdGCJUC
        duukM9iVIOSrY+1jcwJDVQPg0amDufk=
X-Google-Smtp-Source: AH8x225I4t2DKyfDY2xU5UesTPcua48zqHv39NJbJHPDF3f7D5zSqJLdNck3cQCL8yxCqAGBeGuEeQ==
X-Received: by 2002:a17:902:b486:: with SMTP id y6-v6mr519418plr.70.1517875119986;
        Mon, 05 Feb 2018 15:58:39 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v73sm19159038pfk.84.2018.02.05.15.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:58:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 026/194] object-store: allow foreach_alt_odb to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:47 -0800
Message-Id: <20180205235735.216710-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/object-store.h b/object-store.h
index fcf36c7370..518da80367 100644
--- a/object-store.h
+++ b/object-store.h
@@ -68,7 +68,6 @@ extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned lo
 extern void prepare_alt_odb(struct repository *r);
 
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
-#define foreach_alt_odb(r, fn, cb) foreach_alt_odb_##r(fn, cb)
-extern int foreach_alt_odb_the_repository(alt_odb_fn, void*);
+extern int foreach_alt_odb(struct repository *r, alt_odb_fn, void*);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index be67c69c75..ca492eb741 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -665,18 +665,18 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-int foreach_alt_odb_the_repository(alt_odb_fn fn, void *cb)
+int foreach_alt_odb(struct repository *r, alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
-	int r = 0;
+	int ret = 0;
 
-	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
-		r = fn(ent, cb);
-		if (r)
+	prepare_alt_odb(r);
+	for (ent = r->objects.alt_odb_list; ent; ent = ent->next) {
+		ret = fn(ent, cb);
+		if (ret)
 			break;
 	}
-	return r;
+	return ret;
 }
 
 void prepare_alt_odb(struct repository *r)
-- 
2.15.1.433.g936d1b9894.dirty

