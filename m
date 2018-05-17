Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455961F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQWwk (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:40 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:35333 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeEQWwi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:38 -0400
Received: by mail-pl0-f52.google.com with SMTP id i5-v6so3402797plt.2
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zEjQUSO0KCe/ZZrVdOjp2dd0J72fGe0UsoYi5h2U5p0=;
        b=rZLYxsh5ZYIRq7Pe4FqVxf1w0Et9nBMf039yzP9mQBqtiz0rpC5yLbHEEbXJ1uiIPj
         X6mfoogOpITbfzYaUa/mmicjlMVjl2rwm+mWiCLFiz/VHYvbek6mPTj/uTgPpfmtvorO
         CHB9xj8P2KIdLUTffNF40554RE9Hp6SjMxEWOEQH9F3jS3uqF1oHuq9+Qvaem3QlFlMx
         /QIZanubPjEtQklzAErg6Vf/qCBgrSjBVquVZ1wgnpUJcrPNvVqrbi1+Hkkvl9ctxqct
         viT76RJETUaJBHn5v0oDdqJcMxluRuy6Bnhf0Ls2uWYcz9Rlp5ic7xxuVSbLg3tiE9FU
         1OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zEjQUSO0KCe/ZZrVdOjp2dd0J72fGe0UsoYi5h2U5p0=;
        b=YAdpMi0r3WL1cnm/v5i8Xpl1NkvOJjHGJL1nNqC0SJsCM6Xuyeib+O9ZOuOg3L7aBn
         +y8N1Qbhg+BfweNNhoTuael6+YI/k5G81tNj9yspVHth2Lcn7JVsBz57YsYNtIsP6INJ
         XBD2wAI/P1ADmoXFpO2+uZb89xHXPp5CvUumH6FFUjIkMzHjySCFQutsKIAFqpKFMDpp
         sk8fp08K+nsXyfyYDSmwLnGzvT63Kb2Z9gYQwhuvkg0cCK1dlEDGFf8mItWxFKLPnvRZ
         9WvfDRX3TOF3r6Et1xc/F67CT7QEaRqW8jkrl2deTMBDZD9nIo+rckr1yI83gwjUgm1t
         StzA==
X-Gm-Message-State: ALKqPwc2vDSYTOxLN0fjjmph1aLdHxaCDDT0xSsysw/Utb59cECuI74S
        bjLcU/6nB4V9ymFD9S22iMK2mg==
X-Google-Smtp-Source: AB8JxZo4lHmz3IdGCyHqcvA5KvWnfzFmL2DDrgoRvwFlpNnhg/Cm4kuLIJD4Nz7VlFX1OBqgUDO/8Q==
X-Received: by 2002:a17:902:7443:: with SMTP id e3-v6mr6884580plt.169.1526597557536;
        Thu, 17 May 2018 15:52:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id h1-v6sm10053565pfg.135.2018.05.17.15.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 19/19] commit: allow lookup_commit_graft to handle arbitrary repositories
Date:   Thu, 17 May 2018 15:51:54 -0700
Message-Id: <20180517225154.9200-20-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
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
index eef1675d692..b01cc0c3e0c 100644
--- a/commit.c
+++ b/commit.c
@@ -209,14 +209,14 @@ static void prepare_commit_graft(struct repository *r)
 	r->parsed_objects->commit_graft_prepared = 1;
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
-	return the_repository->parsed_objects->grafts[pos];
+	return r->parsed_objects->grafts[pos];
 }
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
diff --git a/commit.h b/commit.h
index 45114a95b25..6de6f10cd04 100644
--- a/commit.h
+++ b/commit.h
@@ -175,8 +175,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
-#define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
-struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
+struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
-- 
2.17.0.582.gccdcbd54c44.dirty

