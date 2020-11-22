Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EDC388F9
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 02:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E09207D3
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 02:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kLN3GFwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgKVCRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 21:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKVCRs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 21:17:48 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583C9C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 18:17:47 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 92so9622907otd.5
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 18:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0dCHjmnEKe6q/FFPGHJ5akl96F3XY0SKJggxPJF+VXQ=;
        b=kLN3GFwlWpcPys01vQ8YyVCQpGZHb6AbG5VC39KLNRJBck9aAQbqrLa6Z7dP/BB7QY
         tV1oGzmcXQqiH4vErZUuxYnM4AF05HmyBkdLgjn2oZvgtXA+q6X1JkXWMZY9oWlMQoqm
         6eNIURee8/OPgZA7GPGYuyLg++0S5Jo1QWGqideViBks6wwBQhSq62TJ+tiWp+18DYdE
         KM/b895JkPlQaa5r3XCYMEklrFyXvnok+UxNPzZAhU1kO+pqp72YbfN30WixbiJHSnwt
         AWT6awhOYFTIFX/In8y0qcbrlwqKOgBEOAVsP4nINGZy1awZJUP0scRjD8WNz3jAOH6v
         xL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0dCHjmnEKe6q/FFPGHJ5akl96F3XY0SKJggxPJF+VXQ=;
        b=WZVSFJzGpPxnZEipMb8dWB2/9H7YXt6DXK5L2zkKafJPvseznej0pUUF1SE4saqF9U
         u+dSRp5KbYKfMjEUSzRE7UGAXupJBAwudvZQ1sg2FhT7cOpUuIbGRdHESQHydEeFMK3X
         O6Uf4DcHhAci01q3nO0dfnjf7xHrwLBr9ewXiIqyqClTpSVr2rznXr03HrqjvB0aP1to
         kPmtbmnWVwDwRM9+lLOGsZqhc6wVwOw4eaWhmnHVvXMBU7c5cUhJxfSUtBcX4TKL1tNi
         qvlMye6KGk0LPcS8TLP3TZNtRorTyYlwPB/8MFoyKbiE1wdMAiVS9rc9w5Dwxtkm3tLa
         Ps5w==
X-Gm-Message-State: AOAM530ijWaJqzBUAGjiNVZv0TlZD70hFAgxL2R9lYpqrKJ9+U0XB4vw
        oNSpnwLNIdvGSEx9GVmX1KrJAw==
X-Google-Smtp-Source: ABdhPJx0uThD7+/E1J0v5uS+ppxFkLabtnIf6SyofPFbMx1mWMGKIecOn/loLDvpZp9jPAl7XWvWiw==
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr17868962otf.43.1606011466036;
        Sat, 21 Nov 2020 18:17:46 -0800 (PST)
Received: from localhost ([198.184.28.250])
        by smtp.gmail.com with ESMTPSA id x190sm4453474oia.35.2020.11.21.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 18:17:45 -0800 (PST)
Date:   Sat, 21 Nov 2020 21:17:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X7nKRxNy47nTre3b@xnor.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <20201118183225.GB8396@szeder.dev>
 <X7V7X/qDfN0udr2u@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X7V7X/qDfN0udr2u@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 02:51:59PM -0500, Taylor Blau wrote:
> On Wed, Nov 18, 2020 at 07:32:25PM +0100, SZEDER Gábor wrote:
> > Please don't simply sneak in such a change without explaining it in
> > the commit message.
>
> Ah, I certainly didn't mean to go under the radar, so to speak ;-). From
> my perspective, the final patch looks like it picked a magic number in
> the same way was the original version of this patch did, so I didn't
> think to add any more detail there.

Oops; when I wrote that to you, I had in my mind that this patch already
changed that line in the tests, so the rerolled patch was simply
changing it to something different.

But, this isn't a new test from this patch's perspective, so I'll make a
note of why this changed in a replacement.

Thanks.

Taylor
