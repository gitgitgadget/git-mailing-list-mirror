Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA0CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C224610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbhIIOrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbhIIOrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:47:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093FC04E218
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:37:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b7so2579438iob.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lmzsWYym1W4zc6Yza5PZE+VEPPgpvYDvA2uRgdoVI+w=;
        b=rUpEBMktMqpo+OSiOZzqBW4v/tObGBpfDJSC1qH4ZJeglaMtThqpJ8qhmu+W7ycmA0
         v8XA1e1FjgO6gFx7laGL/gOf6Y0ik46+0HydqXERaOtJceHVuL8AJ0ZPV0f+eVH6mt4h
         QwZwaXhgchPK50rTCK046yj2epK39EQPLSgVwixppUu+liinqwtonfmCsnoh8m6d46NA
         yQ89exgVHrRb0T1SDbxjW3RMqXV3q3CcPIYrj1XgFkmMwr2eQbYtsEoq4uLZl6p0ZnFJ
         nqRC+aL4ZFJsNV+zGhBu8eCZU87Pj7tbL0d3kM+usAGkgPl2foup5UD1b2dMPs2YL2OQ
         MRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lmzsWYym1W4zc6Yza5PZE+VEPPgpvYDvA2uRgdoVI+w=;
        b=IfeR0dOii/4zpqEcFz500Pln2qBbAWN404Rjs/+m5BpetaMazy6wylwR2PuBUhN1Zj
         ChdZdyNU60WmsR8NLwQFtDreXJHALRkxeQVm/r7V1yt0YHHYW0DQmYIiAcdfBbnAcGpp
         XBsIeoeJg0/CmyxGNbOIy5enZqT+YMV8s//NdbnUlWWOjB2R+hOwJcC60zse602duJjz
         5Jy2sEpOQTBFRvVPGvt8K4Kk/HtqvEr9SXWeP4Zznryz0vz7GCSZYj1Cgp8q4uG3dj5x
         TzvtN1a75eCYTbqXXHnacMP4KhE4PwRsFQuSncAyg22Waf/1WyKJZ5O0mpVb1RzDQeIS
         zWfA==
X-Gm-Message-State: AOAM5336Y/77K7xBDJ1ch8FgoyOkKM8X3Fggwpjy7BL2/P5ScaKh9cA1
        /FN2Z9G92AHpJPFRMxjg9VtniOsuYU/9THyu
X-Google-Smtp-Source: ABdhPJxJsKORswCTn3sjZIC0gcwVIdsZ35M+SRpga106zBkNffiJrU6iq2xnW8fNWjv7HHhbW9bMBg==
X-Received: by 2002:a05:6602:1503:: with SMTP id g3mr2929707iow.25.1631198228837;
        Thu, 09 Sep 2021 07:37:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d8sm942720ilv.55.2021.09.09.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:37:08 -0700 (PDT)
Date:   Thu, 9 Sep 2021 10:37:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/9] pack-write.c: rename `.idx` files after `*.rev`
Message-ID: <YTocEy7PZqL6nvuY@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <0fb2c25f5ad8bfdccd653f760b1c4beeb05273e7.1631157880.git.me@ttaylorr.com>
 <87h7eufaw5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7eufaw5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 09:46:57AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Sep 08 2021, Taylor Blau wrote:
>
> > [...]
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> git commit --amend --signed-off-by-harder ? :)

I don't think so, though I had to check myself before sending.
Documentation/SubmittingPatches says:

    Notice that you can place your own `Signed-off-by` trailer when
    forwarding somebody else's patch with the above rules for
    D-C-O.  Indeed you are encouraged to do so.  Do not forget to
    place an in-body "From: " line at the beginning to properly attribute
    the change to its true author (see (2) above).

Here it's awkward because you modified my original patch and then I sent
your modified result out. But I think the s-o-b chain still makes sense:
I wrote the original patch, and signed it off. Then you modified it,
signing that off. Finally, I sent it to the list, signing off on your
modification.

> I.e. the duplicate header entry can go, maybe something Junio will fix
> up while queuing...

If I misread SubmittingPatches then I'm happy to fix it myself, but this
was the intended outcome.

Thanks,
Taylor
