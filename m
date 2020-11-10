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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A0C56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CE020809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L12i0waw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgKJXma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbgKJXm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42376C0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:27 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so118636wmd.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9tX+jisZnF8QKIRir0GzdfsvhwQEBVAh2/i2Bt96TTA=;
        b=L12i0wawcAP7jVzyUx8GwcfSMgiGxCx6/62C8jNQ2zAPnBIeL+g/psOzdei7qekpeE
         jQVKdXnI9rq7Qf7P0sZbD46RhwvwYSJMiM3ceNsW8gNUdnKmt1qkq3PJNmchL7i5HL4G
         FdrcnspWRUW0XrH2TqnYnVr1R+nHiT0P/4vrdd+Gfyf0vBwRRArxsVYxDp+nP/IBk+wV
         OZy/gikq5U/Nf+6BjtddLqtg+0MIUjoOQpMQduEddR3+gJASHwfOaVG1Err4DaQ4Anpj
         tuJ4OmtuuEgbKbhnok/HvYdwXmvl9xxvmzk0Kd5yfeSxCXORTuqsGg+dD08DCJsIefTK
         PN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9tX+jisZnF8QKIRir0GzdfsvhwQEBVAh2/i2Bt96TTA=;
        b=nsrdGagVkwQ8gXlIB/cMcuEXKrDY5NpkHCiGB3qBdHi9t8ofTjuJCoAsT29i4/D/st
         dmz5M6qc7gC/JSN7m5IYPdEDHXpowcgmdYYV++OcdFnCYBDTU8IjvrfHo70CBFdPSqwG
         tq8jDOj1JxSA43E7mJv3bMUZ7ao/bm5Zqp1Fun+gldSb4zfib83BCF2EdJPtehJOY+uY
         nHfg7YYzqReVFmrLiiVsjS0ox5zmBKYZ6qWq0sglfWhGQ8RDayVLUOXE0SLXjlSnUuz8
         K3eaEPZSo0YSrVn4fWiInSXRO0s8mz8Ck4WhwePUfNMOP5+g7FjnsFe9F7RYwk5c5Cul
         LJAg==
X-Gm-Message-State: AOAM531ijIuCvD5zQImm/i1JbpXVPNdwL1X0I/myodLZziU3ZE7XxjXZ
        qn0dYD5gfADa6qf2egkkRZmNxw/Dkf0=
X-Google-Smtp-Source: ABdhPJy66Tm/06cpmR04wIQjTcHHpRdUoV5Ho+poRRhgTr6VTOWrd3GtGJlR8HPg6vKIITrK04osnA==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr563687wme.11.1605051745934;
        Tue, 10 Nov 2020 15:42:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm266683wrt.88.2020.11.10.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:25 -0800 (PST)
Message-Id: <8df87e639562a93072b86b38da179059be05c231.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:17 +0000
Subject: [PATCH 7/9] add -i (built-in): use the same indentation as the Perl
 version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When copying the spaces used to indent non-flat lists in `git add -i`,
one space was appended by mistake. This makes the output of the built-in
version of `git add -i` inconsistent with the Perl version. Let's adjust
the built-in version to produce the same output as the Perl version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9126684348..c298a8b80f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1137,7 +1137,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	print_file_item_data.color = data.color;
 	print_file_item_data.reset = data.reset;
 
-	strbuf_addstr(&header, "      ");
+	strbuf_addstr(&header, "     ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
 	opts.list_opts.header = header.buf;
-- 
gitgitgadget

