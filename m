Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B770C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39641604E9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbhIGM50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhIGM5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:57:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440DC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:56:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so1422835pji.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BJBFbXS0fSRuiOy/vEVYvftru3cADOP7wwyd9NCYJiU=;
        b=WXQhFyL70K4IgHjLcNYSEKfCGer95LeRhXIEoCpWZ+gar/CeqLF5jdwab60VK1GTY7
         QvkHxHuNOUxYXl8bDj0Fg0f8G8do9AJGs/C6C/RP+V7eXHasviZN2/2w/nRkhRbmAKdw
         kvq5j9WrHISd6QvOIS0S3YEITwNmicjfNwDAe+CMnY66lF/oREW+KETArRNEYHV0kPMy
         hFs/AZZPwowP+GqBa6VWP0oIYNheN5TC21N2Y6UizUBtvaG3w5KgmYXw/v1xhAEZ4j0j
         V6ztV0gcxfiYt4kvR1hMjTVH9xoeJ01CfcMc6mmDrDvH3UjE13cH88vewKEay3YcmDIE
         0+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BJBFbXS0fSRuiOy/vEVYvftru3cADOP7wwyd9NCYJiU=;
        b=Ytddn4tYC16wAjE+4KrtBeDCbo6LeqjRcu45LhbGAQCmzMd/Hhwf4Q2TvnEOt0iug4
         KD6sLV2HrIwkqNq5+BqjIojAIsHkJmJDgCPP9yCAvFtxz/kT2I/KXdcESyCtQigYDGAy
         4JMFvcPVfBvFuUPMgRUrcT2wR5OYmqZ2cSb12TyrjTMnFtAc340bEZY75jp62GX0PN/o
         RBf8E1bKdhZKrzfCrQkSa3ymISi+fvpPMI9UuN4Jc0AfoaN+IvJ1iQQZZnneXzj3utaX
         3j/iC0ebch4Go0a3UMyPqTzUAvF9bV3/VeRieoU/9WKhacv+7jWl92d6AcA5airl7p4h
         RGNw==
X-Gm-Message-State: AOAM5320bQLdfGoWmGFaq33NHecGnLMxHOmcW8gXUaGbM9vNDkVqBti5
        5iDFyahq869TKqmZRUy+ZTc=
X-Google-Smtp-Source: ABdhPJx9tm0gP7mpyHeTcv3wYJuasuWm0S1e1sH8bdw8hFhUmL1koA2Rmk2skeZMZJrpiuuAChLXAw==
X-Received: by 2002:a17:90a:1957:: with SMTP id 23mr4460491pjh.141.1631019374687;
        Tue, 07 Sep 2021 05:56:14 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id 126sm14240958pgi.86.2021.09.07.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:56:14 -0700 (PDT)
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <875yvcmum2.fsf@evledraar.gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 00/13] submodule: convert the rest of 'update' to C
Date:   Tue, 07 Sep 2021 18:23:20 +0530
In-reply-to: <875yvcmum2.fsf@evledraar.gmail.com>
Message-ID: <m2fsuglf2z.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 07 2021, Atharva Raykar wrote:
>
>> NOTE: This series uses ar/submodule-run-update-procedure [1]
>>
>> This series builds upon the previous conversion work on 'submodule updat=
e' and
>> moves out all of that shell logic in 'git-submodule.sh' into
>> 'builtin/submodule--helper.c'. Even though this patch series looks long,=
 a lot
>> of it is preparatory patches and cleanup of unused functions that result=
 from
>> this conversion. The real action happens at [6/8].
>
> It looks like the 6/x part of that still applies, but not the "/8",
> i.e. this is now a 13-part series. Is this summary otherwise still
> current with what's being submitted here?

Sorry, I meant [6/13], this is meant to be 13 parts only. Other than
that typo, the summary is up-to-date with what the series contains (I
wrote all of it today).
