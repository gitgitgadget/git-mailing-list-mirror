Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F24C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD666103C
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhIVTii (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhIVTih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:38:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC2C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:37:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q205so4935974iod.8
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ziW7LaY2YrgfQTN6HmBg0Rt13PzX+CfBBcK17/Dsj/g=;
        b=m6lJsQNPYAMrnE04v4NW2y+lB/YQngPCwUkjzmeifFE5DN42OJumqd106SeOAHapVB
         5NCmeoSGuygOUWw6rsP4aZoCP0pDeQ5N6373IZcpV5YOOIhem5yT/Du4G/EiLwoicuL2
         f93WgRWfPE2ugETb85V0b6vMQjfXlmALnzx+xKXSnpH/ZFjItPdQbnzzqvEanPIYDq+8
         p2gSTkO8cBwSojIbtoVTg8gvjbnGOkGyX3/Y/3ZNxSmt60j588A8GI06akvYUoHpSJmJ
         fYfEfnluTqTGlhxxZcwYDSmpZD02kvk+8KuKVF0J2HErtvIVjhziusyEM7AyxQh24mVo
         dz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziW7LaY2YrgfQTN6HmBg0Rt13PzX+CfBBcK17/Dsj/g=;
        b=ZAqGncM1oMIHYch2mxnAQ/3lvES1hYTtnAWwUExc6E471SKFbKHJncvPKmCD7pHzlq
         kQin7mfsdyKu9Zy2/TGdXjNnxcWq+EBFFybbag96PWAlJgx+Wj7rNUx8prMyfPWzdP63
         Y0JV2POxwaMUE6nfHq6zIhSQu6ledhQmADCgy4rZ0E6pWR6NHvidub4rcUJueZecj6nN
         Zxms7wSxU7x3R3xHNthfWvfa1ElL3W7H8pZ+THyRWpDots2OIB4pITNCwDdmWQ6ZVrwB
         qovG39bFa3RA0/nXgStpDWAXFBO6cCUubV96DUUeCOUpTSffC/ykbUdagRRqL2vP3yZD
         NLdg==
X-Gm-Message-State: AOAM533GVzulF1khmcPV/1THu7fIoE1ZUrdE4MKB2UnO+AXs6EEEyzY4
        JU7MCqcm9naNkF7aP3PHGZbeKo7Phxj6cw==
X-Google-Smtp-Source: ABdhPJyoxLzdhejesq9QlpPd8spwPiCl5FC1+mSbe49NVcOF9t2i8rk+2S1zY7Z7QHntIsZQrEXLKg==
X-Received: by 2002:a6b:f301:: with SMTP id m1mr591497ioh.3.1632339426939;
        Wed, 22 Sep 2021 12:37:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k4sm1447856ilc.10.2021.09.22.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:37:06 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:37:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUuF4SKO4lA/xLKZ@nand.local>
References: <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
 <YUj7GN/qWhw67jyk@nand.local>
 <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
 <YUoJGV0wj0ba7n8X@nand.local>
 <3c9af4e9-f3db-99af-d875-fb11bc8a643e@gmail.com>
 <YUpEX7mmZ0WPvbYK@nand.local>
 <98bd3b94-eb8d-b074-b89d-d86dcefaa995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98bd3b94-eb8d-b074-b89d-d86dcefaa995@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 03:16:22PM -0400, Derrick Stolee wrote:
> On 9/21/2021 4:45 PM, Taylor Blau wrote:
> [...]
> > I fear that we're talking about different things. With your patches, if
> > I munge my .git/info/sparse-checkout file, I can easily get something
> > like:
> >
> >   $ git.compile sparse-checkout list
> >   warning: unrecognized pattern: 'foo'
> >   warning: disabling cone pattern matching
> >
> > to appear. But I'm wondering why the same doesn't happen when running
> > `git sparse-checkout init --cone` while the existing sparse-checkout
> > definition contains non-cone mode entries.
>
> You don't get that warning because it's not trying to parse the
> previous patterns using cone mode. Before my series, you would get
> the warning in a _second_ run of "git sparse-checkout init --cone".

OK. I was confused because in [1] you said that we produce this error
any time we try to load the existing definitions and parse them in
cone-mode.

I would have assumed that we would try to do that during `init --cone`
to read the existing sparse-checkout definition.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com/
