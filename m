Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182341F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcG2Ao1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:27 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35743 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcG2AoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:24 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so26878034pfd.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJESDCJen13JW0qQj43vwh0QbbnzKYY43yz8L8iB5Ak=;
        b=eWKXXLAWoyDc/pFhPFD8bNqCCLDUr5h1YeHWWnsjjFTUzAf1RZtKssUWCAMgFPwjIY
         gAztEXJCkn/8aFaNrOG9dp+iNw60x3DKoclM3VJhKOdOz1PMMEsRLhtKgwrgArcljuW+
         L82iGfhXkNMFfeBtLian6EUN377wP4C2rT8g7bVEOmucdJkgRsIZesd/v2SJsN2KcfeM
         nyMmcr2cLYWvwrd5Pv+2wDRfM6XrCXkmBWOBJY1tHi/6SFttOnsZFym8mMYGJaAi7PtB
         lw++pBiFa1oVtaG1ikJR9eHewKnUIpfGBjgByQnSItRrjQ4lHIn3bR5f9rsWEAbVd9SP
         wSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJESDCJen13JW0qQj43vwh0QbbnzKYY43yz8L8iB5Ak=;
        b=mvRUgpVV47Apd1o1VOvj50kBKlA2Ae7XcLLgGPesNrCoFxoodmLPtXQTX4jXbZOKKb
         8ZfePDab7jd6jCSqjzusRv/v6krtLq6k1g7GI+vEfExL2exmym8i9zJtd8MyGxzBB2T1
         1Lkw5dSxI87C37r/UsH3zaPor/SZIDm8HigS+1Uqv6jFfQGes2nJTMDQHI+RQSCHNdpL
         U2d9fmEfZPsLTlLNlIvhe9G5XbwpWXcNG2ZJ/R/WXc05baADeI13vDveLrJjnWecngIn
         GtQ4jTjazRmYgwHgvOYx4K4rq7pN13xe2dw2zeOXZtUCwd4XNrYLr38jt4InXIXG4Nwy
         p3Hg==
X-Gm-Message-State: AEkoout95LdO52J8WWUY3S+4qPVKGzaoBFo4+j+ujfdv4VscAuhj9SghOCVmSIUBSgx93Ezj
X-Received: by 10.98.66.209 with SMTP id h78mr64402467pfd.11.1469753063793;
        Thu, 28 Jul 2016 17:44:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id o2sm19906851pfg.10.2016.07.28.17.44.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:23 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/7] submodule-config: keep configured branch around
Date:	Thu, 28 Jul 2016 17:44:07 -0700
Message-Id: <20160729004409.2072-6-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The branch field will be used in a later patch by `submodule update`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 11 ++++++++++-
 submodule-config.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 077db40..ebee1e4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -59,6 +59,7 @@ static void free_one_config(struct submodule_entry *entry)
 {
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
+	free((void *) entry->config->branch);
 	free((void *) entry->config->update_strategy.command);
 	free(entry->config);
 }
@@ -199,6 +200,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->branch = NULL;
 	submodule->recommend_shallow = -1;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
@@ -358,9 +360,16 @@ static int parse_config(const char *var, const char *value, void *data)
 		if (!me->overwrite && submodule->recommend_shallow != -1)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					     "shallow");
-		else {
+		else
 			submodule->recommend_shallow =
 				git_config_bool(var, value);
+	} else if (!strcmp(item.buf, "branch")) {
+		if (!me->overwrite && submodule->branch)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "branch");
+		else {
+			free((void *)submodule->branch);
+			submodule->branch = xstrdup(value);
 		}
 	}
 
diff --git a/submodule-config.h b/submodule-config.h
index b1fdcc0..d05c542 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -15,6 +15,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	const char *branch;
 	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
-- 
2.9.2.472.g1ffb07c.dirty

