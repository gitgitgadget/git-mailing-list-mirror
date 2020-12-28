Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0EC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E09D229C4
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgL1Sl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgL1Sl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 13:41:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0545AC0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 10:40:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l23so100226pjg.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xqrJBQ+G3HxLcamtvQxnj/82O/Oh2kdwzCo+sgyx8w=;
        b=WLwcbmdEAJqKgVzouW7iioa6htC0JeoBj1K6wtEOaKntzbbTwn7TM4QpnUQAPP4c2b
         FPu/EoH/ih1vKoViovh9i3hJ2NYgU3IcTxwDO+CH/8ocpEFAuVg8tHHazS+8gXCzA2wD
         AzotGX/1vBDjOoLUFxY7bgePJLfFelVEoyVRXZOeA147ci00cosap8AVSHC/bYFT9nly
         4gwrJuYm4yr4U0D0RFNQrqfyC4boGktbArYMGZwV5DxC9RjELR4/yuz0gViR+juQvtch
         HbBVWzQxuDuEkB/y/yiyWw/HC0aeDK49Ew3pjKy4IllDNJbE3zXTIlraE1k/RNHDHGDE
         nGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xqrJBQ+G3HxLcamtvQxnj/82O/Oh2kdwzCo+sgyx8w=;
        b=NIENOVkE5w8JuvDiwAFvO+BkWeBa4F9iYpQwvUF9afl9edCXPGhisCuH8udecwHtRe
         m6YmTim2KbLeNfNAWu88hyalWBhXlpaSr3Ah/pHW3KDoq8PJRK5i4NeWsm1kYgIHee/4
         AJQ8/sLCJqwQpyy3A89TxEA3PeuEmOtFDwpM0/qQt/NF7KdwDvZy7aaCBAzVM7Dg1dit
         Nfj9441VgR2vZVeZXIyLj4vZKSHoIgdQ8WnhO6nN3Em7pOY/AHjO7DaxNVlHKPYjCqPu
         lXapQCIu+OUBxn5l7AiRCw88CXqSFgikT+Nj1stdj4MVbc4JWvg8WQYsC5XVbRTIf0Kf
         yGHA==
X-Gm-Message-State: AOAM5335M4cz7z7G3DPirZFoej1e/CrFhdDU+KOIMKK8A3P25d7MzdtU
        PAgNlSqeapKk/J55NT+ZTuEEpw==
X-Google-Smtp-Source: ABdhPJxH/Xh2Zdj2tz81JjW5E5kbSZ9BA8kh3u4BdaW2/CgNk/vHZCFkUueHH7Rpk2+0ZNPvwgSBcg==
X-Received: by 2002:a17:90b:4b02:: with SMTP id lx2mr207479pjb.49.1609180845448;
        Mon, 28 Dec 2020 10:40:45 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id b12sm5735184pgr.9.2020.12.28.10.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:40:44 -0800 (PST)
Date:   Mon, 28 Dec 2020 10:40:40 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CoC: update to 2.0
Message-ID: <20201228184040.GK3783238@google.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 04:59:53AM -0800, Junio C Hamano wrote:
> 
> At 5cdf2301 (add a Code of Conduct document, 2019-09-24) we adopted
> a Code of Conduct from www.contributor-covenant.org; back then the
> version adopted, 1.4, was the latest one.
> 
> Version 2.0 tightens language in examples of unacceptable behaviour,
> generalizes the audience from "contributors and maintainers" to
> "community", and enhances the enforcement section.
> 
> The preamble we added to the beginning of the document has been
> kept, but the rest of the test has been replaced in full from the
> "upstream" and then the same customization for our community
> (i.e. the way to contact community leadership teams) has been
> applied.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for pulling the update.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> 
>  * There was a thread to collect acks from community members at
> 
>     https://lore.kernel.org/git/xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com/
> 
>    and that was how you now see many acks in the trailer of
>    5cdf2301.  If we were to go ahead with this patch to move us to
>    version 2.0, we'd need a similar "Ack" drive, I guess.
