Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FF31F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeBFA1R (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:27:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34131 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeBFA1L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:27:11 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so189510pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1NIyc7HEgsX6jI/iLvCIL2Aul64Y1sX6LjNspZyQ7FU=;
        b=CzAwbT3nnZFx4gm0XX/WUYh2j2vKedfcQFVJftv5N72ZCU7qoRLm5pjrBy+huKgzJi
         1nK0LBkeWYcBlpwoGly1d1mxRnNctaS4pGP3z1nYruo/5oOFHsXG7jQnBVyLR+YeqAg6
         y3hu14OSS8vh8K97fVb/2Vr3JM04DXT02Fm+4M7CVRXzwbzJolifOWX8Y0QV2RbejK+E
         DCq1EMd9TWXb1RlFeuIopUxtHHwaPgD4n9B+zGBL7/hxtyMmaJdURH5Hew1L6GmGH0XO
         WXs4lPZkh/ndCK3+AQXOq/fnDfCSVKzi1ciG1/n58TxRide6LD6PxI9+53oOLEbm3yD1
         WA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1NIyc7HEgsX6jI/iLvCIL2Aul64Y1sX6LjNspZyQ7FU=;
        b=bz99UW4DkP6e3kvgPkKnngDpgtQqogStJ9NslAVp0ADkK8kzSSFq7vvFaAO+Sw16jT
         xn0zVCtp63CuIAwyPSKI/xL+Xzdbp1Uu61u51K5uc8tqfaMDWVphYIsnyRNFW+0ehIAI
         ZaxlKJulmdPZ17PmwFQ99PNw7RPGHgl72YDMYUEXwKrcHgHO7W/3c+9TYRRskNNCWbi/
         26Rx6Iydy88q8zcEKAxg8gEfahQILKcAy8Ri4Netg7xDAZaNK6y15DUosPKrYE9nMOO7
         R3eDEO14uKY2xMZg1ii2CvPnKTDfTDMaQ137YH8TgBTpDfzxYtUQID0y3jtwEBC/fVRH
         MOwA==
X-Gm-Message-State: APf1xPC90LsvPh4fjXXRWZvvjiOsMl4llkHI04189TiCzc76l/4HYzfN
        s2+cO/0hHOCIpkdWBkYN+EC+a5YUwpc=
X-Google-Smtp-Source: AH8x227X5nioLLGOP+oydxIv/cIgHnlieFJKAcKcuYyejEDFsH6VEmYF90Ghxe/ckzoxX1smmk3G7Q==
X-Received: by 10.98.207.6 with SMTP id b6mr549979pfg.187.1517876829948;
        Mon, 05 Feb 2018 16:27:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j11sm13938847pgq.86.2018.02.05.16.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:27:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 158/194] commit: allow prepare_commit_graft to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:13 -0800
Message-Id: <20180206001749.218943-60-sbeller@google.com>
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
 commit.c | 14 ++++++--------
 object.h |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 63dac3e601..fcda65bee2 100644
--- a/commit.c
+++ b/commit.c
@@ -197,19 +197,17 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	return 0;
 }
 
-#define prepare_commit_graft(r) prepare_commit_graft_##r()
-static void prepare_commit_graft_the_repository(void)
+static void prepare_commit_graft(struct repository *r)
 {
-	static int commit_graft_prepared;
 	char *graft_file;
 
-	if (commit_graft_prepared)
+	if (r->parsed_objects.commit_graft_prepared)
 		return;
-	graft_file = get_graft_file(the_repository);
-	read_graft_file(the_repository, graft_file);
+	graft_file = get_graft_file(r);
+	read_graft_file(r, graft_file);
 	/* make sure shallows are read */
-	is_repository_shallow(the_repository);
-	commit_graft_prepared = 1;
+	is_repository_shallow(r);
+	r->parsed_objects.commit_graft_prepared = 1;
 }
 
 struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid)
diff --git a/object.h b/object.h
index 369295c7c1..14e0d412bb 100644
--- a/object.h
+++ b/object.h
@@ -11,6 +11,8 @@ struct object_parser {
 	struct commit_graft **grafts;
 	int grafts_alloc, grafts_nr;
 
+	int commit_graft_prepared;
+
 	int is_shallow;
 	struct stat_validity *shallow_stat;
 	char *alternate_shallow_file;
@@ -32,6 +34,7 @@ extern struct alloc_state the_repository_tag_state;
 extern struct alloc_state the_repository_object_state;
 #define OBJECT_PARSER_INIT { NULL, 0, 0, &the_repository_buffer_slab, \
 	NULL, 0, 0, \
+	0, \
 	-1, &the_repository_shallow_stat, NULL, \
 	&the_repository_blob_state, \
 	&the_repository_tree_state, \
-- 
2.15.1.433.g936d1b9894.dirty

