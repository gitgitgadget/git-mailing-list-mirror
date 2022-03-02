Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C62C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiCBPzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCBPzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 10:55:24 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9734CD6B
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 07:54:40 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e22so1803227qvf.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 07:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IyLYk3iyuXCBGvaYfDkOiz2xz4VwT/xuN3em39Lkubc=;
        b=LvYHP8G06bTThjXtcdsdIfM+LFCmlLixxXIXfOAzQb+tp2XnbQnk+7E6pQjvJiTROC
         wTmaWsNTWocsvq7YLeQvYvK9Fd+M56Gum+32NchooOj06ZTChRVWggB5tK7KctW2jH1d
         aJGp36++TuZJMnRYRHwaKpEfWd5wf8gRxzaptFkcQtnRo6S7U72yHeV7zzAANS5ebme1
         F7uJ98Bq4eSiyk1xXQYHY1rlTRlVSfSAkQkE6JDGMHJs/iyj3E5I3gJ5f46cqbP1YGGF
         +r0VHUZmc5lqsN70cmHXr9TMuZ4LS8fIG2xsm6W/lgo4CUDDO3/P92Nw1fCJOft+EJiz
         heFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IyLYk3iyuXCBGvaYfDkOiz2xz4VwT/xuN3em39Lkubc=;
        b=j0BLhW3UPatabSqgpkowfoMv4ohLwdt2gzhsuxeEm7H21rGEZ8qr6tY0sfkIgB2O30
         ntjUvtV7Zmi8wZb96Achvbos+dBJ47pJbhlsptiWJxP/fO9wtTsADTzJ7l1EGGEoXQCM
         rS5azkFGORwnHzp707Ml1bGCbcsCUWkT4rNXEBtKMSu5Pv5NXJ6rXl4cL3xVccSUjr9q
         FEMB/rwaOyJLdD9ILJmB+9ztDvTSNxplwPhadloircQBUBdCJmSORXZ9QM/lLndOUAMo
         aDxpUridpuqLXI9RRZsftaPaqe5kh7xtolr4PQtzDtDj5UWDX4gsB2YHNP3V2qeBICG9
         vIeg==
X-Gm-Message-State: AOAM532MrTNerJKnhw9QpFIt0oLcJ0wWJCZSOr9zZzCk3uNIWTW3QcvG
        e5UEqNHNoTHS8X6IuoGSXvIkz6WesN8aBYEG
X-Google-Smtp-Source: ABdhPJztxU87txUEvhSIMeUJwxzV2AdjJqE+pv5ENDQUqjsSJxoWUeEuXLboEXyuOhJbz9+cXaZTTQ==
X-Received: by 2002:ad4:53a4:0:b0:430:1d8c:18ea with SMTP id j4-20020ad453a4000000b004301d8c18eamr21016407qvv.115.1646236479308;
        Wed, 02 Mar 2022 07:54:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b00648c706dda1sm8230965qki.6.2022.03.02.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 07:54:38 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:54:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, tytso@mit.edu,
        derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v2 11/17] builtin/pack-objects.c: --cruft with expiration
Message-ID: <Yh+TPppXFoBU2zbN@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <d68ce281324097e10e4c1921d84c577bed6943e7.1646182671.git.me@ttaylorr.com>
 <xmqqwnhcn6ke.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnhcn6ke.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 01, 2022 at 11:42:57PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  builtin/pack-objects.c        |  84 +++++++++++++++++++-
> >  t/t5328-pack-objects-cruft.sh | 143 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 226 insertions(+), 1 deletion(-)
>
> I'd renumber this to 5329, as the latest iteration of generation
> number v2 series took 5328, while queuing.

Oops. I had scanned that series, but glossed over the new test number.

Thanks for renaming (I'll do the same, in case we end up accumulating
more reroll-able bits).

Thanks,
Taylor
