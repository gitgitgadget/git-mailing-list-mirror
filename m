Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0581F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeBMBXS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:18 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35756 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBXI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:08 -0500
Received: by mail-pl0-f66.google.com with SMTP id o11so2237558pls.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9V1DRQiLyvTftM4izQoAqcUwMbvztnetZ+H1nomM2pI=;
        b=BmGmOBCDhOGjmZtsKRu8bCUw9ZWlnyJQ2EEej7vxxtSCKwVq3UldG9BFYCZRDgwhOY
         xuS8Q0hxQrz1iIJPlBDfrKJaWVnsNHQCxyn/3H/0OA/QWOo5ros6kVAhZ/HDHzp6f8QV
         ZOH4nJ88ep9bPLuG/MXJv3O9y89tiba37cmUGgWxRsFI8bPxmWZyAlGCrA4fn/6/WYNO
         BfVl8nFoXE4bXJUfnzdzUQwpFxLMWjm9LwGTwi6d1o/a2ppDPuFhofnvA9QSDA4QLBvz
         +I8Lf4y/YOW0QIHx9O0b40IW4szh+g+jJ4+DTwpwUjMudnblIX9ES1PmkhpMmbLLaX6I
         4Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9V1DRQiLyvTftM4izQoAqcUwMbvztnetZ+H1nomM2pI=;
        b=HRtoQ6hUB0l+1hmq09+ItOQ8GKAbTJrFYD/fj+aJH/nmhxMellAXtJStSHR7EMIten
         /fio06J1z+27I9hDwPHpZTqb4zst7Rhjd4POzBe5JeVeyOzrb6WExVdEG5Wa8SrQjThB
         lpHAK9JGa6LKiHS6e9dnxqOPXAt8W7D8z3p4fGo4z5te9uwOwGMjpnEnJ9IOkvGrQeW+
         nOAXc5j7c4o5dwahOohpavfZDkFbIDPzFbL7lKf/xR7P3Z3tRM9LIVVaIFFJpNioJj0I
         Dq/6+pqJDdWVPwTHzeNdeHEssVB4DhT4o7LT9ia8fHkj17YwNgCnPwcIumLkb2BQkEDQ
         dtJg==
X-Gm-Message-State: APf1xPAqvrGl0DjwWu0YAfl1FxIxZbhOCd+dptdsj2//A4DOGwISy8Rz
        jFZMm1Wjz0yTG5qzB+6Rre7ohg==
X-Google-Smtp-Source: AH8x226m5QMRpp9cEBsgcTuJ9nTx5SCndG7/8Iv1aYQYPgKr5ilVi/PKnl0oNreZkBI4V3PklYLi5Q==
X-Received: by 2002:a17:902:bd01:: with SMTP id p1-v6mr12790213pls.172.1518484987487;
        Mon, 12 Feb 2018 17:23:07 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n24sm32317873pfi.175.2018.02.12.17.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/26] sha1_file: allow prepare_alt_odb to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:29 -0800
Message-Id: <20180213012241.187007-15-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/object-store.h b/object-store.h
index d96a16edd1..add1d4e27c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -61,7 +61,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-#define prepare_alt_odb(r) prepare_alt_odb_##r()
-extern void prepare_alt_odb_the_repository(void);
+void prepare_alt_odb(struct repository *r);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index d18ce3aeba..f046d560f8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -677,21 +677,22 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
-void prepare_alt_odb_the_repository(void)
+void prepare_alt_odb(struct repository *r)
 {
-	const char *alt;
-
-	if (the_repository->objects.alt_odb_tail)
+	if (r->objects.alt_odb_tail)
 		return;
 
-	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+	r->objects.alt_odb_tail = &r->objects.alt_odb_list;
+
+	if (!r->ignore_env) {
+		const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
+		if (!alt)
+			alt = "";
 
-	the_repository->objects.alt_odb_tail =
-			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(the_repository, alt,
-			     PATH_SEP, NULL, 0);
+		link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
+	}
 
-	read_info_alternates(the_repository, get_object_directory(), 0);
+	read_info_alternates(r, r->objects.objectdir, 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.73.ga2c3e9663f.dirty

