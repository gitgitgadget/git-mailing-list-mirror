Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83709C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKAUhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKAUho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:37:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E981276C
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:37:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p141so13382547iod.6
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJHUugM3/jFvwUQKJp47Xxg9KYvidCFfldQTCiNKeWM=;
        b=4PfQx41uisMhBn5W9vBrf0wX/W2QFPF0gBmnUJH2WHHgVWa4YYT0eNl0ly79zeQk8C
         vCivq6LvDswEXKTShBn4esmA2mwbJJb4pZJLHZtM4CLxzVIWm6IlNyPlYdK5No4o9KMw
         0YjPK9SalWUh9E4QhzMvjnNjuWZtN0vGtipm6FLpExkqPHN3RYQY4ckHPj21EMX3Towy
         WO29nb3j0V8vZm2QYB3N1UveaZ1mg3dMmJbH0daJLSw9Y34mQ0svXxhQWSAXvUVVMxQ1
         hwb7UKrYurMKuUQydwM9o3oi30oBenvfAnfTHoNpOff1lqYxgTC6eo5MSUU6hUYWriQT
         yRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJHUugM3/jFvwUQKJp47Xxg9KYvidCFfldQTCiNKeWM=;
        b=q62V6vgnqNYsePE0M+FOole7we/dR8hCt+n3mh5d8oC7kOmPRXP/SxOp46oXhWUQ3x
         DBpkxuYJ1poF6L0leLFu3HcySSnCglYymSD4wCMVKEp7sXvMEYw4HCZmAZr9bi6g2QUk
         Xo16xE76zrkTVvRt1KphbxkRcwQuE+ArfVPvD3ZcdWylqmAdk4w2g9THF2YGDyybHWUK
         uUOW7/bhBWoa+dsB2qqD5YuYqNBzb3TaY8EsBngEoPzX7lzv0GnIBRLAfqy0SwgMIVCM
         KjSsphQIqOWijFlPiT55tWCV4cWejAP6xTfGKU1pfZ37lniNWFjaAG+NxeB2yNtepjjT
         ypkg==
X-Gm-Message-State: ACrzQf1MUCeWcLx7h8AQWf6hrkcz+QUW15m4y6pQ0snHQXoSx6QSPmwe
        wl5YZtpiEpLn58Ip8lpVLUQcOw==
X-Google-Smtp-Source: AMsMyM5a70Ran1ubo2PYRO+brPGXiibsUi1T+DIIwCAyRNbIY9fqZg27igD9y/MdxT9F5+0lYQuBlw==
X-Received: by 2002:a02:6619:0:b0:375:4395:4ad7 with SMTP id k25-20020a026619000000b0037543954ad7mr169262jac.108.1667335063253;
        Tue, 01 Nov 2022 13:37:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r23-20020a6b8f17000000b006884b050a0asm4238064iod.18.2022.11.01.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:37:42 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:37:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516: move plaintext-password tests from t5601 and
 t5516
Message-ID: <Y2GDlZBzZqR+lwyU@nand.local>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD4g9z2yVFA06l@coredump.intra.peff.net>
 <221101.865yfz5pjp.gmgdl@evledraar.gmail.com>
 <Y2DLdsM2CYY3Z2Sc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2DLdsM2CYY3Z2Sc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 03:32:06AM -0400, Jeff King wrote:
> If we toss that out, then in theory that widens the options. And in some
> ways it's nice to use git://, because it has fewer dependencies and so
> is run on more platforms. But it strikes me as a pretty unrealistic
> test, just because credentials in git:// URLs make no sense and are not
> something anybody would do.
>
> As you note, since the error comes from remote.c, it would still
> trigger. But it's a bit more "white box" testing than I think makes
> sense here. I prefer the original tests' method of trying to create
> plausible real-world scenarios and seeing how they behave (and I think
> my patch even improves that, since having an actual server on the other
> end is the usual case).

Agreed. Despite some of the niceties you mention, I concur that testing
http(s) is more realistic and worth doing.

Thanks,
Taylor
