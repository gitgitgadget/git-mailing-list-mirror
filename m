Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C4C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F94820692
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o01yjopD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgDGPGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:06:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33960 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgDGPGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:06:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so5561wme.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdZStmJc5G52ec0aG/+C/+0YAs5hltYhVlGBQBGMnjY=;
        b=o01yjopDy+M6VrTAM3DsyP0pb6lR4NT2548YQ6nZbSdmVEIdmK7YMASEynhYnO5C8H
         dAK/7eguqHa9Q/t8+XWm7pnQgXS+x8WIm9GzBIRHfI+z4Z6L1CTludhtKpQJImog0Ius
         fGmvyb5MOteJmd4UPhhC5p6s/j2+EW8Vwk2iaNrnPKD7sdHvUOnldB6Ci4nCpT3ldJgO
         fum4oTfsT5XGcsEPTcqa2ydphR+XRHGXZa/2b03kketdz0DIkZvFoXJ0MriLPH2gBSV6
         matoYhyTgKif//woglasLz4nyyHtOgoqr1IkJF1yNvtJiTGLAizsOPRQOUaP/MHhrbzL
         O7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fdZStmJc5G52ec0aG/+C/+0YAs5hltYhVlGBQBGMnjY=;
        b=k0sCJTbs/MJLDhNgQmEjveZrooFb2O6hc+BFERMrASWpKo83musQdwcIGjAY9dv1Mz
         K1SLJM+K+8XHgBrCiurukiWGJJ0h3wRmhEZ6oxz5QMw3xlbEmCh4OqlvJeWSb1N2anLL
         xkUSTwfGJ7zlReMPmih9nMAlHp46mexBozDngjiKzFRH6HuVv9eq4Z2+RU58hwGxVHjy
         RhivR7/vVo3ySx8l1S1rXz99NIyBkPGmrIp7oMrzQsKs4LOa+MD0jU0pKzgRA0MEu5RO
         RYHACyycYg3+GFZJ7SSU9hyWhyDcSTzngFweD8EiAfXX1mrayc4vpyph+GsStIkdnIf9
         i+LQ==
X-Gm-Message-State: AGi0PuZMU/sW8dxKsICfqlvGL/nfu+Wi6R+0bUvzpZ8vAufz71tyTWRn
        m220YXJvi8Zc8/ZWQoiy7Ko=
X-Google-Smtp-Source: APiQypIaOgQocx0pwSyQ9yEHbuO1uwhtXVR9E07OrPpn3f0mFMDz7yL1f2oblc1lxvabLGwIuA2F9g==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr3066830wmc.68.1586271993614;
        Tue, 07 Apr 2020 08:06:33 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j68sm32696448wrj.32.2020.04.07.08.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 08:06:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 21/23] merge: teach --autostash option
To:     Denton Liu <liu.denton@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <7adf7941921065fa1a5e68524e2dd3cd28f9a12b.1585962673.git.liu.denton@gmail.com>
 <07ec44b0-1162-aac9-1a07-579a3768cbd1@gmail.com>
 <20200407130946.GA2503067@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0b112a11-ef46-10e0-e0ae-ab895eb5fab0@gmail.com>
Date:   Tue, 7 Apr 2020 16:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407130946.GA2503067@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 07/04/2020 14:09, Denton Liu wrote:
> Hi Phillip,
> 
> Thanks for the review. The documentation rewordings are particularly
> helpful.

Thanks I'm glad they were useful

> On Mon, Apr 06, 2020 at 04:20:24PM +0100, Phillip Wood wrote:
>>>    --quit::
>>>    	Forget about the current merge in progress. Leave the index
>>
>> Should we be saving the stash if the user runs 'git merge --quit'?
> 
> Yes, this is its current behaviour, although it's undocumented. In my
> next reroll, I've added a test case and documentation for this. This is
> similar to how `git rebase --quit` behaves.

That's great - I'll try and read through v5 later in the week, it looks 
like there aren't too many changes

> Now that I think about it, when `git rebase --quit` happens, the
> autostash is just dropped out of existence, which is probably
> undesirable behaviour. I'll probably submit a later series to save that
> autostash so that it's not lost forever.

That's a good idea, Thanks

Phillip

> Thanks,
> 
> Denton
> 
