Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE5DC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjELIES (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjELIDz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:55 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9A106C7
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ab38a85a1eso1878709a34.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878628; x=1686470628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Z0cfAq0aabBm8FzgeQmq6D+BvEWRX37KEkRzg2W1M=;
        b=AWimjRy78NekLONnfVj+e8s/cAAaXTX3BqiTaoaneKjz9LLxTbFgbNLx8LvlvOjni3
         IbFoqnSZDC/RCXQeMk+VOkXIz+CZueD3Ctnp5B/fJ4XD+i6QjPGmsjzE/t3G82PHLeyk
         TkVkLt6gm6ktmRyyxbqexW7ZWivbM3r/8aHe5ij4ZPiYHOh2SVmKcXj3Rh9l/gHbOuvD
         P/WiBldM50aBXnW3svW5g5ANlgjLyED3KbThKMQSNBeL8H/mck0UWbB9zfhJQ0DQkoYU
         nm0QH4tI8ky/8cjDI1frQDzDij9YSPSF+HORI2hK+6bpGcsjblzYiUUAIXjTQ/Lr57LP
         OEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878628; x=1686470628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Z0cfAq0aabBm8FzgeQmq6D+BvEWRX37KEkRzg2W1M=;
        b=d0y+T9hjpYIGZAHVGBzb3/HPN8deVPFcegs/FpKNYQTGr6lUd6TSjxo5tWtLX7av8X
         GMoOtlf30z7k/10B32bBRnPhffJaxNNwI6eHhJbcVHcgdEq2QBL2NYC4oKXulq6hvhLB
         xcpPMtVkDpkei3KZt7R98Y/8HREseo+iwkbs5CgnqVH7hDpXhkYSbllhcchvSFDs3qxj
         1BjNonQOkEsoziBJEryo4l1+e41cUFPCvpAB9u3gjAtTan0/idIgBqBx/qv1h383mVNV
         /AecXNOfjNAOBnhvafqjHZv72Je6ZP76lFoiCVFx2zRQ8ksdfsCtb8tLyxQm5P/1zipK
         8fBw==
X-Gm-Message-State: AC+VfDwSoBrDag6wgQizy1STHEC9TeUKfPP5alWYhz6KhzTgByHiiJpU
        0JokGg6YhxSyREf6x6uX3yPdhcARk9s=
X-Google-Smtp-Source: ACHHUZ6oSvywhaiqyRxXLr75ZMYwdgKJXpgZfh+Y/i+qFAo7x5Je+giTlxBCWHUDS/d+7uNLj4Gb6A==
X-Received: by 2002:aca:1c14:0:b0:392:5882:69c7 with SMTP id c20-20020aca1c14000000b00392588269c7mr5535276oic.52.1683878628236;
        Fri, 12 May 2023 01:03:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z83-20020aca3356000000b0039466db554dsm895238oiz.18.2023.05.12.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 6/7] diff: add --silent as alias of -s
Date:   Fri, 12 May 2023 02:03:38 -0600
Message-Id: <20230512080339.2186324-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since 2e5e98a40 ([PATCH] Silent flag for show-diff, 2005-04-13) -s
meant silent.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/diff-options.txt | 1 +
 diff.c                         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ba04b8292a..a402b6f9b6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,6 +34,7 @@ ifdef::git-diff[]
 endif::git-diff[]
 
 -s::
+--silent::
 	Suppress diff output. Useful for commands like `git show` that
 	show output by default.
 endif::git-format-patch[]
diff --git a/diff.c b/diff.c
index 45c860496f..d171f155b1 100644
--- a/diff.c
+++ b/diff.c
@@ -5493,7 +5493,7 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_DEFAULT | DIFF_FORMAT_NO_OUTPUT),
-		OPT_SET_INT_F('s', NULL, &options->output_format,
+		OPT_SET_INT_F('s', "silent", &options->output_format,
 			  N_("suppress diff output"),
 			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
 		OPT_BITOP(0, "no-patch", &options->output_format,
-- 
2.40.0+fc1

