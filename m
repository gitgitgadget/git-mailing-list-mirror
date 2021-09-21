Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D31C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 07:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BB16120A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 07:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhIUHm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhIUHmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 03:42:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16BC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 00:41:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so1906481pjv.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cLFYlvtTCzE6IcBPpYTzi/SAg5xCirNj2SnbMw6G/yI=;
        b=Ar3Z/Jeqz4Ruh7Jnresf5oP39AWtOecpE0MkT7mM2AARn5TBYWRm4nOviWcIQlOV+l
         JwiBDj7SR/GAIO6jyrTlSKKVpWlu9wnQW0ZuVOt90v8oGGTxdGtM6eMvZhD4znMQR9ZI
         qdEHdPf4usRCZKoJRmiJMSihpK7QshOTC72JjVu56C0VSV6LtRTMQyl4VQKUa5/mBPz0
         6677Owd3x5t0RxomqO9BN4idH7a0gde4taX+DUIaXiJir9Ao+UymlxiRsKDu5Eupad/O
         3AS0KrLha7uGw7i789FiVb24HCeNawUu/5gRZF/QJ/4NYHIH9tcSmmVhacvRnvrtgyyc
         YALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cLFYlvtTCzE6IcBPpYTzi/SAg5xCirNj2SnbMw6G/yI=;
        b=t1LQZxk9v54eSUG+7ppGwOnHx49Y0zF/2tacW5A/3CxEbQYLjUHzsuM1YY08q7JTqZ
         OxNMAW+Iz/Bqd/CHdl3netZ50I//GcfKlAVuQt94f5l6BReRXEFJ2mDQVVVvb+3kHfBx
         vS6kLOGzZvDn980O6fxBTQfuRUtMhwBZwKRy5Pu410NqQ3XQjdi/kwIiKQUr64hv4kHL
         a2b0e0t+doRZrUtyJ36vMaH3/XG4CCSpuWM662yxj2m0t5MFsZE0KzlwDcFf6xbGw7+s
         5Lfjis2ihka3qOf20R7ZLbDEj9P6/q+MLQciMjXmPPIltUlnafdoHfVXpJNSVX1+4sXV
         lh+Q==
X-Gm-Message-State: AOAM533ppGERbYR/YejVMLuoAs/jJqbqvuTNzZ34H7n85oKhZGVQXR94
        HC0bXD36OnQdCvrzttcushU=
X-Google-Smtp-Source: ABdhPJwLXsGx76mFN7cEDyxlQv/iQXh1jXR4cTJvjvnsFL5EDjozjgdH1pcqPieViSn/m2w/9jx0aA==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr3721216pjb.240.1632210087188;
        Tue, 21 Sep 2021 00:41:27 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id u6sm3570051pgc.68.2021.09.21.00.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 00:41:26 -0700 (PDT)
Subject: Re: [PATCH RESEND] difftool: word spacing fix
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210920121627.905359-1-bagasdotme@gmail.com>
 <CAJDDKr4LfTC8h00NCLSu5J=oBTX3LWshrOXMQ7_iBi4RNie9sA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c536bd3a-d1ae-a617-c284-dabc9f8c1c0f@gmail.com>
Date:   Tue, 21 Sep 2021 14:41:23 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJDDKr4LfTC8h00NCLSu5J=oBTX3LWshrOXMQ7_iBi4RNie9sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/09/21 04.26, David Aguilar wrote:
> But!.. and this is a big but... the po/ translations would be broken
> by this change.
> 
> I'm unfamiliar with the policy about changes that affect translations,
> but in general this seems like a situation where we can make things
> easier for the translation team by not leaving behind further work.
> 
> My gut feeling is that this patch would be easier to accept if it also
> updated the po/ translations to fix these typofixes.
> 
> Question for this list -- would that be a separate patch or not? To me
> it seems like it'd all be one patch so that git is never in an
> in-between state.
> 

I think you should see po/README for details.

In other words: we can change translatable strings here as we want, and 
it's the responsibility of l10n teams to update translations to stay up 
to date.

> The following commands show a few places of interest that should also
> be updated.
> 
> $ git grep 'combined diff formats('
> $ git grep 'tool returns a non - zero'

I git-grep-ed that, and nothing outside po/ matched.

-- 
An old man doll... just what I always wanted! - Clara
