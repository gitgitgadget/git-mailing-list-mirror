Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38395C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF75023407
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgLPSwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgLPSw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87BC0619D8
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o19so25352438lfo.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kOkP4lego7EZOuPmiRpasKtn2YczGi2a2/WA3CzwMQ=;
        b=MNnzjFIRmKX4sUVwoxh3oBE0OXUEOlABtBkz2E/H0Mp9pFtgwdIAKSUCGaczYtVamB
         TKP/yGx3TOJ1V+JM1krnMeGFD42ds6t+7xBbHE9/CaOcHgBhe4kKpA96SpkEYh3kxukV
         SkTyjtlTbE9/Zp55eXcCa9S5cUaL6CcRyKhP5DwqzTGnLChicP3+KDDsmFhklarqmfP/
         cwkYZHhoXtRNCeMxDTJn4I0YZhCyTdOBqzO6zhlrGto3YBzrINsNIEj3EP92DQIZX3EP
         C7ER+4HDJyKoy3NthvU2kpasyJtb43n66eYYfEwjPvwjqASvPT4WbABlvtfY0C5VOmOx
         8GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kOkP4lego7EZOuPmiRpasKtn2YczGi2a2/WA3CzwMQ=;
        b=fWKwzF2kUqsiZyCFmmg4QAn2h/Mm9Tg7ozWEPoC8RM4sjAiyb9CwNeODxgh2lwlJw3
         FfITcPXtRpYdkVTdu4pkLO/Vckr+cIh1cLjvAf2eaDSr/10TG2bpcYd0c2Jag38iPytP
         Kfyhv+fd8rT4SgR4LTfh6Cyc+zPgOEQ1J7bDgKry8ZBgMXydB+K8s0YcdBnh3fWmjyHO
         nLi4OENe2D7X51zm2KDfmBR/lPgv7XuKijB921SlpojUrAVBPDXYgiGwVNWf4ANqd2TG
         u+5aV8vSB71VnC0+ydbbl4A8RDn/0dB238/N5gsaOO/hrtkTRxmu99I6fkspY9TNSXap
         CsEw==
X-Gm-Message-State: AOAM530t1/Mix10S3N6T4Xfmiwiutbhs8MUhqNxeDM6heJ/XlSuuAX7u
        vsmwoaOaIXRXEWKf1ZGY15Q=
X-Google-Smtp-Source: ABdhPJz95zvM7WJaO4qGA3KRXrQ+pu36vVfejFqWBcBO8iizRAzt3qPVvMitSrxiTJrUsxwzP4U/ug==
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr14178605ljp.253.1608144653148;
        Wed, 16 Dec 2020 10:50:53 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:52 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 25/33] diff-merges: do not imply -p for new options
Date:   Wed, 16 Dec 2020 21:49:21 +0300
Message-Id: <20201216184929.3924-26-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'combined_imply_patch' field and set it only for old --cc/-c
options, then imply -p if this flag is set instead of implying -p
whenever 'combined_merge' flag is set.

We don't want new --diff-merge options to imply -p, to make it
possible to enable output of diffs for merges independently from
non-merge commits. At the same time we want to preserve behavior of
old --c/-c/-m options and their interactions with --first-parent, to
stay backward-compatible.

This patch is first step in this direction: it separates old "--cc/-c
imply -p" logic from the rest of the options.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 12 +++++++++---
 revision.h    |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 2ac25488d53e..725db2312074 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -9,6 +9,7 @@ static void suppress(struct rev_info *revs)
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
+	revs->combined_imply_patch = 0;
 }
 
 static void set_separate(struct rev_info *revs)
@@ -77,10 +78,14 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!strcmp(arg, "-m"))
 		set_m(revs);
-	else if (!strcmp(arg, "-c"))
+	else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
-	else if (!strcmp(arg, "--cc"))
+		revs->combined_imply_patch = 1;
+	}
+	else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
+		revs->combined_imply_patch = 1;
+	}
 	else if (!strcmp(arg, "--no-diff-merges"))
 		suppress(revs);
 	else if (!strcmp(arg, "--combined-all-paths"))
@@ -127,8 +132,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combine_merges) {
+	if (revs->combine_merges)
 		revs->diff = 1;
+	if (revs->combined_imply_patch) {
 		/* Turn --cc/-c into -p --cc/-c when -p was not given */
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/revision.h b/revision.h
index dcfa14454a55..bfbae526ad6e 100644
--- a/revision.h
+++ b/revision.h
@@ -197,6 +197,7 @@ struct rev_info {
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
+			combined_imply_patch:1,
 			dense_combined_merges:1,
 			first_parent_merges:1;
 
-- 
2.25.1

