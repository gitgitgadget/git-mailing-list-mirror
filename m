Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A141F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeKJPdL (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42252 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbeKJPdL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id f3-v6so3366829ljk.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhATxoStaC6DfpOsQgwQMZ0vUIFnPYO038q8CO26K5A=;
        b=C/DrReMf+dIGeZEe3Wp22S9MKn9gY38B6Yx5BzjRUBZPe9uhuzJZY5NFzWnIpUy3mE
         mM5nbEaGkf5FOac46c0TDzKxsz0MBceVmqD4Tl7Osd2LhKx4wiuYcK6OeCvtUKLB2phg
         fEgJ7zotij/S+pPNy6UCf5+KO7ZiEj136AIB8nAnLlCasm/MkL5VB9Fb3Y2iqDJDhJxC
         ymjqVwAxy8mzi6ZEnMp71ZV81zYxp2u2SKNDyVazs/5d/3gHdooI710VNY/2TXwg+npj
         O75oTC8zdt7IOzCzTKomvRMER446qV0GtiIMSs9E2IUpdvbJjbk1WZEYLQZ+p6QTLJq5
         pebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhATxoStaC6DfpOsQgwQMZ0vUIFnPYO038q8CO26K5A=;
        b=YuKA+cI39djOJtzaJO+iPRicL9/8HKHWASDrx1YkGKa2culkeD0LExOwLqfhbi0N8b
         b7k2jl8Df9Pffu9TuO+ofYSPapgsbELhYke7glZBuI3THKV2n2gMoU8FC58Mj+x4kPpD
         0imM9tTpKIi6wx2Wy/3DTMzujIyl15nX+KNLyCaa74Sh2/6YcXOPT/sJYmr4ye5K2f50
         f16ZBhjHjju7Wmy1rOR33IBl4uQzSxnDp0PEMmubJ4kpKgwMnD+WznG+3eSUldpQOIcn
         Zj8rl+kCK8qZbI5UXEsH7gs0M1UsgjYg8zM45yzZGv3jC36BK9vGFLvNlCMcek6a8KA2
         TLwA==
X-Gm-Message-State: AGRZ1gKiKSBtl+//CUhr0GR57eM3Wu5O5kp31xJtSHQoxG7hT5C1MkaM
        QjsoRwwedMwKzzxrq3cb6ztF+IW+
X-Google-Smtp-Source: AJdET5ckQ3qA6/Ee+Ld4bJEWyzvF4oVz+CttQXoQj9EpPdqlGSNUhiOmf/vrGnmk+YQF4xXKuXqxFQ==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr7962120lji.130.1541828963854;
        Fri, 09 Nov 2018 21:49:23 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:23 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/22] list-objects.c: reduce the_repository references
Date:   Sat, 10 Nov 2018 06:48:52 +0100
Message-Id: <20181110054910.10568-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 0cfd646026..cf7f25bed3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -123,7 +123,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 		}
 
 		if (S_ISDIR(entry.mode)) {
-			struct tree *t = lookup_tree(the_repository, entry.oid);
+			struct tree *t = lookup_tree(ctx->revs->repo, entry.oid);
 			t->object.flags |= NOT_USER_GIVEN;
 			process_tree(ctx, t, base, entry.path);
 		}
@@ -131,7 +131,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 			process_gitlink(ctx, entry.oid->hash,
 					base, entry.path);
 		else {
-			struct blob *b = lookup_blob(the_repository, entry.oid);
+			struct blob *b = lookup_blob(ctx->revs->repo, entry.oid);
 			b->object.flags |= NOT_USER_GIVEN;
 			process_blob(ctx, b, base, entry.path);
 		}
-- 
2.19.1.1231.g84aef82467

