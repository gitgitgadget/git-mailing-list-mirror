Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9791E1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfFCO7q (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 10:59:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfFCO7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so7185456wrw.13
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gMnyRvg3pgqR7I9PD3QTnaVaP2sgZrEbfQrf7zGKgOU=;
        b=MhCHVaonSU7+zArNf0YmwprOaHYbfVP03oNs6dZYccyDUP3tFcOVB7oEoVACc1a7+G
         0LO0LNZZLCGkDgYDf4KKQSmnVoUxFVNQ60bDx6357fjaOvMEVecjoJLNkuwokYJ2Akck
         ixo/BELglAVfxMJKN4MFkX18LGT+SMkG6iG3jr8IfVrqujm4TvbnTWqMCtc7UumdANyS
         MWy9PW1UMNomwC89+piXgmiDoJiPSnWjlu0LHd9dV4iRqzM4JiCBRwr9ZnTnn8g0MOkB
         cq7kvoStFLWM+rAVnv4N2/VhiruuKOE6gKAyY6OPX6tVZ6/r/mKQMavONKtl2Lv8gX1S
         0URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gMnyRvg3pgqR7I9PD3QTnaVaP2sgZrEbfQrf7zGKgOU=;
        b=YfvEfKWPOCf655lWMyiufGksF7RF6u52H/DBH+tpFBR/oQl0ewCVZoWI/ITHVTQ0Az
         ZxTZqxSvOBZ+7keEm5+uf436WeqMWhV5czf2/eQ08GvrnRwvmy6c+1Sr6wSSQHFd4SVE
         hRl0DqYP4fTWVpJGbSuvWFwoUK2dHOmE6nP+h4k0XaZRFq34v5KZ4WsccMXfk4Jsq+ms
         naOV7ggGTafkUfVgYsFH/6U5uWQG8ldEYLvztwQ3p58fia58Io+3fglxgm83zGV7Pu8L
         0ZhA5vM4JtodiBNwyK4SqY7vqLoat+DsRKj9cHEhmq5NAcWDHNhhVZVg/+wJuriXvLpN
         RgNA==
X-Gm-Message-State: APjAAAVStpofCW9CuaekOoafj9V00g8dEjmxU6aKNDylYwRlb/RmO//t
        EkBwdBqQ3os+j+0DOCZlOTNg+mEQ
X-Google-Smtp-Source: APXvYqwsHFcEMTFGCYcskXU3dGqnTzcBYlt8HHQ5PK4qM7VVzpz7sBKZBzK8nBVBcuiD6cGYFKuiCw==
X-Received: by 2002:adf:ee42:: with SMTP id w2mr2968232wro.253.1559573984447;
        Mon, 03 Jun 2019 07:59:44 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id u19sm36409134wmu.41.2019.06.03.07.59.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 07:59:43 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add -p: coalesce hunks before testing applicability
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Jochen Sprickerhof <jochen@sprickerhof.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180828085858.3933-1-git@jochen.sprickerhof.de>
 <xmqq36uygyau.fsf@gitster-ct.c.googlers.com>
 <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>
 <20180903190114.GC17416@vis>
 <d6a8f77b-0a83-90ae-a7fb-a3954ac3b346@talktalk.net>
 <nycvar.QRO.7.76.6.1903221453360.41@tvgsbejvaqbjf.bet>
 <a23789e9-ee99-d23b-ee25-1acef8d8d114@gmail.com>
 <nycvar.QRO.7.76.6.1906031229110.48@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3ac6c94c-edd5-b376-4d44-cbf7aebf37a0@gmail.com>
Date:   Mon, 3 Jun 2019 15:59:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906031229110.48@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 03/06/2019 14:40, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Sun, 2 Jun 2019, Phillip Wood wrote:
> 
>> On 22/03/2019 14:06, Johannes Schindelin wrote:
>>
>>> On Thu, 13 Sep 2018, Phillip Wood wrote:
>>>
>>>> On 03/09/2018 20:01, Jochen Sprickerhof wrote:
>>>>
>>>>> * Phillip Wood <phillip.wood@talktalk.net> [2018-08-30 14:47]:
>>>>>
>>>>>> We could restore the old test condition and coalesce the hunks
>>>>>> by copying all the hunks and setting $hunk->{USE}=1 when
>>>>>> creating the test patch if that turns out to be useful (it would
>>>>>> be interesting to see if the test still passes with that
>>>>>> change).
>>>>>
>>>>> We set USE=1 for $newhunk already, or where would you set it?
>>>>
>>>> To match the old test it needs to be set on the hunks we've skipped
>>>> or haven't got to yet so they're all in the patch that's tested
>>>> after editing a hunk.
>>>
>>> The way I fixed this in the C code is by teaching the equivalent of
>>> the `coalesce_overlapping_hunks()` function to simply ignore the
>>> equivalent of `$hunk->{USE}`: the function signature takes an
>>> additional `use_all` parameter, which will override the `use` field.
>>
>> That sounds like a good solution. Thanks for working on the conversion
>> to C, I'll try and find time look at the code on github.
> 
> Please note that I did not update the Pull Requests on GitGitGadget
> lately, as I had no reviewer feedback on #170 and did not want to waste
> too much time on synchronizing my work between those PRs and Git for Windows
> (which now has the built-in `git add -i` as an opt-in feature).
> 
> So: the latest patches (as of time of writing) can be found here:
> https://github.com/git-for-windows/git/compare/9f09372011%5E...9f09372011%5E2

Thanks, I left some comments on the commits on the add-p-in-c branch at 
https://github.com/dscho [1,2] before I saw your email. I've still got 
quite a few commits to look at so I'll leave any further comments on the 
git-for-windows repo instead.

Best Wishes

Phillip
[1] 
https://github.com/dscho/git/commit/9b7d0fbb095e9e14491d4344981ae346c97e1692

[2] 
https://github.com/dscho/git/commit/74e058179ae7743a8a99e5a20d5362bf55563505

