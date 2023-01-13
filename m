Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2690C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAMQnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjAMQnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:43:11 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B29363394
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:41:34 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j15so13997014qtv.4
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1sTcra0pSWVrMadrrabH6Ubb672f0D7tYrWAUK5Hkg=;
        b=iE/nh1PhF5n3UI+85BxbtnCgpLWIT7HVNQeyxQxGSRp6wodPm3HR3HwMw42Biy0PSS
         88gd9+tsFDY5mkrzU2PBMV8FmkUctHoKoK+wl4SWYZYCyyvf0TtJ4Nhob3Gh5rYMOg5I
         QZvKAbWNfbQaN+/BYh2wSIwe1AExdoWc9daJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1sTcra0pSWVrMadrrabH6Ubb672f0D7tYrWAUK5Hkg=;
        b=topzj9s6FMuaF/0BQOBvzFA0K8ZF0Xwn++rKu9q12xRDqggnVw1Y5QOMMcX4B+kutE
         4yjGoUlS0WxBdWRsUBhKCFS7cdwQJtX+NO74T/t5eSS7kHY24w4lT7E1NOZ04qxY8gVr
         l4WS9SsbKnGnr4HXEIRBOSjqbteuKlyYW3Y37scu8/8y5W0ccKX2uct0AUqFkcp6XMme
         YDfNM6i5YqwNs4mcalWXh9nODj5poO9cwOupSe6AI6d/0sFwFwi1E2c6pmn7hZ22zvMC
         nmkgr0lacB+y60Lix3SkVSZBtTKZulw6YkicwQ3+8TESOliLAKU2Mqn3Oco34t2ODyam
         Oh1A==
X-Gm-Message-State: AFqh2kqoieGwxYREsxIYbfq8i87k8GBB1qaJ6z8arc0ZEIgpyrABXfhP
        k1MFfVKqHIZBKFaeygnxmZ9J3lZ8wmlfAHn7
X-Google-Smtp-Source: AMrXdXuITQVUxU4RG7KQ+/6N83fMfPMpSOT3Vu8uZlCDwXAIGSHXIjlK8gTn/sW6krlLLzR4SOAI6g==
X-Received: by 2002:a05:622a:4d47:b0:3a7:f183:7f66 with SMTP id fe7-20020a05622a4d4700b003a7f1837f66mr123029671qtb.22.1673628093462;
        Fri, 13 Jan 2023 08:41:33 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id l6-20020ac81486000000b003a981f7315bsm10795589qtj.44.2023.01.13.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:41:33 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:41:31 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Message-ID: <20230113164131.swif4buln2py7tyl@meerkat.local>
References: <20230113133059.snyjblh3sz2wzcnd@carbon>
 <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
 <20230113162721.qwl2asjo542cxe3c@meerkat.local>
 <038b4ea4-2a10-9b5a-14e4-e987a68e93b0@selasky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <038b4ea4-2a10-9b5a-14e4-e987a68e93b0@selasky.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 05:35:57PM +0100, Hans Petter Selasky wrote:
> > Not to discourage you, but you seem to be making statements without a good
> > understanding of how git works. If there is a history rewrite (even one that
> > for some reason goes back millions of commits) all hash calculations will
> > happen exactly once -- on the system of the person who's rewriting the
> > history. After they push it, it's just a bunch of objects that everyone else
> > merely downloads.
> 
> If you used CRC, you would not need that, because CRC calculations are
> "concatenatable", while SHA-1's are not. CRC would just need the first and
> the last hash, and then you would apply the "difference".

It doesn't matter how it works behind the scenes as long as the produced hash
is not unique (and CRC gives you no assurance of being unique). Git is built
on the concept that every object has a unique hash. If this is no longer true,
then it's literally no longer git, but is something else.

Since we're discussing this on the git list, it's not really a discussion
worth having here.

-K
