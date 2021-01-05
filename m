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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B7AC433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AC222D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbhAET0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbhAET0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:26:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14816C061796
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:24:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so1141320lfo.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h160zvyTCWIHZC4E07QPWvDkUCT/B3ZZvGD+ofHAQ9c=;
        b=W+6tlkpt+BqhW7vA63S06btRXdZ1PvJHj4ZCpYP6V9LrYnlb/NRE5sgIDzENQ1d4/C
         +quJomAQN5kcIKBI6q4omv6PBU8dbtLlmkV7uy0HuR0ezy4+r8/r8odGzhwxUYreGHjl
         Y2AZcklneGdlpxbRrDP/qt9jhYFOcjHt+t/EpafoQNDNy0JuiOrvVi+cmLSLX2+rY+IV
         hAO51pZAM3ltN6cJ9h+lK9AHVMNQogy1Ifgp6JJhIy8wIlya2XcNmlJX5ooKTnSQiGqz
         LCzaj8q8KOteHuzIiIpGqQwHeiqvks2C58GN7UXTvt4QsCnqVWLkpeIJ2bC/rlHkg/7e
         iTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h160zvyTCWIHZC4E07QPWvDkUCT/B3ZZvGD+ofHAQ9c=;
        b=ryUCmxT9S3sOPObrgDetHZXaX7TF1apQaLXcjSMfcOLyG04bgHWc6IommX+YcuwkJ1
         LkCMleeqIWqcjnpZbJggr/HrF5XK/yVLtnh4ZNH5y0D6Btpyd5xOXz8xZeFqQ5BtdILu
         H1beNSvn0f1oS0UbFCGlMkpB9QxbB/4p5ptEPJn1a708sc0klY+tKTiUNkdDUfjGXAI0
         mLWPMdhtbbrKSrcLrWBEbbYGyBVZRa7k9kcVzul83Ot9sUpsBXzrStb1EXND6lTLnKXd
         MNq2dfLTgYYT7kG16SB51aBaN8BWxaVF/hwZ6cgR7CRfPgJNXRQ/6DUlb2f5gNuC4iOo
         pqDQ==
X-Gm-Message-State: AOAM531tq/0LvXIrrJ6XDygax1yfHDfNSKLq3Y4CwSIAmPHQRknbPFwL
        AZSbMRnQhUn14+2h5CYzDeCVD3+SbxI=
X-Google-Smtp-Source: ABdhPJxRIiwtDqhw0flvOLpSPLw+RayFVkUEaFa4W75IoYQTQIRyfE7QcVQD+WtizG2jh2fPxJi5Iw==
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr347419lfo.170.1609874681402;
        Tue, 05 Jan 2021 11:24:41 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm9116lfc.121.2021.01.05.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:24:40 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 2/5] commit-graph: don't peek into `struct lock_file`
Date:   Tue,  5 Jan 2021 20:23:47 +0100
Message-Id: <7a91469c7c791d5faeabc601775a3b535cbfc26e.1609874026.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609874026.git.martin.agren@gmail.com>
References: <cover.1609874026.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commit, avoid peeking into the `struct
lock_file`. Use the lock file API instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 commit-graph.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 06f8dc1d89..031641014f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1694,8 +1694,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
 					       LOCK_DIE_ON_ERROR, 0444);
-		fd = lk.tempfile->fd;
-		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+		fd = get_lock_file_fd(&lk);
+		f = hashfd(fd, get_lock_file_path(&lk));
 	}
 
 	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
@@ -1833,7 +1833,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		result = rename(ctx->graph_name, final_graph_name);
 
 		for (i = 0; i < ctx->num_commit_graphs_after; i++)
-			fprintf(lk.tempfile->fp, "%s\n", ctx->commit_graph_hash_after[i]);
+			fprintf(get_lock_file_fp(&lk), "%s\n", ctx->commit_graph_hash_after[i]);
 
 		if (result) {
 			error(_("failed to rename temporary commit-graph file"));
-- 
2.30.0

