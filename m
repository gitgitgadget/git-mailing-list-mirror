Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C291F20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdFLWOr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:47 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34589 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbdFLWOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:40 -0400
Received: by mail-pf0-f177.google.com with SMTP id 15so29711358pfc.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qn9rOWZB1XNjwZ4P2mcH9KNY+vDovVQ5sTxdqINHzmE=;
        b=GUnluOTKqcWfG/STBuTl/h3VsrC+m0ZIw8GVO4WlB6Pjm23FX7vukxGgSHRo1haNEE
         c6XwV/npiBXqQ78GakkJPmjMpC+KIcS1G7ymyo//7bdesZqe5NkTUUVlnAiRPpE/Vg6I
         fjGLAUBSSDRT+IsCrMYP/nycLukeEOQe2yFRwspGt/HFoKuu6FCqX/9TwCP/5OeN9VIy
         vSV4+D4IH6OYMjmpeDquQivHGylVqEf9MN04gmwTx6hN4f7ls8kIvw20eOg4N/0Ez4i8
         E+CD/6Evm3nEpp57TeCiHyL2IC1jRqPAVk3/OS73TYt7ukfFk8nQ2LG4oPVOVAizwC+S
         ++IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qn9rOWZB1XNjwZ4P2mcH9KNY+vDovVQ5sTxdqINHzmE=;
        b=LKjVFbtgj7lZumec1OLWcq1i5n0/XuYdgha8qc19ZV2VMuVk7K28KHne4n7+XTZWwA
         g30Kv+b5iW+xkWLrk41lYRZPzHgtdxKCcpHTwBTody60jkSwcTrJZlWrwBF1e0QkaDV5
         kjTRhlRlq7rIaMs9kkfnJLXavYq4ZKfl4GTbmavSohgPcoVR5VmqQjVB0htaOePxtrk9
         DFQLbbF9E3ZXU0nF1Yt1XTEdwlUVfxdxayDh4rw2X9QPyG2judPLysTaqDcxzVl+UPIA
         h2FLe69wy0pMHwIDJaKySdQmbs6FE2SvHKCpfSzEmOA78Up+v/JZw81LRB3lSPS1vfqK
         AB4w==
X-Gm-Message-State: AKS2vOzSM/afAHv37geud7pQ9W6BZChayHKTDCAULMPeXKq/qkHrIzDQ
        n7FGEFD7+/NiO97Q4Y62/g==
X-Received: by 10.99.125.8 with SMTP id y8mr45934pgc.267.1497305678805;
        Mon, 12 Jun 2017 15:14:38 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:37 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/17] ls-files: convert prune_cache to take an index
Date:   Mon, 12 Jun 2017 15:14:04 -0700
Message-Id: <20170612221408.173876-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 762257f39..b1626b13b 100644
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
2.13.1.518.g3df882009-goog

