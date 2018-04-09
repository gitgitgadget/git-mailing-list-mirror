Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8C21F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDIWqN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38395 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeDIWp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id y69so6613264pfb.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fz8Hu9rbl4CwVoaIHeHjZetf0HGqOw4GHluWGVJfI+o=;
        b=l0RFZdocmCvPuwivbjjYSbUFzgTdJh9asMBHVng7nZhIi7KvNuLjeRxUItgyPy7wBZ
         6NRqYIYkaCnEbMFSm3RC2Ie0C1Q9wd3qKk5rMg5nxuwNpsJ6YdcOTBg6GE4WcrIt5+Eg
         vVSj6N4VWqStoVnSjpaTlJQYtf84Joppoe0a2UCjILdx5PtzBXneS56TYkQWCJaF7ATu
         gbDxJG6nKS8/zAKGcHbJPLQrP/mnNVN/TlhFdXpKDVCdhBr/qPCD5ePu6gU9+lgk1+oD
         p+T4KPvKWrT3PGnVa52U14+FiaAvVpvk7ObIBbFXa0z2CbhOrhKi7g738sPuJdYUZ8x0
         aVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fz8Hu9rbl4CwVoaIHeHjZetf0HGqOw4GHluWGVJfI+o=;
        b=EfExn2jJPDy1HLWKMP55znR38Efla6NLFV61HV8DtZaQSFkx90asett1gOVEWPKAON
         7S008TEq8kTUbrXr6ygG3d97biz3Ly+FNKS7prFCQA/j+vszS+twszAn+JwTNNdUIHAC
         7jyRX+UH2wgb7rFw8INTrHYdfarwZb3yfVTurFAN937DXejLTLCd6BMZeA8qL5BCXkzT
         cc1qg49wFwWVByh/tQgzNn/8NGP245Lk/h+QUNAPZFXGYH1BBuELcfE6T2T2nw5PjI1v
         pgH1J73NISvr4p1pKC9EbgGqz1NV7uUlofU/BYrr39OKBBF1WCt1B77H7Kt0ifH5f36o
         oqGA==
X-Gm-Message-State: AElRT7F7qVjfAt+wmIz3oq5+JXJtZRBdX7ua1GxBaeRfYiN5L2L2QT/L
        9bIoYakPmlKHkDxXMhmw51p/oA==
X-Google-Smtp-Source: AIpwx49YeSNvSKgWyfi4qXNDxMR86amP7OowqPK/9YUTGkxhgAKy4KXVdE6DvwtkRWZcUqBQFGGE1Q==
X-Received: by 10.101.65.75 with SMTP id x11mr26639097pgp.203.1523313958597;
        Mon, 09 Apr 2018 15:45:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y129sm1850102pgb.64.2018.04.09.15.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 14/16] replace-object: allow prepare_replace_object to handle arbitrary repositories
Date:   Mon,  9 Apr 2018 15:45:31 -0700
Message-Id: <20180409224533.17764-15-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index adfed78901..eae52c66f3 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -31,18 +31,16 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-#define prepare_replace_object(r) \
-	prepare_replace_object_##r()
-static void prepare_replace_object_the_repository(void)
+static void prepare_replace_object(struct repository *r)
 {
-	if (the_repository->objects->replace_map)
+	if (r->objects->replace_map)
 		return;
 
-	the_repository->objects->replace_map =
+	r->objects->replace_map =
 		xmalloc(sizeof(*the_repository->objects->replace_map));
-	oidmap_init(the_repository->objects->replace_map, 0);
+	oidmap_init(r->objects->replace_map, 0);
 
-	for_each_replace_ref(the_repository, register_replace_ref, NULL);
+	for_each_replace_ref(r, register_replace_ref, NULL);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.17.0.484.g0c8726318c-goog

