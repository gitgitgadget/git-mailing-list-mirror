Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351EC209FD
	for <e@80x24.org>; Fri, 26 May 2017 05:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936010AbdEZF6R (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 01:58:17 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35361 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764166AbdEZF6P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 01:58:15 -0400
Received: by mail-pf0-f172.google.com with SMTP id n23so1736993pfb.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5zmtAXVbr1Fequw1R/Vux5YjGHKmQwS5uOaM3+QzO98=;
        b=L8G9V08zvx0gEHVv3wC0Aq+JfsXgMtc7cNGtEhaweFd85Z1jwRHAfBXJ+AD2qAn4tX
         ff2JMv8vC744l9vVnMx73PQ78Ze+rp6/pQo0ld13t80gN7RNrYO1iHqSMFANODwS62FK
         nldRFyrhJfAvY+5KRHtCk7aMCQMtzeSEFTRi8wsFDZefHqmkHtXBq2nHMHV+kQC+S8FJ
         IDj4LyVINghYybdw99eeMUcGjALMORVYCGKkVGmaM7GZGJUFtiN8DI7airyu4xvlV5zT
         /kiZ8mGRMS7UUUcUEGEAue3NewI/QHGuYf8rIIf/1V0bcazssuLiaDEkf4K1aDrYptHj
         5ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5zmtAXVbr1Fequw1R/Vux5YjGHKmQwS5uOaM3+QzO98=;
        b=MhLqxFZiSIZeRNylVJhpmxPcJlWJrkBoGsX+5LXpmPdn4rQIyOzIRrLIEhjg0+Ryxx
         MoO0d1vIvykOTKqp0hCljd6mUHMjIgFUch7fp8sHBNNVwszOdWESPAZPX4TKIPyo3DpP
         FuqUwBod/ii47RLyHX6kNR5RpW5jx/lIITXYFyH/I3uymurEAd0DjtU8smG6FrOPCmm9
         QLU0dno7b0LNvGo01n0t0bylUn0MzxvXRSXwPEDGxTXbtzZg54gIbOQWXRC1xKMolxuC
         p5CEbqUeM2MMT+ew5NU3fUskoJrTCrvDo5SGnXvLs95e/KczmSFSBkvS7m7Wk5UiDRv7
         m/OQ==
X-Gm-Message-State: AODbwcAREGMBaYY8zses/HhXBqjv8iZzVpCdd46zYdIiMurk5vS4k3r8
        MIAYRUMwRyOqtA==
X-Received: by 10.84.168.67 with SMTP id e61mr36896237plb.124.1495778295068;
        Thu, 25 May 2017 22:58:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id p9sm17400522pfd.35.2017.05.25.22.58.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 22:58:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tyler Brazier <tylerbrazier@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
        <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net>
        <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
        <20170525180407.ni2oed5wk3qsd2ch@sigill.intra.peff.net>
        <20170525182230.552dif62zqxuufk3@sigill.intra.peff.net>
        <xmqqpoewcy05.fsf@gitster.mtv.corp.google.com>
        <CAAZatrCQZq5_Jc=O-6guyKx1BcOcTNOmWoqwGNrbotnK-VXacg@mail.gmail.com>
Date:   Fri, 26 May 2017 14:58:13 +0900
In-Reply-To: <CAAZatrCQZq5_Jc=O-6guyKx1BcOcTNOmWoqwGNrbotnK-VXacg@mail.gmail.com>
        (Tyler Brazier's message of "Thu, 25 May 2017 23:38:04 -0500")
Message-ID: <xmqqr2zcb1my.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tyler Brazier <tylerbrazier@gmail.com> writes:

> On Thu, May 25, 2017 at 6:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> Anyway. All this has shown me is that it's probably pointless to do this
>>> timing at all on Linux. Somebody on Windows might get better results.
>>>
>>> But regardless, we need to do something. Correctness must trump
>>> optimizations, and the question is whether we can throw out the whole
>>> conditional, or if we should just restrict when it kicks in.
>>
>> Yes.  I personally do not mind going with the simplest approach.
>> The optimization thing is relatively new and we were perfectly happy
>> without it before ;-).

[administrivia: please do not top-post]

> Does git accept outside pull requests? I wouldn't mind committing the
> fix for this once it's been decided what the fix should be. (It might
> help my resume ;)

Please see Documentation/SubmittingPatches.

Thanks.
