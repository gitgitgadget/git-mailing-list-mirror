Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37FE31F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEQWwv (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:51 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35132 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeEQWwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:36 -0400
Received: by mail-pf0-f174.google.com with SMTP id x9-v6so2784621pfm.2
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xqugCIfPnMY8MngeZ2JHKm8nE6hOwPdtvPxhyR0W6yA=;
        b=uEZbNVUJMmMH7j2eCJfej74OkC7DbfNVoMtTSxZeqrDKIRqAPlwFfb05lTqREKRiAF
         otOb/ne9L+Jv/2vfM861C3liVtH0rcNPzSObLg+ZyRtAB7ZJbiTnNoiJhh8CbsN6fJub
         zWhAjCMlUXfvZVS4HgWlk+BVEsDOozqZjDk1GzdpcI1uINHs4h0AKTo4nBin4pDiZYYE
         A2xAlYLkVkxxoHxOMyiDoGQgm8IVYgYs3zoUazBUWekPbVyIOYyjtWQPGnVDZbtWEwLj
         rpIF72lIWKhrxvMr1sNiO4pWZlBKaHvkLU/aBeFGw9ez3zntCHK/NPJnA79sa2++FAFT
         A8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xqugCIfPnMY8MngeZ2JHKm8nE6hOwPdtvPxhyR0W6yA=;
        b=TjOLecDBCZktvZ6fJJ08tvNMYHb/5fD15vhrgYya6FDpRriymZABsulYo8Bm+kiOEZ
         4g3mBKSWcTScC9QP8hcFQa5k42kwNMLjTTjpwBUSqHhabFyNXQpExj5PPxvu1/XGNFU1
         E8ah1cBNVsfkrVke1UEYiRn4j5Ycxyk1KuAz4cdl3EoIMxELwUk+GESn347KfW2fWFgF
         F9oY7Bql6zGIaf8WcNJMJn4KJVd+RfwS1eRl6wSjqSYOuuSsP8Qv0XdJfod8GTccOjys
         bVBYDpwkRxtf8C2XhlfbYdfd8TH5Mb5FeXSdDBT8M40hhDXnfpAzDlztzRSAtsJvfgNF
         FCHQ==
X-Gm-Message-State: ALKqPwcT3M2UCDFoiX8j6k66rToQmVEJPBq3Fy2jUA+gzqhtHwYW+v6L
        LK6xzxoM+MJb3j/GQDWhZuGKsQ==
X-Google-Smtp-Source: AB8JxZpaQpZtcc+ze+ydjIfFfW2EhrPZDVaxBjhemAKlYTPLA1UMnEkA6ieBeoYYmnjF3RNGSCpLXg==
X-Received: by 2002:a62:dc4e:: with SMTP id t75-v6mr6807441pfg.139.1526597556096;
        Thu, 17 May 2018 15:52:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e18-v6sm8868242pfi.100.2018.05.17.15.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 18/19] commit: allow prepare_commit_graft to handle arbitrary repositories
Date:   Thu, 17 May 2018 15:51:53 -0700
Message-Id: <20180517225154.9200-19-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the global variable 'commit_graft_prepared' into the object
pool and convert the function prepare_commit_graft to work
an arbitrary repositories.

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

