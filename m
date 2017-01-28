Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639FD1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdA1CDS (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:18 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35630 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdA1CC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:58 -0500
Received: by mail-pg0-f52.google.com with SMTP id 194so85530087pgd.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUQ00vbXw7xEomNWTMcIwu2Hu30POAbRcIRQz9rXCQM=;
        b=hnL/yyfiCuQUmA5pbl+ZiZW7wbu/lnF3O4M+PgxnzJpTkT4i5b6kyPJvchXzJ9QKmS
         JgOixTTNf7DvyeVgl+DjtZuPT4l5wJH3OJRbXG9w6IeKD1KZb4UN5fsHvDYH6uJr0h6G
         mvHOBiEMn3ssZq+dWqJXQ4ah+kFBvoXQogLIbABPGcdfM1OV70+dKiz2PvwDeDFyviTK
         EQB/l/8ROHsnLykrFg7wC9rwkfrXGevNFerss8sOBjsQ+rZrslJMTM/E+nP8ERux4LPV
         CAuF86O+N5mEDkQnMPvqa1zJlflFriLutX/W9qiMDYOMUBdU9HihFuLEg+clH1JGW7Tu
         ax5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xUQ00vbXw7xEomNWTMcIwu2Hu30POAbRcIRQz9rXCQM=;
        b=Fn6t+DC4s0bQSz3bPTSl5QioKKQEG/OXPTaTMh6YuNl7YSq7NTILbDu4moNHk2C4L8
         WJQs+XU+xqO9Usp7PzSWXjBEBF93N7IckQEXrk1FMPVh94dFSFjDtbe5IvCgaMagyRTz
         uEHOSPZG344jAosFpf9pGMOBL+ukVbJRKziMPmqFSbnaf3+chLr/1Xm+pX3PwS1Lm3+R
         rmaPIMB00BuwrSg4iWZbFuZqlz8yPseDOOM5pbJfYr/ng3T2ybhhK0wJjtIajIE9RxFL
         Y9sqCFMSXDDLOWLMVkADEBqisIDUzMcgAOX+K/11d71q/rDXdNUrKu2tCtpdlPArpRdz
         Ppew==
X-Gm-Message-State: AIkVDXKvN7dfTKRPi/x4GQIe5nyC3kUaAM1TFWcvuRiLxnxNvBw+c6BKrds3T834eNPnUxYw
X-Received: by 10.98.223.195 with SMTP id d64mr12287659pfl.80.1485568977639;
        Fri, 27 Jan 2017 18:02:57 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 19/27] attr: pass struct attr_check to collect_some_attrs
Date:   Fri, 27 Jan 2017 18:01:59 -0800
Message-Id: <20170128020207.179015-20-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old callchain used to take an array of attr_check_item items.
Instead pass the 'attr_check' container object to 'collect_some_attrs()'
and access the fields in the data structure directly.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/attr.c b/attr.c
index c0e7893b5..81a3c74d8 100644
--- a/attr.c
+++ b/attr.c
@@ -846,9 +846,7 @@ static int macroexpand_one(int nr, int rem)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int num,
-			       struct attr_check_item *check)
-
+static void collect_some_attrs(const char *path, struct attr_check *check)
 {
 	struct attr_stack *stk;
 	int i, pathlen, rem, dirlen;
@@ -871,17 +869,18 @@ static void collect_some_attrs(const char *path, int num,
 	prepare_attr_stack(path, dirlen);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
-	if (num && !cannot_trust_maybe_real) {
+	if (check->nr && !cannot_trust_maybe_real) {
 		rem = 0;
-		for (i = 0; i < num; i++) {
-			if (!check[i].attr->maybe_real) {
+		for (i = 0; i < check->nr; i++) {
+			const struct git_attr *a = check->items[i].attr;
+			if (!a->maybe_real) {
 				struct attr_check_item *c;
-				c = check_all_attr + check[i].attr->attr_nr;
+				c = check_all_attr + a->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
 		}
-		if (rem == num)
+		if (rem == check->nr)
 			return;
 	}
 
@@ -890,18 +889,17 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int num,
-			   struct attr_check_item *check)
+int git_check_attr(const char *path, struct attr_check *check)
 {
 	int i;
 
-	collect_some_attrs(path, num, check);
+	collect_some_attrs(path, check);
 
-	for (i = 0; i < num; i++) {
-		const char *value = check_all_attr[check[i].attr->attr_nr].value;
+	for (i = 0; i < check->nr; i++) {
+		const char *value = check_all_attr[check->items[i].attr->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		check[i].value = value;
+		check->items[i].value = value;
 	}
 
 	return 0;
@@ -912,7 +910,7 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	int i;
 
 	attr_check_reset(check);
-	collect_some_attrs(path, check->nr, check->items);
+	collect_some_attrs(path, check);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -925,11 +923,6 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	}
 }
 
-int git_check_attr(const char *path, struct attr_check *check)
-{
-	return git_check_attrs(path, check->nr, check->items);
-}
-
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
 {
 	enum git_attr_direction old = direction;
-- 
2.11.0.483.g087da7b7c-goog

