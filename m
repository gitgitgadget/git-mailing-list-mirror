Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629DC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459662065D
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UqnlmDTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGGQt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGQt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 12:49:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D8C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 09:49:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e12so32224828qtr.9
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0hnkD01Xzl9yWl9g3wBXPDgegY4+QjFO5fcVkXvNzg=;
        b=UqnlmDTOWLAOZxN2hft2zNOUdcIC+mQyPJGMpkFWQg2Sysct55J5VOCra664eaM1bO
         nJ5r0/XGQ7Jc0RjyB2BECbQ/QrYSAo0EwTH/pENxLGjMx/9382oplY5JNuMTKNXCzB69
         MBVKVzF8P3U+eZDyIgmONO21nHD4Y2hfKkNWT53TLsfN5wmF8ZSQzC12AUO6dS9VNXc6
         qSfv93n7BC86poANYpt7G6dpg8o37GwNDUnaoMMECyrdQv81acjijk9LReBCg9CXkSo9
         Lk6hhN5mUJ61fVzndWcWYr2AB84XskMI0L8eksmx0B/jkvM7zSM/wfT1W0bfkr8oD/wG
         jWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0hnkD01Xzl9yWl9g3wBXPDgegY4+QjFO5fcVkXvNzg=;
        b=IvO0PMUpt3LIv2v+xkcsmk96EitQf1AoaNhc5KbjQxSK+1i5TzoibKHsQ0fRd0w36q
         B/MYd8Pbwac7V7DW9Z3Tk9O7vI9vG+HtuIJSwTM3AqfhOIeQbo1wh9rBVh5GF03369aD
         IlcuxkAF6vprmOGDsg8x6wrwJ9NHxf8mkHbPkvNVxZnW4/QidwwZPLDI+3HO80z/IcLh
         zhRV4R9ArML44awXUvW+7iSch2uZ0MBF/Blq5sd0oBDX0hMnpq05PRtExY18EboDhi0E
         1+LX0ZaSh5yw5xTtsQlAugUzmFRIp0R1U8kejOyua1cgzNIHN8GReXywUO66VMd6eRgm
         8pvw==
X-Gm-Message-State: AOAM531qxFeC7hS9DTj7bSaYVrYDCHL5rbf96mueSkoAfF5AZ07C1IKf
        /AiHl0i7xQ/Y+x+OxtpyXJW3fQ==
X-Google-Smtp-Source: ABdhPJxpj48FCTsIrIhKlRZl7W2dZZN5bmoRPs1I0rn1O7btMDGYtSbE66Nj2d3gfjxtcIDwSOZ9TA==
X-Received: by 2002:ac8:3893:: with SMTP id f19mr57096945qtc.184.1594140595757;
        Tue, 07 Jul 2020 09:49:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cc04:7df5:37b0:651d])
        by smtp.gmail.com with ESMTPSA id x73sm13073847qkb.20.2020.07.07.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:49:54 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:49:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul
 2020, #01; Mon, 6))
Message-ID: <20200707164953.GA36941@syl.lan>
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
 <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
 <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
 <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com>
 <xmqqimez5l5q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimez5l5q.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 09:45:21AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> Oops, I am not sure what happened here.  There I thought were issues
> >> pointed out at least on the latter series but was I hallucinating?
> >
> > I believe I have resolved all the open comments in both series.
>
> OK, then I do not have to be worried.
>
> Let's merge it down before -rc0.

Stolee and I did find a few unrelated bugs with Bloom filters in the
past day or two while starting to use them at GitHub. The biggest is
that Bloom filters are not used if the top-most incremental layer does
not have Bloom data.

I'm not sure if this is a show-stopping bug or not, but if it is, I'd be
happy to send a patch or two on top before -rc0.

The other bug is less serious, which is that we do reuse Bloom data from
previous graphs even when writing a new graph with `--split=replace`.
The fix is more involved, so I'm less inclined to rush it before -rc0.

Let me know your thoughts. Thanks.

> Thanks.

Taylor
