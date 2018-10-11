Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05141F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJLErH (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:07 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:38067 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:07 -0400
Received: by mail-oi1-f201.google.com with SMTP id j186-v6so6977084oih.5
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LpMC4FYyUEce8MrzoPqSOFz2HJiapPWB+LYSLNRAk58=;
        b=fi4UJVIfp1m38x8QW8UpuHfIf9FkkclZimiQYfZ4MIaO2jWWXrwaWFHadDsStxqing
         V8cc8Ki8q7EYvhwIADp3CyNJ543tnkbuk9XWt9VAjYJ9M3jL63WtC8ItbhhiQrBvBsnp
         3wbVewVs5XnBF6uXaOUAuqKtusCLzJgLEA1AbkKWYITUTQqfFWtI1tZwxuUlkeRPes8V
         7K2ClrWO6tkhe8oEiH2Ce5eXz0wDIu0JPrdfkCAbTv6bPNg9xM0fj4mfolDLu6AicKBq
         Rkx+rQ4nylj05tRqkosAnt9MtrG8t6Wb0U0x27CDBi5RJubio43WJIyiVwYFS1BMQ/Tc
         ngtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LpMC4FYyUEce8MrzoPqSOFz2HJiapPWB+LYSLNRAk58=;
        b=YbmkZ3hwSpO15tGb4hybMipmcG2lj/znXydftqbqe520trg5TgJM+O5uTXjLlehtA4
         whaOrMVARiik729u0KwLMSzrq34WygVgSy4h4FNMIWOhF9w2WaKxWxwcjBzgA0+UFXo1
         N7kMniNAPrDjIRE6k494xkJyqgpcmNpNn7zSTiaoGZ95RiBEMZLPvqjROWNb+AX9cfR3
         HXUAcFFO12m6SvTKOuXp4bLVGY6NkV7RjC2qOr+vVS5Olt2n+yvrIbAbCDI3QPZODDxA
         L67m7SffpRQCJcCGjp7tuTa9AzMxvj+SkE86GeDs9BRFKQo5EDhHWdzuZTHlgZJVOqXF
         CorA==
X-Gm-Message-State: ABuFfoj4mQvOEAxl/xXpCN1JRwOPmfAWRGYIYpvHShBx37Dw1tuXOOKU
        jrvsh6NxwFy44oIs8EHnaQtKYx2s8oBaBfPSdkbugKsd+MoEOEOp59HDYdSp3I/4cWn+nXDl4IE
        E5HCnhdH/5OMRLv8A27GGxx1rhY2+UaZWeYmJ4Wt+cE0+xX7J7uw3IRZQAcNK
X-Google-Smtp-Source: ACcGV61mGi339FXiUPiyKM3LhAY0tEnFBsM0aVnkJJNhi/EIukr3cyzs+cQjSYT00R5yxuZJI8WbdUDwZjST
X-Received: by 2002:a9d:2cae:: with SMTP id p43mr2787394otb.0.1539292682670;
 Thu, 11 Oct 2018 14:18:02 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:37 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 02/19] packfile: allow has_packed_and_bad to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

has_packed_and_bad is not widely used, so just migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c  | 5 +++--
 packfile.h  | 2 +-
 sha1-file.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index ebcb5742ec..40085fe160 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1024,12 +1024,13 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 	p->num_bad_objects++;
 }
 
-const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
+const struct packed_git *has_packed_and_bad(struct repository *r,
+					    const unsigned char *sha1)
 {
 	struct packed_git *p;
 	unsigned i;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = r->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1,
 				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
diff --git a/packfile.h b/packfile.h
index 630f35cf31..1d2d170bf8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,7 +136,7 @@ extern int packed_object_info(struct repository *r,
 			      off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+extern const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
diff --git a/sha1-file.c b/sha1-file.c
index 647068a836..13b3c5cb79 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1432,7 +1432,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(repl->hash)) != NULL)
+	if ((p = has_packed_and_bad(the_repository, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
-- 
2.19.0

