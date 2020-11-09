Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29FFC5517A
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EB5206D8
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mNNPEO3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgKIWBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbgKIWBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:01:48 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5BC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:01:47 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so7168625qte.11
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3HsI4N63vR1rzAV41MuL+h/lpYlGCHM0102/4aR6KDE=;
        b=mNNPEO3Sbf4X1cGutZAdCJI4BAw5PbrhmMvTELccpm5MyrVTS0FATB/YhhnscLM95+
         2ouwk8hepjyzsfdz6ZBfPoIsDL+bTkw6oZJOfPVXhCuNsH6yvb3hJGp9y8XgDcdCqU+k
         KL73Gm2OOnQrdkWjLSn7ZMEHBlokn5/hKR+HielNk/23fk63N+s3WFf0Ia1ZJPOIvET3
         +gwQ0sgVuAbtom217zJohLwGxCSRJ4WL8zVnA8WDBL4OQkmBRyGaDe4UTOQ4l03CXO1U
         SeX/fy12luLJQF+HoSiv5oU4Fu7O2aOfyz7FdBNE4iBrGU2ePcMuUZiP6mfhUQBZpMUQ
         govQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3HsI4N63vR1rzAV41MuL+h/lpYlGCHM0102/4aR6KDE=;
        b=eBGDREoLSQQawa1SMjY5QGkhl+U1XpIK4Efz6fZ8XNM3smvE8OzdhEgRG+sq3kvJYm
         LNtnrZVMZMvSEBXGKvzDMoteG243xlg5dXRyFpxh9r+1MXjGF1zBBsYiGRndOkOxZ9w8
         nzrj78bWr8inPI3+seaEILI7SUxoL+9ziSLkuAmO1AbkO4JwvaAI56ZNtHxJEkfiBM+/
         b6d2U9uQE1Zj0dGgDPMIVkyFiTTe4kMD5pRad9CpL4ia6GB3JSEg4nO1GeSaylWWM+mb
         00ttO39JNStHXDWYVfFAYkyrlvfWg9fMjJP3tYqftbdG4+1OO0h79rWZuxuQzBKGkGjm
         GesQ==
X-Gm-Message-State: AOAM531+R+le5/KSbahZTCJf56O1fWNnDL9TL+bvb9BUIFkhHnxX7yhq
        bXmLAft6tOmPAEUg/n5h4vqRvw==
X-Google-Smtp-Source: ABdhPJxRZ2xYk3sAXAJLBW+zfcf27t73AphqK55hLHu9fqxYgryB7n0R3oOS1rjpNKsaAXKbxLPeuA==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr699442qtn.162.1604959306663;
        Mon, 09 Nov 2020 14:01:46 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:10da:7f7a:3c41:db0c])
        by smtp.gmail.com with ESMTPSA id t184sm7126046qka.19.2020.11.09.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:01:46 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:01:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
Message-ID: <X6m8R9erSxGlPXq2@nand.local>
References: <20201109215248.461167-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109215248.461167-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On Mon, Nov 09, 2020 at 03:52:48PM -0600, Felipe Contreras wrote:
> It is possible to have a recursive aliases like:

I am not an expert or user of the Bash completion scripts in contrib, so
I'll refrain from reviewing that portion of the patch.

I would, however, recommend that you avoid the word 'recursive' here.
Git rightly detects and rejects recursive and looping aliases. In fact,
the example that you give below:

>   l = log --oneline
>   lg = l --graph

Is not even recursive. I would instead recommend calling 'lg' a "nested"
alias.

You could argue about whether it is "l", "lg", or both that are nested,
but I think renaming the patch to "completion: bash: support nested
aliases" and then a s/recursive/nested throughout the patch message
would be sufficient.

> So the completion should detect such aliases as well.

Thanks,
Taylor
