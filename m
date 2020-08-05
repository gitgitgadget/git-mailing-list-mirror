Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E3C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D525320842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMV6Ea4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgHET4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgHEQqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:46:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48305C034602
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 05:37:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so4433791pjx.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYSgL+RcmZNAZTtntm4miw7yQLbOjZVLd/nNR9Tlq2A=;
        b=AMV6Ea4ChzcCh5XYv+6f6LuP/aZClovISTsjfh852UQHOr/jzp16PRCIpNMye3oIXS
         uP8Q27GSx8LHy0aSQ1dRS/bVxb8m4pAzr8mxiyM9ftyAhi+0faQ/YbmcjP9R0i2opxrz
         cyICAc7GUyBFtEHoOceS3xfViKJYrPEh059SRmvmlOGuF0t9rTGALhbDU9SLg31sRnCa
         zxnOVnS6OF8LMAJkXcCgnQk6qyV7e9deok7I6ueW1hvOGMqaz14XnlRQMAnu7PZrDx1u
         uL8FXSSR24jUh3zEQCZwF7XQ0OzTZXVGZxGz3NlhU5AeBZUJ1lCkV7d7EnuSAfTUiNLY
         c8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYSgL+RcmZNAZTtntm4miw7yQLbOjZVLd/nNR9Tlq2A=;
        b=Ik4AF/MourghSwCWpMkWhDNidTz1NATxNyxTEWelg2FhLLFMuNSD1V7vxuXONEyN9b
         0KzdF4IG9pK/ed/ByJHik3pZuNL7pvL8LUL62t3rF5R1/RpDTUnnCamuhbnkoscTjopY
         At5HQtZck5B6zwadVmGMMPdVEANXi8dFOy/CFQkSHtxhltknXM9cegIxZaY3Lj2v9xgP
         h7fUgU4EOsp+NlYbGlMUUgldwlW1Hud9oQHS8HBqAgG7SNkEWibY3t+OlkJxtCoa2OGL
         GU/ca7JVaGnqgeePqEUG7G7PvQWEH8y3KdwRcIpc+oNAyTDuSmZbirns/66plO2vLZJ9
         vuxA==
X-Gm-Message-State: AOAM5327ecFcXV0/wh5wVsX/TXi96xa7BkVi02sS9N4w63eCFQ/0A0kR
        y7TcsABcgL1BNatqIpJX9k8=
X-Google-Smtp-Source: ABdhPJylYyKOUvwYkQVLdL0XKmyns9TWBcbOyTuT45OHXVL9sDigU0bU+TuUdrhqlSdQ0pnBW2GKUg==
X-Received: by 2002:a17:90a:1682:: with SMTP id o2mr3195128pja.227.1596631044124;
        Wed, 05 Aug 2020 05:37:24 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id g8sm3140508pgr.70.2020.08.05.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:37:23 -0700 (PDT)
Date:   Wed, 5 Aug 2020 19:37:21 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
Message-ID: <20200805123721.GA23655@danh.dev>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <20200729222334.GE2965447@google.com>
 <b374cb3a-f681-d514-c465-6b3f0b674bcf@gmail.com>
 <c0b9876a-9041-3400-25ac-e52568a02074@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b9876a-9041-3400-25ac-e52568a02074@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-30 15:02:32-0400, Derrick Stolee <stolee@gmail.com> wrote:
> On 7/30/2020 12:57 PM, Derrick Stolee wrote:
> > On 7/29/2020 6:23 PM, Emily Shaffer wrote:
> >> On Thu, Jul 23, 2020 at 05:56:33PM +0000, Derrick Stolee via GitGitGadget wrote:
> >>> diff --git a/builtin/gc.c b/builtin/gc.c
> >>> index eb4b01c104..889d97afe7 100644
> >>> --- a/builtin/gc.c
> >>> +++ b/builtin/gc.c
> >>> @@ -1021,19 +1021,65 @@ static int multi_pack_index_expire(void)
> >>>  	return result;
> >>>  }
> >>>  
> >>> +#define TWO_GIGABYTES (2147483647)
> >>
> >> [jonathan tan] This would be easier to understand if it was expressed
> >> with bitshift, e.g. 1 << 31
> > 
> > This is actually ((1 << 31) - 1) because "unsigned long" is 32-bits
> > on Windows. But it's better to not use magic numbers and instead use
> > operations like this.
> 
> Nevermind. This breaks the build on 32-bit machines (even adding a few
> "L" characters). I'll replace my magic decimal number with a magic
> hexadecimal number.

Would it be better if we use this C99 feature instead:

	#define TWO_GIGABYTES INT32_MAX

But it seems like it's available everywhere, except (maybe) Windows.
(judging from UINT32_MAX's usage)

-- 
Danh
