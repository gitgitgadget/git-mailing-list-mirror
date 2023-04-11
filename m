Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9496BC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDKVWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKVWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:22:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C890D8
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:22:08 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54ee17a659bso184334127b3.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681248128; x=1683840128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AqTh/P4fVYPToKldPt/u/cPz+d52mqnVizo0M4NcMmY=;
        b=mX3paJZ4I3TnuqYu6dmnpo0aTBZX107M6pX07a5V4z1T4fJu18yVuI2cpqXD5hgy76
         gNsDOaABOhnvp3312RINBC+SX4wy77EzPvrwePIjOAqc3zEcspxSBQUhioFMPqgqsoJD
         ES74mlO2TUThE4gqNIPBtq09hLK1OJ3MBbkAnUZxXFH66PphaEs5iUkcXq3lJ3tpsVin
         IxmldpGHbtLRufXwvZctaMtpn7dobw3BS0TEogpi9epnaqu2dqp0ZEeNxcxLlTzodT8U
         fZezJasVogWIIwhJQF6nhgN38jGhmEZDclBNYM9qoBYgn3KIn9SGicYw0genqFi1w1io
         o8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248128; x=1683840128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqTh/P4fVYPToKldPt/u/cPz+d52mqnVizo0M4NcMmY=;
        b=FfuxP3h4TUCynL5YYHGdI4hlXQ7g3HL/xdnx8ejQ+gW2bXhFmSVLJixxtWoQVYeZa1
         /iGCzLGpoT0w3+eafSM0TT9NUu9pnijKqxI7Xv5g4T7klLmeD+3YFx0tA/WXC5b8WOi/
         5gCrj+u2CVujiz/lByuSdrHyTfAnnPyEVAOAApL/rmUlh03ZzdP6yBJoCJhUf0kivCvM
         RJn5VI7oxZhiA12sQGyb7AmJCNnyEB5yh+S9i98CJRWUFIJxKYhhNorVfqbqcTMK2u+S
         xOaZVBY8ieuUOrBVKw8s0oI9F1mk+VbhU0koCUf3Uo0azEGtccTbKtAvzMD85Tx7UsQa
         QE0A==
X-Gm-Message-State: AAQBX9eSAdZMc3FoEWo5UD6nWNC5xdLVchqnOVq+MfLeaPXySv7NCmNY
        0zwzBAYUw3hj5vjTrAQcf7p73DRSslkbpVhn6vWgpQ==
X-Google-Smtp-Source: AKy350aslUZuf7hs6sHHwvASiABmgCaavq7E8OlbFN26AJKsWtfdAyf5c7AfhufCz4f/2QdoS1Lp+g==
X-Received: by 2002:a81:9484:0:b0:541:826c:2104 with SMTP id l126-20020a819484000000b00541826c2104mr9540593ywg.49.1681248127742;
        Tue, 11 Apr 2023 14:22:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q63-20020a81b242000000b0054c0c9e4043sm3732131ywh.95.2023.04.11.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:22:07 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:22:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-ID: <ZDXPemH0d3YWnpjL@nand.local>
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
 <20230411210633.GA626331@coredump.intra.peff.net>
 <20230411211604.GB626331@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411211604.GB626331@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 05:16:04PM -0400, Jeff King wrote:
> On Tue, Apr 11, 2023 at 05:06:33PM -0400, Jeff King wrote:
>
> > On Tue, Apr 11, 2023 at 10:53:59PM +0300, Jonas Haag wrote:
> >
> > > There is an infinite loop with an accompanying memory leak in
> > > annotate_refs_with_symref_info that was introduced in Git 2.28 (I
> > > think in commit 2c6a403: “connect: add function to parse multiple v1
> > > capability values”).
> >
> > Have you tried to reproduce with a more recent version of Git? This
> > sounds a lot like the bug fixed in 44d2aec6e8 (connect: also update
> > offset for features without values, 2021-09-26), which is in v2.33.1.
>
> Never mind. I was able to reproduce (I never used klaus, but it's
> packaged for Debian, so it was pretty easy to do). And yes, the problem
> still exists today. And bisection confirms it's from 2c6a403.

Yeah, same here. I hadn't used it either, but it's easily installable
via pip, too. Indeed, you can see the value of *offset jumping backwards
in `connect.c::parse_value_value()` (whose caller in this case is
`connect.c::annotate_refs_with_symref_info()`).

Thanks,
Taylor
