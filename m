Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA78C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiB1WrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiB1WrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:47:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921B13A1E8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:46:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i11so19625088eda.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TL8RrY8X4fQeSRDOQbCTmcCL4ST3zoPSoM3RKYUZcyo=;
        b=eBGoa7DaTQOxFJy3kIPKP2JslU39uZryf0ZLkRP/gE0van8xlu0Uk5EC86DJQHDFmX
         LB0INMiyRutezsQ+DOdbOrhYm83AUG4sFlAFBO1GgsWpZhdqH/9GVbKgxyHuJOgBhObE
         8660up3dDQ1A6GAlVUUDtmqf1ysuLSQLBhCyMpu0s570o0oX0tttfe+fY9+nFudLscS6
         krCvVTT59Ad3nyoG1sYJYVBXNHG0+NJif8UfsU8GKdiyJBZWNlYOidjGqUgNJqTanMBQ
         SMKGDeh/egMmx/TqzUp5MAKDlp6zM7NfpVbKvI9K434y9jr56y3mMsJDqvGM8RyQJY/o
         GrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TL8RrY8X4fQeSRDOQbCTmcCL4ST3zoPSoM3RKYUZcyo=;
        b=KCKMvAzGviiB/G43On/u1IDgF1uwK+Fo0QtoVL3juZu+g3EwiVh4785Ft7h67Y6L88
         YU3Zg1t6Ie77sOV+YtY9UzynQEva9EPCuZBMAVMAWreJ3I6praL/10fIzwnkAL0SnEPM
         MY8bqAce3aO1twy47PRbTGjGQYk0Cu5Ys6zFwr/+MPUIas/ZGnn/BjIBHjDRLbdILI+0
         Wc5ifxpqlDZ+JIeUwiQP33fef7prLyOoC8RP7Ot0/3SCbo5O9xcYVP9BWLkYlCfrJVlt
         YVUIeTrQKpgbKXhEYZNmGOTWZBZ+Uy+x635w5On05rCyaOq0CyLBRzu92X2XaT1Yj9Y3
         rYzw==
X-Gm-Message-State: AOAM533yvINGobZ85YdZMZn10e4a4K7H3kjzz1OvDXXO65C+vB/LLf2X
        QAGpSrOqugSeji85hNhfWkw=
X-Google-Smtp-Source: ABdhPJyZvUisQQNJdLFkwu8rjQaBSJsHKyygOy/Yx8EJhgcVrFqnBTB/7huMg80Oo948SCFTbcpiRQ==
X-Received: by 2002:a50:e696:0:b0:413:3846:20a9 with SMTP id z22-20020a50e696000000b00413384620a9mr21874601edm.96.1646088395112;
        Mon, 28 Feb 2022 14:46:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gz6-20020a170907a04600b006cec40b2d34sm4819920ejc.15.2022.02.28.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:46:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOomo-001dL2-45;
        Mon, 28 Feb 2022 23:46:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Matheus Felipe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matheus Felipe <matheusfelipeog@protonmail.com>
Subject: Re: [PATCH] fix: include the type flag in the cli docs
Date:   Mon, 28 Feb 2022 23:42:21 +0100
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
 <f171e157-7dbc-b07e-7164-c62e2427fbe2@gmail.com>
 <xmqqilt03xat.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqilt03xat.fsf@gitster.g>
Message-ID: <220228.86a6ea38z9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 27 2022, Junio C Hamano wrote:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
>> On 26/02/22 12.34, Matheus Felipe via GitGitGadget wrote:
>>> From: Matheus Felipe <matheusfelipeog@protonmail.com>
>>> When the `git config --global --help` command is invoked,
>>> the cli documentation is shown in the terminal with a small
>>> error in one of the values of the Type group, which is the
>>> absence of the type flag in the `--type` argument.
>>> This commit fixes that.
>>> 
>>
>> What about the commit message below?
>>
>> ```
>> The usage help for --type option of `git config` is missing `type`
>> in the argument placeholder (`<>`). Add it.
>> ```
>
> It is more concise, and at the same time points out the problem
> being addressed a lot more explicitly.  Much better.
>
>>> -	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
>>> +	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
>>
>>
>> The help should be `give the value the specified type`.
>
> I am not sure if this is much of an improvement.
>
>     $ git config --type=bool junk.flag 0
>     $ git config junk.flag
>     false
>
> uses the type information to turn "0" into "false" before it writes
> the value set to the variable to the file, while
>
>     $ git config junk.flag 0
>     $ git config junk.flag
>     0
>     $ git config --type=bool junk.flag
>     false
>
> shows that a stored value of "0" can be turned into "false" when
> showing.  "Give the value the specified type" does not capture the
> essense in either direction.
>
>     Before setting or showing, convert the value to its canonical
>     representation according to the given type.
>
> is what we want to convey, but it is quote a mouthful as-is.
>
> Saying "Assume the value is of this type" would strongly imply
> "Convert ... to its canonical reporesentation", and the current
> "value is given this type" may be a close enough and shorter
> approximation of it.  I dunno.

Perhaps:

	"coerce (on read and write) <value> to <type>"

or:

	"coerce (on read & write) <value> to <type>"

or:

	"coerce (on rw) <value> to <type>"

For the short help, depending on how verbose we'd like to be?

In any case a follow-up fix, just the "" to "type" being proposed here
is orthagonal & looks good to me.

