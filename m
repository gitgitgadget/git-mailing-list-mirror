Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70170208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750811AbdH3Gy5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:54:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34488 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdH3Gy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:54:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id 63so4466523pgc.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yNj3HhXr3N/aixpazdBB/rFbmbZyOvsseVhCC5tWymM=;
        b=hAbe/8mUslW9hEGrV6GJNRosg4U+ofn3cfe11+vxdC5+Stg650cEArDixoKi/D2Uxn
         WvvQ5RlTQE+yDLyVt7O/28GCbCeimrYxQuTHqtgxcRY6o3oWfxn/MYICbe0El33e4jyE
         K5DhceXV95SVLku2n2jA/cQOkhazoJMWE2sfz7RcXMbuNl2gprsJJA80+dVcBR2r7lkf
         GDdBgkAroR7g9CROM3QdZC7LVw39rlNQhoT73l/1tXjsXMLXAtq7lRWijfmB9Xr4mt97
         27oa7b9WLzYQDQs2ByQ3y/XnNU/PBNFqY4nYTtL3QXxkIPq2K1iY06eZne9MHYp+QaQ0
         pqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNj3HhXr3N/aixpazdBB/rFbmbZyOvsseVhCC5tWymM=;
        b=aT1ABNPCjRCx6aRuO5FmGPsXNrWSGnhc4mmCQKwjlrS5BpunZqLh27FDQk8JlIfPyH
         S2UMhsRIQxRpr9XxZW4PfrgF6xGSuQxTRePcj1l397qaKE2APm7+qXHir6B8urQ7ctF4
         pDEqF6FT6exNpH/PxyZf+WkRB125Akv0+if8VK03RefLqJ5WnBvlHgpGOfTdpLqnc7GA
         45kEvy4LPXKDBkncph+PjvLCWc0/qjSGUpLMa2mMW7VYCbwMJjoHyq7gYb2RRuKkGcrq
         adlFvj6vEuNVs82w/bxbOYpeNGDSuLulPEWZAbJCqsEhYdgnXiOmzSG+jFhaljoP6nRb
         YFXQ==
X-Gm-Message-State: AHYfb5gNUAAEL6Jn656hq7+hhzk0cC6eyDhOj7ogE70bXDU5OglcW3II
        qhfG+Zy6X+Sy9O59Rhs=
X-Received: by 10.84.231.129 with SMTP id g1mr758210plk.326.1504076096111;
        Tue, 29 Aug 2017 23:54:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id l85sm8069695pfg.175.2017.08.29.23.54.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:54:55 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:54:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 05/39] pack: move prepare_packed_git_run_once to object store
Message-ID: <20170830065453.GF153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 8 +++++++-
 packfile.c     | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index e2a59a0611..14129fbba1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -15,8 +15,14 @@ struct object_store {
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL }
+#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/packfile.c b/packfile.c
index 57260a9b34..c54fe0ac1c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -866,12 +866,11 @@ static void prepare_packed_git_mru(void)
 		mru_append(&the_repository->objects.packed_git_mru, p);
 }
 
-static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (prepare_packed_git_run_once)
+	if (the_repository->objects.packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -879,13 +878,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
+	the_repository->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
+	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
-- 
2.14.1.581.gf28d330327

