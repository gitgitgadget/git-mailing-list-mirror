Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9AB201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbdERXXK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:10 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35690 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754833AbdERXWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:32 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so30736843pfb.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3J4qYJA0XuAnw1ZXKYBrJD49nR9bWY3J192lpGmMzew=;
        b=SeIOtfVcMVfeuTK+/g/gx+TjcTW8QX2Y/YMg0hvfVMadmECTGc2AbOocXsflG0mzup
         vee+BYkZft+F1lQffWtx0JB7l7LURR60hDOBy68CjolOZc6umOhDNFoPNYHdkeeHBJCJ
         3V1IvCrFzwaUkZ2vOBeRJTAqp/JRGP015QxjgVAZ6xp1wzWZikdSXbfbZ2mO2wnVCmsW
         Xk/u2H82nefEdUqdRhL67IpuiTQXLQbsPGumne74WiJ7UhbebDauMe3Zfy0go24+op4o
         LrB0zDJlgEfOwz9RMQ9ff2mpf0eEz38Diie6BCxpErvD82t1dZdyczo9mK/FBzLFjUM+
         OqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3J4qYJA0XuAnw1ZXKYBrJD49nR9bWY3J192lpGmMzew=;
        b=uKxP8h6PPQt6ZQrWKppetO837TrbEcnWVRGebCkV/biNTJVptMee5Z7rwOZZpZGWCH
         +WdQvfQtYNFVFVVNExcMKhAaUQMQ9T3V51MGSKRPsEVAxQ9elM58ufgMkCQUkgE1+Ehy
         y8MIg1ZZb1WKKEh1h6/vT3innNco0ji0GIM8WJGGUhPtS6Ft77e7h33ldZqziXHgzhZC
         IYDp++9LLgyoEN+vnoExvC/SUxMqlT3sUNv1BFGMFeNzkuMu8CVN+i+Gw0mO2JououN0
         H42jTKGk+uBOuCw92bXltF/SUSBCFE7ybxcisNkAfb9WS1hXIrgYKo8WFmi14aHL3lzi
         t8Ow==
X-Gm-Message-State: AODbwcD7yCFxSoOnS6jywu3V08XrPkl+BpaWBrLoM8NjzcMwc8fn0Yrz
        mLQ1az62mELdKuWi
X-Received: by 10.98.102.208 with SMTP id s77mr7077354pfj.22.1495149746125;
        Thu, 18 May 2017 16:22:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 13/23] ls-files: convert prune_cache to take an index
Date:   Thu, 18 May 2017 16:21:24 -0700
Message-Id: <20170518232134.163059-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index de02819c6..8448b04e8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -380,30 +380,31 @@ static void show_files(struct dir_struct *dir)
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
-static void prune_cache(const char *prefix, size_t prefixlen)
+static void prune_index(struct index_state *istate,
+			const char *prefix, size_t prefixlen)
 {
 	int pos;
 	unsigned int first, last;
 
 	if (!prefix)
 		return;
-	pos = cache_name_pos(prefix, prefixlen);
+	pos = index_name_pos(istate, prefix, prefixlen);
 	if (pos < 0)
 		pos = -pos-1;
 	first = pos;
-	last = active_nr;
+	last = istate->cache_nr;
 	while (last > first) {
 		int next = (last + first) >> 1;
-		const struct cache_entry *ce = active_cache[next];
+		const struct cache_entry *ce = istate->cache[next];
 		if (!strncmp(ce->name, prefix, prefixlen)) {
 			first = next+1;
 			continue;
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
+	memmove(istate->cache, istate->cache + pos,
 		(last - pos) * sizeof(struct cache_entry *));
-	active_nr = last - pos;
+	istate->cache_nr = last - pos;
 }
 
 static int get_common_prefix_len(const char *common_prefix)
@@ -661,7 +662,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_cache(max_prefix, max_prefix_len);
+	prune_index(&the_index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
-- 
2.13.0.303.g4ebf302169-goog

