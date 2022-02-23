Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A9EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiBWXl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiBWXlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:41:55 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4C5AEEC
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:41:22 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j5so456751ila.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3xBSG4Y8qT+96SRcLq+HUghyj+K2UsvNh8wBI8e+mQ=;
        b=n7EuxG275JSCSNfVDyQdrGHFtsJXZXGqifRTcfl6uECRzKXe4Fsyy6MMJWK/+WHMuk
         qKKTKwAEnSUXT+QkQmWFN1+pgemM9BzyY5YnpIpyHUbHc9uM5tj8MMpWMMC50cFehQiM
         yAmZ21ZTMaCgfu5O3/batnwP1f9p+XWH4tCRi5eQoY6+2ArZic67IyUEzHTsRRnfIEmf
         bd5M29DOxHUL89VDlhSOKbuubYuI/HS/djRsX3GrP3pKMuVAKvvjNXxSP+OEvweKroDR
         q9byFiUA6xfy1WnxaxtR8WM2HS6V1xpjQCJ18m5Mi8DMQxBaKDO2rloNyyWikJDU/rkh
         br0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3xBSG4Y8qT+96SRcLq+HUghyj+K2UsvNh8wBI8e+mQ=;
        b=r4jKgTSCGba0ezXrdI3eBYgp0HXAJogzGUA3mrixobqoxdkH3lH1Dv8Zj0zn4mzdg1
         jxuIPSFzBi7YuSUvdytBUq3MmfNk3qgYoEd9AqvSaP4m0xIgwqAKTa7Esiw96JYu/JIx
         kC7h+BM+0290osqu32HcW5sucF0FbiDSA9yrXDKIGJwn8xTGqX5gmUaCw/9Y0gauZ61P
         G3MeKb1TPgM1e5QWEtUE3RFC9ax2n0Vi9L+HqnfnsOUdiT10NzcJTywcc5bVymTahMKn
         zO/OVH59Urv8zNbE9ppkyrExZIT7hvlPTZGSBpUvDWvI5SyWuI8Z3ec/wEeM8KWzhe8X
         itqg==
X-Gm-Message-State: AOAM533kjygPcqwfbQINb5aGFVn9luvcJfu47AIpFPgKL8vat0MANFao
        Eug8FX+KhohkQa8PVmsIe2pp4F+YPvgElJpz
X-Google-Smtp-Source: ABdhPJxi3AHcD/bHtECMb+PH3O3vA2DMSyLzH3YLmH63Vhl0VYXTa+i2pkQdR2/WVnMoTLH2bdTZFg==
X-Received: by 2002:a05:6e02:1544:b0:2c1:eb43:db10 with SMTP id j4-20020a056e02154400b002c1eb43db10mr1660453ilu.251.1645659682157;
        Wed, 23 Feb 2022 15:41:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm769970ilu.11.2022.02.23.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:41:21 -0800 (PST)
Date:   Wed, 23 Feb 2022 18:41:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH 2/2] t5302: confirm that large packs mention limit
Message-ID: <YhbGIeksK7Df1QzS@nand.local>
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
 <43990408a10d65058d872f13ea9619e85de7081d.1645632193.git.gitgitgadget@gmail.com>
 <YhZtcEqczAFES+hQ@nand.local>
 <xmqqh78pp3k1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh78pp3k1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 03:26:54PM -0800, Junio C Hamano wrote:
> > It's not a huge deal, and I'm sure we have plenty of examples of
> > slightly out-of-order commit trailers throughout our history. Personally
> > I don't consider it worth rerolling, but perhaps something to keep in
> > mind for future contributions :-).
>
> People need to understand that each such contributor robs maintainer
> bandwidth by not rerolling.

I figured you weren't going to tweak the trailers when applying, hence
"not a huge deal" in my comment above. But if it's going to cause you to
spend extra effort in order to pick these patches up, then I'm sure Matt
would be happy to reroll.

> >> +test_expect_success 'too-large packs report the breach' '
> >> +	pack=$(git pack-objects --all pack </dev/null) &&
> >> +	sz="$(test_file_size pack-$pack.pack)" &&
> >> +	test "$sz" -gt 20 &&
> >> +	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
> >> +	grep "maximum allowed size (20 bytes)" err
> >> +'
>
> This test looks OK to me.
>
> Shouldn't it be squashed into the previous patch?  After all, it is
> a test for the new behaviour introduced by the previous step, right?

Yeah. I mentioned in my response to Matt's cover letter that I figured
the two could be squashed together, and that there was no reason to keep
them separate.

(That was written under the assumption that he wasn't going to send a
reroll, in which case the advice was along the lines of "not a big deal
for this instance, but in the future...")

Thanks,
Taylor
