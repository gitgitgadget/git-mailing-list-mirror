Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6150C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 12:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKXMkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXMk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 07:40:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F741001DA
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:39:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r9-20020a1c4409000000b003d02dd48c45so3516090wma.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUI7C87zbXmetg77dzhHebAhmKGvtlQLL9Maw8T5hmg=;
        b=FNyqB5dSPsub/LYbOtGYV/5qSlPVWv+fVeb4lUk645GpqSFDYkAMTaCU9Tuv5D9Wn/
         +KaXnqRUgW+D46kW96swTfKhiaZClwEf2m7y3E8CZaBxhpj6FniKTJIwzlSZicwI1BO1
         QCK+2tF0XOJ4bptTmZxMIt95NLV+i3lDibXzDVZHrBGuJIMRCPYZx7LFPLUbdMQsqRro
         a8zZy4g8W8ceJN6FSthiswnUkvUCJTTGFrGKqCjmWNZtcJPLPWX3C8bXO62s1U2u5WU9
         1t1P93VwP9iuJFoCQxoS3fQGEUB9vqakoqaGO0uANxNDw4P0CzfPdh5krIyRqcsCVsQP
         DAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUI7C87zbXmetg77dzhHebAhmKGvtlQLL9Maw8T5hmg=;
        b=tHGW+84QpcqozWHtaGRlHUFM2cRHcMQpZxfkBbnA4ZYi5j2BbZRFfNQJ/a3M7OQRtq
         i7QqurnLCd7deVQOGaFen/yX++Gn4NB98P02ROqBW7WZybSEu6XRQJKLkm3f2XEScHVU
         E82AosIUfrmZ3IuVWkspyZJ6lVIcyTobHQqzFheFdsT/j9OFc7m8JiztvEMB6XkHjUgt
         4cPqbTIaZSkiz96np6FEnY532UjgyrOfvGTrH6She6SnKDpEC9uPtvMl9TRNLLZZrDUR
         BZ0Nu1ghpGX9VWtnsMfJZ9m2mFmNMTTV+m0nbjEomNmg59t3gqyjFDp+e3d5tF2kDPyb
         iHDA==
X-Gm-Message-State: ANoB5pmajRxkjk87qQH8f3id5kmlLmCaMbvkhT3qrnSvs2scIUmi7WaB
        gmo4ObOcjXqgQiYOkDMTn0w=
X-Google-Smtp-Source: AA0mqf7w9ZGn2d3Q1yrYIaHZY+rk7PaB5Opoop+VZpAj3hoWkJwHjCTYesMuo6OWYO9p3OMrJHPDEQ==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id f22-20020a05600c43d600b003cfa856ba2fmr13286768wmn.37.1669293586538;
        Thu, 24 Nov 2022 04:39:46 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id w5-20020adfde85000000b00241cbb7f15csm1217993wrl.106.2022.11.24.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:39:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyBVW-0009cA-3A;
        Thu, 24 Nov 2022 13:39:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: python 2 EOL (was: [PATCH v2 0/3] Fix broken CI on newer
 github-actions runner image)
Date:   Thu, 24 Nov 2022 13:28:20 +0100
References: <20221123150233.13039-1-worldhello.net@gmail.com>
 <20221124090545.4790-1-worldhello.net@gmail.com>
 <2219s80r-q7s3-391o-o3or-7q70sn37ooo9@tzk.qr>
 <4oonnq45-s269-sr8n-o5sr-n214593nps8s@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4oonnq45-s269-sr8n-o5sr-n214593nps8s@tzk.qr>
Message-ID: <221124.865yf4plw1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Johannes Schindelin wrote:

> On Thu, 24 Nov 2022, Johannes Schindelin wrote:
> [...]
> The changes look good!
>
> One alternative I considered about 8e432f13bef8 (ci: install python on
> ubuntu, 2022-11-24) was to drop testing Python v2.x (it's years past end
> of life after all, see https://endoflife.date/python).

Just 2 years? :)

We're still pinning "perl" to a supported 5.8, which is so out-of-life
that I couldn't find a good reference to when exactly it went EOL. My
guess based on [1] and "perldoc perlhist" is sometime around 2009-2010.

> So I agree that the best idea in this patch series is the stop-gap
> solution to install `python2` on `ubuntu-22.04`, and deal with deprecating
> Python v2.x support separately, later, or never, whichever comes first ;-)

Yes, let's address that later. We had a recent discussion relating to
EOL-ing it in-tree. See the ML discussion around[2].

I would like to note that you seem to be assuming that upstream's EOL
for something like this should match our EOL for supporting the
software.

I think one could argue that, but that's not at all the stance we've
taken in the past, as the "perl" example shows.

I've personally wanted to bump the "perl" dependency more aggressively
for purely selfish reasons in the past (being able to use some newer
feature), but the reality is that people "back-port" newer git versions
onto various older platforms.

But in terms of the cost-benefit of the disruption that would incur I
also don't think it's worth it (although a bit past 5.8 is probably
justifiable at this point).

Someone using "perl" on an older system for git's tests and git-svn
etc. really doesn't need to worry much about the full security surface
that "perl" might provide, which includes e.g. all the CPAN libraries it
ships with, I expect that the same would go for "python".

The one potential security issue I can think of that we've ever had
because of it is that you could trick "gitweb" and the like into
ever-growing memory use if you had a perl version older than the "hash
randomization" security/DoS fix.

But other than that we're not exposing perl, python etc. directly over
the Internet, so I think we don't need to be too paranoid about it.

1. https://endoflife.date/perl
2. f7b5ff607fa (git-p4: improve encoding handling to support
   inconsistent encodings, 2022-04-30)
