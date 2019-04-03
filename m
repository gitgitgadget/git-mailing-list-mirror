Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850D220248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCLfU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38573 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so8022253pfo.5
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Hh1qjhIYgsEJ1RAvKb6URhIj4fZF8d7gLklPr6lwvk=;
        b=ZCQv4k+HoTA9jn8e5BB/KGcPrJa5/U9sKhBWCp975EXwdQEZ1uxZouxPlng/nJMc5P
         +sJoXLSxQ07UxLnaUNGTdC+LI7zzAQgEtWYBnbakNATcIrFkouin03Kv+rE0/Ift+94w
         Muouaht0JUfitfc727U/7kbTJ3w98DGZYsCZa5fURr7KoMWIqi0QkqNR6/AUK+IJ1uqB
         bz3xPPg+o0RsPAllCQAkBzPDBCvyIUk3Bowmr/7/xJOCzBXbmIHDjkPvhhg0ylMXx8BL
         t5pvaLyRyAd9jqYNkYU6qBdD4JBovGVegszJQuDwvXoTcxXjaiES8zrqOMZl3U4sG1GD
         2AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Hh1qjhIYgsEJ1RAvKb6URhIj4fZF8d7gLklPr6lwvk=;
        b=oCz3U5On81WXC4RZv7ZcoJ0kFKWQjfFX4mJ273/zpjge4mPwPg4QQXyqhMTNHc8ySN
         pimipL38ayAz6F1VqF6pA9G2XBGQSCekoAu25WIrmp31uNcYb71qeRY/PZq1gfqvKnvy
         JkoDo2T7yZ0+G2nMLG6aUwfWGYb/8fDnGZNcRcRz0Fa6LfzytsRm1nLTvOuzrFLuGOc4
         bzxpYjYYijzrLesQ+kFHbSCuA5T9D4h5E/5esZQ/kpBvDQY94h+cf5Fxv3yp6lLRYgnf
         duPeJIlZYaapPMuWwfTeUWstVLVab0hgPT91vrngVphcAKfsN9MBU/xqihtUQtza6KmF
         ns2Q==
X-Gm-Message-State: APjAAAViqc+ky+Ow81pZxtckNKO5hDOdyjzfbh534VSC75RZg6Qg2OZU
        56IFcFI048GMUYPweEDaK0dRSmtt
X-Google-Smtp-Source: APXvYqyogTVdheJKxIhp346F050wy1sP80PRQvBZXMY0ubT+DxDWFkkgL9shtqHOxMchCL2hCiDv3Q==
X-Received: by 2002:a65:6259:: with SMTP id q25mr44640064pgv.103.1554291319557;
        Wed, 03 Apr 2019 04:35:19 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id f63sm10260899pfc.180.2019.04.03.04.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/32] packfile.c: add repo_approximate_object_count()
Date:   Wed,  3 Apr 2019 18:34:27 +0700
Message-Id: <20190403113457.20399-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 14 +++++++-------
 packfile.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 16bcb75262..2ad4fab2f8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -893,25 +893,25 @@ static void prepare_packed_git(struct repository *r);
  * all unreachable objects about to be pruned, in which case they're not really
  * interesting as a measure of repo size in the first place.
  */
-unsigned long approximate_object_count(void)
+unsigned long repo_approximate_object_count(struct repository *r)
 {
-	if (!the_repository->objects->approximate_object_count_valid) {
+	if (!r->objects->approximate_object_count_valid) {
 		unsigned long count;
 		struct multi_pack_index *m;
 		struct packed_git *p;
 
-		prepare_packed_git(the_repository);
+		prepare_packed_git(r);
 		count = 0;
-		for (m = get_multi_pack_index(the_repository); m; m = m->next)
+		for (m = get_multi_pack_index(r); m; m = m->next)
 			count += m->num_objects;
-		for (p = the_repository->objects->packed_git; p; p = p->next) {
+		for (p = r->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
 		}
-		the_repository->objects->approximate_object_count = count;
+		r->objects->approximate_object_count = count;
 	}
-	return the_repository->objects->approximate_object_count;
+	return r->objects->approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..f04440f984 100644
--- a/packfile.h
+++ b/packfile.h
@@ -57,7 +57,8 @@ struct packed_git *get_all_packs(struct repository *r);
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.
  */
-unsigned long approximate_object_count(void);
+unsigned long repo_approximate_object_count(struct repository *r);
+#define approximate_object_count() repo_approximate_object_count(the_repository)
 
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
-- 
2.21.0.479.g47ac719cd3

