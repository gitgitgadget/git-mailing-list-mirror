Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB77CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjJJUfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjJJUey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF30ED
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:53 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77409065623so359028285a.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970092; x=1697574892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uabCbZd38co7wxHR7CqxCuGHk4kMlq7YArvbQKC3YmM=;
        b=i6mCxcRJwk3V3OGZ3oG79iNHRGFp70ec1z8b+Cuf2is5ksfkMekTrtnW11sKY+Bz+R
         DPZSN/Mb8+RnAkrt2ld+ukd6RwmDXNEeCO/RozbRv4UttxkfVVQE6gockMdHqzA9te1F
         YDuOHp2ypY5wLgpT82Ti3zki1LOSd80teqxPVfc/z9IdebmSydKDDGnu7d0S8OmYkDun
         qUyogSott7JB/5JIo1L0NpYqAnVBwT0y+Fc5GOqc6p9jkvRNMzHc/9ISPdFgkopK3fdJ
         azuNRljn66Sv6TfweiaCPkVuZdLnhAklgeZ0/aNcutuaxGgryr786/4/fm4bZkS1/dDH
         ygdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970092; x=1697574892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uabCbZd38co7wxHR7CqxCuGHk4kMlq7YArvbQKC3YmM=;
        b=tXT3LqlXPf2MrrasCbUjhkTSYY7qcGtF/tF00Zl+bovfU5Ps00pDumLMo0Jtyqtdff
         jHMqcHGoF+fSxAzGLA8fYas9Gc+3jFXUFTSqQ70xqZTErShzzjK+2LFVGaAfSKxiFe9s
         6JWbcknGd5oqxbVZQ64y/vmwJXALSansGr9QfeQrJZLZHw/GhrGPjzTKa0YIEU51IZlS
         XfpnIQSSuZKs4T3fDmyN7Ddur281mbOvJLw+c4kp/1QfAXzBywuMnRC1MRwmtuGq7bWi
         ZfIeOO7MOX//Yt0HQKwypCokSzTrZy6INcTSKhbtEvOC7zwHSVaN7pB8dAq3mRDH6qqT
         Iw/g==
X-Gm-Message-State: AOJu0Ywf/ab1/yysl25OjtLP5ibg0X/KPw1QJOhpI8gSDYEg55LWcWML
        y+I9VtX5ZuEYnszyQr0HbyTawg==
X-Google-Smtp-Source: AGHT+IHbecjmP7gBheJQPo0spFqHlRVOHaJB/JhCGf25OitR5GYYxqFNhg4te8byA1ZQ+02EoBdyng==
X-Received: by 2002:a05:620a:4001:b0:775:6b2a:d749 with SMTP id h1-20020a05620a400100b007756b2ad749mr21228244qko.6.1696970092443;
        Tue, 10 Oct 2023 13:34:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s27-20020a05620a031b00b00767d572d651sm4626066qkm.87.2023.10.10.13.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:34:52 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:34:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZSW1asgEDWMSQkm+@nand.local>
References: <20230830200218.GA5147@szeder.dev>
 <20230901205616.3572722-1-jonathantanmy@google.com>
 <ZRIRtlbsYadg7EUx@nand.local>
 <20231008143523.GA18858@szeder.dev>
 <ZSRD0tK3bk67aDw4@nand.local>
 <ZSRVJ3iASRaDGc80@nand.local>
 <xmqqr0m3y3o2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0m3y3o2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 12:52:13PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > However, I am not entirely sure I agree with you that this is a "new"
> > issue. At least in the sense that Git (on 'master') does not currently
> > know how to deal with Bloom filters that have different settings across
> > commit-graph layers.
> >
> > IOW, you could produce this problem today using the test you wrote in
> > <20201015132147.GB24954@szeder.dev> using different values of the
> > GIT_BLOOM_SETTINGS environment variables as a proxy for different values
> > of the commitGraph.changedPathsVersion configuration variable introduced
> > in this series.
> >
> > So I think that this series makes it easier to fall into that trap, but
> > the trap itself is not new. I think a reasonable stopgap (which IIUC you
> > have suggested earlier) is to prevent writing a new commit-graph layer
> > with a different hash version than the previous layer.
>
> What we probably want more urgently than that stopgap is to perhaps
> teach the code pretend as if commit-graph did not exist when we
> detect multiple layers use different hash versions (or perhaps only
> use the base layer and ignore the rest as an anti-pessimization), to
> protect correctness first, no?

Very good suggestion, thanks.

Thanks,
Taylor
