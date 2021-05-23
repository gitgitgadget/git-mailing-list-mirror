Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36214C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1218D61057
	for <git@archiver.kernel.org>; Sun, 23 May 2021 11:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhEWL1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhEWL1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 07:27:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E688C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 04:26:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so25501545wrq.7
        for <git@vger.kernel.org>; Sun, 23 May 2021 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8NUNmR7TzVsDGLhA1up5eKZswcAwBY4LL+qGMzLUI0o=;
        b=qeGnXYrR4rNj8ltR9GIUx/xgmvBHLpcsTJ57dJ4MHRORZW10yJ4+p2nu2lkzI9+/j+
         a4i4mqycY2k6EW8/Sam+nnd1Ce9KPEW3cDJMF10Itm6MY/qmN9VdPSk/UzIFke91eptT
         sJOyatiByjbvepC+gzSZgiNwPoj87pkbjW9NI5VI4cpHVAIx+9DalyQHkIZ2ZlufL0sy
         uypijASOMgZJLiWQgBVhELDB0WUXcx65I/LE0jzvO9gt9lxpKAL9dmcmKCRSuAbAyRr3
         mEA6SFMMRpd5mAa6zhzLPsPCgTZLl2RI61RwKLzKDDxhiKaEslcNbk28lD52WOWMZstH
         N4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8NUNmR7TzVsDGLhA1up5eKZswcAwBY4LL+qGMzLUI0o=;
        b=nLi8kiLUXm9P/hk5P/Oxd+oButAyKprT3o6+zX3sh8k51KPPNST1CU3i414d5NWExi
         IBdCe3QNVEu7JFK6QIfJZykwszdpQWtpzEiuJjGgdfWayqe0opxfpWaLLQ5nF0DF/SIc
         dJZ/1lNxK0A4TuKXgmFZxpya6OwE51H0+2IIwJ1d7XcxctPE5EmWV3NLKXI8OMQ54GgO
         sTTrM7O4B783K9Ll/BBsw2VIrpLTa4xLe0aprRgACcG4UI0uBam0z6RMHpTWsGxN9T79
         6TyW6reHwfu8e0GsG+Ya9AnX7Ap+Y0TSyyXiv+F2mv3Ed/rWm0acrU2kTCsU72MM+hfz
         tDpg==
X-Gm-Message-State: AOAM53185ydZEIiQdLf7XXehFu2FBiMXkLiXrTtODRVaAcQBoEGXg24n
        wWCOczJCxCLZFnoCt9cShEWM51dGHsY=
X-Google-Smtp-Source: ABdhPJxCUibINZQxiieCz/qgalN2KwZPW7r/T3jGuPElo88bFIAN3G/RLFlPDmzL8OjN0+07tblZEg==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr17910266wrs.170.1621769167722;
        Sun, 23 May 2021 04:26:07 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.160.177])
        by smtp.gmail.com with ESMTPSA id u132sm2963065wmg.31.2021.05.23.04.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 04:26:07 -0700 (PDT)
Subject: Re: [PATCH] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net> <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net> <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
 <60a8243323625_77e4f208f8@natae.notmuch>
 <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
 <60a83c794ed4d_81cd4208f3@natae.notmuch>
 <e669d76b-0bed-4eac-a942-c89b7523ca34@gmail.com>
 <60a97c12d96a_85723208d4@natae.notmuch>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <6642528a-b270-5862-bfdc-7bfa22682c2f@gmail.com>
Date:   Sun, 23 May 2021 13:25:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <60a97c12d96a_85723208d4@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22/05/2021 23:48, Felipe Contreras wrote:
> 
> Language is understood bit by bit. To properly understand the sentences
> that follow you first need to understand the sentences that preceed.

Except you can't deliberately chop and butcher mentioned sentences in 
order to "understand" them in isolation, as the meaning is largely 
determined by context - and yes, the following sentences as well.

You focus on seeing the trees, but you're missing the forest.

> I know what you said in the rest of the message, which is precisely why
> it does not follow, and since you ignored my argument, let me state it
> with logic symbols for the record.
> 
>   It is reasonable to configure certain software such as a text editor
>   to use color or other ANSI attributes sparingly (such as the reverse
>   attribute for a status bar)
> 
> We extract part of the message:
> 
>   It is reasonable to configure a text editor to use color sparingly
> 
> The first sentence implies the second, no information is changed.
> 
> ---
> 
> You interpret that as:
> 
>   It is reasonable to allow the user to configure a text editor to use
>   color sparingly
> 
> This is obviously a different sentence. You introduced a part that was
> not there.
> 
> Now we use logic symbols to transform your sentence:
> 
>   p = the user configures a text editor to use color sparingly
>   q = it is reasonable to allow the user
> 
> This is what you said: if p -> q. The contraposition is: ~q -> ~p.
> 
> Therefore you said:
> 
>   It is not reasonable to allow the user to configure a text editor to
>   not use color sparingly.
> 
> This is a fact.
> 
> What you said doesn't make sense.
> 
> ---
> 
> This what no-color.org said:
> 
>   It is reasonable to configure a text editor to use color sparingly
> 
> By doing the same contraposition as above we get that it's the same as:
> 
>   It is not reasonale to configure a text editor to not use color
>   sparingly.
> 
> Or in other words.
> 
>   It is not reasonable to configure a text editor to use colors heavily.
> 
> If it's the developers doing that, then that statement is correct.
> 
> This is my interpretation. My interpretation holds to scrutiny; yours
> does not.
> 
> They meant the developers. They are not trying to tell users what to do.
> 
> Cheers.

You are overthinking the whole thing (or the piece(s) you focused on, in 
fact missing the thing as a whole completely), making it unnecessarily 
complicated for yourself.

The NO_COLOR[1] homepage text, read in its entirety and even if not 
perfect, seems clear enough for everyone who wants to understand it. 
I'm sorry if it's not clear for you, I'm afraid I can't help any 
further.

And while I find your armchair analysis amusing, you'll pardon me for 
not taking any more part in it as, unfortunately, I don't have that 
much time at my hands to waste.

Cheers, Buga
--
[1]: https://no-color.org/
