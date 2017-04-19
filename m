Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC331FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 20:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937882AbdDSUyb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 16:54:31 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36275 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934198AbdDSUy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 16:54:29 -0400
Received: by mail-lf0-f47.google.com with SMTP id c80so18808467lfh.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5nW50bmmSW9GPr5E7CqW7ptiRcLhUYm8QRjAS/TaUoo=;
        b=NsnT+NoVrbW+BxOP/3l6LoZPSMcmKareVv+2OlNsivPqg/88K8a1a8BguHUxYq55kx
         9rKvFiXKSTG5X2yvTqdxN2aaobqp2svvtHX7ySI2Y3x07ax4OMI7/2iNqmP442s6Ww09
         dWEtILaBi2hPcrx02v+ipGsfxGVvuTiaYHpW19llrjLcjjSUC0H7gd8Z1IM9GqNnQXox
         mp5w2nmlhhAaCchPB3VU08hp5nGv2EkY/sifb2IRlaiA5vqST4d+gf9Dldd2WVTbvCNM
         O75lVvyWFuKxWy3NmarjTFyQsFr1CukhONr2nBoTjm8C4xtr6K/+WQt3uj7SWXvCbrys
         MVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5nW50bmmSW9GPr5E7CqW7ptiRcLhUYm8QRjAS/TaUoo=;
        b=qC/18Sp8t0gZBoVO/6Qut5oezUr0Dxb2pCRcQAECIdyiKKZn6rdya5My+xTsGgtIJH
         E+wQOOUunmGadny83It8GZkTSWOB0hYhzTeoUxRHbvuPRvG6skN52n52XfPOfIgiOdwG
         H7bHtdgopsEXie40UsK7wBukp30nbGjlZnTVfNIEWBsGYCK1O458dvsXJpFDDccwBgP0
         ZGpdTV56q/ToACsxX+BHMzOZFhHESjxkZR14F1w2heqj9uOcb4dHG6cTRw7vF+kaLx/4
         TVn26TD+nxpsesY3Qu2CAx+bdnKxlphZ0eukbYD6eO4ZkYUHWi/cfhp/qN0DGVetqc1Y
         WXog==
X-Gm-Message-State: AN3rC/6m4bA+cGTJPINlMwrILuO4UBpqyMaTKbzY1n2i0BWCufkQETF2
        0Z7RjER3s2YnjylCDSJPgg7IpZqLBA==
X-Received: by 10.25.216.212 with SMTP id r81mr1687251lfi.66.1492635267446;
 Wed, 19 Apr 2017 13:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Wed, 19 Apr 2017 13:54:06 -0700 (PDT)
In-Reply-To: <20170419151005.wolvxiacjqxoqrq3@sigill.intra.peff.net>
References: <20170419090820.20279-1-jacob.e.keller@intel.com> <20170419151005.wolvxiacjqxoqrq3@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Apr 2017 13:54:06 -0700
Message-ID: <CA+P7+xqo6BJ8LXy8EVvq0JXPD4r-jZ6boOGT=2XY8SVnWfVMcQ@mail.gmail.com>
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 8:10 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 19, 2017 at 02:08:20AM -0700, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Many options can be negated by prefixing the option with "no-", for
>> example "--3way" can be prefixed with "--no-3way" to disable it. Since
>> 0f1930c58754 ("parse-options: allow positivation of options
>> starting, with no-", 2012-02-25) we have also had support to negate
>> options which start with "no-" by using the positive wording.
>>
>> This leads to the confusing (and non-documented) case that you can still
>> prefix options beginning with "no-" by a second "no-" to negate them.
>> That is, we allow "no-no-hardlinks" to negate the "no-hardlinks" option.
>>
>> This can be confusing to the user so lets just disallow the
>> double-negative forms. If the long_name begins with "no-" then we simply
>> don't allow the regular negation format, and only allow the option to be
>> negated by the positive form.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> I started going about implementing an OPT_NEGBOOL as suggested by Peff,
>> but realized this might just be simpler, and we already support the
>> positive format for the negation, so we don't lose expressiveness. We
>> *might* want to tie this to an option flag instead so that it only kicks
>> in if the option specifically requests it. Thoughts?
>
> Yeah, if we are going to do anything, this is the right thing to do.
>
> I am on the fence on whether it actually needs addressing or not. Sure,
> --no-no-foo looks silly, but if the only way it happens is that the user
> typed it, it doesn't seem so bad to me to respect it. I am tempted to
> say we should support arbitrary levels of "no-" parsing as an easter
> egg, but that is probably silly. :)
>
> So I am fine with this patch, or without it.
>
> -Peff

This is why it's an RFC. I don't really feel that it's too much of a
problem. As for the reason why I thought it might want a flag itself
is because of concerns raised earlier that we might have something
liek

OPT_BOOL( ... "no-stage" ...)
OPT_INT(... "stage" ....)

or something already which might be broken and the only proper way to
disable no-stage is no-no-stage?

Is this actually a concern? I thought this was a comment raised by you
earlier as an objection to a change unless we specifically flagged
them as OPT_NEGBOOL()

Thanks,
Jake
