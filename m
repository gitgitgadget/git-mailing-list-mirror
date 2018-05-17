Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7CF41F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEQWwb (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:31 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35643 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEQWw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:28 -0400
Received: by mail-pg0-f53.google.com with SMTP id 11-v6so805104pge.2
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIhWTeimfg/UXdVGamZ51Gb4pzoFc7conKzULF4Vw6U=;
        b=QaHIbgU2Oc44pi5js6NRedIdX44YtXc1l196XIQfvbNPvnKhSAykPrK2JrgPIlDos9
         8zXKda8OZXFbXSlgxFVM697DsnSw59If6hVJXHbHkt45gGwdbdM82GQ4Afi0dWQlYhAD
         eXm+1Irbnrdj5wOq5vgOccsexrp9nzYZhSmHkJEj71ggwYbuC6N/uIE4iSMVHi+dTUcG
         mYjhAFgr8ODgSh8KDca/RKZxKllFeVtAmNy25PGrvXGsln22BiB9wh6gRnSc+EM4v80v
         44y9qbfhJVjxEi6kQS8MmX8h+CGsndDES1pZRt7NEETew12QVmFoqom+ZHT60S+8eHGG
         0MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIhWTeimfg/UXdVGamZ51Gb4pzoFc7conKzULF4Vw6U=;
        b=T58qM/+SCbGESHqFu3I6ipPvX6upF7uvJDRQnH0r/PbXvnrSJyvkFajtIlDH4ULvgv
         P+NYhaEHUu70Pxn09TMfqJX5YeoHcmzwfvW4Zv/ZLrTRXyiVGsET17TeTcvGr3Le5VZr
         cqW3dN8EQ3TeV96lm1lONUkl5NhUm/IjlaaXA0EWxt8xnaY6HoY2ts7z21+d6L+ZPEBh
         b2+qJ0ByJmoEs2K3uQyDrclzE2synWFaQJ7cC8PyUbpsYtYJm8pFpBoMuSIl944seJs3
         D8N/Sa+6IC7IMdP4hMoFcISy7BImKqFG1xKOeUvHf9biJnoaqk2uoNdwp0pHF9JASj7K
         2XLQ==
X-Gm-Message-State: ALKqPwdyT3cg4GVxyO9MzyTi3VeA8oXD0NDGIllw21Szs5rnrSJAo+9k
        m7d0wzIklirFmHScywf8DbZUaCLbBu0=
X-Google-Smtp-Source: AB8JxZrYfMrIcoqgfJ79ElYdyWxH0mQKnNusY9cWjfA3JGnQj2vyhPYiK39F5UcuXPQKzzAjkCMF2A==
X-Received: by 2002:a62:49d7:: with SMTP id r84-v6mr6844470pfi.146.1526597547774;
        Thu, 17 May 2018 15:52:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1554987pge.8.2018.05.17.15.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/19] commit: convert commit_graft_pos() to handle arbitrary repositories
Date:   Thu, 17 May 2018 15:51:47 -0700
Message-Id: <20180517225154.9200-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 684eeaa2ccd..0ec3d22813a 100644
--- a/commit.c
+++ b/commit.c
@@ -104,11 +104,10 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-#define commit_graft_pos(r, s) commit_graft_pos_##r(s)
-static int commit_graft_pos_the_repository(const unsigned char *sha1)
+static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
-	return sha1_pos(sha1, the_repository->parsed_objects->grafts,
-			the_repository->parsed_objects->grafts_nr,
+	return sha1_pos(sha1, r->parsed_objects->grafts,
+			r->parsed_objects->grafts_nr,
 			commit_graft_sha1_access);
 }
 
-- 
2.17.0.582.gccdcbd54c44.dirty

