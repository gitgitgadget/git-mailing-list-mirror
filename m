Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0FC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8A922CB2
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgLUErS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgLUErS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:47:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4D1C061282
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:46:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r4so9661042wmh.5
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D6R2xMYBnOCgYtvJdv+7WkxHb2CdaZcBtkWyAtkeR7A=;
        b=n5cGOfY4tMMlCwW2JC3fWzpkeBIMME/nmhBEbD7GUTtcvBAQKpEaqyX4LOqBGTiemJ
         umSi3CbhhAbFTqkoLgc+vFpegidpM/MKcfzWsR/WfCMgeAncFlikAUa+WSwLC+K09dRw
         +Mt4vm1MonKsaRwcMVwkH6YKuvs2JEO4lhRnsLEYl2pXeEiurlg0dqUqqzMS9qDPJ396
         ln4NoVHoGniMHALfJAk5SbgJgxJ47U5genWNvlItgXYW8eVf3u8aktiZpcMiQ5RII5Gb
         WF/0ua1MNsb5LWyps/mJoaR4KUFSGQIwLTHtTpa1yat/1nfx6AKQXaSTNuRx37+PlCxc
         IW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D6R2xMYBnOCgYtvJdv+7WkxHb2CdaZcBtkWyAtkeR7A=;
        b=U2cVgrj+VxWq3XVkIp7CJHbA7O2+vbi8nrz4Eyh2HstILpZcUDyYLKXghjOONYMmC+
         r3hPQIQ+h+rDfJDly2F6mJGVz8/ljeSp4ut3s7K1nUFbbalVyET1rcEcIbbgtJ5nkfay
         dpK8jzoUjfYhVShZ8TSW0AmpQSKf+3H+uXr3R5Ft7MfJIYa8fc+tr/Je4tKvK/2od3G2
         8m8bj6mvVhXogQs0phVYHMpLU3dsR4gCsy7L2sulOduQlJnEISIR5dpfb0ZR8q7x0hty
         NoYnT3U6w4nYS0VryD5XD2QsmfzEe1poxbwvAha+yC3jlCKSdFJIlTd0u1H8HtxdIdYn
         Zfmg==
X-Gm-Message-State: AOAM532ZF4V+G9ZOm2vQuLm+3PK5+iVcJ9TBtBsaqu1InThvgwehATMt
        3HVQEcQIuJ2GMoGclhmUj6Ec42e0a4Y=
X-Google-Smtp-Source: ABdhPJzLBUkmuG8phq2YTwtdJcPjDS3UmXZOwBOREbyxFCm7YAJTUY5za9TcNvojwquUZBUgy0hnPw==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr14244212wma.22.1608516324900;
        Sun, 20 Dec 2020 18:05:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g191sm22937898wmg.39.2020.12.20.18.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 18:05:24 -0800 (PST)
Message-Id: <0fd4e9f7459901e6e93bb21c41d04759b40b60c3.1608516320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
        <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Dec 2020 02:05:20 +0000
Subject: [PATCH v3 3/3] negative-refspec: improve comment on
 query_matches_negative_refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Comment did not adequately explain how the two loops work
together to achieve the goal of querying for matching of any
negative refspec.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/remote.c b/remote.c
index 7323694b163..c3f85c17ca7 100644
--- a/remote.c
+++ b/remote.c
@@ -736,6 +736,12 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	 * item uses the destination. To handle this, we apply pattern
 	 * refspecs in reverse to figure out if the query source matches any
 	 * of the negative refspecs.
+	 *
+	 * The first loop finds and expands all positive refspecs
+	 * matched by the queried ref.
+	 *
+	 * The second loop checks if any of the results of the first loop
+	 * match any negative refspec.
 	 */
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
-- 
gitgitgadget
