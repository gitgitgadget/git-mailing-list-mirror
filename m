Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61DFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiBAU6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiBAU6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:58:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C3EC06173D
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:58:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id me13so58178687ejb.12
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=o5/GaimW6eVraOYVDtPnVveNBGtZGP1H9jhN9LuXrGo=;
        b=ZJ8uUyFB913+SIjF32zEaBDNkmZcSeP1k2zM2fsJNUxhhVl9yi33LNjyTKJ82vJehf
         kA3HBy77cKoR+zIQBuJ5qYxWljeyK5RZ5RlrBT3zwlDfptDQaNo2cV4QP2Y7Gpr7n1se
         EL2Nmjxh2hu2DG1iUWaGyjjM83ji1d2beN+0PX4I10qg0CkTWQLAHjvSThNpspz9ZHzP
         RFdmRZdFI4AKeApCMCIrihBsBRyyALUZnHWa25G+8GqqLCPG58jBWqu2i3rJ84+7oCiP
         C2+5Z8aK0MsG6spC1EEOABOAJwG4NU/tC89R42NG4DrP9/zUi5m6GBaH/ABwFsEYhf2+
         nsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=o5/GaimW6eVraOYVDtPnVveNBGtZGP1H9jhN9LuXrGo=;
        b=NrGPr4GAz/X3HkUxMar1C/XjA+7NRt9EsSe2I6RDhaJdgWnac7Ys1LRFnXt+7ZGIbL
         czVwwkMt2gMMAa2RNu2uqVZLW6CVvV3DTipcwp9pF0hh+zLtV9w1W+8+8YUj35hdH5fb
         V5YR37EF5WF3GNboXi4Vo/WgjuORYfoZkco6zvkP4S2baYU02hlBMxRfs6nm2Vu3uQoQ
         eHZVZpwDqelm3f7HCB9Yg7wpSAPxKTrjrTYDzwCZqSRumWfDG6XMk5yQ75Wsk35b0Bhi
         nSPeKslhAF0tsviViddRdqVo4JYbA8p45yKJjsfl8aPREAqf+tClguQl9I5J7y5Lfoo8
         a04A==
X-Gm-Message-State: AOAM531tLvXwORvjjk4+inEYnLOXZ/HGI3KDQ9EdeN6YUYgxBqTCV+Rq
        qhiIg90f6m8GbCiz+F8xS1k=
X-Google-Smtp-Source: ABdhPJwoEY2ujffuDRzZFLe8V8QfBxEHOBDCLgV0nEkh0WvQW9Zdp1NGBHKA1VCS4Ldj73r6trRonA==
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr23145038ejb.325.1643749092011;
        Tue, 01 Feb 2022 12:58:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22sm14956099ejo.48.2022.02.01.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:58:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nF0E6-004MDc-TH;
        Tue, 01 Feb 2022 21:58:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 05/10] object-file API: provide a hash_object_file_oideq()
Date:   Tue, 01 Feb 2022 21:56:51 +0100
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
 <patch-05.10-719fcfbe13c-20220201T144803Z-avarab@gmail.com>
 <xmqq5ypye767.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq5ypye767.fsf@gitster.g>
Message-ID: <220201.86ee4m9ue5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 01 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Provide a new hash_object_file_oideq() for those callers of
>> check_object_signature() that don't care about its streaming
>> interface. I.e. at the start of that function we do:
>>
>> 	if (map) {
>> 		hash_object_file(r->hash_algo, map, size, type, real_oid);
>> 		return !oideq(oid, real_oid) ? -1 : 0;
>> 	}
>>
>> These callers always provide a "map" (or "buf[fer]"). Let's have them
>> call this simpler hash_object_file_oideq() function instead.
>>
>> None of them use a non-NULL "real_oid" argument, but let's provide it
>> like check_object_signature() did. This'll make it easy to have these
>> emit better error messages in the future as was done in
>> 96e41f58fe1 (fsck: report invalid object type-path combinations,
>> 2021-10-01), i.e. the die() calls here can emit not only the OID we
>> expected, but also what we got.
>
> This has a potential to moving us in the wrong direction when made
> to code paths that currently fully slurp an object in-core but may
> want to shrink the memory footprint by using streaming API more.
>
> Having said that, I think all of these want to also use the in-core
> version of hte object data (mostly to write them out), and they need
> more work to move them in the other direction, so I'd say it is OK
> to introduce the new helper to simplify these callsites.

Yes, I'm avoiding any value-judgement on whether the callers that use
these APIs should or shouldn't be using something else.

But I think as the end-state shows splitting apart the two very
different API users that do and don't provide the "map" parameter makes
sense. We're effectively calling two different functions in all but name
before this change.
