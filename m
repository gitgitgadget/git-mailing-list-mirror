Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2399C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjHIVpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:45:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33AA1702
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:45:12 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5841be7d15eso4185797b3.2
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691617512; x=1692222312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kk0u6KyooJ/tF7OtitQKMoWa8mPHkmV81pY2FZKUbXk=;
        b=iMzHKwUOhfm0y7NnvGhLVWX/W5JwXz8w3J3YeKOpGbT/Zxks76/fSQvgivVPrkcppn
         VX7h6kBP/Sxn05GdlKx/KgpP0ufs0YXpKonWl+gveSBf30M20k8mjwpckOsdUCOpE964
         vbzmH5j5MNmWZbxXCYmiGU8JK2A+VCFhOm9V3uVINLl/WeBuO0AzFjVFF75ZQ1lp7+fm
         Gw8pMUhyRFNZrqPuPzTwPYD1j3cqJNmmkpP55sy8V26tYP0+1LRPxdLca9nUSQprFfqn
         e6KiqWwxOF+Zbhq1vpCIscvM9Lhnanh+RIAyhQnpR9OrfRKTnfZ8S4+p0aDJ9RhvEL2F
         UwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617512; x=1692222312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk0u6KyooJ/tF7OtitQKMoWa8mPHkmV81pY2FZKUbXk=;
        b=gt94GsTZEJQT88JyM5+gaJj97TqFvVlZtPiMTgxrgUjviVatzNms02aKhiVVZ2aQ5W
         Zgp0cLHG08dzAfSJ32wBG0uj9EFnlXpBgJ46Yi5bO0hG0P7XK87bXT+wNd3IxwWM83X+
         Jo0NCzB/mhmhedgN2j3QzmiJlgf5rQ52DCubHStqfTRR2ybR4Vzc14AaBu/KBq0/Jo25
         OIwXGVl949h56XFmER0CFh7/bqGBHDjZrFCRoxKkW2BdzdZycfS0n5CHHvpd72JEUo0X
         SmdwztgBCB7VuOAjfHsRisVPL3pCC5sOyOqT0CiXYi0mR5zouxFBGv5L3QjfA+Aph1SM
         WUpQ==
X-Gm-Message-State: AOJu0YysXRTdviAEUFDXq7VnrGfGl2IFlUsArdKQy80QtfTU/grydASf
        cAOSFYOEiA5S+s32+ktyQt9mBQ==
X-Google-Smtp-Source: AGHT+IG+3oWOqQLWStLb0Tgpf+Bjhp9QTFj49C6L2wpCjT3I7RjO8EQtlWHGmlYk/0fstVeN1GaJZw==
X-Received: by 2002:a81:5d8a:0:b0:583:cf0f:152d with SMTP id r132-20020a815d8a000000b00583cf0f152dmr641746ywb.6.1691617511926;
        Wed, 09 Aug 2023 14:45:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g11-20020a0ddd0b000000b0058451237d7dsm4211272ywe.119.2023.08.09.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:45:11 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:45:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/8] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZNQI5vpcoXbkkPWa@nand.local>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:26:00AM +0200, Christian Couder wrote:
> # Changes since version 3
>
> Thanks to Junio who reviewed both version 1, 2 and 3, and to Taylor
> who reviewed version 1 and 3! The changes are the following:

I took a look through the range-diff as well as the patches themselves
again (skimming through the last three, which are much more
straightforward than the preceding ones).

Everything looks good to me here, and I think that this version is ready
to get picked up once we're on the other side of 2.42.

I left a couple of comments throughout, but none of them merit a reroll
on their own. I think there are a couple of things we could easily
ignore (marking parameters as "const", etc.), and a couple of things
that we should probably take a look at after the dust has settled here.

We *may* want to fix up the test_must_fail invocation that has the
environment variable on the left-hand side instead of using
"test_must_fail env", but I don't know for sure.

I do think that we should take another look at disabling the bitmap
machinery when given `--filter`, but I think that, too, can be done in
another series.

Thanks again for being so patient with all of my review comments. I hope
it wasn't too big of a pain; this area feels very fragile (to me, at
least) so I wanted to give it an extra careful set of eyes.

Thanks,
Taylor
