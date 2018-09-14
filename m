Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0811F404
	for <e@80x24.org>; Fri, 14 Sep 2018 00:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeINGIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 02:08:32 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54901 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeINGIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 02:08:32 -0400
Received: by mail-ua1-f74.google.com with SMTP id l14-v6so2579398uaf.21
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=or8aEAWBIZHq8J0TD2TlhHIWogfIMG08lPBrb5j91Cw=;
        b=loTBpBHc4D1GTvtpl+lO7yy+7HTN2T5BXn31m+AtC6ce/zRg5YoNuQ/r7Is8ON6joV
         jxr9osv+WxvegtuJDgOdKNtwa6t8jTOne4qEDE3utEWGT48UCGu+YVJcTvBdY35YTd+h
         na0E9SZwsMORAz+GvXObgfqWXmvqmlzx3wmjkYSXHUtm0xpt8Mm5+vHzmSQqJqWnbh0P
         qWxuWpYQ6Lrw3LD65sYBsX4+DakkihpcSgw1Iv3x94ay8ZC+jqWkiQoFdkAsmPHgOpB8
         OFA1WtpfxEjsxg0pR50/RLeWiJcA0FlYrySfkFeZ+rVZ98c9PyfV+Agw+vhbxvtLIVJa
         kQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=or8aEAWBIZHq8J0TD2TlhHIWogfIMG08lPBrb5j91Cw=;
        b=rbg/2Fif4c00wHSJTSiAgPPBiz8WDxnOYnweOvgGc0i1GjL1MUMXMr+F5mSJ2XB+f7
         FMrZsMlDff5SDfgZJEleKQza1PFUJM59NVpo3OP8nBLCQfJs6D+Quh2kKyfp04fdoVcT
         nx3TBwq0tapv1503hlMnxnN/m+2y90AtKIN2rPe8JZ4alyNbukWpFudJKxZC3+xp4ecn
         X1s0H+b3HDKZIpMEK7dBuitxbexZbcU7wpVVXuqbvdtTGEMLBjtJ5IYR2CM3b5R6IW8m
         7uutZL+jGzAJZIi2AXBlphtu2PS6sjedajjeEkt3rs58OLKuOlvGVf9evX/NlZmdq2Mf
         P5xQ==
X-Gm-Message-State: APzg51BAw58qownHX2J7JWGqF4UiIxwx1HQ2do90bxZ9b/yEZQvnjvs8
        x8xUX+xNOD0SySW1Kq1mxpYxyfpGhhM=
X-Google-Smtp-Source: ANB0VdbxFCiIY35REUUSjGkLM+5EwlwY7xxZO5iErykU7JnLYroCRIDC7hbyWpN093905qaE0aNUaY0vtgDO
X-Received: by 2002:a67:4689:: with SMTP id a9-v6mr1759203vsg.31.1536886595976;
 Thu, 13 Sep 2018 17:56:35 -0700 (PDT)
Date:   Thu, 13 Sep 2018 17:55:26 -0700
In-Reply-To: <cover.1536885967.git.matvore@google.com>
Message-Id: <0e0e7306625e6e88b7779e900fd04acb365e2f78.1536885967.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536885967.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH v8 6/7] list-objects-filter: use BUG rather than die
From:   Matthew DeVore <matvore@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases in this file, BUG makes more sense than die. In such
cases, a we get there from a coding error rather than a user error.

'return' has been removed following some instances of BUG since BUG does
not return.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index a0ba78b20..5f8b1a002 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -102,8 +101,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -208,8 +206,7 @@ static enum list_objects_filter_result filter_sparse(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -389,7 +386,7 @@ void *list_objects_filter__init(
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
-		die("invalid list-objects filter choice: %d",
+		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
-- 
2.19.0.397.gdd90340f6a-goog

