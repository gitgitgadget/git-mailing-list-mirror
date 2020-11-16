Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28DC6369E
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3121221F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZcQRcPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgKPQIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbgKPQIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:41 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF01C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so206721wmg.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/1KLgV2xLIpkunGyPrrCfBxphaLP2gFzSlc7IzvFqQk=;
        b=QZcQRcPpx1nfUheI61X6Q8m+SYmRNiZ9CUair5twlaSBdYc5VBUcjAuSZax2J1p1cV
         +v/I/BsHn61ouAjdHur9W3K4GFpvhtjmkgKH4wSbQ3KA8Zs0MbX3WFNMeSNa0I/T9tNd
         g0uKduw6nnd3XcgCQ79ZGcphpfOn3qcwfNkQlJSQTltVS007tuVUHrC4Zd3oNr+sJ+Q2
         k572o6G6YNBfjQBn76FiMEroJltfZumFtIjGZ0tITuTI4MNglGMec1aAwuSIRdRZuCkL
         zE2qTQEy4u+cYR25OLJBaoQNxhLU4x0g2nHM1Hncx1Q5krDMgbwlP27SOk2OBtXgZXIj
         rSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/1KLgV2xLIpkunGyPrrCfBxphaLP2gFzSlc7IzvFqQk=;
        b=LWZuf6kXtaxNirK2SRmpcENLc/sJNB+6zcr+7ozNm+xQzBW1TVO/WuYMl9ym5qXZBS
         8M0rBxjJviqHLWrhoABSNYdW1P4JioFI4f1f09I/1k1zxm2FCps7XAYjHgxpGG7iWeL5
         Cn0RZjIJ3iJyQeqDj481jGcGvZsrQgxWzJIm4jH3stwTSG7fP5jVfoQCuWTBXSu7KXXL
         xWfw+kHO9lTyfz3vzrpPEPFyI60spl8JK11bjCAs2MAwN/G4dVbdKTsZmTWaKjEIYT38
         vzt+dvbpEWZg7assnAU3+dR22Xj1tXbPpgsH2sQm0QB1VimlZ66p64MbIaIVzle1QnAv
         lNlQ==
X-Gm-Message-State: AOAM531uD7xCGj0A9cjJGa+lhPqYCF1K0hngMwlaoMQKkFFdmEr0YcID
        cV2h5DefYWZJRSbP0/91DZtbY65CJIE=
X-Google-Smtp-Source: ABdhPJxOVzy8GK2kRZQZXQeM96VHz9KV5FwiHE1WOqu6WTvaKRKGIB2j3TavuzSO9vyXnQYpY3zkkg==
X-Received: by 2002:a1c:2d93:: with SMTP id t141mr16272443wmt.104.1605542920222;
        Mon, 16 Nov 2020 08:08:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9sm25337197wrg.59.2020.11.16.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:39 -0800 (PST)
Message-Id: <6a68bc5511a72d25b84a243dd5d8019f81cee610.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:28 +0000
Subject: [PATCH v3 07/11] add -p (built-in): do not color the progress
 indicator separately
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version of this command colors the progress indicator and the
prompt message in one go.

Let's do the same in the built-in version so that the same upcoming test
(which will compare the output of `git add -p` against a known-good
version) will pass both for the Perl version as well as for the built-in
version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index bf89c43145..2fad92ca37 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1461,15 +1461,15 @@ static int patch_update_file(struct add_p_state *s,
 		else
 			prompt_mode_type = PROMPT_HUNK;
 
-		color_fprintf(stdout, s->s.prompt_color,
-			      "(%"PRIuMAX"/%"PRIuMAX") ",
+		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.prompt_color,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
-		color_fprintf(stdout, s->s.prompt_color,
-			      _(s->mode->prompt_mode[prompt_mode_type]),
-			      s->buf.buf);
+		printf(_(s->mode->prompt_mode[prompt_mode_type]),
+		       s->buf.buf);
+		if (*s->s.reset_color)
+			fputs(s->s.reset_color, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			break;
-- 
gitgitgadget

