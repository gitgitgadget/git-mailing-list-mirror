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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64976C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A7C610FA
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhEQQo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbhEQQoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF49C0AF564
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w15so7850477ljo.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7LjQ1nCHmH3DD5i6uodYrBsR+g7A7XW0vpjyrg6Y0E=;
        b=N140lRcSWigYCgQCXC/CuDs9t3ffWXB35Mrj+eyCsjRw1zD3yZ071/R3n4NRHHHnmn
         lfn3/f7gEGG5JzeOjtVavAskzOa/NoDAdSoSQjRkENNEeCKw4iKgpPJ/P+dipQPBKHOb
         TvLu8u2ur07qJhZAWzsQb4gEQOyuPFNGHrTuvs7KJ9uyrugGf/HNVqovy58x1QPJF7NU
         OGW+AFB2cmaeeuhvNpsE7Eh3ptMJuwwvQ/g5UV0Q6QtsnRuy7nA41Tx+xkqw7aan2vU3
         HkmCNQNGKxCRpX9FTPPD7vGm54GY97OCxhiCwyPHPE+GTCdz99T1gUPjlfXhfINaJsXD
         MD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7LjQ1nCHmH3DD5i6uodYrBsR+g7A7XW0vpjyrg6Y0E=;
        b=sjWRzTM+dNWd2TpUYEltHHpo0XYY/2Wy1dES0rvZhglF95mkFJj7xsrea+cjcmQbEF
         cufrlDNJQuWWHnTRQZrrw8maZwoowRWSb91WqUH9Xc4Gl/vt/tjBQiSA/QxgeDVa/G1w
         WKJWaxzrit7rp6UVr5nbcuXqw+yh4aQrJKiuWNbyQgBMj28W8AtWB/IaFZcj2D/uvmEC
         9VXZyIZfx0jXDUBSrS8LrbD9evyqXd2JfAROTmkOcsZPOLbkR4uYj191k9O67kWCPKfF
         Gj67APv5AU7AkzCFlapCDMofQ4Pw8N6u2Swo4flfk6GKY7YgUdp77dTZbKYLf+GsIhk6
         isQg==
X-Gm-Message-State: AOAM5325OBgT6gPM79gK2hlBMk960lxif/SgjqRxIHKO8NkKhYIKZcAI
        CZ2JoHUv5VawIJxKHCM9ECI=
X-Google-Smtp-Source: ABdhPJyfAnlwwQfeWZtRiuLwvCTomlj6qoX6WmJSDzQRSeWnz9S/csAftD4birxLtXUjnmdJPhgAMw==
X-Received: by 2002:a2e:80cf:: with SMTP id r15mr91099ljg.409.1621267126159;
        Mon, 17 May 2021 08:58:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 8/9] diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
Date:   Mon, 17 May 2021 18:58:17 +0300
Message-Id: <20210517155818.32224-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring change in preparation for the next commit that
will let -m imply -p.

The old name doesn't match the intention to let not only -c/-cc imply
-p, but also -m, that is not a "combined" format, so we rename the
flag accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 10 +++++-----
 revision.h    |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 9ca00cdd0cc6..d897fd8a2933 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -15,7 +15,7 @@ static void suppress(struct rev_info *revs)
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
-	revs->combined_imply_patch = 0;
+	revs->merges_imply_patch = 0;
 	revs->merges_need_diff = 0;
 }
 
@@ -109,10 +109,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		set_to_default(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
-		revs->combined_imply_patch = 1;
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
-		revs->combined_imply_patch = 1;
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -162,9 +162,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combined_imply_patch)
+	if (revs->merges_imply_patch)
 		revs->diff = 1;
-	if (revs->combined_imply_patch || revs->merges_need_diff) {
+	if (revs->merges_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
diff --git a/revision.h b/revision.h
index 93aa012f518e..17698cb51aca 100644
--- a/revision.h
+++ b/revision.h
@@ -193,10 +193,10 @@ struct rev_info {
 			/* Diff-merge flags */
 			explicit_diff_merges: 1,
 			merges_need_diff: 1,
+			merges_imply_patch:1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
-			combined_imply_patch:1,
 			dense_combined_merges:1,
 			first_parent_merges:1;
 
-- 
2.25.1

