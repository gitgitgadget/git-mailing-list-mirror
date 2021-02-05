Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE6DC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E7D64EEF
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBEWAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhBEO5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67967C061797
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:26:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j21so3654730wmj.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gCmwl93zPkh0oihFNdClf2ImDoCqUwjAd7IhSneAF3s=;
        b=GKEthkGXMn7xJeHLLTlD11Yc7ofnSYRle4S4wCjmrZtUK8S7qHrO7zFOQL8GG2Ug1W
         qjjBhiOFpOBDIAuhmf4xyNCDqpw6Kdv41kUyJ35LTLGZNIjHQuQmMqMs8Q8eTQIvSrSt
         iXHNBklRA+BTJuffQsx6BPCotDAv1P0VFkrmvqjDovBs8cbT20mjoXEkWp6mw7fagc8q
         VyYPF+D6UDRDf5tRo8P8XZLaAFaiMtTWDtpcjMmjz5oTq30LhPRNJBZAjDXwag3PSnEU
         t1qCfPaXWN0xTF5urOsAxeZCR4WrpfoysC3keUBsNXM+731gter+e2axKkCWpLV2/fSn
         ovZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gCmwl93zPkh0oihFNdClf2ImDoCqUwjAd7IhSneAF3s=;
        b=Dj9FOBvAaCViSzzKDFnD3iAdRheW9ovGTZcLWzly0BCVNwJqvX+fYwj61JYI6MRc0G
         /IIwIcMFIe9woot6VNOoKgsHFuyp0zMZ8Sr7EZR4uNVupTtfM26fqRaSn1rt59UWAXcr
         O7ajgyPMewLxWwNck0f9u76SlN2K6fFZfFHDBAcDGMWzSmAT1aQ3VoFQJQwcXGRYVGIo
         KMzWvkdgAYBxKVr8x5ahJMShIEel9gV7bNmCfqDzIblAnNnQ4MK7AWdjK2HLQcHSohfp
         bar97B+JrhKp2cCtImjlaS7AfEcZjfX1+dUOB3VIzqht06KUrmiv6ynoopialhJBwlIx
         M9ew==
X-Gm-Message-State: AOAM530o0ZX6GL/xgr+4eF/iQLV/BU/3Szf0/iOvI3ouzNbu0qgYJnJZ
        w2FdkTuX//YXP2rPnD82jdc6FyHpLRU=
X-Google-Smtp-Source: ABdhPJzbwzkxXVuGINW8bDmPgxD29AiUmstSrQEGThyy//BKg782U7AYQXazLNr/TUGQoUEJpb52eQ==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr3845349wmd.40.1612536376528;
        Fri, 05 Feb 2021 06:46:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm8994805wmq.36.2021.02.05.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:46:15 -0800 (PST)
Message-Id: <99e466ef32d77f45de5c3aae5f44bea017b622cf.1612536373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
        <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:46:09 +0000
Subject: [PATCH v2 2/6] range-diff: libify the read_patches() function again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In library functions, we do want to avoid the (simple, but rather final)
`die()` calls, instead returning with a value indicating an error.

Let's do exactly that in the code introduced in b66885a30cb8
(range-diff: add section header instead of diff header, 2019-07-11) that
wants to error out if a diff header could not be parsed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 9972808fe4cf..8844359d416f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -136,9 +136,16 @@ static int read_patches(const char *range, struct string_list *list,
 			orig_len = len;
 			len = parse_git_diff_header(&root, &linenr, 0, line,
 						    len, size, &patch);
-			if (len < 0)
-				die(_("could not parse git header '%.*s'"),
-				    orig_len, line);
+			if (len < 0) {
+				error(_("could not parse git header '%.*s'"),
+				      orig_len, line);
+				free(util);
+				free(current_filename);
+				string_list_clear(list, 1);
+				strbuf_release(&buf);
+				strbuf_release(&contents);
+				return -1;
+			}
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
-- 
gitgitgadget

