Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655A81F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEQWxL (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:53:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41391 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeEQWwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:14 -0400
Received: by mail-pg0-f68.google.com with SMTP id w4-v6so2436624pgq.8
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z2E/+xHgBng2dmQNd3iP8lZviuFfWI9JlXzMs//8jVw=;
        b=VnBZqUABBfdAjmwU8scuBtN8wNX6P9HtVg4ohpQfmw0P/JvFHopx/SGMDCaQ97ZAhr
         CyaTiE7zwtK7qMZQNq8T/vo25dklNep4w5o1e79ZvcazBgNaOG0Do+8wGzi5LQw3Dznb
         9MI1af5UPTqEOaYDQRYIcgsAkGKQI0wF05ap/LuRt5vhovpoGk1cxhm6MQNdtZkTdCMN
         uhAT6tDICSSJy1Iu9Iv6k5EClYTqXss5MO+jKYq0ewwhPlNQ39auDTbAzCrE+0cy6VIL
         4mAqIq1hZwioXKvURQxfV4Nk8ozszUlQjnZ2053alePu3XW7LFVJCuHvdotwZbNhGHNz
         lpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z2E/+xHgBng2dmQNd3iP8lZviuFfWI9JlXzMs//8jVw=;
        b=GYWrKaCOOZAM5SrB1Xkh0fMve8q3CCgKHkBVRVJAzC3CxKbtvW7lWUMBFxInbmo2/f
         gGbfnLbfo1Pf5/ntXVzlAUTrgey0y7uHZbAQAYX8KJcsa4ONLdRe7endM6C3IQcNHSMN
         oBhzj68v9Gtp9cPU/7W+wBvDUW+oZnpOrFKBV8l7Te6TFRd9Q9hnwUW5jUSIUr7kdnCM
         MWyMiq1ANjUUjtv4IY/eeeJDIWr2AHYcLf4uOZqvI4600cZeZsDdW3ZkrcZS0M6yQJMy
         aYLFdvfArHNOdXtaIrGe4n5Nt6hBbuooWPum6Uj0Obu/7EFaFI+DywEa7cB+FdhfadPf
         eFIA==
X-Gm-Message-State: ALKqPweBRCmV5oKcwN5csDWL+ecBcJAfbP9AnOaBj/MDttEMcRilAUc5
        OELLunyQct0N4diCU1US0bF6+lU4S+w=
X-Google-Smtp-Source: AB8JxZoUXztr6ij8nC0re2CxRZ35S6f4ZIhBX6a3DzcFjTjJ2ZPxzt0aXgXd2shituuQBuw/T6TKLQ==
X-Received: by 2002:a65:438a:: with SMTP id m10-v6mr5527173pgp.315.1526597533976;
        Thu, 17 May 2018 15:52:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a65-v6sm12265069pfg.40.2018.05.17.15.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/19] commit: add repository argument to commit_graft_pos
Date:   Thu, 17 May 2018 15:51:38 -0700
Message-Id: <20180517225154.9200-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of commit_graft_pos to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index a0c9eb05c82..2cd5b8a0b96 100644
--- a/commit.c
+++ b/commit.c
@@ -104,7 +104,8 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-static int commit_graft_pos(const unsigned char *sha1)
+#define commit_graft_pos(r, s) commit_graft_pos_##r(s)
+static int commit_graft_pos_the_repository(const unsigned char *sha1)
 {
 	return sha1_pos(sha1, the_repository->parsed_objects->grafts,
 			the_repository->parsed_objects->grafts_nr,
@@ -113,7 +114,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
-	int pos = commit_graft_pos(graft->oid.hash);
+	int pos = commit_graft_pos(the_repository, graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -213,7 +214,7 @@ struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 {
 	int pos;
 	prepare_commit_graft();
-	pos = commit_graft_pos(oid->hash);
+	pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return NULL;
 	return the_repository->parsed_objects->grafts[pos];
@@ -229,7 +230,7 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 
 int unregister_shallow(const struct object_id *oid)
 {
-	int pos = commit_graft_pos(oid->hash);
+	int pos = commit_graft_pos(the_repository, oid->hash);
 	if (pos < 0)
 		return -1;
 	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
-- 
2.17.0.582.gccdcbd54c44.dirty

