Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0221F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeDIWqD (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45976 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeDIWpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id e22-v6so4332552plj.12
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHSAwNXBOtbJVeO54kob9OLLObKZUyl1A4tWgSnixbc=;
        b=fYcvPZdcosgVj2Rqejw0rglfBiqidjCuIBztqJ531R9jDiBtUuehbgkLp8hnsDYuZF
         dkm4ie2bQ3GH+AI7+c9aaM6mKa8Qjdp9glkemsGQUMeOywOebeO4buuSQcuQkadLquHy
         djY3QgBzj3SVdtQbUbO2LhBZRViuZySczGP9kSsI+JblibSdrKPuwqu82cXlJtITAkX/
         M0eJlmolgjE9WsDpiviMB0SI6PMBXsiw5Z3dn3KVCsxKEyYT+3b26d6wu9RwsqZjMs9k
         4FCB2qaD5K9hyamxlSTy0w8GU1GEqBMPRmfofb2tO1XvR1MImTkG0KyujOQ+FimyvORv
         keXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iHSAwNXBOtbJVeO54kob9OLLObKZUyl1A4tWgSnixbc=;
        b=i5Lr5curB5vn+yio1tySLrJpoDFcJYozHXQZ2ldKjyw9cVqLqODj/aRjwy4NJAdZGi
         daXUU6Y+005jlvRZWbF8+hnR3n9/fq8tnR6zV3rHuJRxm6lRc6aJ6eQvcyq2erRM7G0H
         eUqKYhXWzH9iX2YA7yS4P7NlVOq3Iw/G4VgIYNGe0KaDFlSXucSn1fgJV9gdDM+IfPoq
         rB4U/2EVO9YbUExBbKXzjYpxtkdQ1IjvrsU0O39sL83Vdc+3Eqq3XpQSZhWZeJZP6uTa
         flTMnd6PKAcVDThpxH+tNm6cma2zhGt7kZmEAzCAxxtVgPSP4JRnM8vY+ZHkWJ4Z3r2a
         RtQg==
X-Gm-Message-State: ALQs6tAZx4a1ctHvMaQcXciwHchZ8Hr9yiNsWRFQuh7gCvQCEEss+NoW
        V+7azSYFi5qjXNeTR6MHvO0cNw==
X-Google-Smtp-Source: AIpwx4+cERq/ToEtzFNTuJFeFDuQiPHQcWo2r5cxy8La+2oMoveQskbTT8WA/KAJTKTvkln9mUelqw==
X-Received: by 2002:a17:902:714e:: with SMTP id u14-v6mr10720682plm.356.1523313950807;
        Mon, 09 Apr 2018 15:45:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e190sm2468978pfe.171.2018.04.09.15.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/16] replace-object: add repository argument to prepare_replace_object
Date:   Mon,  9 Apr 2018 15:45:26 -0700
Message-Id: <20180409224533.17764-10-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the prepare_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 16a95ea416..567d9da708 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -31,7 +31,9 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-static void prepare_replace_object(void)
+#define prepare_replace_object(r) \
+	prepare_replace_object_##r()
+static void prepare_replace_object_the_repository(void)
 {
 	if (the_repository->objects->replace_map)
 		return;
@@ -58,7 +60,7 @@ const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
 
-	prepare_replace_object();
+	prepare_replace_object(the_repository);
 
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
-- 
2.17.0.484.g0c8726318c-goog

