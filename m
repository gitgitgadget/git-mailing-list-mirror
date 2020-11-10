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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A3C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92009216C4
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLc7gbJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbgKJXm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbgKJXmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:24 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF0C0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so161320wmm.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dpll76Bt0FuWoTL59TONqXQ0KGL2T+WUdIsjig1jOUg=;
        b=KLc7gbJPz1iwSFaQz0SnxVxEGIKelSPwISD3+qao2twqNXEVK4jHbm+lzeHVz9LUAJ
         QFhnUrry3D+ABl29EqrdzRlf+C6diM29K6kpt/sgWg/760Ty7CpVjDtFj5eHeeJjGOTV
         Qe9WCeHzdxc3fbbVUD7NAM8qU3lluSQEkAzbWAox8QluCHJMxOLq7AgImb09E9buNC35
         qWV362pD0sfkzF3f4ux7XnKuDRsfXzuZ+MUQMygMm5Uu6ImghAVxS9h5sMEnNXikLago
         OKr8jXeWnbVZLK2+6HxaJ4qPrAuONKUCjhP9hCZPsf+6hE3hqDJS2RXrNnkTSEHe8olt
         ZtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dpll76Bt0FuWoTL59TONqXQ0KGL2T+WUdIsjig1jOUg=;
        b=cOCX3k/oUHVndYzn9sCzkMriwQFfxRjfoJOS/E/DRIunbRz7Dx9RmPUdXKmSP3O+fM
         eNUdaLrKiph3lLMTMXXZnW/8XS3L4i79569JtZ/x+B1YHtZjw+49YZtP5c43px1QJMry
         edc78mJwKhDLZXxgIn9t07DaAhC2YzU214vmJ5/nwByJHbsahixwfGIJYJyWEi09P++t
         YhTC1am/aFgJQWIiqVBVAobZ6FrE1rBALl/oQJ8+09n2mwYsI/MDEVEAWG+6Q+kONeEN
         iY7CzWNH0kmvptC+hQcYITMiqHIa2YXlEAVhIczIkAE92um0ev7HV1vtQ5nMBZIsbgf/
         60ng==
X-Gm-Message-State: AOAM533x0eybDdfQxL6sCCuCCFMYr/NUJsZhPLwdIxBsbYv0WCWpO7LX
        4wU2JyvuQZ7o88pQL4LL7TY8SZFWamw=
X-Google-Smtp-Source: ABdhPJx0otzfnT/lE4/Wr8qMXHrRHuYEGfD7T68bs0mbN8EHCRhFHW9zia0r0NIxORYw+YeHZgWQEg==
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr554264wme.137.1605051742212;
        Tue, 10 Nov 2020 15:42:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm374149wmf.41.2020.11.10.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:21 -0800 (PST)
Message-Id: <068813912b9e5133f9d9bbacb239f7954788bf53.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:12 +0000
Subject: [PATCH 2/9] add -i (built-in): send error messages to stderr
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

The Perl version of that command already does that since a301973641f
(add -p: print errors in separate color, 2009-02-05). The built-in
version's development started by reimplementing the initial version from
5cde71d64af (git-add --interactive, 2006-12-10) for simplicity, though,
which still printed error messages to stdout.

Let's fix that by imitating the Perl version's behavior in the built-in
version of that command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 8ca503d803..0f24992ca4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -365,7 +365,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 			if (from < 0 || from >= items->items.nr ||
 			    (singleton && from + 1 != to)) {
-				color_fprintf_ln(stdout, s->error_color,
+				color_fprintf_ln(stderr, s->error_color,
 						 _("Huh (%s)?"), p);
 				break;
 			} else if (singleton) {
-- 
gitgitgadget

