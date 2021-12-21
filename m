Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42745C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhLUQYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhLUQYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 11:24:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A94C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 08:24:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bm14so41306491edb.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rqKyHXBQGscXVUNQu+tiGDKFM3+IAOr5ghwHjd8GB8w=;
        b=WoSh8BD8liuBa+FEmkWuYJn3jppnz6oBJw87kmpcKS2cvFhbuVobTkgNsOM3S89HFa
         ll3R9ImVStIjemk8Sw0Mz0+QRL7pgLVpdU1X1w3nmS4HnbAepzc+Gprl+eMsA1hbSzoE
         HvpwzemGwYIdkU3Kmt/SOSvB+ICIps7EzRdteh22uzlJ88wNdlXmJAqBeap5XSQHtAxp
         vs4+30GUlS7fG5cvoJ6S10j5HAL0P1itqIYuC5COhDwMZxM5GykLhYgUieuebkZLi+oh
         0zP8hFNqFjvdUjilrJ4ZSlgSRlQGVPpBJNchrs4EJPQE1pcwmi+ZwTcjqUgMhzZM1QdH
         riBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rqKyHXBQGscXVUNQu+tiGDKFM3+IAOr5ghwHjd8GB8w=;
        b=ql4X2xQ4mLhRhvb8fSo5+N4NpUidVcH/Cq9BoYAJ67z2VZN4IzrbdVkVmWJVl1YSqo
         Eg0kMtgBomklwA6HEgUyJnDc/puNEEEPOioo0+GO+W0+5NKzUHhJTzS4JuxnRlqxEupk
         CDbJ0T//m/RFeRxvsNPKjnXTZ4Zh1J/XhfeweEmjzuoLBuyxAWwW77aYU67PcWu0CyJG
         k+QlRxKzuHgOZGtrLS2+Ml935ugtCwhMhf96Ixz90ZDq3Fx200pKXTKYHvYXGeCaP5FD
         Ctw5DzdGJkSZg4KF6r10QUIeN9QVLAxw3CPnQg7ujj2/iayMDM5+zJ9IOrQ5jQQsLM2d
         Cs3Q==
X-Gm-Message-State: AOAM533gw5wWtdRsqkMvEzohSkVZHeDwf+56RJhhxjtq69wxSfoCYq0c
        n/aOIM2PxvWxS/pKwQO+D1Y=
X-Google-Smtp-Source: ABdhPJz+XKZslySZI/7EkxEH6IdDNojXg/l32VvJ3+oVkZnT23crSJGY9FBTAveJdsB9bMGZUn0rPQ==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr4113462edb.360.1640103841323;
        Tue, 21 Dec 2021 08:24:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g2sm1023923ejt.43.2021.12.21.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:24:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzhvk-000oCc-6x;
        Tue, 21 Dec 2021 17:24:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Florian Mickler <florian@mickler.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jqassar@gmail.com
Subject: Re: passing CURLOPT_CERTTYPE to libcurl
Date:   Tue, 21 Dec 2021 17:20:55 +0100
References: <20211218010621.2fdc2b3c@monster.mickler.org>
 <xmqq7dc2zplg.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112202223300.347@tvgsbejvaqbjf.bet>
 <4B51B2CA-3BED-4046-8544-219DA737E7CD@mickler.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <4B51B2CA-3BED-4046-8544-219DA737E7CD@mickler.org>
Message-ID: <211221.86h7b2q63j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Florian Mickler wrote:

> Thank you for the summary!
> I am currently looking into it. Got into a conversation with dwmw2
> also about fixing libcurl or even openssl after i found some issues he
> opened about this weird interface. Which really sounds like it would
> be the real fix. (Although probably slower to trickle to end users and
> more complex)
>
>
> For this patch i guess I will skip the engine variable, because it is not needed for my use case and my lib version. (Although I am still experimenting with the whole pkcs11 stuff)
>
> That makes the error handling easier (none needed, imo).
> The git libcurl min version is also raised above the introduction of those curlopts, so no libcurl-version-bracing needed.
>
> I was looking into the testing framework, it might be possible to configure the https to require client auth on a different port and then testing that with pem and der file.
>
> Adding pkcs11 infrastructure to the test harness might be a bit over the top though :-)

It would be really nice to have https tests in the test suite, but we
don't have any currently.

There was some discussion about setting them up around some other recent
libcurl related changes, but it hasn't been done.

So if you want to work on that it would be fantastic, but don't consider
it a blocker to just get CURLOPT_SSLCERTTYPE into git.git.

We basically assume that we don't need to re-test libcurl itself, and
since these settings amount to just setting various flags in the library
the need for them isn't all that great.

> Am 20. Dezember 2021 23:21:28 MEZ schrieb Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>Hi Junio & Florian,
>>
>>On Fri, 17 Dec 2021, Junio C Hamano wrote:
>>
>>> Florian Mickler <florian@mickler.org> writes:
>>>
>>> > Is there a specific reason, that patch wasn't merged? It would
>>allow
>>> > for non-pem ssl certificates to be loaded also (without pkcs11 at
>>all).
>>> >
>>> > I realize, that the underlying systems could and should set up
>>> > everything automagically as soon as i point them to the certificate
>>that
>>> > i want to use. But not opening up these CURL Settings from git
>>seems
>>> > kind of silly given that today's systems still seem kinda borked
>>and do
>>> > not do that.  What harm comes from these two tuning knobs being
>>exposed?
>>> >
>>> > Best regards,
>>> > Flo
>>> >
>>> >
>>> > [1] https://marc.info/?l=git&m=136675822032549&w=2
>>
>>This corresponds to
>>https://lore.kernel.org/git/1366758207-7724-1-git-send-email-jqassar@gmail.com/
>>(for those who prefer lore.kernel.org over marc.info, and for those who
>>want to look for the Message-ID directly).
>>
>>My summary of that thread:
>>
>>- The patch implements something Git wants to support.
>>
>>- A couple of improvements need to be made, such as:
>>
>>  * Error-checking needed to be improved
>>
>> * Adding a hint to the documentation of `http.sslKeyType` being set to
>>    `ENG` causing `http.sslKey` being interpreted differently.
>>
>>  * Adding regression tests, if possible
>>
>>  * Maybe a more complete commit message?
>>
>>- Testing the smart card support was considered hard, especially given
>>that the contributor still wanted to contribute patches to cURL without
>>  which it wouldn't work.
>>
>>  The patch seems to have been contributed via
>>  https://curl.se/mail/lib-2013-04/0340.html, been reviewed and changes
>>  were requested, but there was no other patch submission that I could
>>  find.
>>
>>However, over five years later, what looks like an equivalent fix to me
>>  was applied:
>>https://github.com/curl/curl/commit/4939f3652473c1519d2b604068efb87ef7531874
>>
>>- The contributor, Jerry Qassar, gave all the signs of working on a
>>  next iteration ("reroll", as Junio likes to call it). But that never
>>  materialized, either:
>>
>>  https://lore.kernel.org/git/?q=f%3Ajqassar
>>
>> Based on this, the lack of a cURL contribution, and a quick web search
>>  for the name "Jerry Qassar" I somehow doubt that Cc:ing them might
>>  raise their attention.
>>
>>> Almost always, when some patch aims to achieve a worthy goal, and in
>>> the initial discussion on the thread more experienced project
>>> members agree it is a worthwhile thing to do, the only reason why
>>> the feature proposed does not materialize in later versions of Git
>>> is because the developer with the original itch did not follow it
>>> through after getting review comments and saying something that
>>> makes reviewers to expect an updated version of the patch.
>>>
>>> I didn't follow your marc.info URL, but I am reasonably sure, if I
>>> were involved in the discussion, that would be the likely reason.
>>
>>Yes, you were involved in the discussion, and indeed, there was no
>>follow-up.
>>
>>After more than 8 years, I do believe that the patch is fair game to be
>>picked up by any other interested contributor who might want to
>>contribute
>>v2 (hint, hint, Florian... all it would take is to study the mail
>>thread
>>from way back when and adapt the patch accordingly, of course after
>>rebasing it to a recent Git revision).
>>
>>Ciao,
>>Dscho
>
> ---
> Signature

