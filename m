Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA8A1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeJQH3C (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:02 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37086 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id u43-v6so10873420pgn.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pbYa7JpLVrLMQojmFQC8qEWdy/zc/7hAIZnqgBLNh1Q=;
        b=BNLzbv0hWvcm39u9b/UBZ0bPLPmDyUsYKpW0z/NEtOz2DUaq1P/pHE77jMw6B+EEYL
         DS2N6swqUR6dh2K4IOtWPzgM4q5VOhVJLvxZxqD2NJsoOW0dYQq8A44CJBbXM1r5VRNS
         rLhxGFUA+oCkn6sORYfYqpyt3ESwlO20LCprFcAHvvkLuiA9cmAyMzN/XgUMDZyQxrRU
         2SRGo5nKiGpQfKVnQ8l+Q4u/+PEqRd79hFQSyQEYW+YEzCRn25wCTtb+UpKCDSXhfXox
         sABQXvpMbRwt16Nn/aYNqBCwKPjjBl8my5Lo4iKfRvkj1R7TIXEal2QLTnZCVIJkAAvM
         Y7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pbYa7JpLVrLMQojmFQC8qEWdy/zc/7hAIZnqgBLNh1Q=;
        b=ouY2Kr9paAEDq7ubkjfDZZiyKyxRcIYondKIq5uFeDIJCeObxq4O9G5beqo/X+Wmr2
         WUE7xbljW5b0sI9wjkh2+ghlRFJSIucSdM5agi+hqsVAawEWnYM6miKdgPpEqQlISGof
         K6GMoGVzS/sUd7R46NUt91A/SQO8Fa1hOwEwyTCKIYHkQobR8MDka55UKlVR855GlRTi
         k2C+ARcIunZF4o7xw3DcWhfjr6Oa+edU2J7fk0rwX6LeC0CKN7n2PY9DJEPtwDJGgO94
         +LE+oGtphdyfrF9kWDJapOdG9cSqQGK6VgdimbrUGQ0TmmLSlnoJ4WKrlGI4/ZPPGvjP
         MkqQ==
X-Gm-Message-State: ABuFfog7bMYPIfcw76UwWMbevyhBpNkhMcEUvQIHkpAwBYRQY+bNGZ07
        ZHhMNy2R1LrX8hXfMspOrC+NoMyZTYd52hURMqR5Lj90aEHAH+e9DdCf8gyYQYf3qYtAY+A7z/b
        IaIYK+Er+TDCLCjP5VKXF4uJU9pOCCzJlmKP6Qw5zBaXTqr3nWZEn781NISr7
X-Google-Smtp-Source: ACcGV62pHzv2Jy8oyVKqxYSwPSVVLmtTXRC+k8Z2F6wajiLC5XitiecA4dSaeeYazvYAB7Hy5CO8RZ/dHVsr
X-Received: by 2002:a62:fd05:: with SMTP id p5-v6mr1792111pfh.25.1539732976770;
 Tue, 16 Oct 2018 16:36:16 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:40 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 09/19] commit-reach.c: allow merge_bases_many to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 2f7ae20bd4..aacd8cdc1e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -92,7 +92,9 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	return result;
 }
 
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+static struct commit_list *merge_bases_many(struct repository *r,
+					    struct commit *one, int n,
+					    struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -107,14 +109,14 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(one))
+	if (repo_parse_commit(r, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (repo_parse_commit(r, twos[i]))
 			return NULL;
 	}
 
-	list = paint_down_to_common(the_repository, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -221,7 +223,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(one, n, twos);
+	result = merge_bases_many(the_repository, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
2.19.0

