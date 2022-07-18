Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40801C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiGRPQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiGRPQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:16:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E2E2528A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:16:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id tk8so10480380ejc.7
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EhZVxL9fz5qYd0zCfZZ9QTowCr13JIa8AHKWIQ5gPr8=;
        b=l+RE68tdTnY1pRtPx2dnDItVrgKjmwQaAJEmixhKbM9ykWrGOZRHBKYOr4FGQtzFp8
         3KcvMgEMcqDDFcUkFVUm6xBWestQFxU03VEVFDidt4Zg+jGYErBQ83kLoHHZcKB0FGsG
         nkZzGzQbryC76BZe7yip5Kl5fLCFO3tRaUZL0WfCovun9eh3bmFnQBKpZTe4nn3eLEHw
         LTvfzZSRX6FNYUwHQ9Z+izTZV5w53e/Y0P0RK/1n9JQ27nbYG+hLrB75J44pwYv+IMQC
         mD1neuJTQZE0Fqqgtt8Hh1yd0qeIcl6pUozX86IDmSFYzp4y3TdUBigTC/iaPFYjSSQj
         lNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EhZVxL9fz5qYd0zCfZZ9QTowCr13JIa8AHKWIQ5gPr8=;
        b=6lvePIE29HPsS+TOckCEezLhn8UAsAk5v9Z4H68vUMmZ1/HEVMcSHLszivpViiWe/L
         ewsyNXLOOHqtHX+FwiuYmOT6ibV67XT8hA5Ie44sIT1HoOS3UN3pOxgsIhD1wDz0nO+g
         TAEX3JNILZozSkzi6ULJPwG+iMkfSixGdkj5tmgkzhJjC/SUbk+S3Yyp/1qvI+gnHcHD
         Te9RAOpWfwD9sMp4AVpP/LY9EIdxxsbIMzmRsRFbbm0Vyt6SFo8pQ5Pjmf8AakBU2u0x
         ohOjp2wnKrtckQCDZkweLue3KGNzNmVTyW+nKf7eianl5VW5vStmLxIEQODoGTQqUUUE
         0G2A==
X-Gm-Message-State: AJIora+UXHfODbb8GE9aWaYHOlKHFLRYdm9r3DhyZ/fcSWzdRN49qY8U
        FCBwjqkW7eYsO3yOmvUvy6U=
X-Google-Smtp-Source: AGRyM1sXgENpDQwAAcYQPmPWH4+jmM79cpcO2SxSIANvJTqhjTHcQrOyXM/v5XhHYSno5mF2BxJKQQ==
X-Received: by 2002:a17:907:9612:b0:72e:56bd:2b9a with SMTP id gb18-20020a170907961200b0072e56bd2b9amr22965578ejc.526.1658157398906;
        Mon, 18 Jul 2022 08:16:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id by28-20020a0564021b1c00b0043acddee068sm8826452edb.83.2022.07.18.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:16:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDSU9-003Cho-Ok;
        Mon, 18 Jul 2022 17:16:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Date:   Mon, 18 Jul 2022 17:13:05 +0200
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
 <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
Message-ID: <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Jeff King wrote:

> On Wed, Jul 13, 2022 at 03:10:35PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> There's several potential ways to fix those sort of leaks, we could
>> add a "nodup" mode to "struct strvec", which would work for the cases
>> where we push constant strings to it. But that wouldn't work as soon
>> as we used strvec_pushf(), or otherwise needed to duplicate or create
>> a string for that "struct strvec".
>
> Right, I think this falls down when you have mixed const/non-const
> entries. You have to know which is which for strvec_clear().

Yes, that aspect of it sucks, such a caller will need to do its own
bespoke free-ing.

In practice I haven't really found such callers, API users tend to use
one or the other. Either they're using strvec (needs free-ing) or
main()'s argv (no free-ing).

To the extent that that wasn't the case I figured the easiest fix for
those is probably to fully convert them to strvec, the copies being
trivial in the larger context...

>> Let's instead make it the responsibility of the revisions API. If it's
>> going to clobber elements of argv it can also free() them, which it
>> will now do if instructed to do so via "free_removed_argv_elements".
>
> OK, I think this is a reasonable and minimal fix for the "--" problem on
> its own.
>
> But if you went just a little further and made the option "rev should
> own its own argv", then I think you can simplify life for callers even
> more. They could construct a strvec themselves and then hand it off to
> the rev_info, to be cleaned up when release_revisions() is called (and
> of course freeing the "--" when we overwrite it in the interim, as you
> do here).
>
> Then all of the bisect callers from the previous patch could avoid
> having to deal with the strvec at all. They'd call bisect_rev_setup(),
> which would internally attach the memory to rev_info.

Yes, I experimented with this, and it's a solid approach.

But it's a much larger change, particularly since we'd also want to
update the API itself to take take "const" in the appropriate places to
do it properly.
