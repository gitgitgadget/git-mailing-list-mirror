Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A227C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF06560F23
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbhIIBOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:14:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA89C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:13:13 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z1so201400ioh.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mbYDbpfaG2WfVY2s5a5S19UJ4GArn12Qta6NQPnS+9Q=;
        b=ShrFjZ66kcEYT70/GLUXr0tSIOVHwqTjn/tWt+tvxcrvAfq19lJRUyy7K7Jsvgt79g
         0Lp1jVa7BU0/z5AeHxiJ62F+Xm+uQGBZYGYD5VN5a2xxExRogScZmOL1TvQHRCAlsdtL
         UAxIsvwb3M9XOdppy8VHUHuywa4mug9Cyl/q+sHUmmrKiEeS0tH36fu3tUtqJfaJUpje
         u8MSmbKHrCq+n0M0gpgcdEqk/ZcrENyXCJSTWr1fvAX+VvwC8Ghd24yuRXfif0TUybg2
         ++EW2wNSan9JMron5KxevIJ6WXtXwJkaGmTV8JjTWspqnvJhnTpv0cNhrqHnBTZK+HHI
         EklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mbYDbpfaG2WfVY2s5a5S19UJ4GArn12Qta6NQPnS+9Q=;
        b=35HqXHdsQcCqfz30eLWF6f7UnqsSN40bEcUfJ6YsEKO/o3grxiRWiQ+lyV8yoyaEri
         DPHJ3ldIWL6prp2tI4eRpOPGeiBLaqgVZVY/XMm1P8uY9ZG+KtGdaQ5rwZ2yTKgD0Vzp
         cf3CwnBIQlGnqZerWnTOp1LGlKxrqhA0bNiPyMyEYuShbgffWtrTVHtph1SGI54Ag3lg
         iroNZmR1UmSbEtWhcsAegL0sDGfKXhBSInALqXSzJWWoSUWmlEYIR+p1t5rVTD3Bka7Y
         IuPdmPV2531Z/1Ft4uZtxnlGf+oStYPqHaefCxsJUt2QjYw/lhTiGMQNzz8kjfsSItBQ
         GC8Q==
X-Gm-Message-State: AOAM532wKvIser5EErT7spXEr/koFGhPppDbZwKoYEkkOYHOhVyTSvNf
        qOD3PnaGlGJ7pLW2hENv2hnghA==
X-Google-Smtp-Source: ABdhPJwz61oo/W1kLUtbdrjLoBuv4KdA4o//ErNp8ffx2fqj5Ehu+a84Sb5xgJDAX40teaTxkUfLFw==
X-Received: by 2002:a5d:8715:: with SMTP id u21mr384132iom.1.1631149992868;
        Wed, 08 Sep 2021 18:13:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16sm142195ile.72.2021.09.08.18.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:13:12 -0700 (PDT)
Date:   Wed, 8 Sep 2021 21:13:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/3] prevent opening packs too early
Message-ID: <YTlfp/tRmNy0kt+b@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
 <877dfqhb8n.fsf@evledraar.gmail.com>
 <8735qeh8h5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735qeh8h5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 02:50:59AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Thu, Sep 09 2021, Ævar Arnfjörð Bjarmason wrote:
>
> > On Wed, Sep 08 2021, Taylor Blau wrote:
> >
> >> Here is a very small reroll of a couple of patches to make sure that packs are
> >> not read before all of their auxiliary files exist and are moved into place, by
> >> renaming the .idx file into place last.
> >>
> >> New since the original version is a patch to apply similar treatment to
> >> index-pack, as noticed by Peff in [1]. This should be queued before Ævar's
> >> series on top.
> >
> > I read Junio's earlier <xmqq8s063m7m.fsf@gitster.g>[1] as a suggestion
> > that we combine the two into a singe series. I do think that yields a
> > better end-result, in particular your 1/3 is much more readable if the
> > refactoring in my 2/4.
> >
> > I'm mot of the way done with such a rewrite, which also incorporates
> > your suggestion for how to manage memory in rename_tmp_packfile(), but
> > I'll hold of on what you & Junio have to say about next steps before
> > adding to the re-roll competition Junio mentioned...
> >
> > 1. https://lore.kernel.org/git/xmqq8s063m7m.fsf@gitster.g
>
> I've got that at
> https://github.com/git/git/compare/master...avar:avar-tb/idx-rename-race-3

Beautiful :-).

I mentioned in my response to [1] that I missed that message when
sending v2 of my series to fix a couple of these races. And I was even
happy to unify our two series, but you did all of the work for me while
I was eating dinner. Thank you!

I fetched your branch, reviewed, and am happy with the result. So I
would be content to apply my s-o-b to your patches and resubmit them as
a unified series.

But I did wonder if you wanted to include [2] in this series as well.
It's kind of different, but also related enough that it probably makes
sense to just pull it in. So I'm inclined to just do that, unless you
have any objections.

Thanks,
Taylor

[2]: https://lore.kernel.org/git/patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com/
