Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD2C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 11:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC2L5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC2L47 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 07:56:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F11FFF
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 04:56:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so62129945edb.6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680090988;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=isk6Om0nSCs6K1HPd9U9d3S/S8X/L3AeiXCWsC30/Ew=;
        b=haijnWTFfRfK7UwAuAG3vuuKQLqvFYmndZwrizFUu1zKHBk6e1n4yTinc9zl14YD+H
         bq4aFkVdQn1/SxKmLxz8JpD2SSbSMwAJ0rvHn6A4mjXwz+6e6KCeH7gU99r1A3c1Bsq8
         4z9FxDPgjkLbgdOWQ5QnDgjeHd6chfemcLTMiR3QA4Y5cWBk/XH/FW0mCyQTpQYiVNrK
         DFdL42+KnbeSmkgmxgS5PYFLsxouJS056NlW1PbWfR5McgtFgE+GVZhYjZrrDLjH/fZc
         5bD1qXr55yVgiT2byvawEsJwbHIAPYb8L+269/oibwo1rjjy17CaRc7F8m39GZU6o5Qg
         RXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680090988;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isk6Om0nSCs6K1HPd9U9d3S/S8X/L3AeiXCWsC30/Ew=;
        b=miy0jkoad87H/rR1XouO6qlIwtnEffXGykUn5BigMijucwUV09f0de25Od/erw/cgg
         7WhySWTo9IPiPZUOP7VOZmYM0R83oz+/WLLc/JZrPH1tEZGpIizdBBvQQIE4fMBZrThV
         vFP45FZP8NckOFgdh4DOSbUuN+fffYohBpA7Lh5DbBnF7LdwcMiin5G5n8PWd9qmSyms
         J78+QS12siDjnlVyh8WnLegotWTciFmY0WkDclFtb2R64+b2O6omx6XLKbYErlK+SEXa
         J07qhlk8Rt70SMbsl+nEZ3e8FDbYXS+bKWXN2TzAvHhzqYyvd/D7tjijm+nNKMAGUh7h
         jTnQ==
X-Gm-Message-State: AAQBX9d2dy/MIaDZSnk7BQAV+c7eQMFLn3rHP1qKgjIWSgBmmlWdjhcK
        DeP+B6PghfUqNJaFB6dsy6IpfyYpgG4zQg==
X-Google-Smtp-Source: AKy350YtInoql6tg1uDqeBfh2K2Uysds7BzUzrlGgUc3rcuFa3nAQsyKzfQZ5w5pS4iKkKdceLjlNg==
X-Received: by 2002:aa7:d9c7:0:b0:4fc:6a39:d2f2 with SMTP id v7-20020aa7d9c7000000b004fc6a39d2f2mr18874315eds.18.1680090988132;
        Wed, 29 Mar 2023 04:56:28 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m11-20020a50998b000000b004c13fe8fabfsm16895668edb.84.2023.03.29.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 04:56:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1phUPh-0059e5-34;
        Wed, 29 Mar 2023 13:56:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [RFC PATCH 0/5] bypass config.c global state with configset
Date:   Wed, 29 Mar 2023 13:53:06 +0200
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
 <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
 <kl6la60buquj.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6la60buquj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230329.86o7obvkie.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 17 2023, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> Similarly, you mention git_parse_int() wanting to report a filename
>> and/or line number. I'm aware that it can do that, but it doesn't do
>> so in the common case, e.g.:
>>
>> 	git -c format.filenameMaxLength=3Dabc log
>> 	fatal: bad numeric config value 'abc' for 'format.filenamemaxlength': i=
nvalid unit
>>
>> And the same goes for writing it to e.g. ~/.gitconfig. It's only if
>> you use "git config --file" or similar that we'll report a filename.
>
> That's true, but I think that's a bug, not a feature. See 7/8 [1] where
> I addressed it.
>
> 1.  https://lore.kernel.org/git/3c83d9535a037653c7de2d462a4df3a3c43a9308.=
1678925506.git.gitgitgadget@gmail.com/
>
>> We can just make config_set_callback() and configset_iter()
>> non-static, so e.g. the builtin/config.c caller that implements
>> "--show-origin" can keep its config_with_options(...) call, but
>> instead of "streaming" the config, it'll buffer it up into a
>> configset.
>
> Hm, so to extrapolate, we could make it so that nobody outside of
> config.c uses the *config_from_file() APIs directly. Instead, all reads
> get buffered up into a configset. That might not be a bad idea. It would
> definitely help with some of your goals of config API surface reduction.
>
> This would be friendlier in cases where we were already creating custom
> configsets (I know we have some of those, but I don't recall where), but
> in cases where we were reading the file directly (e.g.
> builtin/config.c), we'd be taking a memory and runtime hit. I'm not sure
> how I (or others) feel about that yet.

I'm pretty sure that in the end this wouldn't matter, i.e. the time it
takes to parse the config is trivial, and the users of these APIs like
"git config -l --show-origin" aren't performance-senitive.

But for the general case & if you're concerned about this a trivial
addition on top of what I suggested would be to pass a streaming
callback to config_set_callback(), i.e. you could get the values you'd
get from configset_iter() as we parse them.
