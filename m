Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077CAC433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5B022D58
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbhAYRvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbhAYRuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:50:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78FC06178B
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:41:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k193so13271957qke.6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+B1IwTW24D3XFXz9G37ySOAr9R2e0u9fnaTf+B+hRdQ=;
        b=WMJuYTsrsLeRM4cFoRJ3w93HRgpPGgDvxW5qfTSKz1ycHLTce5RExhIENGFxyZyhOd
         Kyse0zm5tvhcgMbYL6RmwGc9xpjxCwW74cXFa4YDfq5zDG7adCZIR5mSIigGbc1MdKvk
         gzD2EwyqhDqLzR4PaFfHTZcuGSSJD0cduw7+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+B1IwTW24D3XFXz9G37ySOAr9R2e0u9fnaTf+B+hRdQ=;
        b=NxM3VM3UD8sbFzSAR6CanbyIByXAZSB5VAtknovboj6oW/hku0QMA/oY47fS3GVBNi
         1o/EbYHt8Rf7npme9nJA7s2jAC5vkZX6hrlvooJ0SjS0SgEat3FkskUuaw/CsSgOClud
         ER2foLhJmzy1Cwr55RsTIL5mu46xUq/QTwnWH+vL6MSDSvSC0+Jt9Tc+sYqsir+1UQPI
         sMvadS8VyVpcKPip1DfWgundMFhqlYqnSBdsye3KP8bCjNKwymk5+NWjHliDCe0qu4NO
         STswBkjH3jXTgmbD+4e7bPt4daNvQGAcAwlChLdODnT70wzRNd82eY4iDIOL4CoJzIpz
         zCxg==
X-Gm-Message-State: AOAM530JYUvy8jzJXApNuJtdakl5QCoQLSadDv55s8nxXvmHuxUUvecW
        aZ75q50E08BLt+/vUto8K7boo1lNznah1vbkkSpOolmciyZrdA==
X-Google-Smtp-Source: ABdhPJzgAys+GG9yHMxyQ50rfXFQLUOxcDo5TmRQXQG3WKQnIsHemEzaPVBDLRUTZWrFv3Db80lROm1rk1W3KMUcd3c=
X-Received: by 2002:a37:6713:: with SMTP id b19mr1819299qkc.493.1611596493762;
 Mon, 25 Jan 2021 09:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20210122142137.21161-1-jacob@gitlab.com> <20210122142137.21161-2-jacob@gitlab.com>
 <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
In-Reply-To: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Mon, 25 Jan 2021 18:41:23 +0100
Message-ID: <CADMWQoO5e29YO+F_iHT73PhO0T7nK2Q+tDsfCwSPBKG1Bur3tQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] upload-pack.c: fix filter spec quoting bug
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 9:32 PM Jeff King <peff@peff.net> wrote:
> I also found the use of " exec" clever,
> but rather subtle; you need the extra space so that our "don't bother
> using a shell" run-command optimization does not kick in. I replaced it
> with "env" here, which is a slightly more canonical way of running a
> sub-program that does not rely on shell builtins.
Yes good idea, the exec thing is too clever for its own good.


> But all of this should be added as a new test, probably in t5544 with
> the other pack-objects hook tests.

Did that, hope it is what you had in mind.


> I'm somewhat embarrassed to say that despite being the one who added the
> pack-objects hook 4 years ago, we still have not switched over to it at
> GitHub from our custom patch (the reason is just mundane; there's some
> other adjustments that would have to happen and nobody has ever quite
> gotten around to it). Presumably you are looking to use it at GitLab.
> Just beware that you are probably treading new-ish ground, so there may
> be other bugs like this lurking.

Thanks for the heads up!

Jacob
