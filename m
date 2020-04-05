Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59400C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 00:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C2F206F5
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 00:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UffLKWaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgDEABM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 20:01:12 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32973 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDEABL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 20:01:11 -0400
Received: by mail-pj1-f68.google.com with SMTP id cp9so1912227pjb.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9OXKjFFreTdrLZnTw0BY/j792y0n/lEMFmZXhqo2RBE=;
        b=UffLKWaaSL50N07fOOUi8XAex/cx6wudFTyJyHtV3BO2B1llPc3+NaJOw2GVSW760Q
         srofenZuCU3xa0uZocrWYKuyNEMIJYY39N7H4pYyA05hC2ikRicVCxy6XE7Nrb1o9TjD
         DRSSxJCP245O6xN4qxgXf1sHIG78TzP5u6enfOYdv5XI8d7n9JyY8KWfIApCapVe0M4g
         ig7JQulT0Vo0JHueSFAgIi9wii2+Bece6VQ5n9wzlIoxrS8q2NC529EOIB42kFFQbdMM
         ukfznp/+v9xbqqSn39nszQml91tlVerUmAdB22vNpujqyeMkcsvZndIHeGdtap/rXnmp
         pZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9OXKjFFreTdrLZnTw0BY/j792y0n/lEMFmZXhqo2RBE=;
        b=GUN988+djQdpaY0HItIlB2b6Np999jpzC/qaUrnU4nOTFyavRZseUMm7EA6DxSjmt+
         /dyMsk52zqIoT5VnISc6lt5RAsM37qPLtKUFigW6kpG7G/kXVJr1/4CYH05I/51u0Iw5
         hbulCDtUsy7d/oZrKG4fOzCRcGtTNupExdTvoPppE61RU+99bxg0A4z0kLJuf88uHlLK
         OU1Wbr2qJ5DxBrTlWZtmZ0QYETEvH4KuQFaCOs6Mn/cUYgwBnAMw9w1bBS3ERKHZBv7Q
         NBeH1D5ysgU0YVCeY8ucwutPctYv27L+TR4uoQW7dkjzADOZCOauQyDSyYqaGHX69atG
         Si3Q==
X-Gm-Message-State: AGi0PuZ8wRnL+MOWOWUqaiQ/oEZxXDKHzIRlZ6C25UZCOVve8yR7+mZs
        C5exybkJktsgPfPuM77iWpSzxldq
X-Google-Smtp-Source: APiQypKQTXhChj0hc7+CyhVkd96K75biC6Gw95mStVapeYvw9vX/ofyN3syJ3DclUpV4JdJ5csOx6g==
X-Received: by 2002:a17:90b:292:: with SMTP id az18mr17789513pjb.126.1586044870915;
        Sat, 04 Apr 2020 17:01:10 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id 71sm8560013pfv.8.2020.04.04.17.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 17:01:10 -0700 (PDT)
Date:   Sun, 5 Apr 2020 07:01:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
Message-ID: <20200405000108.GC1896@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
 <20200403084654.GK2224@szeder.dev>
 <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-04 22:08:56+0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Gábor,
> 
> On Fri, 3 Apr 2020, SZEDER Gábor wrote:
> 
> > > +	CI_TYPE=github-actions
> > > +	CI_BRANCH="$GITHUB_REF"
> > > +	CI_COMMIT="$GITHUB_SHA"
> > > +	CI_OS_NAME="$(echo "$RUNNER_OS" | tr A-Z a-z)"
> > > +	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
> >
> > Hmm, if "macos" isn't not equal to $CI_OS_NAME, then set
> > CI_OS_NAME=osx.  This is head-scratchingly backwards, and I think
> >
> >   test "$CI_OS_NAME" = macos && CI_OS_NAME=osx
> >
> > would read better.
> 
> I can understand where you come from, but your code is not `set -e` safe,
> which is the reason why I wrote the code this way (compare to the already
> existing code in the previous clause, which was copy-edited here).

I certainly saw a shell that broke on

set -e
test false && ..

I couldn't recall it, though.

Would it be OK if we change it this way:

	if "$CI_OS_NAME" = macos; then CI_OS_NAME=osx; fi

-- 
Danh
