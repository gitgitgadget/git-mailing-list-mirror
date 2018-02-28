Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562111F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeB1BGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:30 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46810 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeB1BG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:26 -0500
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so486308pll.13
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zDyn3ZzSWH1YsgSqat0/Klp9X2+Mh4DstMKpLEwPD+w=;
        b=rEmfZlWAnLoTp23tBo98OojJeThROY4mu6IyZrkEv7av2zdvyYug2jcKJGND+0PTd4
         8zRoo4BnA0nnWDkvCqH9kNvFXybCQmxost/53KkGB4/LId+yhTxE7AHgwsbj+DT3Yj6t
         lqYRc+NiiusikD8uARofJkngVrzR1c2Q/+zeA1cOpPU/hQCRKjN/tUnlv0vkP2ToQnKZ
         5FHQ9j9OjMvNe7ASGIlM6SsiGYpAeagbAqcH012L9IGXH6XUbfLf79vbO5OlSWk0k22o
         pBRgZbJblWn1RurNafjHYHufHm2H27zBn14KNcM/+UqPgfm0Hspp7qI7ay/qNtnJb6ji
         /evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zDyn3ZzSWH1YsgSqat0/Klp9X2+Mh4DstMKpLEwPD+w=;
        b=MvIXqDYYtwP+B2CV6FfP/SZljOht+vfmiT8D/wZtJytglnJ54JQP1lU0DF+kk9VSm1
         f+DU6O6a1B5jDr9amIeXcPzesIWaHmbQH/lC4+OTMThllbvKANR7qZa0yigm1qQpsb9T
         0G2R836AJkYaXkLyHu5MRYRa4RND5sv1DE6e7t9QNH0R903DFPqhzHMfKo2aCeuNin/f
         Fa8SQII/qZ9btvgNmcFGUNtOsR/pSSBryDYSu7zKSj5kUJsaWeWEM3xCmiIofJA96cG/
         cYibCLgpj9cF91L5VbWhtBVqxfrgufwoza393v2A0FYukXL1Cmqwi3PN1feuDqKAaFX1
         L8yg==
X-Gm-Message-State: APf1xPAynKj1EWia95fyOw2nyVwvVRQMtX0pqCR0nRP494FVFSRL3rtK
        ja0IRlGRLIgAxHh98zGzh0hkpB0K+Yo=
X-Google-Smtp-Source: AH8x225Pil6A2S1eHhxZlcadyvhLY8wDJBBtk1Pm/syrP+3i+fi+plRs+Y3j2gVdLOdUqCI6N585ZQ==
X-Received: by 2002:a17:902:b109:: with SMTP id q9-v6mr16354528plr.340.1519779985251;
        Tue, 27 Feb 2018 17:06:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v1sm505019pfg.33.2018.02.27.17.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/11] packfile: allow prepare_packed_git to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:06:05 -0800
Message-Id: <20180228010608.215505-9-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 18 +++++++++---------
 packfile.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index c45516acd41..9a3efc01555 100644
--- a/packfile.c
+++ b/packfile.c
@@ -883,19 +883,19 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
-void prepare_packed_git_the_repository(void)
+void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
-	if (the_repository->objects.packed_git_initialized)
+	if (r->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(the_repository, get_object_directory(), 1);
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru(the_repository);
-	the_repository->objects.packed_git_initialized = 1;
+	prepare_packed_git_one(r, get_object_directory(), 1);
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(r, alt->path, 0);
+	rearrange_packed_git(r);
+	prepare_packed_git_mru(r);
+	r->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git_the_repository(void)
diff --git a/packfile.h b/packfile.h
index 9afbf73657e..9142866c8ae 100644
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
2.16.2.395.g2e18187dfd-goog

