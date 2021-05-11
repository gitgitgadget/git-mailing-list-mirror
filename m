Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B536C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 01:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBAB60233
	for <git@archiver.kernel.org>; Tue, 11 May 2021 01:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKBKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 21:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKBKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 21:10:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BBC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 18:09:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g65so10158785wmg.2
        for <git@vger.kernel.org>; Mon, 10 May 2021 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ezaDKWuLH4aNV2mPdV5SLAUzItf27InZ7V7z5D8CR1o=;
        b=o9c+J43eIkymBaUwGPTSbQx8+Kt96Tuusx1lq0k7Hk04ZlqAeACtS9IuqnukFXsHjt
         vzM1AuzJ3jxS/yCXxLeE7W874JLMh50s8I6jwWZ/UIidzbf4hEkBKMCbHbl3Awki/Cdl
         2NXTCt/mUExggAQH5XgePTaIAPwrj7kt8I2T6IBlR0EliZaMrds26i1d/05VZj5OuKuY
         hl9mvcidjzICxeIC7eUQAGM4IlhGBXprbMx3O0mKVsMGwu6bOTz3Ih0Sx1hp2C7ezbHv
         2GqmpiE30gMfqGXjdyFBNMrMES3pTtZyZO1+3RKLV8h329dLFLe/LIaTnsKMc2ZwLK5i
         dqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ezaDKWuLH4aNV2mPdV5SLAUzItf27InZ7V7z5D8CR1o=;
        b=Kkkc3rA4QQlI+VNXQI22pG3vrvYXui98lDVmf6E2HF21IS4Pl6LdZePfVzGWc7ouaB
         18E97Z219ZgxHh9OJoY94c5FzbWnsYwMWMXjw6mGavBFI+uC6ZTulvb6HxHGWh88zQBH
         3B3hdEshfmJKf+jUHijIDFx4BMj4CeSo/UH+bZuszX1GSks5qTbKrI4kstqVvnHF1yqx
         5g1LbwDEL5Q4DbISu5rSnjyJ1Fmw34p6E9S4whfDhXOw3qFlh8ubRicOd96OSnWFNtZS
         uQreiAXU3QhVNuXPDa6W4GFZHNsjshNpTzwEDPGbR1G19H6E2TP26J+PlbMmRfkUZloo
         FX6Q==
X-Gm-Message-State: AOAM533agv4hdtLUsUe3j6Bs6IqmxUlMJSRSWO0fsGi111BRz4yiFYDW
        OmlAkQnSTMcblsjZAdc+19A=
X-Google-Smtp-Source: ABdhPJwpRQZJiiOcghTeHoZdQrwnZ5Cfgrmq9slQHAQrHfNup+7hzScZLZ6tMlT8jPEKbvUH7ebK7g==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr2145760wmd.60.1620695363536;
        Mon, 10 May 2021 18:09:23 -0700 (PDT)
Received: from Inspiron (2a01cb04010c4200a87bd4460637fee8.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:a87b:d446:637:fee8])
        by smtp.gmail.com with ESMTPSA id b10sm29504119wrr.27.2021.05.10.18.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 18:09:22 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
In-Reply-To: <YJUAmUJiHmJRQBMj@generichostname>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <60949be8613c1_8c2220882@natae.notmuch> <YJUAmUJiHmJRQBMj@generichostname>
Date:   Tue, 11 May 2021 03:09:21 +0200
Message-ID: <87tunaf54u.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

Denton Liu <liu.denton@gmail.com> writes:

> Hi Felipe,
>
> On Thu, May 06, 2021 at 08:46:16PM -0500, Felipe Contreras wrote:
>> Firmin Martin wrote:
>> > Currently, git-format-patch, along with the option --cover-letter,
>> > unconditionally overwrites a cover letter with the same name (if
>> > present). Although this is a desired behaviour for patches which are
>> > auto-generated from Git commits log, it might not be the case for a
>> > cover letter whose the content is meticulously written manually.
>> 
>> This is one of the reasons I never use git format-patch directly, but I
>> use a tool on top: git send-series[1].
>
> It seems like everyone has written some sort of tooling on top of
> format-patch at this point. Taking a cursory look at your tool, perhaps
> a feature like `--previous-cover-letter <file>` might provide most of
> the functionality that most tooling that I've seen gives.

This is a good idea. We can default <file> to the target cover letter
(e.g., if -v2 is passed, v2-0000-cover-letter.patch or if
--numbered-files is passed, 0) if present, or the previous series' cover
letter.

> Perhaps this option could parse a cover letter from a previous version
> of a patch and use it to populate the next version number, In-Reply-To,
> cover letter subject/body, To/Cc lists and maybe more.

Absolutely.

> I think that extracting the information would be pretty easy but
> designing the UI it in a non-obtuse way would be pretty challenging.
>
>> It would be nice if git format-patch grabbed the text of the body from
>> somewhere, and even better if git branch learned --edit-cover-letter.
>
> Well, you're in luck! I wanted the same thing a couple of years back so
> I implemented the --cover-from-description option[0]. It allows the cover
> letter to be populated by the text given in
> `git branch --edit-description`.

This is the reason I CCed you!

Thanks for your comment,

Firmin


>
> -Denton
>
> [0]: https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.txt---cover-from-descriptionltmodegt
