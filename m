Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F781F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936050AbeFMXGu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:50 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:49304 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbeFMXGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:48 -0400
Received: by mail-ot0-f201.google.com with SMTP id h19-v6so2490424otk.16
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=WKZYiCZGkDSbL1dsLh8pBln2ZVJUaPCqnvQQMC4hRxs=;
        b=qqzpvwML7ZYzBf+HmNgp7OMFgg1wPBn3c3oqcdcyBFp6DTxmr17COPT5mymx2hhwNQ
         +BqMMkPie9YZZ9HCZelXsfJ+3GeK2d035RoKq5KUGRQfZgRsQIotT1gng0JLhfw4nVhd
         TpgMouy6szX39r/hafApFo8t3M4EOWap4L9V82tUxRx5HRFMER8fd+bPHchJC/JY1xjf
         WlTJKzE4bCwR/1IUtMKfiEztDgySuMePOq7Yky49+63YJYjhrelAwpR2BKNbUHfV5Nlf
         D7aFdUXj5BZKIfDbHpvSlsfGe6PP8dl1ZJRoabRaXbGlKOGRGCV6p544oqCG9RYUcZqS
         KmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=WKZYiCZGkDSbL1dsLh8pBln2ZVJUaPCqnvQQMC4hRxs=;
        b=smAvQp/feQDudUG4+suP6288eofSc/c31+junxYaJ4JGoH9FEHHZ55ewY4zWNxyVKq
         qnAUXeVL4wGZL5M501x2fbTTyo94Ea2WPWZy/dhJEMpEzOOk/yWLE2W8+xPdRKE7uPmk
         m6hcYjGno2f6IQSiiNyEr3yuUFtmYi0w4R0WJuT7iRNj5+om+r7E5a0tpWItncoq6pV3
         2rHary8Wh/F4w96rvhE5OAUjNiheE7iQEe4b0cju3bRPN0XsgSYVRn0313IzMm49m6yW
         YBg/5O/99s2aHmzlkEWN7C8z9kZQMvww9rNvtSChDaZVGSYzW+tDa7Mrd7DGLhai1mEd
         Rg5Q==
X-Gm-Message-State: APt69E1n8bA7GwMSRIEuGlGAV6QW+fZOq8J8mQ9BB1MqRG/yLFow+nup
        BjAwELduLYwfJHp0ydoXGKos1jbeJqcvW8W69iwvZFueB9oFdCsWIPnRzCF0nCKCt2gZzTMkgSS
        NlztvfSWUi8sy4p3vsI2BLk/dfTgvkh8cYH7xylOD/SBU+kOOh4YKLFzHi4Nl
X-Google-Smtp-Source: ADUXVKKZmWcp6dgSSHMU1AKbdAU6ApcLSRdcsqBPw4H29C4NJrz8ggmj8E/7MVk/BMRq+cvNA4EsnTMBFpB6
MIME-Version: 1.0
X-Received: by 2002:a9d:447c:: with SMTP id f57-v6mr78226otj.1.1528931207760;
 Wed, 13 Jun 2018 16:06:47 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:22 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-32-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 31/31] commit.c: allow lookup_commit_reference to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 009e1d33e08..7b60e0cb030 100644
--- a/commit.c
+++ b/commit.c
@@ -35,9 +35,9 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 	return object_as_type(r, obj, OBJ_COMMIT, quiet);
 }
 
-struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
+struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
 {
-	return lookup_commit_reference_gently(the_repository, oid, 0);
+	return lookup_commit_reference_gently(r, oid, 0);
 }
 
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
diff --git a/commit.h b/commit.h
index 717403d6431..e1eb48afde2 100644
--- a/commit.h
+++ b/commit.h
@@ -54,9 +54,8 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
-#define lookup_commit_reference(r, o) \
-		lookup_commit_reference_##r(o)
-struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
+struct commit *lookup_commit_reference(struct repository *r,
+				       const struct object_id *oid);
 struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
-- 
2.18.0.rc1.244.gcf134e6275-goog

