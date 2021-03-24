Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F42C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 00:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC9B619E6
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 00:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhCXAqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 20:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCXAod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 20:44:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C7C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:44:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq27so30078237ejc.9
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fOnlNMWZ0jmqfMAixE62qUmooA1sWaiKsgWbogeSoWQ=;
        b=Oz/IHb4jfhIIFeeZazS+gPxHBJgBbu/Nfb4Pf1vviYoUMBFRJh9e9uaUcgHpYgeNAT
         yGDcHE5uJB1xpa5ameDJkCnsgrNM7nHoN/sdMMAv8dRO5arCF1hxcpx/e+Lc2UcBeOVH
         KbRkHjOkxXbPFo0ldsmWuJVVoG7Big3iZ9jY7qjCXQ8lWTIacRoOx17NpX+yhQ8lBmrr
         MNzG7ubA41GHau5r4tduNhV0WfpS7+BC9lugOCO5V0WCO7IqDovajsMC9mrqll6K6vHS
         DFtUtfkGFdOFr+Q8/T5J2ncm7j+I4mexV50zij7BcryTy178ptx7o5N5uvj4YofZsN6l
         RdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=fOnlNMWZ0jmqfMAixE62qUmooA1sWaiKsgWbogeSoWQ=;
        b=hnuV3ScHZWw+tn066wgJODbGZDGNqRR3poxObNyLKuHIJMAx3x5mjsshjI9jzLDn4v
         JRRXDK8XkzseoQNyqKjCpkNrQoOZuq9+fmFGwo2n497zrpjQSnE4IKL3cX5O5kuRvT4t
         60DgjFkMswhFhs6BlWhueeNCnX9uODKLn2s/PpcXDzJOFYyw4VeAuRgAvSVfP+DleU5a
         MA0BGsT+YNuNacu11lHU9VKGm32/DwqoNdX8bSMO7ynCBo9XBVXJpdNkl1cTAe+5QRhF
         VQp0sqDRCbkiLV4zCBfITMhGrv0NqVB9zhC1946w0a/4ogz+xxtCdwrjtQtREA3xPPCQ
         YUrQ==
X-Gm-Message-State: AOAM530MA7eSdX/3XVILwuZ4k4Gj7HxeE/i0TVsTso/FySowLqzrMtPi
        qEH0Sq2+WMhDkQHNkwAM3nE=
X-Google-Smtp-Source: ABdhPJyj0SDbXsZ7SDkBQgFpIYBrrp+6CImS20rCFN7vtKPI7hSxu6UVQJVCUjmzwC3WvgaIkpB5kw==
X-Received: by 2002:a17:906:95c9:: with SMTP id n9mr863292ejy.16.1616546668933;
        Tue, 23 Mar 2021 17:44:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z17sm160612eju.27.2021.03.23.17.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 17:44:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Emily Shaffer" <emilyshaffer@google.com>, git@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        "Drew DeVault" <sir@cmpwn.com>, Rafael Aquini <aquini@redhat.com>,
        =?utf-8?Q?Ma?= =?utf-8?Q?rcelo_Arenas_Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v3] git-send-email: Respect core.hooksPath setting
References: <20210323162718.1143982-1-robert.foss@linaro.org>
 <patch-1.1-cc0ba73974a-20210323T173032Z-avarab@gmail.com>
 <xmqqeeg51ojs.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqeeg51ojs.fsf@gitster.g>
Date:   Wed, 24 Mar 2021 01:44:27 +0100
Message-ID: <87zgytpehg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 23 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> From: Robert Foss <robert.foss@linaro.org>
>>
>> get-send-email currently makes the assumption that the
>> 'sendemail-validate' hook exists inside of the repository.
>>
>> Since the introduction of 'core.hooksPath' configuration option in
>> 867ad08a261 (hooks: allow customizing where the hook directory is,
>> 2016-05-04), this is no longer true.
>>
>> Instead of assuming a hardcoded repo relative path, query
>> git for the actual path of the hooks directory.
>>
>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> Here's a v3 that fixes various issues with Robert's v2. Range-diff &
>> updated patch below.
>>
>> The advice I had in the v1 feedback about GetHooksPath was bad, just
>> having it be a new accessor is better. It's not like anyone is calling
>> this in a loop.
>
> How urgent is this "fix".  I am wondering if Emily's "git hook"
> automatically fix this for us when it comes.

We've had iterations of that topic for almost a year now (since 2019
counting RFC discussions).

While I'd like to see it land I'm skeptical of parts of that approach[1]
and expect we'll have more re-rolls of it, and in any case the conflict
in send-email[2] will be trivial to resolve. So I think it makes sense
to queue up this narrow fix and not have this wait on the larger topic.

1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/20210311021037.3001235-36-emilyshaffer@googl=
e.com/
