Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B802AC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A4C22ADF
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgLUTS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUTS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:18:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BBC0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:18:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l11so26383123lfg.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuwqwrvIkTLiwqA7mgIiaCDvYQ5YzkkGaWzqOEULN8o=;
        b=ThNH97R1vek2DSgNKrPyIRzoTMdveDDCGHktRC1sO2xW8QpMoYjuhvKSWLEZE9sV4J
         NQ3P+VFbmPJJvL6EsalIIzl0I4DPIQ5POTyBA7FPRWJYRfapBsVr8z4M1DDbx19PByyh
         eKf5EDM0nJDiuyM3hu7kZm0RQsZj812sbszfO2IdPRMLa2CbBGdgzQka2Bb2TLbgcmzP
         cW76hnvfBnP7hIBMZDsKf5YOPyhG9uDLKz10c8rAGSBEDhIVlgwRIhGmEZJFO5Ujc/89
         KgSiW6VC8vEKudv+mIR73CdD45kFPsW55tkw4XtRscCwPvs5g+hRY6RxBqjrPnPFzdsz
         KtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuwqwrvIkTLiwqA7mgIiaCDvYQ5YzkkGaWzqOEULN8o=;
        b=JXBuRdslHI1ivLM502cJN93SlaxummTBjfwPSR3x9drBuBJWu3qga/4q2Hw7so4+UC
         Yoso6+OXFPNMguCREu+Yam8YzQKh7P5FVPttkMCeIqxb7wHZrAcjoUo/TYYC58vZh5ZU
         o1dfLOvZ0fEOPjL8G5WNyfMTdNGnZ77k8fAA3Ws0P//Bu7ObdSLMg7Qy9GvOLR6LtNvm
         aN+h5gMmwBdgSurCDNf7GvpyhCk82TW6EeQRSz3nnDa9mRdwOLSqZpt48ZKOQgA9f9qT
         +wNtvIpgVm2ISOVizYeyFN0v1xKWb4D5EYQVFBt3LbJYb/ng+f/8n4aUdShqkb+G0HFw
         0I7A==
X-Gm-Message-State: AOAM530yqTIpVzm5aACQmkAS1DG+31swiIe+o2lkqcIzC3DmRsUdZrQ6
        /4Ld/LjYRGXMnJCexx9/WoOghXIRcZA=
X-Google-Smtp-Source: ABdhPJwrdw2Suf7J9krDPGa6zWOGRFhcip2O3uKobqulxZDa1rg19fVqye6nokYdTbvuoV9glpjyDw==
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr7819028ljc.324.1608564045044;
        Mon, 21 Dec 2020 07:20:45 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:44 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 10/32] diff-merges: new function diff_merges_suppress()
Date:   Mon, 21 Dec 2020 18:19:38 +0300
Message-Id: <20201221152000.13134-11-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function sets all the relevant flags to disabled state, so that
no code that checks only one of them get it wrong.

Then we call this new function everywhere where diff merges output
suppression is needed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/merge.c |  3 ++-
 diff-merges.c   | 17 +++++++++++++++--
 diff-merges.h   |  2 ++
 fmt-merge-msg.c |  3 ++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2f7..1f7b69982b40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -14,6 +14,7 @@
 #include "lockfile.h"
 #include "run-command.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "refs.h"
 #include "refspec.h"
 #include "commit.h"
@@ -400,7 +401,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	printf(_("Squash commit -- not updating HEAD\n"));
 
 	repo_init_revisions(the_repository, &rev, NULL);
-	rev.ignore_merges = 1;
+	diff_merges_suppress(&rev);
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
 	commit->object.flags |= UNINTERESTING;
diff --git a/diff-merges.c b/diff-merges.c
index 8325ab880166..23e6cb11d1ad 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,14 @@
 
 #include "revision.h"
 
+static void suppress(struct rev_info *revs)
+{
+	revs->ignore_merges = 1;
+	revs->first_parent_merges = 0;
+	revs->combine_merges = 0;
+	revs->dense_combined_merges = 0;
+}
+
 /*
  * Public functions. They are in the order they are called.
  */
@@ -34,13 +42,13 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		revs->dense_combined_merges = 1;
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
-		revs->ignore_merges = 1;
+		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
 		revs->diff = 1;
 		revs->combined_all_paths = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
-			revs->ignore_merges = 1;
+			suppress(revs);
 		} else {
 			die(_("unknown value for --diff-merges: %s"), optarg);
 		}
@@ -50,6 +58,11 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	return argcount;
 }
 
+void diff_merges_suppress(struct rev_info *revs)
+{
+	suppress(revs);
+}
+
 void diff_merges_default_to_first_parent(struct rev_info *revs)
 {
 	if (revs->ignore_merges < 0)		/* No -m */
diff --git a/diff-merges.h b/diff-merges.h
index 243ef915c4cd..a031240576f7 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -13,6 +13,8 @@ void diff_merges_init_revs(struct rev_info *revs);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
+void diff_merges_suppress(struct rev_info *revs);
+
 void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index bd22e1ea8865..abc3403fb820 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "object-store.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "revision.h"
 #include "tag.h"
 #include "string-list.h"
@@ -668,7 +669,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		head = lookup_commit_or_die(&head_oid, "HEAD");
 		repo_init_revisions(the_repository, &rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
-		rev.ignore_merges = 1;
+		diff_merges_suppress(&rev);
 		rev.limited = 1;
 
 		strbuf_complete_line(out);
-- 
2.25.1

