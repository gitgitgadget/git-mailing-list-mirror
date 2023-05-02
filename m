Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F02C7EE25
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEBQj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBQj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:39:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC5199B
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:39:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95316faa3a8so811595566b.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683045564; x=1685637564;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWxcqgd8aJ3f3F6Yu0spoiv12aMkyxDIb8+Mp4IKtaQ=;
        b=durTVSHryx1rwfoan53nWtVnKAsJTRZ8a46eEigC/U9spKogn5C1Je+PpS8HCQoKnN
         cyZMP0Bu3gNu6/Ex+RA8qIXezbsOvCSZ1gpI3PPlskCiriqRcVcEzavYQhdc0NHaAVBJ
         DtEnSnaKG9+VV30lZMfXNJ80pkBaX9u3ymEMab2YD/TRaI5SPaTxbIwO8kWTEEiryRkO
         fBXY8EpQbHQxfd9oTMImhpbU2B6Vwzxxo7B5QhgC9A+TZoUGkbpXe1+dG+csOalR6NXs
         i4nD1Kw1kjwMMjobA3U61v5C+g5o/zrEMZvLPs/HRsgoWDf0D9TpaazeECVKuH43dcdB
         xbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045564; x=1685637564;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWxcqgd8aJ3f3F6Yu0spoiv12aMkyxDIb8+Mp4IKtaQ=;
        b=TB7S2nWUh9vZBWUTsnSuB48rsMf0EfNZxpWW10CMt9w/CjA/vsjSp2GF0GN5NGIzSW
         FAKDRQygmsc+iPnIvdMT4NR+EeBRXK2JgwtlZAemNaCMajKLpxWjhLUEy2V67lvtyoh/
         Vzr0YL6agdjvuQM+6tkAETdGgEwQ9kbr0c2re943Am0MLuNSMwx/SEnzaoeL0sNEs3vJ
         KuEt4URmMalvIkXcxengOSlyzQ4Ym5hxTCpgIHTRIDcHKgp0JkumbKtSyXiJyO0Kc+y9
         7RP48/P57uUpbMf/POml3V6S2+3/+GLhLImScdi3grYeNxRS2nBl3Ors2sMKnTDh3959
         veWg==
X-Gm-Message-State: AC+VfDxsQUKyH/PvM2tbzhpsYgBgGjFJCt+eZC2paMuqtAiUB0tLWqC3
        pHxwtZ9xloO2iXi4VJN1CNk=
X-Google-Smtp-Source: ACHHUZ53GkDANcsDd07LNTxxFZtVx6yFw0STeMW4/4grXsakzUrRZTByU3ubnc6f9HJ/RTP4E58IFg==
X-Received: by 2002:a17:906:4fcb:b0:94f:64c7:d7e2 with SMTP id i11-20020a1709064fcb00b0094f64c7d7e2mr625979ejw.9.1683045563810;
        Tue, 02 May 2023 09:39:23 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906795600b0094f25ae0821sm16143294ejo.31.2023.05.02.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:39:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptt2A-000Z6C-3A;
        Tue, 02 May 2023 18:39:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Date:   Tue, 02 May 2023 18:34:44 +0200
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
Message-ID: <230502.86wn1qhemd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 27 2023, Phillip Wood wrote:

> Hi Calvin
>
> On 27/04/2023 18:50, Calvin Wan wrote:
>> Introduces the C TAP harness from https://github.com/rra/c-tap-harness/
>> There is also more complete documentation at
>> https://www.eyrie.org/~eagle/software/c-tap-harness/
>
> I'm afraid this reply is rather briefer than I'd like but I'm short of
> time and about to go off-list for a couple of weeks. My ideal unit
> test library would
>
>  - print the file and line number of failed assertions
>  - allow the test plan to be omitted by calling test_done() at the end
>    of the test file as we do in our main test suite.
>  - support the TODO directive
>  - allow named tests (this maybe more trouble that it is worth as I
>    think it inevitably leads to more boilerplate code calling the named
>    tests)
>
> Unfortunately this library doesn't seem to offer any of those
> features. It does support a lazy test plan but uses atexit() so will
> not detect if the test program exits before all the tests have run. I
> think it would be useful to add some unit tests to our test suite and
> maybe this library could form the basis of that but I think printing
> the file and line number of failed assertions is pretty essential.

Other things aside, I prefer our explicit "test_done", but I don't see
why you think an atexit() isn't enough to catch incomplete tests.

For a C program you'd just do something like this (somewhat pseudocode,
I didn't check if it compiled etc):
	
        static int done; /* read by atexit() handler */

        void on_atexit(void)
	{
		if (!done)
			BUG();
        	print_plan_line();
	}

	int main(void)
	{
                int ret;

	        setup_atexit(a_handler);
		ret = do_tests();
	        done = 1;

                return ret;
	}

If I'm understanding you correctly you're concerned that if some user
code within do_test() calls exit() we won't return from "do_test()", but
we *would* call print_plan_line().

That's a valid concern, we want to distinguish such "early return" from
cases where we run to completion, that's why we use "test_done" in the
shell code.

But in the C case I think just using something like the "done" variable
pattern above should cover that, without the need for an explicit
"test_done".

But maybe I'm missing something.
	
