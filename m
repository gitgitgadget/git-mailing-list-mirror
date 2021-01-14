Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9EEC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1125623730
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbhANX5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbhANX5K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:57:10 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE0C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:56:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 30so4859967pgr.6
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h48mDPeXi6u+1sGC/y8mz0BnnXnuA3eehhRlOKPKTvg=;
        b=gclORwQLYv11V6+arjl2n/xRFyQ2NvCFW/1rBfh8ms+rPcjduBeX/JLxJsCMlQYWoO
         QX/s0I6zodjzCg6XT4mySNaXa/4t/Lw9pzaednALxfHalGo2l6vThwiULwvoX8607khY
         7BIxlqaS+UhbvJCZygkSV1EFtGR2ICEFLpuZYdNF/UwEKjrtOfUN8bhKPo1lBU8ccO5c
         m9xiQnr2CCAJqX7DcJ515pVP9Cd8HDTTfj2Q/T8MUWbTrsX6ILQ1mNQZDaCzD9GUp7CE
         cpcu68lXaDDmBOeRR8WdDiMO46n5pdQw5Ly9A9pt3+tdPuUGTIyie35yPMIBtgdBAi7p
         /qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h48mDPeXi6u+1sGC/y8mz0BnnXnuA3eehhRlOKPKTvg=;
        b=p5DN9Wrn8NapQMmcq+GcElczqoYtnJZZlrFvil56WCoXE6WFDmVpb+wsdzyv61zYc5
         7fK2s3BmWYdElaa6G+sRZ32sKIwzuhZvocbBq2u33v0gQb3989qbtcQ4A8q1SncNUUn/
         tmxfdD386RZQ7U/ofbbmDTG4MJiD+JOdph01H/dVeiTyAJVHbk2qyLa68fYJJ90Y5Whx
         OBxRuoRN2AUgpxlqoO2J4dp09H6RplpoTsaq82D88U2pTPov2Ftklq26ZV9rRSnGBxXn
         uPWHI0t1eUXpCq8WDG+2FM4kNDetSHIr69OszWP6Tdx+uIV8U9arys0xkH5xo7YD8jxf
         xUgg==
X-Gm-Message-State: AOAM533ugUpaj8m1o4httfdPHNmbuLHaY1O3nYdn4hfB3MC6FiAdkTxX
        hSeEm6E+EHPx6bNQspfumPPiqg==
X-Google-Smtp-Source: ABdhPJzDjdANVxvHUV+3dSPM++EZBMfiERKkUgN/1ESCNr/ZDsWrl1M8ihRSGSSifsSfLULvC/kOWQ==
X-Received: by 2002:aa7:947c:0:b029:1a5:dece:c07f with SMTP id t28-20020aa7947c0000b02901a5decec07fmr9521909pfq.47.1610668589076;
        Thu, 14 Jan 2021 15:56:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id w8sm2473862pjc.24.2021.01.14.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:56:27 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:56:23 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YADaJ1gfbxQaLGXf@google.com>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
 <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
 <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
 <87k0si5k75.fsf@evledraar.gmail.com>
 <YADZSsVqyGnArF0n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YADZSsVqyGnArF0n@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 03:52:42PM -0800, Emily Shaffer wrote:
> Fourthly: The perfect solution, as has been mentioned, is to stop using
> user.name/user.email in commits and start using some generic ID instead.

Another throwaway thought:

Taking the time to redesign commit format (e.g. use user.id instead of
user.name/user.email) also gives us room to improve other things we
don't like about the commit format (e.g. limited to single author). How
many things-we-don't-like do we need to collect before we have enough
inertia to go through the long/painful process of starting to use a new
commit format?
