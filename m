Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DCF1F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeEOXnJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:09 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:43560 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeEOXnD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:43:03 -0400
Received: by mail-pf0-f174.google.com with SMTP id j20-v6so815163pff.10
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9wBbRoHfA/XrEqCWOM/GPay24EZUAy3MMSy5zUxySY=;
        b=JJay+AIOnSgQ3gNdxt0zFkVT6RlZwdxZZ7z9TYL7ZnCSc75JxigVNJr78cf+8aVLYG
         ymBdHtDbmEHDdHGV9TfSgLyOKlvtGSB+CIH+QwNEhAwGYfNBc9SNzQ9h8ie8ukxZ7GzP
         gbvBH6UdykisSZpcUzh51C4Vxw+DYiWR45VcwLUVJ3vwHQ4OVH3RcTGvB85CabIVWGN4
         d0l3+sD7lhhz3epD2J6b1cgfml/XFZJ8+OWQuwo70YwlvA5BWqdxSjzZbNMsgHZoB4rl
         cMsmsmXJTSFmSkiRESlLVgm6oevjjlciLSxDNGH786vZgfCFz4qRBWwkvosUR64f79A9
         nMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q9wBbRoHfA/XrEqCWOM/GPay24EZUAy3MMSy5zUxySY=;
        b=HxJyfN/WrvdPETTueEi0HLHTlw+myKVAnA4Cb/mSgZiBj/ZYmayY5uNsH98OlrP1Qy
         +/1UNjqo+q/7ND6jhcKF1DrlHn9OxFpQyYLI+dun8K7V/zTwZbxGvcL9ICg8vnRVvfsl
         IVxaMhXHvPwA13DCLofi5eRqlBVTjhK0IHahVxwmAKbZAnIk6uKKm2oji8gBNkaBoee8
         5PCzgyu0NhzexfLNQlDk/woqfuGwts1R8PDRc25EwmogOt0W0wRnKstPB1CERoY8GSZF
         rM7gE9wAVzc69rFJwm+DGK8jHt6I/BU1rahoe0SrGVc6hS4riiRNbUtLm/ja4u+Hpk4x
         NZQA==
X-Gm-Message-State: ALKqPwcba4UEeyIthd1oVShhprIPzZ9e5efd1Qd+elkqBOuPBjJRZAAX
        YRT/D42AKwrZOUU0IG+9GcePtjlNPf8=
X-Google-Smtp-Source: AB8JxZoKEnl1nYfLZqW3HfMSb1oWU5UcFPMkWhIM8arRIlSc2Safu311HUxKDOvM/qRs/62NAMGCpA==
X-Received: by 2002:a62:d044:: with SMTP id p65-v6mr17396944pfg.64.1526427782324;
        Tue, 15 May 2018 16:43:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x88-v6sm1612001pfj.126.2018.05.15.16.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:43:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/19] commit: allow prepare_commit_graft to handle arbitrary repositories
Date:   Tue, 15 May 2018 16:42:32 -0700
Message-Id: <20180515234233.143708-19-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 14 ++++++--------
 object.h |  2 ++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 24028fd257a..eef1675d692 100644
--- a/commit.c
+++ b/commit.c
@@ -196,19 +196,17 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	return 0;
 }
 
-#define prepare_commit_graft(r) prepare_commit_graft_##r()
-static void prepare_commit_graft_the_repository(void)
+static void prepare_commit_graft(struct repository *r)
 {
-	static int commit_graft_prepared;
 	char *graft_file;
 
-	if (commit_graft_prepared)
+	if (r->parsed_objects->commit_graft_prepared)
 		return;
-	graft_file = get_graft_file(the_repository);
-	read_graft_file(the_repository, graft_file);
+	graft_file = get_graft_file(r);
+	read_graft_file(r, graft_file);
 	/* make sure shallows are read */
-	is_repository_shallow(the_repository);
-	commit_graft_prepared = 1;
+	is_repository_shallow(r);
+	r->parsed_objects->commit_graft_prepared = 1;
 }
 
 struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid)
diff --git a/object.h b/object.h
index a314331acaf..4af499ab03e 100644
--- a/object.h
+++ b/object.h
@@ -20,6 +20,8 @@ struct parsed_object_pool {
 	int is_shallow;
 	struct stat_validity *shallow_stat;
 	char *alternate_shallow_file;
+
+	int commit_graft_prepared;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
-- 
2.17.0.582.gccdcbd54c44.dirty

