Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF86C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7935520679
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5zzhDrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgFOOjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgFOOjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 10:39:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F8C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:39:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y1so12714275qtv.12
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8VFPlC0ByDJANFrJMQ7AsRL0rgE7EoL5B91WlJJR02M=;
        b=n5zzhDrWSGd6+VCFYUm8j6oDpzpbL86X9OSGuK8H/VpKIEx3VSFQqH4KT5cBw+9eRf
         yOf0Lsq+dRoSWTB4YnEwaiZ9s0l6CrdpnM4dGXMRLsP0FjKyskrzJViygLa1PPTWWFEP
         Oo9eySQBgOMo9P0oVHR8hRWzxII4DunMSiOiA4EmAWKWPmAj+PuLjSb50gyqOPLK0tGS
         KUAC6S2FFbM5gyV8EznW7/UHbtQUNwuNyIXVwvQTCS+Osm5IzVvuFEnEOWCrRe0WVKxy
         ndmDtR8b5gPNNztw9UReacmDcH7iyYZerTnn655u7cIh0Wn+x5HZOQqNAbYSYTsaOcVt
         8Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8VFPlC0ByDJANFrJMQ7AsRL0rgE7EoL5B91WlJJR02M=;
        b=IiCNSCNPaj60lSyoFcfww2K+5xFEFYjoreAYD6j+DperXnJjTUvguZnCt7959tgF8d
         FNdvhkYCT996TlqaBxwwY9Lx0tC8iHgT81Yy0IgmFDtasKVRIjXBloQWUjNVKeuDEumr
         KiCxxeYzNF3+6d0inEuIuaG2Jamvgpwah8dsTlXhBgXT32ktANxTW4LB5j+dgNGvDKyY
         HeqNc5kipwvP5IS0WjTSlval7ZMWauMKKwNRQb6LyfUSNmjpF1l9tnvoVkeNOmTLuI2R
         aRMW2rGe4brTGlrKJ3Wp1u2jzgL3h3UfPrVk/+PgJfXTCtYLUUDmirQlPg2XtNjMIFJU
         oUNg==
X-Gm-Message-State: AOAM533zOttAiHVdk10ZU5ZMG7GQ/61Rodq6adsVwLOwDTYJrsoUZ2cF
        mvNGdulRwcC2/aAI/J/BGp0MNaDFLRk=
X-Google-Smtp-Source: ABdhPJzH6UB2M6MTLQ09HCt65xm00kqCVdSwHRw2OXQpmtFpeo+4FkyhavPgMLrF5b+DqNHqU6jyWA==
X-Received: by 2002:ac8:6edb:: with SMTP id f27mr15576202qtv.325.1592231981586;
        Mon, 15 Jun 2020 07:39:41 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id z3sm10655435qkl.111.2020.06.15.07.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:39:40 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <bee91039-34fc-d3da-a0a0-c048e410c582@gmail.com>
Date:   Mon, 15 Jun 2020 11:39:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems the developers made their mind, so I'll just leave some food 
for tought.

https://www.youtube.com/watch?v=KEU-t-ANpdY

