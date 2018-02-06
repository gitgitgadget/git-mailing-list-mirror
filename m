Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DCE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeBFAbD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:31:03 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35742 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFAbA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:00 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so192438pgs.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lnAD/BR5P1lO5+ilXvc3E+mVjRj/xqvQ222rEwfR0V0=;
        b=ml22EFp8GbgdxjXC3pVIc53UvNNKRcyzZOyjN2IHIpJ4xSwnhtA+nIO7LL6E80pQ1j
         9e2A8AAEq9LbTH/Jvi+T9viqajltuETUD90h5dTtXkduSRezMuZJ0ZPujVGF7VnjAYbu
         7nWzPE/sdFO8U/U9ikYYBlY00i86aHkjlkDQb9gpsXHn7tJus6pRVocpXw5tyG34FbdC
         CQRkhAtwNVmJjKVo0gUU4n/iEwUVUuw7f/I4QYspR84i/TZhQWaLxWmb+O1tYfH+uzIf
         DfdZHzz1mAs6BfRX7oQxkcNyDw1JXMlj+Z/0UUCkIJd1pFqq1/CxsoyvqtRFLi0EbnXN
         h+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lnAD/BR5P1lO5+ilXvc3E+mVjRj/xqvQ222rEwfR0V0=;
        b=osVhLYPPFW7emTpeHmyj58j7GjnLNN8MNOy3ADJIKTgCNxKGrQI2xXbXKkj8lLL/r2
         0uxQZX62IakM8rUC6dMqO4kd+KkFMuZZEqSkiMhJe4h6GXFImwTYqoK+wU6hHaGFUO8D
         Y5u1g6vSlzjo7qtfFLzgNg7564mfqXiUwUJUpyJ+bpwHBt21gX2ma4v6eoPKrZciZUMF
         yGG74S3Mtka1yezHeohHAtXfVDzQyEyzylBm3d+FjvR8zux7UtQoGtsJMHq2KTrV8VJI
         M4Qn7A8xad11XbqmHhe11WYQ6Fqrldk6RLomtacZX6Rn5NkIZozEd7qYHjPPM0pHV8nU
         FSwA==
X-Gm-Message-State: APf1xPAeimHsxXjZw7Kv/CarUiTTQeIA1OJDzUcmXbFSsk3QT/COuPtO
        00R8GivsnNSVc10AQwvmtY8zGPXJH7k=
X-Google-Smtp-Source: AH8x225CfMR5bmL7gXBJdUvLC0YkxrE1jeaXrmZ2rGI4eerbFJZxvtPqOV+9YetqfUsSe9ZNpkP17Q==
X-Received: by 10.98.65.13 with SMTP id o13mr547593pfa.97.1517877059108;
        Mon, 05 Feb 2018 16:30:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r3sm13734241pgf.46.2018.02.05.16.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 181/194] commit: allow lookup_commit_reference to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:36 -0800
Message-Id: <20180206001749.218943-83-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 426cbc9b55..ac65c1dbd7 100644
--- a/commit.c
+++ b/commit.c
@@ -31,9 +31,9 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
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
index 154c61f111..d2d5e66b53 100644
--- a/commit.h
+++ b/commit.h
@@ -47,9 +47,7 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
-#define lookup_commit_reference(r, o) \
-		lookup_commit_reference_##r(o)
-struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
+struct commit *lookup_commit_reference(struct repository *r,const struct object_id *oid);
 struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
-- 
2.15.1.433.g936d1b9894.dirty

