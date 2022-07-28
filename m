Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A830C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiG1RO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiG1RO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:14:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D3E61DBA
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:14:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id os14so4262183ejb.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=v5FVTAXqa+JLcjF2fOMP23lb6hai46PtleQcFl6/dSo=;
        b=VHl6JbYnJ6RngV1ESw3FjgVN7k+/dED//2XWY6wAPx4OCSXiTOwMyNni4cQKAIkDIr
         xfeQ3RL2M5j/GBQcl294r428NScAiwB6/Yy1b9PlOVqvhohWc926/7Y+zThFxsBmJ/tP
         kctmKA4/8VxaAQwzRn/X+cZlOOdEIG+SupyhVTiZ1rHm5K/JsMMXjzkGDtkNsyKXk1Iu
         fhnYCLtNxGJ7GBUqq47Zb8WFdWg7ikc8YhbIU7JzRBR8R8UWRQUuKqnNkcYzxZJ5wlKU
         QWyTfnqDS2Q8plHEopY2oANpgTQsGvfI7a9D1IFDcfQz3DVZPvgAv4C/RUU3nAmXyQt3
         NoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v5FVTAXqa+JLcjF2fOMP23lb6hai46PtleQcFl6/dSo=;
        b=v5sLgQzqx4cupciqs7gkOP2zE1Iu8SS28rmPzMxxcOHBHk+ZTTyAxr4ZG4Bvbbz7N6
         Kkq14Oqt/gw9bVPqFuXXZoi7GRYyRlnZonKavzI9/5QaYpw/J/ApzZlvtZKcUyyDn5CE
         BSUAt0IgYc19H4jpuWr98lrTaTSkqADIhftiit870z1nE+HfjJv4bWtqQ6ZKYB3BVxoQ
         s7ndiGU/EFrIcmWn11nKUc5Ao9bpUcKSo1vDJA0dVZp11RPcWrUwKDDNXkKiYDvIMUCw
         0VzlVGh6T9pKisox/ryo39SCpn+SkIGZmyrArLIVHOzl2vqax+wjuJJfdYq4p8U0+Rv9
         UaOA==
X-Gm-Message-State: AJIora8iJj9jjarWcdzwzse//PX9yZ4jskyOY89DvRrGnLJVsPsjiHyL
        pnVi02lTW3Xr2uw58j5+42c=
X-Google-Smtp-Source: AGRyM1szriF1H9G/aeZM8Q9cN1Ur6JLsAUke6ZQ3hWqNUOGJ+mJ/yK1kJLU25CKiAo/TgxLNW/XGdQ==
X-Received: by 2002:a17:907:2ce9:b0:72b:30e5:f1bc with SMTP id hz9-20020a1709072ce900b0072b30e5f1bcmr21684527ejc.127.1659028491834;
        Thu, 28 Jul 2022 10:14:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ek6-20020a056402370600b0043a2b8ab377sm972403edb.88.2022.07.28.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:14:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH762-007C4o-4I;
        Thu, 28 Jul 2022 19:14:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
Date:   Thu, 28 Jul 2022 19:12:45 +0200
References: <1196830250.20220726145447@yandex.ru>
 <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
 <xmqqo7x9ch7n.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo7x9ch7n.fsf_-_@gitster.g>
Message-ID: <220728.86k07xjh11.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi Eugen,
>>
>> On Tue, 26 Jul 2022, Eugen Konkov wrote:
>>
>>> $ git range-diff --creation-factor=100 branch...origin/branch
>>> 1:  a87daecd47 < -:  ---------- Add mocked exchanges for ...::AutoRenew::General test
>>> -:  ---------- > 1:  36eaeb56a9 Add mocked exchanges for ...::AutoRenew::General test
>>> 2:  9594ccf145 = 2:  70681dd13b Remove a call to DB::state
>>> 3:  740903e01c = 3:  5745ae5702 Run cpanm without tests
>>> 4:  e8e6cac09c < -:  ---------- Do not use 'require'
>>>
>>> --creation-factor=101 does =)
>>>
>>> but maximum value for percentage is 100. So expected behaviour is to display range-diff when value 100 was provided
>>
>> Please see https://git-scm.com/docs/git-range-diff#_algorithm for an
>> explanation what the meaning of the factor is, and why 100 is not the
>> maximal sensible value.
>
> When I had to give a huge value to the option the last time, I think
> I used --creation-factor=999 or something.  The thing that bugged me
> in the output of "git range-diff --help" is that SYNOPSIS section
> has "--creation-factor=<factor>" but the OPTIONS heading says
> "--creation-factor=<percent>" and the word is used in description as
> well.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: range-diff: clarify --creation-factor=<factor>
>
> The value is not a per-cent that ranges from 0 to 100.  The SYNOPSIS
> section gets it right, but the body of the documentation said "percent"
> which confused readers.
>
> While we are at it, rephrase "smaller one" that corresponds to
> "larger value" earlier in the sentence to "smaller value" to be more
> explicit, to avoid misleading eyes of the readers to an unrelated "a
> large change" nearby.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-range-diff.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git c/Documentation/git-range-diff.txt w/Documentation/git-range-diff.txt
> index fe350d7f40..e49630e8ad 100644
> --- c/Documentation/git-range-diff.txt
> +++ w/Documentation/git-range-diff.txt
> @@ -61,11 +61,11 @@ This is known to `range-diff` as "dual coloring". Use `--no-dual-color`
>  to revert to color all lines according to the outer diff markers
>  (and completely ignore the inner diff when it comes to color).
>  
> ---creation-factor=<percent>::
> -	Set the creation/deletion cost fudge factor to `<percent>`.
> +--creation-factor=<factor>::
> +	Set the creation/deletion cost fudge factor to `<factor>`.
>  	Defaults to 60. Try a larger value if `git range-diff` erroneously
>  	considers a large change a total rewrite (deletion of one commit
> -	and addition of another), and a smaller one in the reverse case.
> +	and addition of another), and a smaller value in the reverse case.
>  	See the ``Algorithm`` section below for an explanation why this is
>  	needed.
>  

That algorithm section also says:

	The cost of an edge o--C is the size of C's diff, modified by a
	fudge factor that should be smaller than 100%.

Which I find quite confusing to follow, isn't that "fudge factor" the
<percent> (or <factor>) we're accepting with --creation-factor? Doesn't
that also need to be adjusted?

I still find this documentation quicke lacking, if the default is 60 and
it's not 0..100 what is it then? Are values of 200 sensible in some
cases, 1k? 10k?
