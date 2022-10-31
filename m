Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B38ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJaSkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJaSkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 14:40:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A313D49
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:40:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k2so31722970ejr.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sl6LooDzxQasG6P3QZ7+m05QgBqdF9tMoYShKUViwY8=;
        b=MrDX9ToLN8rXDCZuuwQvQZHWPsQztbfgfQLW/+4EF6dr5Fy2uFg85WrJ/jsLV5s/kx
         cWrORm5mxj8uagLAY9CVPGpa3BF0Ul1jgeCkdPz9JwPjk/riOs0u7DITHiLREws/Jsap
         gmTEFeXhX4RcPZyZXQ3CXIA8x7t+tWRclEs7GmL82Mm387jhuHqcvkB2AuxAYj7Vlrqu
         DyWCK5oCxgHlhRWJs5CJU55ndTWre3BSaAvkQ4kc361PSn1TXrpJjN2Ln6ozpJsnQ135
         2K9sbqJMQnSRHqbnma+4rKaHU1M0ijq30jt39IrU8yBxh9h+HB8ksJ/Jze5C088VCzeq
         lhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sl6LooDzxQasG6P3QZ7+m05QgBqdF9tMoYShKUViwY8=;
        b=yHWYmSs/q/6b6MNtd3rwKUaob9YQ4geBwRLkV3EPBAhCsLkjlALBW9fhtyDaxbrgc7
         CT+y72XHIT7VMMWg/+VByo6UhVWhSEYF/i8LAeZ6wr1yhYU9N+f2N0xpYbvtOBokcWrH
         LZXwr3vTn9W0F1WoA33QXtw9Kyla+Ze639WEPygeMcU6ysN8izG6mvdOB4BKlPflJQuM
         X3RASdkhf5Q36Hpfu+FyX1IYNmPEZLZBLVT8UETZNDRbx9ttpZuIYoFMYLkq/+iHc7Kq
         O1oebATHKNk9E4bV2GkD0ot8jYPlAsgtzqNlYSwLOrzLBIXfrd2r6tZXx4Y6ATm7DJu/
         YsfQ==
X-Gm-Message-State: ACrzQf2O5kDGbq5tZgNvIXOfsPAqlrcdCDHLUj9+mg9/MBS+++xZhaEm
        wHV/sC2CRpK6nT4TTSwOdXEweHHJ68w=
X-Google-Smtp-Source: AMsMyM44mhBWgzkVrYAx4rfr6OAphyQLO6+cB4+47Kxu4rLjUu1X5x6I1EtPMAsCRV0r7VSH73Wp9A==
X-Received: by 2002:a17:906:8a6c:b0:7a8:2f09:d88d with SMTP id hy12-20020a1709068a6c00b007a82f09d88dmr14095732ejc.49.1667241604444;
        Mon, 31 Oct 2022 11:40:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i6-20020a1709063c4600b007adbeca22fasm2430696ejg.47.2022.10.31.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:40:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opZhb-00AmA6-1A;
        Mon, 31 Oct 2022 19:40:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/10] config API: add "string" version of
 *_value_multi(), fix segfaults
Date:   Mon, 31 Oct 2022 19:22:45 +0100
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
        <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
        <xmqq4jvpkpxd.fsf@gitster.g> <xmqqzgdhjb89.fsf@gitster.g>
        <221028.861qqsajx6.gmgdl@evledraar.gmail.com>
        <xmqqmt9fiws7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqmt9fiws7.fsf@gitster.g>
Message-ID: <221031.868rkv7s70.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 28 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Actually, I take it back.  Instead of introducing _string(), how
>>> about introducing _bool() and convert those minority callers that do
>>> want to see boolean values to use the new one, while rejecting NULLs
>>> for everybody else that calls the traditional "get_value" family of
>>> functions?  That would "optimize" for the majority of simpler users,
>>> wouldn't it?
>>
>> I don't think the goal should be just to optimize for those current
>> users, but to leave the config API in a state where it makes sense
>> conceptually.
>
> It is more like guiding a conceptually clean design using the need
> of the current users to rein in pursuit of theoretical "elegance".

I agree that the current code users don't care either way, they'll be
getting the same thing.

But being able to readily understand an API is valuable too. The config
API is bad enough with all repetition of:

	{git_configset,repo_config,git_config}_get_value()
	{git_configset,repo_config,git_config}_get_string()
	{git_configset,repo_config,git_config}_get_bool()
        [...]

I think it's worth it to be able to say that:

	{git_configset,repo_config,git_config}_get_value_multi()
	{git_configset,repo_config,git_config}_get_value_string()
        <ditto "bool">

Are "just like the scalar version, but multi". Actually when I summarize
it like that I realize I should really make it:

	{git_configset,repo_config,git_config}_get_string_multi()

I.e. "*_get_string_multi()", not "*_get_value_multi_string()". I don't
know what I was thinking.

But aside from that, the point is I think it's worth it not to have it
instead be:

        # "non-string" doesn't exist, but get it via some use of
        # (currently static) configset_find_element()

        # "get value", but really "get string, for multi"
	{git_configset,repo_config,git_config}_get_value_multi()

        # ???
	{git_configset,repo_config,git_config}_get_bool_multi()

We currently don't need/have a "*_get_bool_multi()", which I think is
besides the point. We might in the future, and should forsee that we're
picking a nonsensical naming convention.

We also have similar gaps in the current API (not all variants of all
functions exist, for the scalar variants), but at least those that we do
have behave consistently.

>> Now, if we don't supply the equivalent of the "raw, but multi-value"
>> function we'll make it hard to use the API, because now you can't think
>> about it as the "multi" just being a list version of what you get with
>> the scalar version.
>
> I am not interested in _bool() variant that "stringifies" NULL to
> "true" at all.  What I was suggesting was:
>
>  * Reserve the current get and get_multi for those who should have
>    been calling config_error_nonbool() themselves (because your
>    _string() has not been available to them, they were lazy not to
>    bother, leading to NULL dereference given certain end-user data).
>    And do the config_error_nonbool() inside the updated get and
>    get_multi without introducing _string() variant at all.

I get what you're saying, I just think it suffers from the problem
outlined above, and that it's worth solving it.

>  * The above alone WILL break callers who are prepared to handle
>    "bool" and "bool plus some other string", because they are fully
>    expecting that the get API will give them NULL but the above
>    update will instead stop before they see the NULL they are
>    prepared to handle themselves.  Introduce _bool variants and make
>    them call them.

Even if it wasn't for the naming question, I think the arrangement in
this series is also better in that I need to go and change each caller
to the new variant, and explain for each one why it's OK.

Whereas if we just sneakconfig_error_nonbool() into the low-level API
we're going to have a smaller change, but also one that's basically
"trust me, I read the code of all the callers, this should be fine...".

