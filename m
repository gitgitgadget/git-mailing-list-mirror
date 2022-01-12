Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3189C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356576AbiALTKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbiALTKG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:10:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DBC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:10:06 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id c4so3330074iln.7
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GtXiJXrP3703wLIuOdDAjTROykxG+8apSv849UDqYi8=;
        b=qeg47Z9t9w31O4vZDf49jjT/lYAEJULvmLVlp6zBEE9OlPq8fKjCvwL7Y14GUI1roG
         c3u/eboiKzPYjFQTqWL3fhOmu+glo2yWzvjGgrC2BC7Uh0IeC52xuUr24IDYG6BVobdP
         9n3DwgyicqEMyEj0KPVykEbf+vU6g/JfQPIvdEo05T6EdJ3CIFV6hYqijTr8YVj6+FZm
         7fCRXiek/PGuDqt9vs5NBqw+GgesQ5gPyANDg+WwXZhj3uJpVMe2vj8uGcGcolaiLTjn
         ZFhQUImXkuBrZ6Tho49H53FWd+labptRjpw0X52+iVl/a+1xyZ3LeXBrrPI8BBu4eHfF
         lJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GtXiJXrP3703wLIuOdDAjTROykxG+8apSv849UDqYi8=;
        b=WbX7Cu8K/QRE1ZSA8KZbNQ4XLzaOfGrNKBYTWYrWW+fM9MgDkkJUDZI2daJR0g2UiW
         rj/BuRX5wNDra5b8fPrj6KO10lcssuj3VJQzgLdbdZ1gZD1TrLpK9rf6JyB5zQdukIFd
         jjxqIkzMeimL1ZgDmEikXge6J5o+sS6WH+yC3P5u9D3NkgF24K4YYfCTb9VWaN9+QZwM
         M/c4HXuDj2A08T3ZopHaNh/Pxd7RMDneLhFOUmQzMBFsp4SgVC+RLhBM2KrEMpYuNxF4
         d6xWAc6vRytsOvhq/k7Hzi/45wWwRzBQfGgLXTt3pQOJuJNwuJtwLVAiG/9N8Lefsfbw
         vaRQ==
X-Gm-Message-State: AOAM530cnli8Xue+HLUoNwOHKpQGeQNeQT/f8eKfwRcud6dS+t2ey6NP
        j633b4e6nK+JprG32N8frLJJQQ==
X-Google-Smtp-Source: ABdhPJxOcTm45Mz4z28vsVJ73v39NGdpuPG1Wy85zOoQKiKv81E8TEC5BbmJ4N38BqikahqJa8QsJA==
X-Received: by 2002:a05:6e02:1b0d:: with SMTP id i13mr651216ilv.202.1642014605749;
        Wed, 12 Jan 2022 11:10:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s6sm370182ilq.21.2022.01.12.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:10:05 -0800 (PST)
Date:   Wed, 12 Jan 2022 14:10:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid
 SunCC warning
Message-ID: <Yd8njHz2m099iDfL@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2201121518360.2121@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2201121518360.2121@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 03:21:46PM +0100, Johannes Schindelin wrote:
> > diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> > index 8ca988d6216..5dc89eda0cb 100644
> > --- a/t/helper/test-genzeros.c
> > +++ b/t/helper/test-genzeros.c
> > @@ -3,8 +3,7 @@
> >
> >  int cmd__genzeros(int argc, const char **argv)
> >  {
> > -	/* static, so that it is NUL-initialized */
> > -	static const char zeros[256 * 1024];
> > +	const char zeros[256 * 1024] = { 0 };
>
> This diff does two things: add an initializer, and turn the variable into
> a `static`. The former is the actual fix that is required. The latter is
> not. During the -rc phase, we do not want to see any of the latter. It is
> unnecessarily controversial and distracting, and can easily be postponed
> until January 25th, 2022.

This assumes that making the declaration non-static isn't necessary to
fix the warning from SunCC.

I would guess that in reality it probably isn't, so removing the static
designation is a stray change, and this would have been easier to grok
as simply:

    -	static const char zeros[256 * 1024];
    +	static const char zeros[256 * 1024] = { 0 };

But to be honest I don't think it is _that_ big of a deal to make such a
small change during this point of the development cycle.

Thanks,
Taylor
