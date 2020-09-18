Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78233C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 01:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FF62072E
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 01:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EsRD+sPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIRBPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRBPW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 21:15:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48846C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 18:15:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so4411531qkd.9
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dhipW7gR7MInA5nAUFG0SZOjDIV0H7eMUNm+S0ZZMw4=;
        b=EsRD+sPBhA8Jnpb/fQBi06sSGPccXpxTeyRZcuvpjyXMVGfxHq/CqmZ7/x6l937ihH
         6noDoZIxRflLrwPunrlZxWob/z27oAIsqkkpWo8QTpQfzS3A1OoEUWanLrtEFsQKWTcl
         eYrQhLZyvT/1huNAXE/0Ys91D3g5VlLtcNrzFh9D66yRrWL4WC8U98xItmRsnJSaP9cp
         ic8qoOfIVop5VrEro+2HCgdwQa/3C1XglTvyHPRxuFtG6cyYBLHPpqguYUg5k1Ll7GpJ
         or9nCT4mvwKOO6Ga+8hRxxVYTmPbZLOlilKlF3CyLOh/t2olHujKCKUSfeo3UByhFFVK
         sa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dhipW7gR7MInA5nAUFG0SZOjDIV0H7eMUNm+S0ZZMw4=;
        b=ABJDeYm7ijsq9rFJgRt+mdW4ChaEzJZMs+QHOQ97dmaSjRKyF/cwxqaHjVhDJSqa7C
         omxZkslmQCRMa4yq/irq/ffD5NyYDkgwPys6yYeqOLbMEq1FpIvljOaMwSBjoRku7xFf
         GU4HkPk6HdkXfMr4h5i7Bcnv6A8L51m2Eys6O/Wix4aRLkLjd82j/B+RVnjUpVQuaKGJ
         cKatd5r8KBSPEjq8Eq3TwGFoNyugLjvkiZ6Pewvnmzd9GmuMlTX8Qa0/aIoY6ixHg56z
         r248pQ9dcDffsQ89I1ZVPtXSkeAX3Ivitiz8ZkQPurP20G1Lk2zw7cuLllQFl16HiJqu
         cyJg==
X-Gm-Message-State: AOAM532VvCuL5BqR8jjm4jqSJjMe3dl8u3PI1ADSBF89v3BPdNHK5E+E
        QVfcYA9s3CEGh4pGg2iw7lhZgg==
X-Google-Smtp-Source: ABdhPJxYAMwKFY4AAGhrPQ1Qs3azeFWRIdYhJFLC1udzTdRFfGj89iHqhDPi+KxwpRFyq77qa5F++A==
X-Received: by 2002:a37:8405:: with SMTP id g5mr31257857qkd.248.1600391720301;
        Thu, 17 Sep 2020 18:15:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id e9sm1105399qkb.8.2020.09.17.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 18:15:19 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:15:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH v2 10/13] bloom: encode out-of-bounds filters as non-empty
Message-ID: <20200918011517.GA2013074@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
 <4653b5b4bcd254a3791797214b46722b4062dc18.1600279373.git.me@ttaylorr.com>
 <20200917221302.GC23146@szeder.dev>
 <20200917231344.GA1591704@nand.local>
 <xmqqo8m3oqis.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8m3oqis.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 05:52:11PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> > In practice, these boundary commits likely occupy a small proportion of
> >> > the overall number of commits, and so the size penalty is likely smaller
> >> > than storing a bitmap for all commits.
> >>
> >>                  |      Percentage of
> >>                  |    commits modifying
> >>                  |   0 path   |  >= 512 paths
> >>   ---------------+------------+----------------
> >>   android-base   |   13.20%   |   0.13%
> >>   cmssw          |    0.15%   |   0.23%
> >>   cpython        |    3.07%   |   0.01%
> >>   elasticsearch  |    0.70%   |   1.00%
> >>   gcc            |    0.00%   |   0.08%
> >>   gecko-dev      |    0.14%   |   0.64%
> >>   git            |    0.11%   |   0.02%
> >>   glibc          |    0.02%   |   0.10%
> >>   go             |    0.00%   |   0.07%
> >>   homebrew-cask  |    0.40%   |   0.02%
> >>   homebrew-core  |    0.01%   |   0.01%
> >>   jdk            |    0.26%   |   5.64%
> >>   linux          |    0.01%   |   0.51%
> >>   llvm-project   |    0.12%   |   0.03%
> >>   rails          |    0.10%   |   0.10%
> >>   rust           |    0.07%   |   0.17%
> >>   tensorflow     |    0.09%   |   1.02%
> >>   webkit         |    0.05%   |   0.31%
> >
> > This is very useful information to have! Without the total number of
> > commits, it's impossible to know whether or not this is a win over the
> > BFXL chunk. But, since the number of commits is probably "large" versus
> > the percentage of boundary commits which is "small", it's almost
> > certainly an advantage.
>
> Do you want to include it in either the log message in one of the
> commits, in code comment, or a technical doc?

Let's put it in the commit message. I think that it's useful enough that
people interested enough to dig through the commits would want it, but
too detailed to be as visible as in the technical documentation.

> > So, I think that if it's truly misleading, we could revisit this after
> > the topic is merged. But, I'm not planning on changing anything at this
> > point.
>
> If you do not want to help us go the last-mile to completion, that
> is sad, but I do not want to see a basically good patch stall like
> that, so let's find somebody else who can do the helping ;-)

I'm sorry to give off the impression that I do not want to help; that's
not the case. After reading Gàbor's email, I thought that the changes he
was suggesting were minor, and was trying to say "let's do this on top
and apply the important bug fixes first," not, "I am never going to
touch this again".

> Here is what my trial rebase produced.  I'll queue it to 'seen' (if
> you prefer I can send a full v3 patch, but I expect that you know
> how to fetch from 'seen' and review locally) after checking if the
> result passes the tests locally; an extra set of eyeballs to verify
> the result is pretty much appreciated.

It looks off to a great start; and thanks for taking the care to make up
for my laziness. Everything you did looks good to me. I touched up
"bloom: encode out-of-bounds filters as non-empty" locally to include
the table above (and some commentary around it), so I'll send a v3 to
the list once I have finished running the tests.

> Thanks.

Thank you, and sorry again.

Thanks,
Taylor
