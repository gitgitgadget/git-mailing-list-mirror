Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE77A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBFAbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:31:00 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34494 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFAa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:58 -0500
Received: by mail-pl0-f65.google.com with SMTP id q17so149313pll.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6v9kaq8kKI7G1cqkiMvd9Cgq3eKXOkEh0K+tvR95j0M=;
        b=kOr5a2NwWwkfqCOtWHgnP/hJ309qa/OFoB0YH73laBGXWxW6ZM76AD4ehJAJgl320a
         kiqQVTzEWV6nzvhkkeHJKvGN/B50szDBBg9LIOe6M+TDgFpWLHonpS8c3i6DPo5p9Bez
         U1bSQrTDbld6WMO6QJq36aMP8APvebCIdC9T30JpWZxxv1vBWG5utQFPlWkT6c9ucJzV
         9NVPm/5TPo3aj50HIE8/o9znzf4LKWfMynu0iMi/DQDUXc1SO7GIDoAHBJTk0DeHQ9co
         mTgQElSWqiSQvflOcirRNihbtRSg39BaBOJKrEfkjC/0Tu67PhAygo7iNIzBonBCBlBY
         v7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6v9kaq8kKI7G1cqkiMvd9Cgq3eKXOkEh0K+tvR95j0M=;
        b=KmXyC1e8D3RHQGIxryB2OpIQVGN41tywIYAAzP4ZDa6YqB3lou07cJcXItLyspXMin
         iTMZLENFcoFgypNMLnnMDkoNw5Ez1NOin3qjXLB3kBwcqUl9NiWCC2UBd15Y4Ubnpl8m
         yYnA8whXaC/OW3Ooj+sz+9wA0Ehy4lM4ZnevhL4qX3eZTk8JqBgdhXlU/WhL+56zM3or
         1ryMVtGMcN1rPKprfrKak/ewRhkbi/HXVL0WMx/8bcQhlh4JWo39fge33Ec1Q/nsDuFQ
         MdIfoDevxxjae8rH9+5WHqBDAHpSpvPB/R+ui+JL2Q0QThHHt3cz5W28JBXxdl/oDH5p
         Pr/w==
X-Gm-Message-State: APf1xPDsLr5cxxe3badJn98Kip52gpEoZkIHEOeUwlyhKXucJpba7IQW
        Filub1tbcDhK6jZ/2kr2Lh8eMTe7wQM=
X-Google-Smtp-Source: AH8x2243KuaS2TPaHaAn0Ll7igUI5Eij8VvLWswYdf3DwUO8ZL/MXSzLHBCNQtS/L1XHuXdPeMQI2g==
X-Received: by 2002:a17:902:8607:: with SMTP id f7-v6mr557021plo.273.1517877057834;
        Mon, 05 Feb 2018 16:30:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z90sm559937pfd.78.2018.02.05.16.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 180/194] commit: allow lookup_commit_reference_gently to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:35 -0800
Message-Id: <20180206001749.218943-82-sbeller@google.com>
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
 commit.c | 8 +++-----
 commit.h | 4 +---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 33f5442dc1..426cbc9b55 100644
--- a/commit.c
+++ b/commit.c
@@ -21,16 +21,14 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-struct commit *lookup_commit_reference_gently_the_repository(
+struct commit *lookup_commit_reference_gently(struct repository *r,
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(the_repository,
-				       parse_object(the_repository, oid),
+	struct object *obj = deref_tag(r, parse_object(r, oid),
 				       NULL, 0);
-
 	if (!obj)
 		return NULL;
-	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
+	return object_as_type(r, obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
diff --git a/commit.h b/commit.h
index 7fe6bb0b22..154c61f111 100644
--- a/commit.h
+++ b/commit.h
@@ -50,9 +50,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-#define lookup_commit_reference_gently(r, o, q) \
-		lookup_commit_reference_gently_##r(o, q)
-struct commit *lookup_commit_reference_gently_the_repository(
+struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
-- 
2.15.1.433.g936d1b9894.dirty

