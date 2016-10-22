Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDEE220986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965077AbcJVXdZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:25 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38135 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965032AbcJVXdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:17 -0400
Received: by mail-it0-f51.google.com with SMTP id 66so74095468itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iOaZbfMCqdQxwvaSN7ejEYDnHV4kwyoj8eemjl6Bbwg=;
        b=DoQBWufHOhcBQ5DQSjr5dj+N0iKq1KoWZ+MFMbbnS+69OPD+TwZ69Rajsj3M+L2FiC
         XMvijHkveDzM1EOJI+FqjKlW8cLkYu12W9MaDors9aiL68tarGgfaOOpngVpDMJ+5q21
         ULnWBT+EybGSFupxqdhbBnK/vR5GoSYHhgit4A8NDktVgOTVDFtl2qVFOOi69qeIGp3U
         39A5c3Ic+OWSK3KjyL5Jgn7wL4o/qe+VGNnYaGtGis5Kv7bGr9VDAsYKIISfj9HyT03g
         hfiw6bQq4SDqHNrH+yU+7q3/G8G9TTauoB8sGoDHB5AxsQxQcX7aY/N/2ZjP1+gXjxFg
         aLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iOaZbfMCqdQxwvaSN7ejEYDnHV4kwyoj8eemjl6Bbwg=;
        b=SYI82NOinN7jZe2leQTBS6mKCr6rHOJJSCe/lKdCvS2ttlmBEk1yUWpRSK6C/oE+9l
         2dbO7jm4gtpptBgXI5IfmiGby1FOA0q+QZk/HjYLvX3istvpwEYrxPbp5dBkgLnEBria
         8ohqWNlD1N+O/hyt4kiNjA9X/6S/GiGUKRFygoUo7/bguZuoM6JjEE/sCKi4kpYvCk4H
         xJmBJnWLWRZZ9KbH85oyLVsn73KRo41bfGydjvP9F1U6amRvlEGdESJL0EKtV44GH68q
         DNDRbh77fSOpDo7rexC4p/iGtdzL4HV2pcZmxIZEMXV8FIzMTddfEXgcDyyjW6rZyswm
         ZUrw==
X-Gm-Message-State: ABUngvfwinHU55fzsQNa4t+i7x1kiCfsWE2rzBJ7hHsGKFDDC6CG6DfFJ1ENn/Hh6jjC2v+W
X-Received: by 10.107.133.199 with SMTP id p68mr7467927ioi.227.1477179196147;
        Sat, 22 Oct 2016 16:33:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id r67sm4577493ioi.9.2016.10.22.16.33.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 23/36] attr.c: introduce empty_attr_check_elems()
Date:   Sat, 22 Oct 2016 16:32:12 -0700
Message-Id: <20161022233225.8883-24-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

One codepath needs to just empty the git_attr_check_elem array in
the git_attr_check structure, without releasing the entire resource.
Introduce a helper to do so and rewrite git_attr_check_clear() using
it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 2d13441..9f58cc0 100644
--- a/attr.c
+++ b/attr.c
@@ -746,6 +746,14 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
 	return (void *)(check->check) != (void *)(check + 1);
 }
 
+static void empty_attr_check_elems(struct git_attr_check *check)
+{
+	if (!attr_check_is_dynamic(check))
+		die("BUG: emptying a statically initialized git_attr_check");
+	check->check_nr = 0;
+	check->finalized = 0;
+}
+
 /*
  * Collect attributes for path into the array pointed to by
  * check_all_attr.  If check is not NULL, only attributes in
@@ -912,12 +920,11 @@ struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
 
 void git_attr_check_clear(struct git_attr_check *check)
 {
+	empty_attr_check_elems(check);
 	if (!attr_check_is_dynamic(check))
 		die("BUG: clearing a statically initialized git_attr_check");
 	free(check->check);
-	check->check_nr = 0;
 	check->check_alloc = 0;
-	check->finalized = 0;
 }
 
 void git_attr_check_free(struct git_attr_check *check)
-- 
2.10.1.508.g6572022

