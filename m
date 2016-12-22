Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A529C1FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 02:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756532AbcLVCVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 21:21:42 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33423 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755014AbcLVCVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 21:21:41 -0500
Received: by mail-pg0-f66.google.com with SMTP id g1so16500415pgn.0
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 18:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=h15rLUMPqqqyPrVTx4OHqqFoT8IOwJFg9eV/QcLUepI=;
        b=TfMKNF0C/xy5HmguDgpKvVkX8TCM3lrBkWx4NEhCgm2XIZa4WHe29ql5101BVpMwif
         R94IhZrOVG9kAssv5YgOo6CMRAth+KHNp9LpcOh/0+tU7lqeqJVukam8bK6AmRNXQ/fj
         WHvrzSYf3oA+sur+j/UOgMAMZC8lvIYaUGl/o1dTYJHTf9nNYmRp1UwCiipQc9PI7raa
         0QorsNK6KKbOlbCiePsjKeaqcDwZpKDmoWa6yCNrBRIFPdt/RopkH5zzo2m9Gsop2Lrs
         kKVeB/t/2zJ/0IO9slB0xpGBwZQJXVxE4sBSFBo8PFrP/OdGfAl+3SDxY4xDknv3yIJw
         /RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=h15rLUMPqqqyPrVTx4OHqqFoT8IOwJFg9eV/QcLUepI=;
        b=e19JF3sxwHuRylGDGYqyHCEAPfpQHNm2BTTZbXLvoeWr0Yuf9XH2kKspIm2U+VC0XL
         kORJ/q88vJC71m1Hi9OXY4kObezF6rzUZA5MUfhTI209z0b/3rwvyPD4qdwn332zlZoY
         v8LWq0FEDVkCILpTe4WAh1E+T/jLD2unOBtTzdeq/BRLleAwpN/oIE4A+fw5F0j0qIHa
         eUJyZZhOl+DPPqiNpvOWRX2Krq9F9HwRLhVwZ7mUkxsc+QtXvD/FGsMxlOSC1D+Uupz7
         UIYO15SeL0mD6UgUfKTlcOTs2djwexEF9HCCXnIzgcl97tIcvZ+YapSKpwMQC1nz4u85
         7e4A==
X-Gm-Message-State: AIkVDXK61BSohG+0Z4L0unQc4CLbiY6QPhuIkfeS7lv6oBJbHwZrGSE12B4jJSKNyY1Ocw==
X-Received: by 10.99.146.76 with SMTP id s12mr12992603pgn.8.1482373300531;
        Wed, 21 Dec 2016 18:21:40 -0800 (PST)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id t184sm50086174pgt.36.2016.12.21.18.21.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 18:21:39 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net> <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com> <alpine.DEB.2.20.1612201511480.54750@virtualbox> <20161220164526.qnwnmr7cvyycmw6a@sigill.intra.peff.net> <222ACFD4-ED9A-4B94-8BDD-3C70648A684B@gmail.com> <20161221155539.aykcmkuzqvq733ri@sigill.intra.peff.net>
Message-Id: <F5001DF2-20C2-4757-997F-9D40BD48E1D9@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Wed, 21 Dec 2016 18:21:37 -0800
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 21, 2016, at 07:55, Jeff King wrote:

> On Tue, Dec 20, 2016 at 09:54:15PM -0800, Kyle J. McKay wrote:
>
>>> I wasn't aware anybody actually built with NDEBUG at all. You'd  
>>> have to
>>> explicitly ask for it via CFLAGS, so I assume most people don't.
>>
>> Not a good assumption.  You know what happens when you assume[1],  
>> right? ;)
>
> Kind of. If it's a configuration that nobody[1] in the Git development
> community intended to support or test, then isn't the person  
> triggering
> it the one making assumptions?

No, I don't think so.  NDEBUG is very clearly specified in POSIX [1].

If NDEBUG is defined then "assert(...)" disappears (and in a nice way  
so as not to precipitate "unused variable" warnings).  "N" being "No"  
or "Not" or "Negated" or "bar over the top" + "DEBUG" meaning Not  
DEBUG.  So the code that goes away when NDEBUG is defined is clearly  
debug code.

Considering the wide deployment and use of Git at this point I think  
rather the opposite to be true that "Git does Not require DEBUGging  
code to be enabled for everyday use."  The alternative that it does  
suggests it's not ready for prime time and quite clearly that's not  
the case.

>> I've been defining NDEBUG whenever I make a release build for quite  
>> some
>> time (not just for Git) in order to squeeze every last possible  
>> drop of
>> performance out of it.
>
> I think here you are getting into superstition. Is there any single
> assert() in Git that will actually have an impact on performance?

You have suggested there is and that Git is enabling NDEBUG for  
exactly that reason -- to increase performance:

>> On Dec 20, 2016, at 08:45, Jeff King wrote:
>>
>>> I do notice that we set NDEBUG for nedmalloc, though if I am  
>>> reading the
>>> Makefile right, it is just for compiling those files. It looks like
>>> there are a ton of asserts there that _are_ potentially expensive


>> Perhaps Git should provide a "verify" macro.  Works like "assert"  
>> except
>> that it doesn't go away when NDEBUG is defined.  Being Git-provided  
>> it could
>> also use Git's die function.  Then Git could do a global replace of  
>> assert
>> with verify and institute a no-assert policy.
>
> What would be the advantage of that over `if(...) die("BUG: ...")`? It
> does not require you to write a reason in the die(), but I am not sure
> that is a good thing.

You have stated that you believe the current "assert" calls in Git  
(excluding nedmalloc) should not magically disappear when NDEBUG is  
defined.  So precluding a more labor intensive approach where all  
currently existing "assert(...)" calls are replaced with an "if (!...)  
die(...)" combination, providing a "verify" macro is a quick way to  
make that happen.  Consider this, was the value that Jonathan provided  
for the "die" string immediately obvious to you?  It sure wasn't to  
me.  That means that whoever does the "assert(...)" -> "if(!...)die"  
swap out may need to be intimately familiar with that particular piece  
of code or the result will be no better than using a "verify" macro.

I'm just trying to find a quick and easy way to accommodate your  
wishes without redefining the semantics of NDEBUG. ;)

--Kyle

[1] http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/assert.h.html
