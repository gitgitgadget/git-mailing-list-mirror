Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827BC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKOTmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiKOTmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:42:07 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F40A21811
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:42:07 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id r2so7946189ilg.8
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UYyGdqLRTv19OAbZGZA4Fo9Ajczg1/1AoyArQ2SJnLU=;
        b=VNmjimksao/fAqzBztCsKgK663O9z65zj11dHUVyvRYcqqMn0SkN0tZjhuD+up4FKs
         86CKubhyMR3u9pKeun/gvBNv0LwhXqGlmev4uu8nK1yENLGm7OTXknkHLxXNrMEZ+BdL
         SvQdrsB8qVwKw0omGAKllOwAxM99nt2w5wCO2saJ/lFFKJab7NXxEJivBqEC4D0Vbbd+
         WqdsDiDcEkrGTCeIXOsdWK6Etgzmw2buBNKuHkG+vdZs2e5MBWXfCFTaRSH0ElHUsI/P
         iuR4AQhfc/bIxHPtdpOO90/HBoRGYe6+gfrZGE99i3hjlQjR3WiXRmoy5TFaYRLLGKjC
         v7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYyGdqLRTv19OAbZGZA4Fo9Ajczg1/1AoyArQ2SJnLU=;
        b=UmlWmRM8biUx/7SSFPiE0o5WJhE6iOKO5A+OokXIRN+ArMZDsnSdE0UM0fP4LVHhch
         r6kN+lhY23hLEhH/kjLwYZGzFi0FQip6W1YN54MaYzCgidr8PrO3XBs9AogVS4ccQqw2
         RjFhaP0VbMQTDElTmJoR1S3aFiC2RZkWwygNN4GfijWqyT2CJ72rxes8F3EDMwUp85Wt
         ri2VMTlpMSsgwiJvQI/OStvCXY40Cy0GsHHGY5N68LRPCtC+e43X8dRMlQPZQL8AIF+C
         8mBxT2HToxPSfl+LbYdJP47/5OGoFBzqc4dck5X+JxMCKhZfEP5zHAFda9ZNH5/wvRzT
         2y0A==
X-Gm-Message-State: ANoB5pmrPjNbxTFgy+oikv06TJ5pFo0kVlJzbtlpJgEktXF6J5qihMkH
        PF1BRxycqQwYg2oBqa/SVkgKMC9dbGROLA==
X-Google-Smtp-Source: AA0mqf5PSluAbFZ6dykLBPyp2k0zBpRt8hWzgtocet3BgPHQ6TX9bqPW6OQZN6wcEyKvIkGbjeViJg==
X-Received: by 2002:a92:c90a:0:b0:302:759b:6fb7 with SMTP id t10-20020a92c90a000000b00302759b6fb7mr2228303ilp.199.1668541326562;
        Tue, 15 Nov 2022 11:42:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020a056e02152600b003007aba03c0sm5508024ilu.66.2022.11.15.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:42:06 -0800 (PST)
Date:   Tue, 15 Nov 2022 14:42:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7610: fix flaky timeout issue, don't clone from
 example.com
Message-ID: <Y3PrjMLcEGfoHifZ@nand.local>
References: <patch-1.1-83eca7b5a7c-20221105T115420Z-avarab@gmail.com>
 <Y2wuEDGMRg99Ifef@nand.local>
 <221110.864jv7ptbq.gmgdl@evledraar.gmail.com>
 <Y2xfNcCfkij6k4Uk@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2xfNcCfkij6k4Uk@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 09:17:25PM -0500, Taylor Blau wrote:
> On Thu, Nov 10, 2022 at 12:55:30AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > But we generally just fail some or all of 3..9 pretty fast, and don't
> > start taking 20 minutes to run the test, when it took 10s before (or
> > whatever).
>
> OK. I still think that in principle this is indistinguishable from not
> running a setup test to completion.
>
> *But*: I'm willing to treat them differently since instead of
> manifesting in an immediate failure later on in the suite, we hang for a
> substantial period of time.
>
> So I'm content to merge this down, but I don't think it's worth
> searching out for more of these in the future.

Having merged this down to 'next', it looks like there is some CI
fallout on the Windows tests, see:

  https://github.com/ttaylorr/git/actions/runs/3473324797/jobs/5805324776

I am not sure how I might have caught this earlier not having a Windows
machine myself. Regardless, let's make sure that it is fixed up before
this graduates.

Thanks,
Taylor
