Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010BBC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F0F20B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awOlns6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKATea (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgKATeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:25 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD4DC061A4A
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:22 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id k25so12651375lji.9
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/q0OLuo3ZBkTFZsx8VHkm99h/P3ZfqkpkDWoYxEBBw=;
        b=awOlns6iNIhzwKbMNoIgEhHQ1KTMuEJoToEKjJusa7oyZgLDiif7wUcPWrkHLvV86x
         hvwoL/oOH/wuQyGkbiNG3+4dHrXa5cmVxf3SLnLzN/giS8KQhQkLAjUluJKhQvSNWwbN
         +Ri1sW7x7u2/LZUEe5CR3+T7MnhZI3WaHPZFc4TYUcPiiETvS+a+68CAJFfaiMK2Lk9z
         eCkhGG+yo6LGOqkPli0jJ/EP4WnR9NmfiBy8bgPqbRjbiMk9rZN/sD8Kky507877W7De
         LlF2HjJWETt3KHtcUq3gy+gBD4gkPETAkNCdFMyx/jwwIqEwZTwI9Nuu4Y3vASupvv/2
         Y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/q0OLuo3ZBkTFZsx8VHkm99h/P3ZfqkpkDWoYxEBBw=;
        b=QOmjo62wTTxJztGnllnrqXuLnnygX8NN7wZ87hGdRWHNIUfMgopm8/YJCN8TFfi0TM
         EYWGCiLIImdK6AzbXvlio4mXzQdvhWIJsyNJcIB/c5cFIOR1o/bLoL+RRpTF9BjjhSfN
         dZTQgoKmgY2kmgnHUGqf/KS95qFlQyWSITm1AcDD4RtF3PM3n71ctB2S8sR90thd0NNf
         hED471rxnBA5Iy52CZj5f8w9kjywZhu3sWN77pw/chx9DvVhf7gbZ7yEP11CNpPKQ6Lg
         IKOb4M7jRuXM80MvcNEuNxGBWUAR514jatHONBWTvwl4CL6h/fflxYiOWkirKlWzGD2Z
         2fHQ==
X-Gm-Message-State: AOAM532SZqMp9bGzOGoF9For2MZdnT10QCYoway/zHuinW4dNZAprMgt
        7P+++VlJXJ8d+q5soeIWZBw=
X-Google-Smtp-Source: ABdhPJxvwloq8LJBCbhg/jCX2VaHhJIbcwKEeR9o8iTwpVQeYwER+doaAfd5tNFJMQ7oUsoktNfy4w==
X-Received: by 2002:a2e:98c5:: with SMTP id s5mr5226447ljj.268.1604259261297;
        Sun, 01 Nov 2020 11:34:21 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:20 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 19/26] diff-merges: get rid of now empty diff_merges_init_revs()
Date:   Sun,  1 Nov 2020 22:33:23 +0300
Message-Id: <20201101193330.24775-20-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After getting rid of 'ignore_meres' field, the diff_merges_init_revs()
function became empty. Get rid of it.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 3 ---
 diff-merges.h | 2 --
 revision.c    | 1 -
 3 files changed, 6 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 19cdad1aa4a1..29818abcc00e 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -19,9 +19,6 @@ static void set_dense_combined(struct rev_info *revs) {
  * Public functions. They are in the order they are called.
  */
 
-void diff_merges_init_revs(struct rev_info *revs) {
-}
-
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	int argcount;
 	const char *optarg;
diff --git a/diff-merges.h b/diff-merges.h
index ae1cc8ef9410..9c69b8f3bd69 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -3,8 +3,6 @@
 
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

