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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCC0C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FE923A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgLHA2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgLHA2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:19 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E553EC0611CD
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:10 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id f8so3663598oou.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIiIvKGrRC9ZgYiQSc1H/0su0AeBYRauG0YEoj/P8M8=;
        b=vK5YCgR1qhFwfveeactIR8dG8xDJbC+/JWEfM6H3p/qeVOY3OcFVixZqpYQvXvw3q1
         x85fRzCEvXVrhZSYYCLdOeyNnC35ELAxjYQPgXokZm5Te6vcZwY8WXTlTfqpm/jwfzTe
         zZCI5DkPttNhdgLhezCUIODj22cwCZOQJZioSPQV32rETREvPrPEFSGaugh/d+1GN5pb
         9RHbSdYyaLKv9wnFvoPmxT6n15HuFj6K9G5Ed92+TysG9RG7J9GeFh+7Se1BIohUEn1z
         SdFzLiRcAfcU0+qGA6/4Ng974Czp2ckcPtvy18S4L1oBR0RYstWmtG7aYfSI4tXm3Fxl
         JlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIiIvKGrRC9ZgYiQSc1H/0su0AeBYRauG0YEoj/P8M8=;
        b=YaP2dSYqiMd9jUO9KY5XwbJSXRYLUGR6raJUS5M80JjOCsu+BpTMqcsfkuo034sud9
         nhkyU+eMIGL5FzdqIwJYHDEpJa42V0K3pinsqKsOSJLK/Bdf47nJoC56IS9Qz44ZJJ4V
         sQjQc5FfRphYenrq8V44JhX5/82EcihHvKBvSnJoELE6aXkmp3K3c2HbjpzOwfqzvNmy
         y6bD5R22FhYnYnZEfk04dz9RFrqhdsJECcuAVAYHtYl9xmqcAaeptqpz1PijyCXgnk5K
         iAlIJ17hfTbangffKGf1a0FUrrVjv4sYHQ6xakjqyALZ9xh5XPmosggeIOW458mRSoZv
         Ri4w==
X-Gm-Message-State: AOAM533yy+xhKXDgC3WM1FmF6eivlP0fOQR89H8NlZ/rs9PG9mX6ONov
        YoNFFIktR1bFm/MVc3sXHf8jcFg1ML553qrZ
X-Google-Smtp-Source: ABdhPJzLX9rnhNO6PjGsC9+Tux2fb0ZiLvR8PBLpffMfqc4YLfUs76xo3j82xS37ZduZqp3E7qd/+w==
X-Received: by 2002:a4a:6152:: with SMTP id u18mr14319505ooe.7.1607387230139;
        Mon, 07 Dec 2020 16:27:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v5sm2973158oob.40.2020.12.07.16.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:09 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 12/19] pull: move configurations fetches
Date:   Mon,  7 Dec 2020 18:26:41 -0600
Message-Id: <20201208002648.1370414-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have FETCH_DEFAULT we can fetch the configuration before
parsing the argument options.

The options will override the configuration, and if they don't;
opt_rebase will remain being FETCH_DEFAULT.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 350df6f3c5..addb454e63 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -933,6 +933,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int can_ff;
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -949,12 +952,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
-		opt_ff = xstrdup_or_null(config_get_ff());
-
-	if (!opt_rebase)
-		opt_rebase = config_get_rebase();
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-- 
2.29.2

