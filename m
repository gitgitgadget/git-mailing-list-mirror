Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A42F208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdH3HNx (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:13:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37290 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdH3HNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:13:52 -0400
Received: by mail-pg0-f67.google.com with SMTP id t193so4492374pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJxJX2Q1UBy7P+25sAoiQNEpOXw8ODq5Bx5JX7J5JwQ=;
        b=Ri0GEiOac0DNQMNDFoIw/fxnMzIB3CXp/K9p9oBaYFBQ75T1p3p3dGKWoBiYX6ykuJ
         w8aGO1byDDoedSHErUs82aDUc1XgZMwCvjglRALyNsj9K9tY4qmvl/Z3/d5M1Pqh4pea
         NcoZunetuMJHFKtM+R8cXNccnTu1p59b5JUIv6y5s603zkfR4LbHeIbGG5fw7ew2rwmU
         9ALin43hidTERDMQsF0BEj+d3Z/ijlCJb5rKqm6oUdEgyn3+Op0gWceaOdoI3eHGUF72
         zDo/2OSV2JzDZjWKckpC08Wq+/LjtpkcXYtc8FUdkrlcWFpl/XnMGSNziGZ7Ar/Gddo3
         IJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJxJX2Q1UBy7P+25sAoiQNEpOXw8ODq5Bx5JX7J5JwQ=;
        b=VqERZGW+DFlqpSFnN5MfQk1wrwQY7cbjefAW2X3UCZRgfTfLU0tQN0B6hnNh+fUQWu
         Z4qV19uy9GV3n5TcipNNjADbla9FvL//PMe3Uk9BNd/1NQUOUTn3fNX2fe66y6yJwHSv
         6R+oNpqTLCQZYQJLheN69YPUkeIR/HScMUP8JzVHYQ4JyiaPSmOU2a7bzKo1GJrFkV96
         Ou+BQwxc7YXHTlHTv5h70BDEXoXVedjEDbZvyaSi4ANZ1CPYnVNG0f1XZ2LagKQyJ47g
         EM1DgAYFW5WNAlTHnI+plHwjVmLK4kyvq6coAHjQKhSSpUSixpBfCnM4RAzX/VrWKECd
         twjw==
X-Gm-Message-State: AHYfb5iUEfKGx68QcLuBQv+bQuEd2Z5L7vFjLxcUv1CnwmRv9PuaaTft
        Hfm1ubkmRKSCcO87NtI=
X-Received: by 10.84.232.70 with SMTP id f6mr733965pln.427.1504077231374;
        Wed, 30 Aug 2017 00:13:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id a68sm7616390pfc.162.2017.08.30.00.13.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:13:50 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:13:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 32/39] pack: allow prepare_packed_git to handle arbitrary
 repositories
Message-ID: <20170830071349.GG153983@aiede.mtv.corp.google.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 18 +++++++++---------
 packfile.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index 4652be0b6e..23a835f7fb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -865,19 +865,19 @@ static void prepare_packed_git_mru(struct repository *r)
 		mru_append(&r->objects.packed_git_mru, p);
 }
 
-void prepare_packed_git_the_repository(void)
+void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
-	if (the_repository->objects.packed_git_initialized)
+	if (r->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(the_repository, get_object_directory(), 1);
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru(the_repository);
-	the_repository->objects.packed_git_initialized = 1;
+	prepare_packed_git_one(r, r->objectdir, 1);
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(r, alt->path, 0);
+	rearrange_packed_git(r);
+	prepare_packed_git_mru(r);
+	r->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git_the_repository(void)
diff --git a/packfile.h b/packfile.h
index ba6f08be99..75be3cb877 100644
--- a/packfile.h
+++ b/packfile.h
@@ -32,8 +32,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-#define prepare_packed_git(r) prepare_packed_git_##r()
-extern void prepare_packed_git_the_repository(void);
+extern void prepare_packed_git(struct repository *r);
 #define reprepare_packed_git(r) reprepare_packed_git_##r()
 extern void reprepare_packed_git_the_repository(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
-- 
2.14.1.581.gf28d330327

