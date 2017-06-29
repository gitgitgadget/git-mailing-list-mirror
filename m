Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D061F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdF2WTg (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:19:36 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35444 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbdF2WTf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:19:35 -0400
Received: by mail-pg0-f46.google.com with SMTP id j186so54143333pge.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MqBPm82peRhTPNY0ulZQXEkfBodQYWLHqYH/L+hJ0LU=;
        b=OBj+iLz1sPgGMtR6fkCvk2p7dmsYRk1qux2VpluO5jB6ivzMxGrErycmmVKmFZHvFN
         jS2wdbN4V5d/BA1SuNlEpZ+XUkdQ6LhldbwVsF2md35LjxlcaYUg9x2U2p4pucawk1ZS
         5dhV4HcnOInpOSPe8VKtSI0VugKzdYRQ9So7nNM+jMH8R2O0DmEXN+dc4R3BwbF5BfrN
         dExZEev59I0LTKYVjszDGVzKF6iMeQamlgZEPTNQJVC8UBMStjjpUBpTypI11GHrW6b6
         J7UXoK0n5Da1SA30tE7iS0BnlRzwE9s6h/7HH8i4prPj/iv7Lk7cy0bpaM2Hfu/932Gp
         oo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MqBPm82peRhTPNY0ulZQXEkfBodQYWLHqYH/L+hJ0LU=;
        b=Kc6CyRMMhRlT5gJpGrKZGIfkogBLH9+Gq9XfrddNvmHGMlLZx44TirtZM1Xa0uTPVy
         Z+L+5j62sRZDl2S5UocKVrzTgkz6xpJf87/2szVv8P52a7+jPixMvIM1j2qHhNinbHE8
         mLg8Bc58hlhmsmsSCWnLW6u7VXrNmOSGkfz+MfVUJXlwH47aSByw0KlvM4KzGk4FMs9K
         JYceWXvMfCsa3tXYDh6f4PD90aa6tyal8+iz1FZ0OpOm6DAaSSoi6rsns31qg85E222e
         5AfLiATyk37xaiTR6rKAA9iE0EHhuUJW2rqNEq4TobNu20be3i4jVK4gAz6KRdsBeB48
         FWGg==
X-Gm-Message-State: AKS2vOxqYFD++Cx1fzm7YEmKI2fELiwnexSaQkatnqFchQZT6T0VlZo9
        l472mLpwWwqUvdvHbftyNA==
X-Received: by 10.84.225.4 with SMTP id t4mr21010218plj.274.1498774775002;
        Thu, 29 Jun 2017 15:19:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:18c6:2a3:5614:1523])
        by smtp.gmail.com with ESMTPSA id e124sm10554102pgc.17.2017.06.29.15.19.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 15:19:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] merge-recursive: use DIFF_XDL_SET macro
Date:   Thu, 29 Jun 2017 15:19:32 -0700
Message-Id: <20170629221932.3773-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of implementing this on our own, just use a convenience macro.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 59e5ee41a8..1494ffdb82 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2210,11 +2210,11 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->xdl_opts |= value;
 	}
 	else if (!strcmp(s, "ignore-space-change"))
-		o->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+		DIFF_XDL_SET(o, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(s, "ignore-all-space"))
-		o->xdl_opts |= XDF_IGNORE_WHITESPACE;
+		DIFF_XDL_SET(o, IGNORE_WHITESPACE);
 	else if (!strcmp(s, "ignore-space-at-eol"))
-		o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+		DIFF_XDL_SET(o, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(s, "renormalize"))
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
-- 
2.13.0.31.g9b732c453e

