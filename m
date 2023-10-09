Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E9CD612E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 19:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378397AbjJITb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377727AbjJITb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 15:31:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED7A93
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 12:31:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457899d5bf6so315319137.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696879916; x=1697484716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VnzCamubBB73IQv4Q+K8LwaU7A+bxjXTvAWhNeFm6v0=;
        b=OgH5vVjjSZIby1l0opdTMFve2T0dt2HRv9sl4ld1iLy1Lttg99h+h7yosfp5e0zB3o
         QWWtW478gyNVDyn5J6al0IqNsFU2OZz2rVQJGJEwcrfD50snOYGhlT5huqyoF1IPTjPW
         Hzx09UZF0VBxVAfgJ7o47hTvo6PD5J1KWO5rKLPRToQFYeRqRG1sEI2NlpQcnn/7VHCi
         q1yu5z4+uwn3r3V9VmJBMbr0eb3TqTbYxCyrGcpLdMYyMbFSAc25Zqcwn5d3GTI44LVd
         8gsV5rJJBObsfFB4IIYvrvC5q5qkMf7tl6jIo8l36CJrrjR5VK5lfYyjJMmHxzkoE/ZH
         FSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696879916; x=1697484716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnzCamubBB73IQv4Q+K8LwaU7A+bxjXTvAWhNeFm6v0=;
        b=p46NfhibBvS4e5a54rojtRPTdWsrqHbAK7eSPcyf3/6IAF4Y3kRLQ7aiT8LYk0MNRg
         p/dvH/vH4ur3yNT2dXttASo52YhQJMLeiw/8vM/mxh2sMiVMGelxoPXLE6bUvvpV/Px7
         Ml3P4Yuk2XXol3EN5CzX9GLVciaA0ATWUYcfo9sV3ZVG08u8kxK0HG5bzmAuzYL2R88Y
         PF3C/CnlBrXbtxvfp09poCXiz0rAGLPTRp2O/00MwIbpHLiVWPppiGtVTjjVH/Qwx6W3
         l9INiQmZk6t1WCF2S3y8KQ9QwLJb1kRXoeAu06e84TDtP+PzOZWfC+fpfqSoGahMrgtm
         4q2g==
X-Gm-Message-State: AOJu0YwIHGzIPTPo5RKpW+gftvIWVMdl6Gj+fdI8RZwMuBOEAaynvEHi
        6Zl598SyuwyqJd4yOlA+DsPNyw==
X-Google-Smtp-Source: AGHT+IEtU5Mgcsth1Mr0r29B7HZGiOq4meCaedR4mOEjrccaLYnIr0pJqMbJVI4ZWza/RT9Caag+TQ==
X-Received: by 2002:a05:6102:34d7:b0:44d:4a41:893e with SMTP id a23-20020a05610234d700b0044d4a41893emr15226981vst.6.1696879916151;
        Mon, 09 Oct 2023 12:31:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a15aa00b007659935ce64sm3740417qkk.71.2023.10.09.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:31:55 -0700 (PDT)
Date:   Mon, 9 Oct 2023 15:31:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZSRVJ3iASRaDGc80@nand.local>
References: <20230830200218.GA5147@szeder.dev>
 <20230901205616.3572722-1-jonathantanmy@google.com>
 <ZRIRtlbsYadg7EUx@nand.local>
 <20231008143523.GA18858@szeder.dev>
 <ZSRD0tK3bk67aDw4@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSRD0tK3bk67aDw4@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 02:17:54PM -0400, Taylor Blau wrote:
> On Sun, Oct 08, 2023 at 04:35:23PM +0200, SZEDER Gábor wrote:
> > > Hmm. I am confused -- are you saying that this series breaks existing
> > > functionality, or merely does not patch an existing breakage? I *think*
> > > that it's the latter,
> >
> > It's neither: the new functionality added in this series is broken.
> >
> > > since this test case fails identically on master,
> > > but I am not sure.
> >
> > Not sure what test you are referring to.  My test demonstrating the
> > breakage succeeds when adaped to master, because master doesn't
> > understand the commitgraph.changedPathsVersion=2 setting, and keeps
> > writing v1 Bloom filter chunks instead, so all commit-graphs layers
> > contain the same version.
>
> I was referring to the test you sent back in:
>
>     https://public-inbox.org/git/20201015132147.GB24954@szeder.dev/
>
> but I think that I should have been looking at the one you sent more
> recently in:
>
>     https://lore.kernel.org/git/20230830200218.GA5147@szeder.dev/

OK, I think that I now have my head wrapped around what you're saying.

However, I am not entirely sure I agree with you that this is a "new"
issue. At least in the sense that Git (on 'master') does not currently
know how to deal with Bloom filters that have different settings across
commit-graph layers.

IOW, you could produce this problem today using the test you wrote in
<20201015132147.GB24954@szeder.dev> using different values of the
GIT_BLOOM_SETTINGS environment variables as a proxy for different values
of the commitGraph.changedPathsVersion configuration variable introduced
in this series.

So I think that this series makes it easier to fall into that trap, but
the trap itself is not new. I think a reasonable stopgap (which IIUC you
have suggested earlier) is to prevent writing a new commit-graph layer
with a different hash version than the previous layer.

How does that sound?

Thanks,
Taylor
