Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAE220248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDPJet (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:34:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34456 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so10077408plt.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/8jRsl/lbTooZJyX5DaKzNtxhJuqTU7J9fS42CMkCM=;
        b=GAiWHZQKjL71WYclhWNAsCrLvZmR9N9briNGBxYDJpOhGyFSoEmz70rDnlnhoGKUyn
         0olC0aN46bYQG/g0BzDFWQ61vAv9NCt8H0uTrvNEY8rn5so+3NphjOjJJ8TIqv6Cd3gj
         +d95Dcso+J1UfxiQ2fuaWE9e0TQAsrP4dR272i8rbR/5AvAi13ssJGZnfpssKoA7tGZS
         dGaveEj8JtOcpC1nDuQj7VSDWP3QugCfURPYyXOW/s+mbN2UgA7J4TweRXjy/OzJ7uEF
         Mgj+8yQgIhCjGx4Xpy2cSWKochNoQDBqY5aGgmaqGQjZXPFp759sXCNPuPjjuaQvCjar
         5Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/8jRsl/lbTooZJyX5DaKzNtxhJuqTU7J9fS42CMkCM=;
        b=PvX5kWQwpnKAc2/pvSh/9Tqgeh7u7bwaKKPN4uB4qgv3QvcynwLyYtUdX6UKoYWXYT
         yXyN71lh69X+lDd/8Eg4WFw3a1S7VGij/yZIVZAj9gjeINDpHxfl4zvU0yar1oTJ4WxI
         6zQYPfsPXDfH2jqjzg96YN4DEfZlIYethOFcfbSRLCkPfnycnwOLM18XOC51VoOueUeA
         b5IR2/ZCZIn8BHSjP2irZ94pcAjXEnggEGx+YTYR9QeOyG6fkBN/zR26khDdbqONv/8q
         Yc0pzx8RdJPXK+D9ZX+HjRMtHS+xZGVxJQcNNmkTyVilGQwX8cVmC8kVtIPcqJDOVD3m
         pglw==
X-Gm-Message-State: APjAAAVeMZUlIKtuXfXxKTfLYxB9a+5/jM3M3HMGqm1Oy5G+IaFoGlos
        iMpJgKfZ0Pb/XuXYr+x4ayE=
X-Google-Smtp-Source: APXvYqy+d7RuzO+FDIOPnqBx/QQMgL2h4ajZX99js5+sXeKB16UFg5xlIM6s8vyBnzzPSbXFHQFbWA==
X-Received: by 2002:a17:902:be04:: with SMTP id r4mr82434829pls.218.1555407288945;
        Tue, 16 Apr 2019 02:34:48 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id f7sm86548682pga.56.2019.04.16.02.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:34:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 03/34] packfile.c: add repo_approximate_object_count()
Date:   Tue, 16 Apr 2019 16:33:10 +0700
Message-Id: <20190416093341.17079-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

