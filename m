Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88DE1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfBQKJZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so7079967pfh.4
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkBv31JCMg+KHs34rsN0C+oZWm8SedWnaKMf8OiNl6o=;
        b=jOHdh7+boBcy7YuKrXAi1j466cbNLgG8xiEo9xjdAEEY4bJfksGSsuZJytybk1j6gM
         UBH6dy0945JvP3kFlBbwXVTAvqL9kkevxyrmaNITHgKxDI8ClvoYByiAz++Ks8E9iLMx
         x2Btz0yNqTOEoQnM+V3AE8aDsVg2SuSlcjvys2/GEcS1b5Zi9EZhQ2VUi46byWg1b0lQ
         ZgPtfdEbSy3sU188SRmJF2lKxSlDzN49AcPiVt/GosGqwXlavAsr3Qlk1h4HIEAKr7za
         Sl0U86oTuY2p8thUbO4EOwI3Uo0wPEtFHxLW+OvkzsUJHmAJhgZS6GSBkwqCB/gHWOrG
         tkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkBv31JCMg+KHs34rsN0C+oZWm8SedWnaKMf8OiNl6o=;
        b=sC5muncYcnoFhRUoP+fpV+cuKoAlE184qK4gGfCfP2RNDXVvjM3YMACIjS0OmDoEcZ
         5BDVyo9tPPnhZpmdt1DgZt+5OiNk2jKJP8MzG6vPSYHz1Ms7k85aZ3nXuzvuNLegvXzG
         ySZdQ5W7laR/kEFshOjuMwZDuIP1UoQWj9bP9sJv9dmcF/vA8Q2RgtVls3EehKumo3Zy
         q61EUYr1ZS2pa9nUGSWDXd6VbmFnh2F8jf9DU1ku5EtqUjkFCtW+ETL/46wo4oBGJd5E
         yIuNXEG9hICowFQwgGP5gNn1pL/F5MDh68X0VcW0/aILpFqicsFDp6woLl7tqntrm754
         GGdA==
X-Gm-Message-State: AHQUAuZzmQ2fn5CGZssk95gyENe5NCSNES9FUcHENLwgF9YXDsXOOVtt
        iO0rSyoHRnkjElIWRBF8EUaz1WsE
X-Google-Smtp-Source: AHgI3IZCRqZ+4NtzNj4rlxsfCP4rt5rT2Y3FE915JDK9i4MkKMjEJjiywWwF5mmEECBnmgiRUX7xrQ==
X-Received: by 2002:a62:e214:: with SMTP id a20mr4201194pfi.192.1550398163577;
        Sun, 17 Feb 2019 02:09:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v1sm1140794pff.9.2019.02.17.02.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/31] packfile.c: add repo_approximate_object_count()
Date:   Sun, 17 Feb 2019 17:08:43 +0700
Message-Id: <20190217100913.4127-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
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
2.21.0.rc0.328.g0e39304f8d

