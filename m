Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCE8C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C439521D93
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BWrdxUfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbgKWQWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgKWQWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:22:11 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA5C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:22:10 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so15371351pfn.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9pDCBe3ijK1tauQE6W5n1Qc6mgHYc/2wnKbAR11LSJU=;
        b=BWrdxUfY5Xk2IJYTZzrSlujZs7Lsqr8wQ6C3pCkZhcIQgKxjCoTAUT+W3QP1BFAkcb
         AmN1jLzPVbDHiQ2/UjWFN032Kvqr8Yla8es5rAawguiAzfnItTUCxigIwRU9KpPyLIFC
         j00jot+EL+ecqmj+zSTNBZ4nr5KPpZwRwzMa42pyQCEGYw2p6dJfSRPgYU8dxTr9XlVg
         asdg4xCuYuXs+MnD5snCtdkhahBSFmKuHTusB9t54pU2heLOebmhti94SCvX+Q7qjFkZ
         PLzsA68xoKw9DP2nAqLBSKuNRCesXMljslL9ZaZJ0TubAdmuPbiLJPIk+XqBqBx4Vgel
         kSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pDCBe3ijK1tauQE6W5n1Qc6mgHYc/2wnKbAR11LSJU=;
        b=dI1cJqH0nzwYbIs1Wr+95hz6Y4lgxbpU75AuD8n+OvGPnrFdptZCI/QT4xbhNEdCGX
         Jyw4aPWLS20vZxhkWuRHeBnoPKZB7NrrkvjbTiOORrE2EnhQ9itiz+m3v/uclZKjgj3c
         uOq1W9syH/DkF7NjYfTEGTqXsXZ01dt6e2dBOJfynV09v1JMTi7raURhgCxbQ4q8lVYZ
         Rk9RKU+conuFJ2tbjR3IKjTXoscqQodLCbA2W/bwB24TgVkWp+roWd1ITIvvvXfaXgag
         sbSI52XP4Q/NeQc5dozOEE7lP/Tizx/h/FQxVbdHwbC9GGKrEvtPenfaMN3fDIc2mZZ7
         FFYw==
X-Gm-Message-State: AOAM530uzq1ktg+Q2NoLg4N7v5R+qtLzXFoBoYKanhU1u90s4N/7mLty
        3wxY17PugpcwdBWPTsQ2n180xbIX/9I7M3uX
X-Google-Smtp-Source: ABdhPJyZg381ZqnFBgn7/i7FsSS+Wdm5rtfX5EZqqomZm+LuC9zefaB2Boe6p75EIf6+LYAIzW7X7w==
X-Received: by 2002:a17:90b:3797:: with SMTP id mz23mr527785pjb.147.1606148529605;
        Mon, 23 Nov 2020 08:22:09 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v191sm12237037pfc.19.2020.11.23.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:22:08 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:22:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 01/23] ewah/ewah_bitmap.c: grow buffer past 1
Message-ID: <X7vhrCbeFzxaEVvv@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <36deaad366d66d10b96755dd6969bfe51123a2d4.1605123652.git.me@ttaylorr.com>
 <xmqqblfpqj4e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblfpqj4e.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 22, 2020 at 11:36:17AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When the buffer size is exactly 1, we fail to grow it properly, since
> > the integer truncation means that 1 * 3 / 2 = 1. This can cause a bad
> > write on the line below.
>
> When the buffer_size is exactly (alloc_size - 1), we can fit the new
> element at the last word in the buffer array, but we still grow.  Is
> this because we anticipate that we would need to add more soon?

Right; the check 'if (self->buffer_size + 1 >= self->alloc_size)' could
probably be written as a strict inequality, but that check dates back to
the original ewah implementation that Vicent added.

But, that is not quite the point of this patch: instead we want to stop
the integer math on that line from preventing us from growing the
buffer.

I think that this paragraph would be clarified by adding "and we need to
grow" to the end of "when the buffer size is exactly 1".

> > Bandaid this by first padding the buffer by 16, and then growing it.
> > This still allows old blocks to fit into new ones, but fixes the case
> > where the block size equals 1.
>
> Adding 16 unconditionally is not "to pad".  If somebody really wants
> "to pad", a likely implementation would be that the size resulting
> from some computation (e.g. multiplying by 1.5) is round up to a
> multiple of some number, than rounding up the original number before
> multiplying it by 1.5, so the use of that verb in the explanation
> did not help me understand what is going on.
>
> Having said that, I see you used the word "bandaid" to signal that
> we shouldn't worry about this being optimal or even correct and we
> should be happy as long as it is not wrong ;-), but is there any
> reason behind this 16 (as opposed to picking, say, 8 or 31), or is
> that pulled out of thin air?

Any phrase that more accurately states what's going on is fine by me,
but...

> I think this probably mimics what alloc_nr() computes for ALLOC_GROW().
> I wonder why buffer_grow() cannot be built around ALLOC_GROW() instead?

I think that we probably could just use ALLOC_GROW() as you suggest.
Funny enough, reading through GitHub's chat logs, apparently this is
something that Peff and I talked about. So, 16 probably came from
alloc_nr(), but we probably stopped short of realizing that we could
just use ALLOC_GROW as-is.

So, maybe something along the lines of:

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 3fae04ad00..9effcc0877 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -19,6 +19,7 @@
 #include "git-compat-util.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
+#include "cache.h"

 static inline size_t min_size(size_t a, size_t b)
 {
@@ -33,12 +34,7 @@ static inline size_t max_size(size_t a, size_t b)
 static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 {
 	size_t rlw_offset = (uint8_t *)self->rlw - (uint8_t *)self->buffer;
-
-	if (self->alloc_size >= new_size)
-		return;
-
-	self->alloc_size = new_size;
-	REALLOC_ARRAY(self->buffer, self->alloc_size);
+	ALLOC_GROW(self->buffer, new_size, self->alloc_size);
 	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));
 }

> Nothing in the code is wrong per-se, but just what I noticed while
> re-reading the patch.
>
> Thanks.

Thanks,
Taylor
