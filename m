Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5CDC10DCE
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F690205ED
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcU3WaW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgCPA1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:27:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41362 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgCPA1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 20:27:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id i26so3003176qtq.8
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qkNQqSC25ntjF9Cibxz/R3q3100hxqS0iiNWokHD3MY=;
        b=hcU3WaW+sDyTwjjo7Y2aBYHHsDg6HZyAyUtZ1ZutXVvf6zWe2Lx4pw78nGqa2Jt1jS
         A9f/BT1dPlZn356ki77rmqb++qbu+u5lawZ61uSZOWP0uO9n8AmmJB2drzcy04nGPMwS
         vUMnyCxy47N1YgK+cLl5i6YNXj2cAheXNawCWs1wlgSyNK8e35OO9TewzrNdhhuGWG8g
         5mvSOC7f3pQEXvHEmRadum8B3M8v0bze9B5WizL+ZX76FK30fT0yB2bUwdiHGWgcAOVg
         7VuEBJ2GMtJndPjcaZEoRlQuiJ84E0ODzEeenmhNTMk5sPuQ7DCysikQBNKq0c/66f81
         eUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkNQqSC25ntjF9Cibxz/R3q3100hxqS0iiNWokHD3MY=;
        b=sFuR7lYqvJaOiTOlOaHxlDA8fPz8804rYEkH0CddKDMxEK/GtgaesSO2phBtfAX4Wt
         E7FGHYjSUgq/1be81P5kxuvb6szFZfN9PcuNQjpSPLK2zOjkHFpXQljF00lEMsjm9fTU
         RBhS+fx+X8EGS11hqfETVqu3WdMu7GwETIVfBSiUypCG4oP/g5kwmeSp9NIHFrof6+nv
         55nT1m3D6+HLxhQLwxBYYNJkjnjf80zrAd4/l1bdlSzz5yLxUFgo0kd1xZbJmRomm0pZ
         yDh/OYbnHrVKzTn3V7RfTNGmFt+NZcB/i95C0nBNOmScSvQabXugbzsvN20T3x1j4IPf
         H3Fg==
X-Gm-Message-State: ANhLgQ2Wsnvu9BA4C/RhJf1CYHMqFqV6nZ+LJtmsoRFtFkPfwikmNxqy
        t/1UHDxkZvFdig1GnlBlNLk=
X-Google-Smtp-Source: ADFU+vvk5dLJDxwsyoQT+Ze92z7nYWCVRwUlMRbAbMvR+sN8tjoxraMrirWDi9t+O3W80W9wGYlThA==
X-Received: by 2002:ac8:708b:: with SMTP id y11mr22761611qto.195.1584318421612;
        Sun, 15 Mar 2020 17:27:01 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 207sm16084973qkf.69.2020.03.15.17.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 17:27:01 -0700 (PDT)
Subject: Re: [RFC] Universal progress option (was Re: [PATCH] clone: use
 --quiet when stderr is not a terminal)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.581.git.1584133742475.gitgitgadget@gmail.com>
 <xmqqh7yqc16w.fsf@gitster.c.googlers.com>
 <a044478f-ca04-3475-90de-0332e80f552d@gmail.com>
 <310a176a-1b30-a479-638e-33a51fb2c896@gmail.com>
 <xmqqk13l9zmf.fsf@gitster.c.googlers.com>
 <xmqq5zf59nkb.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db38c8ef-426b-ecbd-b8b4-de6faf8d3ff1@gmail.com>
Date:   Sun, 15 Mar 2020 20:27:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zf59nkb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2020 7:59 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If the parser that kicks in before the commands do their own parsing
>> needs to know that much to correctly understand "--progress" anyway,
>> wouldn't the same amount of effort would allow us to teach these
>> individual commands to understand "--progress" and pass it correctly
>> down to the underlying helpers?
>>
>> So, "git clone --no-progress" that lets checkout progress may be a
>> bug worth fixing, but I do not think a global switch is a good way
>> forward.
> 
> You can sort-of work it around by introducing "--[no-]progress" that
> is taken as an option to the "git" command, just like "--[no-]pager"
> is, to work around the issue above.  But I have a feeling that you
> did not like the resulting UI, which is totally backward incompatible
> and break users' existing scripts and habits.
> 
> The resulting UI built around "git --[no-]progress subcmd" may feel
> much nicer, and I suspect that it would be something we would have
> picked, if we had today's experience back when we started adding
> progress display to individual subcommands.
> 
> As long as a clear transition path can be drawn, I do not
> necessarily object to such a direction that (1) introduces the
> global level "git --[no-]progress $subcmd" option, and (2)
> deprecates and eventually removes the "--progress" option at the
> subcommand level.

I think a way to compromise is to create an OPT_PROGRESS() macro
that starts as a weak wrapper around the current OPT_BOOL() that
is used with most builtins manually adding --[no-]progress. Then,
it can be updated to do a more advanced action upon seeing --progress
or --no-progress to set GIT_PROGRESS as described.

This would allow builtins to easily integrate --[no-]progress into
their command-line parsing without issues as you described.

Thanks,
-Stolee

