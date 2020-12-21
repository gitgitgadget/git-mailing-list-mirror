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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A42C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDB7230FC
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgLUSNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgLUSNU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:13:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B2C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:12:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ce23so14700821ejb.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBQfAvQHFoAwnp3CaECXiSS6MZvFWi5N71SL0nb3uxs=;
        b=HQZuAF7Pb9BHXAULn0A7AbXRQmGx7+HB+7JXZQF+VJFQps7XK5zlWwe19rArtyHklb
         sxoKdvDhhUzG/NuBrrC+UiqRWS69XmUgu2NkLDmgHTr1ZPsrQad7u/3HP2goL/dlR1fv
         ZIJtEJ9k/uDK4mVgTLfsuUPI0I/SIj01b1/A3RmqeqylhMWt6Hc5Bvr2tqah6wWThjWv
         URncfe3w8BbDtouR+YuEy416oC6tTPf5Op3koim/duFiRwOm3qK3MTmR7VlHrL3Bdm7r
         M1pL+bHZXF9c85yne1LMOKGlsMgzGLywHqDdZfJXgrUOsr+ssCTRXqrmNEX60MeFI+06
         Lp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBQfAvQHFoAwnp3CaECXiSS6MZvFWi5N71SL0nb3uxs=;
        b=LzdKUD1uj+zPvzfnffL9Nlz0v9tDnltVhXM9JFCO75OZidpjrkx3Q5ug33R58Dn/4Q
         MYueCW63NxUsCpsdPbEet9wDYXjLPALvf3Oq9GxDsdBv+hJYKYylX/b8ne/c38PtxZFA
         NJWPSJP+Ed3UWlA40ZfY5dEMWKZXCSDAeetQ1FOpHrxpCJNOsnoDRfRqzUp2xGlszkui
         TGSKaOzi5vZeD+q3mp7kXTF84xQvfzmcWfCLOEwrLy4042Tz+XW2Q07sxPeJ9e0RzS0y
         deGv+LHa7j8LIeorKY9HRY8QJLAE5hfvnABpxRSrYjVThtvvMbiIg+RZMSUIifmqtGDq
         gE1Q==
X-Gm-Message-State: AOAM5324iGN6ZHZ2g/Ojw8WmdaMeStWQSGlfFoZQp+eblg92sL+tueV2
        fUJe3vcSJKP4fJ95gFQ51Op7jBpzflU=
X-Google-Smtp-Source: ABdhPJwcE0jkThJP//opD6am1NEITIKY7CQ9Z5Kkr+XJPH7ert6Ladrh9ALaFfJUY3ixYOSHkoBCpw==
X-Received: by 2002:a19:4813:: with SMTP id v19mr7165221lfa.655.1608564056348;
        Mon, 21 Dec 2020 07:20:56 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:55 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 20/32] diff-merges: get rid of now empty diff_merges_init_revs()
Date:   Mon, 21 Dec 2020 18:19:48 +0300
Message-Id: <20201221152000.13134-21-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After getting rid of 'ignore_merges' field, the diff_merges_init_revs()
function became empty. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 4 ----
 diff-merges.h | 2 --
 revision.c    | 1 -
 3 files changed, 7 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index eff54cca8287..34d7ed7c70b7 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -21,10 +21,6 @@ static void set_dense_combined(struct rev_info *revs)
  * Public functions. They are in the order they are called.
  */
 
-void diff_merges_init_revs(struct rev_info *revs)
-{
-}
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
diff --git a/diff-merges.h b/diff-merges.h
index f92de137d3a0..659467c99a4f 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -9,8 +9,6 @@
 
 struct rev_info;
 
-void diff_merges_init_revs(struct rev_info *revs);
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
diff --git a/revision.c b/revision.c
index 5a0e3d6ad542..46645ca0b6df 100644
--- a/revision.c
+++ b/revision.c
@@ -1814,7 +1814,6 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	diff_merges_init_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
-- 
2.25.1

