Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A293FC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbiEZSMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiEZSMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:12:01 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED74AF338
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:12:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a10so2347403ioe.9
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eeGZnYho+8DbqwImmKXnMQBemxMERL04S/vNOPBR47I=;
        b=V6I0fx/pPmBxFlyid/EtKkdiILhuEQWIF3B5ofvdEiNUX+k09z3v8RGYkg6soE6ZkL
         LJOr2RDUqGIU7v58129gP+CHqQfpe1EzOfE2mB96Fguaf93t+wm1ucjwK/FVCJhq3yGD
         /6sdaLahXt+NgQ+8oXlTeuxJged+F/3BRWbpbfthYhHUy0m7Kwzh75Ecmni9MHzEgywr
         NFRaTapIMS61YSOVNGn3tv3oU6HRC8R/76nFCWMYwBtb8SNoADAzD6tUvMlJjZcd68af
         vX/7OJmtytWzkv71x3vkrlJQp84bxJsEjRltsa3KAlLPV2h0WX7ghUlZUIYMQZz8z2mv
         A1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeGZnYho+8DbqwImmKXnMQBemxMERL04S/vNOPBR47I=;
        b=Mudn2ZqF3cUEgAf7zYkF2kM+hSbNWjOjzx1KvV9BFkHn0a3Boaot9NSbI9vArEMFme
         m2cVtbMEplBBCLNqOdd+DJiSEGkKUrTUs4IOrLqGwgZNyER8Xed+APKRZuLsUee89/wo
         XWkXZrhb0ZkoTBWBVFBdRuoiC9L1iTg6LMUvy0J+5kVQAfCbJXdyO+O+5cENTybqy4bp
         9G3Y6+P17e6DyRUb5H9OrNI5V9BOyX7xCN7fZPsL7RFZqLCar+lteIqfQMMiPVmhf48R
         q2AqVYHBcAe8QMWlA32L5OHJn7jnydF1anOgyZHf1vazgF5wA7fIk9EPoWhSw7TF5zVy
         4BKQ==
X-Gm-Message-State: AOAM531mbGj4tVgoBfvdU8r5OMRHIkMyetRK5R14rwytFyzFqf4t/JxL
        9krff856+q9HRqrPa6YQ1+9ZDg==
X-Google-Smtp-Source: ABdhPJwqLbjYo8nHBTQrkxKyCBxNrXa5cCrjfztRomUeu2jYlAbEKrZqVtU4ivkOWtC1Gg2osPairA==
X-Received: by 2002:a05:6602:2b0b:b0:64f:acc1:52c3 with SMTP id p11-20020a0566022b0b00b0064facc152c3mr16973135iov.38.1653588720715;
        Thu, 26 May 2022 11:12:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bw9-20020a056638460900b0032e1e0ac289sm564743jab.8.2022.05.26.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:12:00 -0700 (PDT)
Date:   Thu, 26 May 2022 14:11:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Subject: tb/midx-race-in-pack-objects (was Re: What's cooking in git.git (May
 2022, #07; Wed, 25))
Message-ID: <Yo/C7suyc6nJS8Tr@nand.local>
References: <xmqqzgj41ya2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgj41ya2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 01:41:25AM -0700, Junio C Hamano wrote:
> * tb/midx-race-in-pack-objects (2022-05-24) 4 commits
>  - builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
>  - builtin/pack-objects.c: ensure included `--stdin-packs` exist
>  - builtin/pack-objects.c: avoid redundant NULL check
>  - pack-bitmap.c: check preferred pack validity when opening MIDX bitmap
>
>  The multi-pack-index code did not protect the packfile it is going
>  to depend on from getting removed while in use, which has been
>  corrected.
>
>  Will merge to 'next'?
>  source: <cover.1653418457.git.me@ttaylorr.com>

I think these are in good shape, but I'd like for Victoria to take a
look at the version on the list here.

We are running these patches at GitHub, and they have definitively
closed the race we were investigating here. But the commit messages
changed slightly when going upstream, so I'd appreciate Victoria's (or
anybody else who is interested) eyes on these.

Thanks,
Taylor
