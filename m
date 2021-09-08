Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEEFC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C126108D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbhIHCZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhIHCZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:25:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F7FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:24:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y18so1205776ioc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=81UcoHzQ8PpWP7rqFvHuKJmKWnqtssulnwioT1ujEMM=;
        b=YM5wVfWb7nUeBGK9JP3wuRg6KIy2opuOeA4pOWxyErhK/adNfqje17TESn5ElBtZKc
         kmWH7KRKJ10YD7SqyQsQn1OeW3ok7+upu0/2KxXxzXhM4sg6RUAzx+jYSqe0cdutY3e3
         v+3OHvxjNPpkiCeBTK51Mzs0By8mzTc+DhhOZjg7+lIyIYQtKFEpyhdVek2OlCfVtssz
         rUHVrylA+NThMKYt6keXAKI05z4W2ikpOQbT2gW9pLaH9bQEWnPq8D9LO2UQeWy91uY5
         NdyhPUAE8AcskVGz2Rvv1h8LvdkKtx56i048xpfRaVlP3blmvwCED+mQuPnyYO3hsqiT
         uOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=81UcoHzQ8PpWP7rqFvHuKJmKWnqtssulnwioT1ujEMM=;
        b=GoXyJ/+zyNTepCOKH7MnsLbXiQZdZofYSRryHaQ9g5ILGVL/ZRRzunwEUhvFl4OLgV
         uyuv1KPU2FcyKvLpRJm/bqQO8IIbIi8C6DwOua0+Ap54iFJoZtYF4nBVyhnFKlSxSsDT
         lUMfvsL/5fjj3jBm1j355LPMIv3XOclQflMOniiMOujYxewm7dUh6dM9bHcIJveTzfdm
         fdLqKEB6OM0TeNxHooRqRodWqeBbaFYL9lhwem4SKpWvgFoMf6/bPG/yAZkH4SuopQaD
         1JimDj36e9qhC9YGjmnR+b3Ry3IpxQ+xC5CYpzauPK5Jhc7Kj43X91ePf3/+OTLJRqLJ
         Xtyg==
X-Gm-Message-State: AOAM531NiMrXT7ff7687iyXaEfhHDAO/hj/FHZNpAMReVI+/zDKxnvbC
        e2o9lpng0NJRtijTJRS8RpdxTw==
X-Google-Smtp-Source: ABdhPJwWptPk7XaOGRPCCC+/yYpY/gIv1tQCK795PSRGVSA8iYXvZE5xXN9U3wZMGwFN5W2CWzAj2w==
X-Received: by 2002:a02:cc59:: with SMTP id i25mr1363840jaq.125.1631067865708;
        Tue, 07 Sep 2021 19:24:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h9sm396423ioz.30.2021.09.07.19.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:24:25 -0700 (PDT)
Date:   Tue, 7 Sep 2021 22:24:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/4] t/helper/test-bitmap.c: add 'dump-hashes' mode
Message-ID: <YTge2NlvvRC+VoPY@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <918f9b275a1a03b6383e32f28cf1db26a6d67633.1631049462.git.me@ttaylorr.com>
 <878s07kfsg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s07kfsg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 03:37:05AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > +static int bitmap_dump_hashes(void)
> > +{
> > +	return test_bitmap_hashes(the_repository);
> > +}
> > [...]
> >  		return bitmap_list_commits();
> > +	if (!strcmp(argv[1], "dump-hashes"))
> > +		return bitmap_dump_hashes();
>
> Perhaps the return code only for the brevity of this test-only code?
> Seems like having bitmap_dump_hashes() do the "return 0" would be better
> in that case.

Yeah, it is silly to just return a constant from bitmap_dump_hashes
(and ditto for bitmap_list_commits), but it makes this easier to write.

I don't care either way. If you feel strongly, then please say so (but I
can't imagine that you do).

Thanks,
Taylor
