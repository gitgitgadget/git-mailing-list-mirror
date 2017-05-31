Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593D81FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdEaVpP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:15 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34429 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdEaVpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id 9so18586601pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BRzYlf9ziLltung7EHwsLmd9WtLAM35XQUVz/JC+Pys=;
        b=s5SD/Hx8MKE1IKoKxvOZg/Nn9lDK85/X799yjtfWtY7g9zYtW2oLAvhFIQ6dlsyjPh
         lBasWBxFf6+7WqpJKwb8Z2kzPYjD736anHk+SbQLPUq7fHL9zg3lwpVlce6uwIM/I3L0
         ZkfKHSv1BFPx4ckJMP9xEyzjNXu2zhN5AEqwdchCj9SXTicYigS4UPXJcX5KsKFxrdBM
         +FbDCk7kWQC260z44CTQGaSQni2dRY/V0YfS0hI8NxKZimvq3WGHxQ70vzg0vzdelDt6
         8n/m2Bn6ZIamRZkuzekXZIlddyTG8L9StS+XeNaI0WIKuqR22hMYuXH2I42SIHFHReF5
         ajpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BRzYlf9ziLltung7EHwsLmd9WtLAM35XQUVz/JC+Pys=;
        b=m4XbAo4rkQqXphvrJTMKYAzKQHqXF0SErgNG/KijGiEOJsXK0kBmYcZIOf3yIBeb8C
         EgAaG3ylS4hvLtaZBP5BJAe1LjuK7STbCUyIe0GSax9Tj3KBhD5NOB1GxlExPX+HuEpN
         2lXRvflbTtFCohCXpU7072Qa9z6NVWNfqfp0GyHqGA+LRRtH/Z5AutLo1mLRqEyKuJFX
         XDNOvWVTSwxtuZEBlFkTiMYH/BxNCuqlEjiMjlIWRctngVLqecCfmqZSnIsClZXtT8vn
         wFfCAkSJ+mbAXT7X0SQUYFOq8n8JkO3SpLWpBEqAqsx7CBpnyUT6ZIon1u0EaApPUDeH
         lJiA==
X-Gm-Message-State: AODbwcApN7SuWTm2DEG2BqdJ+mKSsI7uG9mv8J5aJZFiRkUbZuqHNson
        7ZPEGBl1EyNN2Pj7wudwEw==
X-Received: by 10.98.131.134 with SMTP id h128mr32974231pfe.0.1496267108150;
        Wed, 31 May 2017 14:45:08 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:07 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 22/31] ls-files: convert write_eolinfo to take an index
Date:   Wed, 31 May 2017 14:44:08 -0700
Message-Id: <20170531214417.38857-23-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a5ceeb052..c37e9de11 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -54,17 +54,16 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_eolinfo(const struct cache_entry *ce, const char *path)
+static void write_eolinfo(const struct index_state *istate,
+			  const struct cache_entry *ce, const char *path)
 {
-	if (!show_eol)
-		return;
-	else {
+	if (show_eol) {
 		struct stat st;
 		const char *i_txt = "";
 		const char *w_txt = "";
 		const char *a_txt = get_convert_attr_ascii(path);
 		if (ce && S_ISREG(ce->ce_mode))
-			i_txt = get_cached_convert_stats_ascii(&the_index,
+			i_txt = get_cached_convert_stats_ascii(istate,
 							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
@@ -106,7 +105,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_eolinfo(NULL, ent->name);
+	write_eolinfo(NULL, NULL, ent->name);
 	write_name(ent->name);
 }
 
@@ -276,7 +275,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
 		}
-		write_eolinfo(ce, ce->name);
+		write_eolinfo(&the_index, ce, ce->name);
 		write_name(ce->name);
 		if (debug_mode) {
 			const struct stat_data *sd = &ce->ce_stat_data;
-- 
2.13.0.506.g27d5fe0cd-goog

