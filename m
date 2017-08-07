Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0563920899
	for <e@80x24.org>; Mon,  7 Aug 2017 10:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbdHGKRL (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 06:17:11 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54836 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbdHGKRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 06:17:10 -0400
Received: from [192.168.2.201] ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id ef5tdo7sCAp17ef5udIbuW; Mon, 07 Aug 2017 11:17:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1502101027; bh=UdZsM7yUVVt9lFWiXsB7lRItlD08uJkf907L6U7iGno=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QnCBt0bcA8EQIWGG0bTM1uP4z4QOmBfBNAUpaRM2VEh3D9h9KRaCFEFBDjHD8Q4yP
         dYvqfPcVaWAQjxIRSluOxLoIsNQI2FDI51eZq6odugVjdE23zNER8MX/UbM3Utczgr
         2uE+5HkN8MXEfGvuJnhax6+GevyOGRsJLtnWbf4I=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=kxd9BUofY8qykjmLWfsA:9 a=j9hWU7E8Wl5-uYLQ:21 a=3hPXX2amhwAeC6rf:21
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] cherry-pick/revert: reject --rerere-autoupdate when
 continuing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
 <20170802104420.12809-7-phillip.wood@talktalk.net>
 <xmqqpocdr5tu.fsf@gitster.mtv.corp.google.com>
 <xmqqlgn1r4bu.fsf@gitster.mtv.corp.google.com>
 <6a7c9661-9f12-99c9-1fc1-4a4abd3d0660@talktalk.net>
 <xmqqy3r0po0i.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <bcaccf25-b033-259b-9ca7-b77a7240029b@talktalk.net>
Date:   Mon, 7 Aug 2017 11:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3r0po0i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO9XVqnBXjAe5eoEI12hrZICcq/jCYYlG3TRR5eMPmhO1DY7K+jrc09D/kDG13qmCRC5MeahLK2HGyvyzLN08biPSy/gC2mpeIuE+0mQnIkPsuo7hYTI
 bXZQeQgSHl3aeJXFETwVT+GoihhVpgbN79U3gF6wAf+/TaTQ/YpXTDf0DLcb6gt2M+rA0cb3hNqrBlnPo7ZGfJDZjUSym0lix3vBVabK+6x9EwYNcEtA0xZo
 pR2yTcrckJGmndnWPLR4uw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08/17 18:19, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 02/08/17 23:29, Junio C Hamano wrote:
>> ...
>>> The
>>> latter makes it more in line with how "am -3" followed by "am --no-3
>>> --continue" behaves.
>>
>> I'm a bit confused about what am does when you pass extra options to
>> --continue. It looks like they do not persist if there's another
>> conflict and may only apply to the first patch that is applied when
>> resuming - I'd need to spend more time looking at the code or run a test
>> to be sure.
> 
> I think you got what "am" wants to do.  
> 
> The idea is that the user would say she does not trust the three-way
> fallback when she starts to apply many patches in an mbox, i.e.
> 
>    $ git am mbox
> 
> Upon seeing a message that does not apply, she would examine the
> patch that caused _this_ stoppage, and then decide that it is safe
> to apply _this_ patch (but not necessarily later ones) with
> three-way fallback and move on:
> 
>     $ git am -3 --continue
> 
> I have not thought too deeply if the parallel applies to
> multi-commit pick, though.  
> 
> "am" (rather, its underlying machinery "apply") is designed to be
> all-or-none, so a failed --no-3way application would leave the index
> and the working tree intact.  "-3 --continue" can retry the failed
> step, with "--3way" processing turned on for only one message, from
> that state.
> 
> But a multi-commit cherry-pick/revert would stop _after_ it munges
> the conflicted paths in the index into an unmerged state and writes
> the conflicted state into the working tree files.  For "--continue
> --rerere-autoupdate" to work more like "am --continue -3", it would
> have to learn to reset to the state before the failed cherry-pick
> first, before re-attempting the failed cherry-pick with the auto
> update enabled only for the single commit and keep going.  So it may
> not as trivial as "am --continue", even though it sounds doable.
> 
Thanks for explaining that, as you say having cherry-pick take
'--rerere-autoupadate' with '--continue' sounds more complicated than
the am case. Also I'm not sure it would be as helpful to toggle
'--rerere-autoupdate' with cherry-pick as it is to toggle '--3way' with
am as it's not that hard for the user to stage the merged files
themselves. If you're happy with the way it is currently implemented I'm
not inclined to change it.

Thanks

Phillip
