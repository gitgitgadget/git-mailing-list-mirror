Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C217C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02854613BD
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhDMSKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhDMSK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 14:10:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC4C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:10:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d21so368052edv.9
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hgsBkrJYffvLf5ho7ZpJgVpP646uG6q71SLXKjhWa0A=;
        b=gvC8XNUsj3MGaqOYD8eem+Sja/oLuGsMf1RktwvUTp/inrW4Z6FZwToal1iiX3OGsB
         bO3nybxqRq3x+aJ6RvTf8nkpQ3fuwYPFR6FQ3oQe9pk9hycF9yzLeFSqIF8j7k05UCfn
         4THT+G7CNLht+ks+VwXhlLjRRlZb4ea6dWtYAB4bNEx5p83F4L7HV4dqx4Jicvxuk81W
         7/6Rg4maKEE//HrUtMT8ViBcgksKrxHepvMe9FnWrhxzb6dJtuEd+pI7SnlopbQYMxPg
         pEUN/UsI5MkeYA9GVRRRf7+HQRciAee3pV7VfYTWMF9NAmUJmasjcXNw+wWT5IjASo7Q
         sBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hgsBkrJYffvLf5ho7ZpJgVpP646uG6q71SLXKjhWa0A=;
        b=Y7z58d+Mjv6AN6hJC2EdEaOshn/ZqnmZ0w5DMNvZDaeWX/yzlapL3oN/LnTNQwCgSb
         YN93aHh1TTHYB9WxdAEstNfPWa/2JBd0fGpIe3c0aYSLo6ZiL0mZz3NQnNd5kJ7SGAYH
         3Bt6ha3NXK7K77C103uaRgxkyW2niU9FgDYSg0p9zHrYI6AS9YVYTOEcOP5reGobUip6
         l17eGHEDASg9gtyTjSFsLSohrUnZzAz0gsvU8Cgqybn3eBoOpAqZ++O3+ysg4I2Af84P
         kYJsbXlhl8WKxCc0qBvExEedA29yT67/uPlc+iGyxm7OtmQb0yfXoTaYPjL9WLeniTOd
         BYFA==
X-Gm-Message-State: AOAM533qlvNjN8ES9VGHto8jvmiSC13g2CHLoyAvdQe5mbUZYpxw5bRo
        plbid4gtLafPY26o2fxWBpA=
X-Google-Smtp-Source: ABdhPJwsZmNOElG69Z4KnjJjp/Da5mrKnBQBwM+SHmaEZS+39cQrpQ7XHcbN/YBlC2L9tFaVlrV58g==
X-Received: by 2002:a05:6402:14d7:: with SMTP id f23mr36518713edx.218.1618337406108;
        Tue, 13 Apr 2021 11:10:06 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id s6sm1050392ejj.105.2021.04.13.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:10:05 -0700 (PDT)
Date:   Tue, 13 Apr 2021 20:10:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] low-hanging performance fruit with promisor packs
Message-ID: <20210413181004.GJ2947267@szeder.dev>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
 <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
 <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 03:12:54AM -0400, Jeff King wrote:
> On Mon, Apr 12, 2021 at 07:47:41PM -0400, Jeff King wrote:
> 
> > The patch below drops the peak heap to 165MB. Still quite a bit more,
> > but I think it's a combination of delta-base cache (96MB) plus extra
> > structs for all the non-commit objects whose flags we marked.
> 
> I think we can do even better than that, after looking into the "do we
> really need to parse the objects?" comment I left (spoiler: the answer
> is no, we do not need to, at least for that caller).
> 
> Here are some cleaned-up patches that I think improve the situation
> quite a bit.

> Anyway, here are the patches.
> 
>   [1/3]: is_promisor_object(): free tree buffer after parsing
>   [2/3]: lookup_unknown_object(): take a repository argument
>   [3/3]: revision: avoid parsing with --exclude-promisor-objects

I tried these patches together with your first in this thread [1], and
then could finally 'gc' my 'blob:none' chromium clone in:

  elapsed: 3:23.64  max RSS: 3206552k

Thanks.


[1] https://public-inbox.org/git/YG4hfge2y%2FAmcklZ@coredump.intra.peff.net/

