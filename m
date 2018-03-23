Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D684C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeCWRpz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39548 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeCWRpw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id p142-v6so19483708lfd.6
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTq00HhVlFO1hURwILmSPN64fuk4MxJMiIkLwcfjwBc=;
        b=XNuU/5a72A0P6gH64rXwlSiocmp5QOLOn9HJlCfZtxUFzEcmVe1BBeQBkdFFSz1ICK
         KTtU41gQZUMujnW/ccrQ35kndfvZVXl2+F25zJFWSuyUtONP516I59FMyPQpP6byIwxM
         MFv2bt1pYN3t1nW3O8ONkzZAqBULaojgU6jxho+0O2mPZ56cVqmauW/J11Os4u2hfmj8
         7aC1XVgiVlDxcFRpjEm0kgysA0Rb2KCh1UCtXppwa0zxN/LPTpmGPlVv32aMUVD7JNLC
         jUsVes4Vo8aNuFQxQ04f8RdLHH8YsNyjRHpTwG/3tDvZ6Ace6KbF3qZso1Bl00Uxpgu5
         jfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTq00HhVlFO1hURwILmSPN64fuk4MxJMiIkLwcfjwBc=;
        b=dtAveK5BJSVQTkQRiGPktihL26KdSSoARkzJb3gbpsDmTSjz9kh6WalYHaBgRhDh3G
         jkrmWB/KZE3W1hLWqzxUAqjmddsFuW/Onl8kZr3I2DDknjVChOelePbu9om9C53h/C80
         AFI22+E+a+yryfuJGjrcYLqTIdFwJjYkgiBPYJwA4ih6vZyEWd86xkkHRd4/MO1tBZl/
         AhjaFsxTmfDWBxUSTUu9ldoHdlZF7YI9RTnzbwNvu90ORVVOzGbjvF4VdZfWk+050O+M
         rGKMd4QY8UhcrPLXi7juQ+9iiZt8oGKzcZsQNQ2Ust7LVm9i8eFbcaj23ZsgE55q33sj
         XPyQ==
X-Gm-Message-State: AElRT7H94bjdGo+Yqz1yMzpEudxxCUWukT5VkQEujKjlBHVxbltp61OS
        +1uyGGJsMSqFCh8nuqvNpIuLCg==
X-Google-Smtp-Source: AG47ELsdDE9J7hUN2lfKnkxh9dotQPr/G4lrO2FnjiX0jsKiS8XJesOoijy6zpGhGQEaEGX+8NRruA==
X-Received: by 2002:a19:b516:: with SMTP id e22-v6mr21355964lff.47.1521827151312;
        Fri, 23 Mar 2018 10:45:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/12] packfile: allow prepare_packed_git to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:23 +0100
Message-Id: <20180323174527.30337-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323174527.30337-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323174527.30337-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 18 +++++++++---------
 packfile.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index f49902539b..ad90c61422 100644
--- a/packfile.c
+++ b/packfile.c
@@ -883,19 +883,19 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects->packed_git_mru);
 }
 
-void prepare_packed_git_the_repository(void)
+void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
-	if (the_repository->objects->packed_git_initialized)
+	if (r->objects->packed_git_initialized)
 		return;
-	prepare_packed_git_one(the_repository, get_object_directory(), 1);
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru(the_repository);
-	the_repository->objects->packed_git_initialized = 1;
+	prepare_packed_git_one(r, r->objects->objectdir, 1);
+	prepare_alt_odb(r);
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(r, alt->path, 0);
+	rearrange_packed_git(r);
+	prepare_packed_git_mru(r);
+	r->objects->packed_git_initialized = 1;
 }
 
 void reprepare_packed_git_the_repository(void)
diff --git a/packfile.h b/packfile.h
index ab5046938c..3fd9092472 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,8 +34,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-#define prepare_packed_git(r) prepare_packed_git_##r()
-extern void prepare_packed_git_the_repository(void);
+extern void prepare_packed_git(struct repository *r);
 #define reprepare_packed_git(r) reprepare_packed_git_##r()
 extern void reprepare_packed_git_the_repository(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
-- 
2.17.0.rc0.348.gd5a49e0b6f

