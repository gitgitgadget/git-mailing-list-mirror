Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA5C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C5822247
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jmUeIGb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404922AbgJTUaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgJTUa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:30:29 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432FCC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 13:30:28 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b11so1585631qvr.9
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36RSWRZCTOMKdEKcsFYXzoz5+KrWan/NBVl4cT6x31E=;
        b=jmUeIGb9bHhAESWAu+eK0ZPLWdw06M4b3cb6DTQHCL5EzqZNpUzy4u82O5TTpnriNo
         toBY2+go6E1VkF3qJTaoyHachYhtP5KjIOeOjdlf4pb1OleAai78Z30k0N9imUEh3rF2
         P2jG2bfMbossaROoRcqSkr7RP3a870S+GRuws3VCpsIAo1VFpUxxzC0ozbJleKZh3+hN
         r2RSlHJzWMIp915o2/pnH91FZYxkRETZLnhESK7/6lzaVOAsngp4C5ZQ31z4Ycl6/Lj4
         51EaODVZGwR1x2tvqr/Jq1QJ2QT5C9jSJKMs6myz30nvAcsx24cEdtw6xq6aGpYtXNCx
         fD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36RSWRZCTOMKdEKcsFYXzoz5+KrWan/NBVl4cT6x31E=;
        b=CLiX/KltvSwQ6xuml8ljWEqztH0VK/9fC94qJl9xhgAVz/CmtmVbHm2CDpJndSML6R
         FTM4V78lu76k5YSY3fVOUNQ2xHZKQi7ZOerHTHkgpUzKyksuuujs56iGPS7eGs6M6DAy
         VawnjbR/sRHYGsyeOOpEEeIRJqdVjCdqpEhPO4YiEgaaPAVsJPAeGByTIpI50zxSSLC8
         Jfs4cuDO1C8nVG9jjZibmYMmZMHVzZVTixtcvsJjG326mieSHH9hubbs6nnFo9B1hXpz
         6HIgDy2hBKb/a9iolnUXY38ly1PD8emNSdaV7eqsovaOzOeAfuVcUn0S/KRnURHvtne7
         0low==
X-Gm-Message-State: AOAM533i6Qiwxm9OG3yUs6RjskcV/AojFflcGeNQnSOLdffbmDIxXCma
        60NtVgLtjXjYbc0+OCzgx5NvQQ==
X-Google-Smtp-Source: ABdhPJxMwOCmHkdvN5wdJUgDrOTyxM3AK3bQqEBomLDnkVUxG4vpwrGTGKRL4L1/7XWSJTQ17wb3uA==
X-Received: by 2002:a0c:e054:: with SMTP id y20mr5428755qvk.30.1603225827486;
        Tue, 20 Oct 2020 13:30:27 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id f189sm1363966qkd.20.2020.10.20.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 13:30:26 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:30:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        congdanhqx@gmail.com
Subject: Re: [PATCH v4] t7201: put each command on a separate line
Message-ID: <20201020203024.GC75186@nand.local>
References: <20201017075455.9660-1-charvi077@gmail.com>
 <20201020121152.21645-1-charvi077@gmail.com>
 <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
 <20201020201535.GB75186@nand.local>
 <xmqq1rhsbq6a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rhsbq6a.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 01:25:33PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > When I applied this locally, I used this patch as a replacement for the
> > last patch of v3 [1]. That kept everything passing after each patch.
>
> Oh, so this is a replacement for 5/5 and 1-4/5 of v4 are supposed to
> be identical to those from v3?  The difference between [v3 5/5] and
> this one is a single typofix on the subject line, it seems, though.

Yes, at least that's what I interpreted it as (and how I applied it when
testing). I'd like to hear from the author to make sure.

(As an aside to the author, I often fall into the trap of thinking that
it will be easier to send a single replacement patch which will generate
less email, but--as you can see--it is often more complicated for
reviewers and the maintainer to decipher what's going on. It's often
just easier to re-submit the entire series and include in your cover
letter "this is unchanged from v(n-1) except for ...").

> >> As you've demonstrated through the microproject that you can now
> >> comfortably be involved in the review discussion, I am tempted to
> >> suggest that we declare victory at this point and move on, but I
> >> don't know what the plans are for the other 4 patches (I guess we
> >> won't miss them that much---the micros are meant to be practice
> >> targets).
> >
> > Yup, ditto.
>
> As [v4] single patch won't apply standalone, we cannot quite declare
> the victory yet.  Are [v3 1-5/5] (or [v3 1-4/5] + [v4]) good to the
> reviewers of the past rounds?

For what it's worth, I'm happy with [v3 1-4/5] + [v4].

Thanks,
Taylor
