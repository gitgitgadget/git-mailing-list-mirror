Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8775BC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353237AbiCXV73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXV72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 17:59:28 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E0B8216
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:57:56 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e18so4096582ilr.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 14:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yvmC5lDucQWQ0/XUj0AIJDcivu+49lqa9cSMh40QVs8=;
        b=PKJLa/5BYF/jP6p9HLN4kH1mVic1cg+tDH6J69PnXwiv63vB+V1Ic3ovqV5UU5k75K
         4zf1wOh3HioEIr/NcYLAX8bzZhrvVlqWypXIs4aOO2Av5WV1Y3J3UCW1mMDc3FNAbg8L
         KDcH0KMU8iAIhePN5kbJYuGuRS5AB5JCsGFEGWIe4aRtRgvlApV7Le/eHTWktfjTq5r2
         aCh8Bif3PeMSbQRHTsi4c3H/SXdmmBaYuFIkukYl+isAkfbNAO+jMkarbunTbVD0rpd2
         yti1uW0ncA3GHIS5qz8P8iBBNY2FFCYWJPaX5ZkHwDetA1PvUNOFUZhHB6mF6+XQgllk
         pyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yvmC5lDucQWQ0/XUj0AIJDcivu+49lqa9cSMh40QVs8=;
        b=M2GZA023PygCNgNOHbREIEQ8DxACGIGdoBIUePRuiSZei0uAySPjFM/fbf0m48EQYG
         JjQXHgQtNctLKo/FowV+/GEJmeIHsLecVCmLZ1bBRGjSz3LffzRgDE9DKaYoynnYJ3rA
         MYYuHgMACEHc3UzvCQCsbGHy9qNgoxyNFdfwjO0ndPbt9LO1BeYGv2zx6GuTodX9/vJQ
         iih5fB2/7SzzAlTqRBhyvNNrmBOs/1BUlKJgZBp99+t3mccPwqVbtHxjZtxpXIHD1Jns
         awCeKxwoIibA0I8VnabvF/mGW89+rfGoG6QrJ2Wskw1pHxtcLl8lLXiDOe+iBZKFRzWY
         pyEg==
X-Gm-Message-State: AOAM532KdNwDP2oBr+b998YGPWpfIQjtjkkQetwcLM1Zqxk/o54Kq+HP
        DOPeGNNOAy01gW8vKhsZpldNpA==
X-Google-Smtp-Source: ABdhPJx2mD1oU2B/UscTIxseIQqYNogCv7mGWvipYgUW9eah5pyEGmDWxLuMUYykxeTCM48O3asF2A==
X-Received: by 2002:a92:c241:0:b0:2c8:7a67:ed5e with SMTP id k1-20020a92c241000000b002c87a67ed5emr1622666ilo.143.1648159075602;
        Thu, 24 Mar 2022 14:57:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n7-20020a056e021ba700b002c63098855csm2015120ili.23.2022.03.24.14.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:57:55 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:57:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A "why TAP?" manifesto (was: [PATCH] test-lib: have --immediate
 emit valid TAP on failure)
Message-ID: <YjzpYic+QaOpqolE@nand.local>
References: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2203241434360.388@tvgsbejvaqbjf.bet>
 <220324.8635j7nyvw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220324.8635j7nyvw.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 02:48:42PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > The commit message is strong on the what, very strong in giving verbose
> > output that might or might not clarify the intention, and a little weak in
> > the why and the greater context.
>
> I thought "so that it emits valid TAP" was sufficiently
> self-explaining. I.e. we emit this machine-readable format, but in this
> edge case our output is invalid TAP, now it's valid.

I agree; if the justification is "something we use not-infrequently is
broken" and the rest is "and this patch un-breaks it", I do not think we
should devote much space to justifying why we use that thing in the
first place.

Our TAP output meets the bar (at least for me, personally) of not
needing to be rehashed anytime we change it, so I don't have any
complaints about Ævar's patch message here.

Of course, we should be careful to avoid following that guidance _too_
much, since if it leaves us in a spot where we never question any past
decisions, then I think we have gone too far.

Thanks,
Taylor
