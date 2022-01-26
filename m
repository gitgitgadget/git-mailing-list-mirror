Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1505C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiAZUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAZUSH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:18:07 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C428C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:18:07 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e79so972895iof.13
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZFSROX7zomEdyzq4X7K4I9s/OQDIzektZoT4qyMxiOQ=;
        b=QvB2172SSP14YfSIRelOUWTJOe8hX3pXozCn3a9Zen9SAa2NTB8GcR+uTTj7neBuCP
         +qNMVzVtVETYcXhdqCXesq+ZO9w8SDWfrQ36X7eprQnqMjRQaTGqaIYcvt0O7LlBViwr
         bfjTozNSF6C9YeyhBB8QLKZf0jl3++YrrG3LnYg1/w9Y2+e6/AcHyDzUhn4YRhMzS5BE
         6F9Ee3dkHuMWBXdeKLFllCmYnyffcB0cXCy2y/ciQJGtgVGBEBdzo+Z84QM6imlURp3i
         c0dIPHnD311U3JWszzu06tlWY3VwexvRI4/QyouXLV7p/+rvzozLHrxCLG+nILiFPgji
         VffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZFSROX7zomEdyzq4X7K4I9s/OQDIzektZoT4qyMxiOQ=;
        b=dWIWD8ca72s+WhDXi9EqYrUdWlW60PJRD3N6iKAf0xj3jWStW4uFr95g6KkjbrEHV7
         ctruJtSDd3SQTiRhSvWnV8ZKlvOp2CNQIt1CegPMAVKhlToGUlWBSKAyD52BGNNXbtM1
         uzg17kgKvbTKl7DqVD/6xa/lrHCfCO5TcMC/p3SBPsFIxtU2aCY2qvPwF9GR0ynKy8cT
         8QZZknF/L2b6QriCH3AT81AJq6PaSV+T+M9/gnk5Z7FGmwUEX48RrNQFTo8c8QwH1DDH
         lL4/YCL0/bs2KmYBHtsuRVskEUp9j2aqyUiJpNsum/karq77BGH8WOovybhPWdECJoaw
         CmpQ==
X-Gm-Message-State: AOAM532he0/9QU9vA1hecc1W3C9aYi70uGXambeJ2eeGY1cA4h8u/wg9
        sC18WQNnjeohuZkIWYRw8sDALA==
X-Google-Smtp-Source: ABdhPJxlBvFKzrQGCxM9PJDRFoFjOiVSauuK6do1FA+qJjFnrFz/DdByhDTXijRcEQGp4tOpCSUH4g==
X-Received: by 2002:a02:2a8d:: with SMTP id w135mr177335jaw.258.1643228286363;
        Wed, 26 Jan 2022 12:18:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n7sm10334949iof.5.2022.01.26.12.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:18:06 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:18:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 1/9] t5326: demonstrate bitmap corruption after
 permutation
Message-ID: <YfGsfdHjYMBb2JWH@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <7ea9cced8ec79a8e39948a5e4b8dde6e9b54695a.1643150456.git.me@ttaylorr.com>
 <220126.8635lafskv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220126.8635lafskv.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 04:01:20PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Jan 25 2022, Taylor Blau wrote:
>
> > +test_expect_failure 'changing the preferred pack does not corrupt bitmaps' '
> > +	rm -fr repo &&
> > +	git init repo &&
> > +	test_when_finished "rm -fr repo" &&
>
> Nit: The initial "rm -fr" isn't needed here, and we should aim to have
> tests clean up after themselves, not needing to clean up after other
> tests.
>
> This appears to have been copy/pasted from the test you added in
> 54156af0d66 (t5326: test propagating hashcache values, 2021-09-17),
> which needlessly used that pattern, the tests you added preceding it
> follow the "clean up your own mess" pattern.

I don't think I copy/pasted it, but just have it embedded deep into my
muscle-memory from every time that I've written:

    rm -fr repo
    git init repo
    cd repo

into $HOME/a.sh, which I use as a dumping ground for little tests.

Yes, I agree it's useless here, but it is consistent with the style (for
better or worse).

It's fine if Junio wants to remove it when queueing, but I don't think
it's a big enough deal to matter here (probably not in general, either,
but I wouldn't be opposed to a concerted effort to clean these up across
all of `t` if that's something you're interested in).

Thanks,
Taylor
