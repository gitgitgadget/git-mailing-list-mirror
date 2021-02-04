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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1CEC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E84D64F78
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhBDUPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbhBDUIj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:08:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1BC06178A
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:07:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so5078319wrx.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UzjscSMb79x/GFMISrlroGOOsjly/OZvJv1LPuYxIuA=;
        b=H3K/jHpZa2TX4kv2Qf7a01kWNqgyjWYEBVVGAzwrshI3vRU1+STBKT0nSZHWmGZJ1c
         j6pnL6E1wR3sG7jFCl+02BjIXUz2i6t+NNYlj9Sz+gwym/G6fIqcZzTwT0PSa2kH7J0G
         QsiLPZM/STs24hg4ERm+NZ/t9xZduO6kuLxhM3d8mtoAjN8vPOA0Z0cMT8UxumRlpfnM
         RX5HFerl1yeuYATf7MWUd5KeJcWLa/FWonZfEod4XXT9bosX0Q5MUYO1cXEuodm1a9o9
         Rr2IfzPMCu5wlC4NzsZkoPOL5f9MY+d0rPz2hloA/QfPOfNIc6zr9u8FD9uUjjSygxq9
         h2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UzjscSMb79x/GFMISrlroGOOsjly/OZvJv1LPuYxIuA=;
        b=i+di2iPpiekD6U1njfW4UNI2OKYaIDtQhGebP2E/Ujy2+dATlDy+MvSMNcffaI+e1l
         BNUxpg1NI8bfvBIu8d13U4u7SZ8gsUCj4ywvFoSWuL61WC5QK+r04VCKMdrOGvYCQrly
         kOEhNKpSrdiYmnjX479InE97YCRI7f0cDiE/oVtw1VKr3fgjkw+J1Z/sgotserb2dcZo
         EqwJdOYWFMAkD0SBS+o52DdETOdMr+6bnCyngmY9SnfPqUdLYvRmmQu9NWNduyu70P9E
         jMw6hkFAocS+F5IxcwD94uvpdPDdl4sgIYKLEwQwVIRaqTG/4aYqqfTXA+o+GZUzffJs
         PHdA==
X-Gm-Message-State: AOAM531EcQ6/Pa3iQAsmsGfPiaVohK1o+acICKv+z6a9uW/qnkFYBH+W
        9A2CAj5771Z1QA6zVZ6rTXx/VQxsXl8=
X-Google-Smtp-Source: ABdhPJzP+sB5DUvkefyQUGL/9v6F/qsBK9Ntq4LySYgdvq4s+gWiQJp0f0qQqUhksVnh4vwiqLNvLQ==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr1037353wrq.411.1612469277981;
        Thu, 04 Feb 2021 12:07:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 67sm7235459wmz.46.2021.02.04.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:07:57 -0800 (PST)
Message-Id: <0d25dd2a9c2d15479d098b10a85cf14144329a57.1612469275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 20:07:50 +0000
Subject: [PATCH 2/6] range-diff: libify the read_patches() function again
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
index 963cdecb4cbb..6707b728a07f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -135,9 +135,16 @@ static int read_patches(const char *range, struct string_list *list,
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

