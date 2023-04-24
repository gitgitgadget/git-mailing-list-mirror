Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA2C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjDXWUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjDXWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B8658A
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f9d6eccf3so59357817b3.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374828; x=1684966828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgnoPLqFiqEJApQ0j372BU6r2Ik28j2cVQo16+oIyrU=;
        b=Shx26KdKiUv1nx7/MPj8ddFEUCnBjndBaKnx8IUETI9zY0UxemKMD9ctyiHeX7DcGp
         neT0toCeq0ze0QFt9726Cs5K4aNbE+5eErRk4lJ8P7XL9PEBFyqeTu/ppNLy5dADjEge
         yF5HS6HpuVG/fHTlxtxJuEQKYgg5fwAl+MJ7gUViiFxcK/bfGQc36gspJ6GB5yrWsT3D
         YbazgLzT97Hnqs34YZ5SoKfrBgQEKs8zh9LObck1/Is0GHtWylEvODIWRruqsYrb4fRz
         +sA1W99kzOz+WYQY6dqmDBDJ1OpnTFhruiJhnNp8ybVhNQAYPfhVnt81HR8Q1ab535zj
         7uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374828; x=1684966828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgnoPLqFiqEJApQ0j372BU6r2Ik28j2cVQo16+oIyrU=;
        b=ZsRoBeNgidD2JdNvhyRPtapsSUbmKRUTKz5YJHABBpHF8YTOlPOBVAxzccAYffV4lw
         xDEWq0FvVYfN/ma1mXtTN8f2n04OqrX84B/bWZyedA/wY/ZPGfC3IyEQy3lsH9whhX20
         O6B1ZMxq1CCaeYkSHIs83msd2pKxHKFk+rj0d9Ckzfxcm0kEjYjZsFdgykCEWgoZUAV8
         +gl+ZEQPwBnbZh0JBFvFe18EiRsYswePn9CztRT8EIZdUmac6Yf7DVd6vENkKQII8oft
         nDzpOeXMK1OWY2+EP0Jpdt9903fUwEQQ2XQCI9eq38YyNadlIAqePFv6ujuAKRXryLwI
         E48w==
X-Gm-Message-State: AAQBX9cNmycvTMuMGA2Ua1YA17V7xENhXcNamaB97cpSGpIXogw2QNPq
        ROlIlEK0Kd+ZUxSuiEGg6uQc192o/9xb8Fh/jE9bRA==
X-Google-Smtp-Source: AKy350bn8YWAwj3/A8k0c4pjX6C3UXsGkZvIUnVNwoUK5qQdaUjWrPnX+EG6V+X6I6qRRkkUTWP4+g==
X-Received: by 2002:a81:a186:0:b0:54f:97b1:c908 with SMTP id y128-20020a81a186000000b0054f97b1c908mr9259185ywg.25.1682374827788;
        Mon, 24 Apr 2023 15:20:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w13-20020a81a20d000000b0054fae5ed408sm3190041ywg.45.2023.04.24.15.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:27 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 6/6] banned.h: mark `strtok()` and `strtok_r()` as banned
Message-ID: <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`strtok()` has a couple of drawbacks that make it undesirable to have
any new instances. In addition to being thread-unsafe, it also
encourages confusing data flows, where `strtok()` may be called from
multiple functions with its first argument as NULL, making it unclear
from the immediate context which string is being tokenized.

Now that we have removed all instances of `strtok()` from the tree,
let's ban `strtok()` to avoid introducing new ones in the future. If new
callers should arise, they are encouraged to use
`string_list_split_in_place()` (and `string_list_remove_empty_items()`,
if applicable).

string_list_split_in_place() is not a perfect drop-in replacement
for `strtok_r()`, particularly if the caller is processing a string with
an arbitrary number of tokens, and wants to process each token one at a
time.

But there are no instances of this in Git's tree which are more
well-suited to `strtok_r()` than the friendlier
`string_list_in_place()`, so ban `strtok_r()`, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 banned.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/banned.h b/banned.h
index 6ccf46bc19..44e76bd90a 100644
--- a/banned.h
+++ b/banned.h
@@ -18,6 +18,10 @@
 #define strncpy(x,y,n) BANNED(strncpy)
 #undef strncat
 #define strncat(x,y,n) BANNED(strncat)
+#undef strtok
+#define strtok(x,y) BANNED(strtok)
+#undef strtok_r
+#define strtok_r(x,y,z) BANNED(strtok_r)
 
 #undef sprintf
 #undef vsprintf
-- 
2.40.0.380.gd2df7d2365
