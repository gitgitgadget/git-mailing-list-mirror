Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADBD20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDFLfc (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40031 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLfb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so4471369plr.7
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Hh1qjhIYgsEJ1RAvKb6URhIj4fZF8d7gLklPr6lwvk=;
        b=VDq/R7kY1J9zoxoKZ9Co53IXDguPWqV60tTjiT0CeB8gJ4LU3A8wvCIM5NwdpLwvL5
         PorPJTCykDbGP84cDAA1nGHhmOPhO+u7XaqQlLqVFd5Bs5bYgoX6N2dW+FtSFWFyga70
         JZ4gkBeh8QcB80S92lc52ZxjdEXwl5SdEldcYpitXvAiidXeYX6TNw2ffbjIBYcx466S
         FCxXBovPwOq53YadG6IzXeR0tmOS/wDNZ3cPMfDSE82dpN3/xMNJ7uNZnNNC9PYyjqlE
         o3uKrkycYlYrS21uSP2xMauufP+JExtf1kB8VeSS/jPc5o56E5XCWAnWyBIJMW/PjAuk
         +aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Hh1qjhIYgsEJ1RAvKb6URhIj4fZF8d7gLklPr6lwvk=;
        b=QQg6h1avX/85a81cbflFFU85ACnpUx/RVpGICzMX3LeC+nSTuJp11eVX0NwO2WWO5+
         NeAhNrOx8+XMSlF+HhU30rFOZe2F19nqPJJ6X0JNCRbSE/9KsUgrPSYAwu2pHryTVa7l
         /vNdz43/tugu8vjlAI6pkiMz7Ot/xcqPLBSYW65sLCfUgqXOH/v7UKCx7blLbbNDMhaE
         w21oIXMeXh78XB6ttTZZcPpPa47Df1HcFVF9wHY1wytk1ZrljB1TMv3HEnYczs3lWubv
         l5q2iZv/azWsxyO4PhREtGwEFe7/TvnM6vFgU4GOEw57sMhEckw2TGAkZ7uLMwGa8VLx
         vYlQ==
X-Gm-Message-State: APjAAAX/qq+l11h6JBsZKhGEiNaAYbGUpaHliqEKyEuiDMy+itOYgb8E
        o8ib/Y5NnlfK/OaNQ0AyJNmwsETv
X-Google-Smtp-Source: APXvYqxTkfYXcfB7Bzn0GaxiSvSrELiWYHrsGOg97YJDgY+z0fcdFYrYKIvyj4Lz5W9jNjwOdr3KzA==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr18539979plt.1.1554550531215;
        Sat, 06 Apr 2019 04:35:31 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id q10sm30084743pgh.93.2019.04.06.04.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 03/33] packfile.c: add repo_approximate_object_count()
Date:   Sat,  6 Apr 2019 18:34:23 +0700
Message-Id: <20190406113453.5149-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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

