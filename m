Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E5DC433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8BE60FBF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 10:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhJWKDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhJWKDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 06:03:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F1C061764
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 03:01:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so2004608edc.13
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UN8NuRftZ9Xx4rzorfTjFj2wkYXz6ioYSuwgfQ3nP+k=;
        b=ZBUvtVKF5p9M8Nb6XAVC7sN7XkoST5uFFZ365W7fYOgTv0JA/16xDwC+STQ4qIJfEs
         cK9WX5JbHea0Ex/Wa85Y1t1E0ai6ymR4cm4tgzmr+kNjkINdeJ6lDgaFprFu6lgwuyaF
         VeLU4e/imP42gk/xmbpCVT7CUM+Vm3wI5mveVILtAssHNblgQH8I4jn6LAz4PfTVn6o5
         TzfYepsIMpWIcfLv5BPuW8YLiAwQlOIWPUYYzf9ZCwOHrR5Veuesb6JWaWecI6Dwm6K1
         AD4O4kGe5/WztwIbzyND0qnJpQcn9UyCQ4dWRx6vo9/D78OmQwq4mHpIrJydK3nj1/8q
         wqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UN8NuRftZ9Xx4rzorfTjFj2wkYXz6ioYSuwgfQ3nP+k=;
        b=eHYTPLRVlq8/GA2MrdfO3IW11L4RE3phWcZzbChTVmKuvBT++hddV/8ItFvUlqynxG
         Sj9KhEA0t6r2EBFAGi9lon3cO3FlQhEIUc5h4IwgTdTbJ6BQ6TdDRfXkHpkGyUEksSS6
         HCyXt9k0QQ4OTqufzd6lsa1gZuREy3B94CbRRAoyaKgaXY55qzThsR/aROWGPIa0gZ1x
         lV8HWTZrIUYwzLYfyc6Lr0JdrXrJOVzP0tkiZOFy9o6MdTojXbNzZeeZRNfmYc5cadQu
         PPLTFJ5c1tntXsegICR1WhgbjsTnpUGsxq+enVsIR7AYVXWUG99DAexxq0o2u35lB4wj
         a34A==
X-Gm-Message-State: AOAM530rTzW+nA8Ny3eWejG5d0/OCZeLbIsfBP4k3U9gMPGUp8mGZorK
        DtrDIAToEAodTOW7fKtP8Ew=
X-Google-Smtp-Source: ABdhPJwWdPsHqMXANXUmuAMKn9cILYiu/tRubTCSHXc/809gU5do22bf4gH6/by8XUm0p0EkZveAVQ==
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr6455860ejs.80.1634983290748;
        Sat, 23 Oct 2021 03:01:30 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y6sm5916812edj.51.2021.10.23.03.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 03:01:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1meDqD-001PZR-4Y;
        Sat, 23 Oct 2021 12:01:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Drop unneeded special handling of ssh variant
 tortoiseplink
Date:   Sat, 23 Oct 2021 11:57:57 +0200
References: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de>
 <82c63c23-446a-1945-0083-f1f5af6d43e8@cs-ware.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <82c63c23-446a-1945-0083-f1f5af6d43e8@cs-ware.de>
Message-ID: <211023.86o87ghxfq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Sven Strickroth wrote:

> "-p" is supported and "--batch" is ignored in TortoisePLink from
> TortoiseSVN and TortoiseGit since at least March 2015 (and TortoiseCVS
> is not maintained any more). Therefore, there is no need any more to
> keep these parameters for ancient versions of tortoiseplink.

In reply to your other mail:

> Therefore, my first question: Does Git still want to support very old
> versions of tortoiseplink or should I provide a patch which drops 
> support for it?

The answer is it depends, in some cases we support >10 year old software
because it's in wide use, so some sort of vague estimate of how much
this is likely to impact users would be helpful, i.e. are users who are
using a modern git likely to have a modern version of the software as
well, or do they mix & match?
