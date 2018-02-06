Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A761F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBFA1i (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:27:38 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46121 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBFA1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:27:37 -0500
Received: by mail-pl0-f68.google.com with SMTP id 36so122105ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/jAYaBmFmiMrgz7TYrEiZIP9hjqpOQ/s3OLPsIqqNeE=;
        b=RcO3YToCkYChbZJRLHspRdujgbdAZ000oB3M16GW4q5FyX7M8n1KKRrQTFgE7AjUwO
         Oq3Z3UM20MaMqGMgfmvlcnC7A3cE+tBvYBWzYYxAeok8a/FhhlGpHHcGhywBhyvwBfRV
         bt1HgIhLOL4iKFndGmJqGLuN4Ew9P2h8hRSJzOb+Brv5Q7EWB3fK0B0yK1lg7bUDIi/q
         tWxYZVEMyVSY+MYz+xInnMvmMHIiYNBP+7xJ2L1+QZ7EXCIb5+E4k/duoVXNCBeLZYci
         bf9MmN4roej3wglbe06PunvqhbqFTXM0xCExNLKcgRgH0R8znhucF/Z9daCV5Z/EDhqs
         ZVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/jAYaBmFmiMrgz7TYrEiZIP9hjqpOQ/s3OLPsIqqNeE=;
        b=pUdG4kksgKwiiDsiDle1WpEqIOmYdcGzZMGjfFEz1RZmSTL4SM18CefYg0qwkTpfe8
         41e4GjWY3qLnJTHMhx+q7UFhoF1ho9ZwjcSTC9nb60hDeDnWtzTLKcF4LrppED8VR6Qh
         m0AuluqojCl/bPyLLbyDQ9W3qhAYWDWluxiJaxHB+wZPLOgQ8Q4Nu7pwmhrldLHpF66Z
         pDeEyzW7Vcq0WJGMnTlCIoj/LB0s5OSZis9F6wIDlY7dX4x1Wo/KiGbhVUk05LfU/ZqN
         1Tv78Wm98nl06i8kjRucV5S9hfnXz56Nwkwsu00uYCFfHx4CGDtRWfOstfowTp9k4nXp
         yCvA==
X-Gm-Message-State: APf1xPC2BaxOdvX0iusgBGoUuyaBWaMJVjokcy67mogjNSRCp+wK96xS
        tA3YIKhxZ+NC38+gQ56+aLg6szRj3/s=
X-Google-Smtp-Source: AH8x225DBIE7UzagGwVUdG0Ww9rY0V/hX6A7t0qL6dVAnpMATFnAnQabw0v6FAcucq+oGL+lEO54yQ==
X-Received: by 2002:a17:902:6809:: with SMTP id h9-v6mr592645plk.46.1517876856467;
        Mon, 05 Feb 2018 16:27:36 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l19sm6950117pgn.50.2018.02.05.16.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:27:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 159/194] commit: allow lookup_commit_graft to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:14 -0800
Message-Id: <20180206001749.218943-61-sbeller@google.com>
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
 commit.c | 8 ++++----
 commit.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index fcda65bee2..a9660f7401 100644
--- a/commit.c
+++ b/commit.c
@@ -210,14 +210,14 @@ static void prepare_commit_graft(struct repository *r)
 	r->parsed_objects.commit_graft_prepared = 1;
 }
 
-struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid)
+struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid)
 {
 	int pos;
-	prepare_commit_graft(the_repository);
-	pos = commit_graft_pos(the_repository, oid->hash);
+	prepare_commit_graft(r);
+	pos = commit_graft_pos(r, oid->hash);
 	if (pos < 0)
 		return NULL;
-	return the_repository->parsed_objects.grafts[pos];
+	return r->parsed_objects.grafts[pos];
 }
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
diff --git a/commit.h b/commit.h
index cdd12ad75d..b53053400d 100644
--- a/commit.h
+++ b/commit.h
@@ -181,8 +181,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
-#define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
-struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
+struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
-- 
2.15.1.433.g936d1b9894.dirty

