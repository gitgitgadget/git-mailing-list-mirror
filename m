Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EACE71F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeCWRp7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46293 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeCWRp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id j68-v6so19470215lfg.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RwQxXWtKtwDRX0TZOEmadfM6pH89Z4oGcVggrXQkkY=;
        b=KBGblQN4nWtE+d2/b027vXW4Ys/7LpvVTxu0/VWXhbxfvNj2FIjOHj23xaWzRJUI1t
         FqSUDF58X8P6O3+8+U3M6K5IGskL/ZNGBS5Idr9TZgtu4Wu0MIYGFD5oIPTfrypD1lEU
         lMoJ9fTaRQ4IbI2oQ553lQK3Ngnbjuqo3bLjNjg3h8uyLL3O7V6c+TfS9RvR54vPscHP
         Ee3JQRw0/+4iBh70yuFRZsT9CQd1q8RyeTXzOcafAGC1ugijqAJpYzN2uET0ZWPeNQIc
         9QlAoo5PzWe03Nttim25Xqv1Qw3W6N9yXZDGZqPzkycgf+SXXErUbKzu38D3pmAZmcgh
         g/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RwQxXWtKtwDRX0TZOEmadfM6pH89Z4oGcVggrXQkkY=;
        b=ky0wRrhz4u3on0kditygiQOsANK0vqPKQgvqC+ZqIih5F3H+YZqaWIZ3Xh4+KQGUv5
         uXamvHggqMAdVGuctzAt3j56gytAi98DgupKBkOkmcxc8zmzY8YL+QmitdlcH+xi1XWr
         cRjc6AwxIBzv3G7jXvmPqL5255wzn2e9FViUW7+3K06ooY9/oa0MS+HHqL8yWh13AbZY
         4NVNwyavs7SPcGJcIHKPaGEw2h5DeJlRg/aX58byoJGjEVMY5/0Jh5LfAf0BiVCC8kwm
         9RKJVsUr7TYVKMYBFhRtYjC5+YBpkRv2vp64V/v6ItERH3ZrHglNW6snozuLGNuEw6hL
         As/g==
X-Gm-Message-State: AElRT7EpPOdu031ETwxOapcI8OZrKKJGfseiNeHMeVZgboEfbrE/g3vx
        BM4uXEfERJh0X2UHVQtWIRRoMQ==
X-Google-Smtp-Source: AG47ELupKSymxEfbyPWb43mRpVNvN39l6ySgr/jWewcCzGIFpFxoK5NM54UmvUnmCXytHzz22PLIdQ==
X-Received: by 2002:a19:e202:: with SMTP id z2-v6mr11523051lfg.58.1521827156009;
        Fri, 23 Mar 2018 10:45:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/12] packfile: allow find_pack_entry to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:45:26 +0100
Message-Id: <20180323174527.30337-12-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c | 11 +++++------
 packfile.h |  3 +--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 26d5a17dfe..89bd0d47bf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1845,19 +1845,18 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
-	prepare_packed_git(the_repository);
-	if (!the_repository->objects->packed_git)
+	prepare_packed_git(r);
+	if (!r->objects->packed_git)
 		return 0;
 
-	list_for_each(pos, &the_repository->objects->packed_git_mru) {
+	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(sha1, e, p)) {
-			list_move(&p->mru,
-				  &the_repository->objects->packed_git_mru);
+			list_move(&p->mru, &r->objects->packed_git_mru);
 			return 1;
 		}
 	}
diff --git a/packfile.h b/packfile.h
index e68f790ea7..fe1a6380e6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -127,8 +127,7 @@ extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
-extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
+extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

