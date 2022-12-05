Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31568C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 18:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLESyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiLESyl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 13:54:41 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B31FCFF
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 10:54:40 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i83so1785498ioa.11
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aygnPeOZ3KFUZYVzSCakTuN9p2NQj0Q1Bz8MuYb94SQ=;
        b=aUewXiYH46zmtPIY1gOydeFoZNyFb1lYbyClGfX4iYzgAL1PgU92Gf6PiIYFCP372t
         Z1KNHFod+aAW8zRmS9nesEatqtKe4G2EYpdWcUfOKqrL5W/5FHL5q240UWdevbQuCGF3
         qZoV7nj0//chsJOlSABhcJ4r1hqYjZQNLIF/JFA9fIKU15wAYOKCsab7O0LzMbIbB4WH
         j18iFUZUBUdqU9inVC6v9F6AdN+C4pniXgl2vm2CoNbbLBDfx6UqwRzJJ2XDClVQ1mJq
         u+ZpDO9+iRwOxVQeI/UnGyeeAtLwHP1OglDTifbE8dWM0UGbkzllNpY0XL691q9SraXH
         i3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aygnPeOZ3KFUZYVzSCakTuN9p2NQj0Q1Bz8MuYb94SQ=;
        b=YInSdcHRcqEUtlNlX9tx61H4SnzEGCNjIXtmw2Bbjbm/dtMv6qTXnt2S5ghFu5Fi/a
         VbnatwP9LzFRxiE85lWEMLZKetLUMcDV7+kjCAG99hRes+Lbn35TYe2V0g5HRIeBv7NR
         yIbUhn2A0H2w9V0RzzgNdYR5HZNZGAOCSXYrlyTApg6r6o3H36vYrsCB4BFNMrjSfNue
         XYv+fYKtpTAfpbg/ykANHxw4O99SqsWP8kN7tXWP7LGE2P1zBAak7yqsSr7dADR9P3kC
         g3hvx+5JKchMjp6eTLbAFIU0ECyOxTbJVYOZSX6sq1LIBn6PRKf4OwuqkRvQivxnOWOk
         f3Zg==
X-Gm-Message-State: ANoB5pmXGHfadL0Wv2PSP8x1PCnR/ZfUBEZOieYwsmOazAr0e0kRAoCB
        jOtJGl3YpXlpbtWpeDZGmHku4PcYODzk4PgJ
X-Google-Smtp-Source: AA0mqf4SeJXnKpdnqNVyS2RF7nm7Zz+u6Q5TpyhPxpU10oFtNfw16i68TIUuzNvdErd7z2m04O9U2A==
X-Received: by 2002:a02:6348:0:b0:374:f89e:99d6 with SMTP id j69-20020a026348000000b00374f89e99d6mr39011423jac.188.1670266479917;
        Mon, 05 Dec 2022 10:54:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t68-20020a025447000000b0038a007a26e7sm5927802jaa.126.2022.12.05.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:54:39 -0800 (PST)
Date:   Mon, 5 Dec 2022 13:54:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When zero-initializing a struct without the use of static initializers
like "{ 0 }", it is common to write one of:

    T *ptr = xcalloc(1, sizeof(T));
    T *ptr = xcalloc(1, sizeof(*ptr));

These correctly initialize "*ptr" to the all-zeros value, but have a
couple of drawbacks. Notably, both initializations are verbose, but the
former is a foot-gun. If "*ptr"'s type changes to something other than
"T", the programmer has to remember to update not only the type of the
variable, but the right-hand side of its initialization, too.

In git.git, it is sometimes common to write something like:

    T *ptr;
    CALLOC_ARRAY(ptr, 1);

...but that is confusing, since we're not initializing an array. Rather,
we're using the CALLOC_ARRAY() macro to pretend like we are. But since
the array length is 1, the effect is zero initializing a single element.

Introduce a new variant, CALLOC(x), which initializes "x" to the
all-zeros value, without exposing the confusing use of CALLOC_ARRAY(),
or the foot-guns available when using xcalloc() directly.

Write a Coccinelle patch which codifies these rules, but mark it as
"pending" since the resulting diff is too large to include in a single
patch:

    $ git apply .build/contrib/coccinelle/xcalloc.pending.cocci.patch
    $ git diff --shortstat
     89 files changed, 221 insertions(+), 178 deletions(-)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
This is a follow-up on [1], where introducing CALLOC(x) as the preferred
alternative to CALLOC_ARRAY(x, 1) was first suggested.

The patch is straightforward, and I am pretty sure that the Coccinelle
rules are right, too ;-). But as a first-time Coccinelle user, any extra
scrutiny on those bits would be appreciated.

The main point of discussion I think is whether we should consider
adopting this rule. I am biased, of course, but I think that we should.

In any case, we should focus our efforts on polishing v2.39.0, but I
wanted to send this out to the list before I forgot about it.

[1]: https://lore.kernel.org/git/Y1MrXoobkVKngYL1@coredump.intra.peff.net/

 contrib/coccinelle/xcalloc.pending.cocci | 21 +++++++++++++++++++++
 git-compat-util.h                        |  8 ++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 contrib/coccinelle/xcalloc.pending.cocci

diff --git a/contrib/coccinelle/xcalloc.pending.cocci b/contrib/coccinelle/xcalloc.pending.cocci
new file mode 100644
index 0000000000..83e4ca1a68
--- /dev/null
+++ b/contrib/coccinelle/xcalloc.pending.cocci
@@ -0,0 +1,21 @@
+@@
+type T;
+T *ptr;
+@@
+- ptr = xcalloc(1, \( sizeof(T) \| sizeof(*ptr) \) )
++ CALLOC(ptr)
+
+@@
+type T;
+identifier ptr;
+@@
+- T ptr = xcalloc(1, \( sizeof(T) \| sizeof(*ptr) \) );
++ T ptr;
++ CALLOC(ptr);
+
+@@
+type T;
+T *ptr;
+@@
+- CALLOC_ARRAY(ptr, 1)
++ CALLOC(ptr)
diff --git a/git-compat-util.h b/git-compat-util.h
index a76d0526f7..827e5be89c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1107,6 +1107,14 @@ static inline void move_array(void *dst, const void *src, size_t n, size_t size)
 		memmove(dst, src, st_mult(size, n));
 }

+/*
+ * Like CALLOC_ARRAY, but the argument is treated as a pointer to a
+ * single struct.
+ *
+ * Preferable over xcalloc(1, sizeof(...)), or CALLOC_ARRAY(..., 1).
+ */
+#define CALLOC(x) (x) = CALLOC_ARRAY((x), 1)
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
--
2.38.0.16.g393fd4c6db
