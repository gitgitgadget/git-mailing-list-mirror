Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34689C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0853222B37
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgLUTTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgLUTTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:19:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C8C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:18:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so12215030wrm.11
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imDrSAsNzHV5mksQKaJIHb+0E2hP0/2Dc/6y4JoZwh0=;
        b=qR0aPY3pZq2YtJJBzf7Nhr5ZIO9z3RbUJzM9LM2DkwSnF9adXRo0z/gO/w/D6Hwp2A
         jUrtM/tm9JX0qUjJvRdMhOPDVJuRLGSSbiOhbfvh2ys5jGmYBz1nZ5gEHECtwVEeA8f2
         cs3b9+pGH5XrgzKAZbVejwSWW/1YUQLxUoLjBzh2Txtz/aDdlVECFQ2bSaUV/oA+PN7d
         x7xAzSx0sliEGelnGoQw/6hljWcrMgHLatRESOzEt6mN9fFuKHgMHAwkivWQxivWOxPb
         f6YyCpW9wJhUVYObaJIYXapyeSfbnhqLQfaYFQBVQ0EghbRYI2Oa1b1dhQnX07bE2SPI
         U6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imDrSAsNzHV5mksQKaJIHb+0E2hP0/2Dc/6y4JoZwh0=;
        b=NCVSCQPiGhtSeK3qp/fj2op/kmmv4rAAEDExXSFdnqr9S9fB1Z86dA6LTa/fTe8ZdY
         a9giVidMEPpQwgPy9K0Nm7zyjR/tvb20Sx2x3ZHaa5+zWnUZvtHkfFdDQOIeBGsD5KfD
         qYlpIYJ3Q9K7nGbFxDyxiF+aAzFyiUdRjZzC/Nn1fQlBAKesf0bemcwclUAG239mEzDd
         fd5pJP9pTlDvjtgLKCeGYp+c6n2Aru7ce+e7kdpPJocliFMdBhpdGCI1O/gl1TJyH/kF
         quX3dJLgLhDbfIJdrUwAKu7wpBd+7ljUi6Awekmk1ml4roZ0bXD7JvpymXH/kkViGBU5
         /9Nw==
X-Gm-Message-State: AOAM531AgwgFR2wCbrtRzgKyteHR2m5ynV9YYny59aXq6WpVFRDVvJjk
        1AgxrqdUKLCD1r26GCdNeFRd/HpoVGM=
X-Google-Smtp-Source: ABdhPJwWA6xO54QwpljXITgJ2crH0wbyJ12LXi2LIrCReWTWjA2akyvC9l5ipohRYZkITKDx9bVzOw==
X-Received: by 2002:a2e:b889:: with SMTP id r9mr7230187ljp.44.1608564048783;
        Mon, 21 Dec 2020 07:20:48 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:47 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 13/32] diff-merges: handle imply -p on -c/--cc logic for log.c
Date:   Mon, 21 Dec 2020 18:19:41 +0300
Message-Id: <20201221152000.13134-14-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move logic that handles implying -p on -c/--cc from
log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
belongs.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c | 4 ----
 diff-merges.c | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 63875c3aeec9..c3caf0955b2b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -723,10 +723,6 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	    rev->prune_data.nr == 1)
 		rev->diffopt.flags.follow_renames = 1;
 
-	/* Turn --cc/-c into -p --cc/-c when -p was not given */
-	if (!rev->diffopt.output_format && rev->combine_merges)
-		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
-
 	if (rev->first_parent_only)
 		diff_merges_default_to_first_parent(rev);
 }
diff --git a/diff-merges.c b/diff-merges.c
index fb591a933959..c48a65f8de64 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -102,4 +102,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->ignore_merges = 1;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
+	if (revs->combine_merges) {
+		/* Turn --cc/-c into -p --cc/-c when -p was not given */
+		if (!revs->diffopt.output_format)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	}
 }
-- 
2.25.1

