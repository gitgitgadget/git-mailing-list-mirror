Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FC01FAE2
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeB1BGg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:36 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40094 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeB1BGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:30 -0500
Received: by mail-pl0-f66.google.com with SMTP id i6-v6so496956plt.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E5QeYkxe/c8qtNQyyGJhiH538Ee63mqlDFhHmq38kRw=;
        b=bRF9nX67m+Ji47/hFJAqWN8U4q2AlEDnqgT3Ao8uVhkbMQI5k2v4+XEgLfNCzRcaF9
         39abQmskubFuE+mjy93GQAK2noVHqWSYHhVwB6V4Zkzwn0XaFsv4vNkfTBcIgd7d1WJ+
         E8nfMQWtJ6tgODMg/lxOvYrIv4o6OGoxKvmYTJJI7BSzSjGT6Itb7fgDXHmo4W1kZWgv
         DRQ9IQ4R2iAmnUpNlCnylb3cNinq7TDLEMi+GohAYZNoHPaJno/XuaHmK38ci5sUWRbw
         Xw+l92mBQzINI6M/bygLF6WXl2kGE+cUh/3MHC35/7lqQ6zzHgdxUgEgHA3KmiXBPHKD
         zSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E5QeYkxe/c8qtNQyyGJhiH538Ee63mqlDFhHmq38kRw=;
        b=ug7befdr2uCUPsBz0lT8fF2ucs9N3SZyQKQ+6+TVqUcbRThUjP03HdsblBDXJs268e
         JJi8DIm+QI2SsxfkLZYKtIn9RPeAxF4Tc+9kjssecNz3ZgqVclaeQDn2SbivyPN8BFk+
         NKXk+KiurMAGvbNzk10kBen/TWAUsBsQ5AUkQPqYT9D35d/959qNIckWPG3Ss11KtIsa
         Eb1XP+wX0L81aTehpqiO9+HS0G9SzVFEMGzChNurIGVcV5HqHUXEfj0g+Y5+aOLwFLMP
         tFr45xtfTzsWnJTbPIDp8ZqVnfGuwk6/UgIYWdDk40sN9I/AN9TYACgV5G9R40q+nH80
         XpuQ==
X-Gm-Message-State: APf1xPD7egN2/lO0FT+XumOMWyJ0f50fkeqdTslsAxgwoM4dHmsRgmwn
        JyzVh1AWSaQdiz8m7W6qjRIzA3NLM28=
X-Google-Smtp-Source: AH8x224Kd4WQWJna83y/oZzGUq3KuXwklqidckJBpLQyH8dD2/BoaNQnUPlCFJl7j5nIka1B631Nvg==
X-Received: by 2002:a17:902:b697:: with SMTP id c23-v6mr15304894pls.328.1519779989609;
        Tue, 27 Feb 2018 17:06:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l66sm475653pfc.183.2018.02.27.17.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/11] packfile: allow find_pack_entry to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:06:08 -0800
Message-Id: <20180228010608.215505-12-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 10 +++++-----
 packfile.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index e16f8252233..399c59e640f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1835,18 +1835,18 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
-	prepare_packed_git(the_repository);
-	if (!the_repository->objects.packed_git)
+	prepare_packed_git(r);
+	if (!r->objects.packed_git)
 		return 0;
 
-	list_for_each(pos, &the_repository->objects.packed_git_mru) {
+	list_for_each(pos, &r->objects.packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (fill_pack_entry(sha1, e, p)) {
-			list_move(&p->mru, &the_repository->objects.packed_git_mru);
+			list_move(&p->mru, &r->objects.packed_git_mru);
 			return 1;
 		}
 	}
diff --git a/packfile.h b/packfile.h
index feeabd6f031..6f7b9e91d66 100644
--- a/packfile.h
+++ b/packfile.h
@@ -124,8 +124,7 @@ extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
-extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
+extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
-- 
2.16.2.395.g2e18187dfd-goog

