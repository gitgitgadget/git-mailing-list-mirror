Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0AFC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4659C6052B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhGNIm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhGNIm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:42:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D33C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:40:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id go30so2055063ejc.8
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ihsRshd7E5boAOnjzstMLA3RdmLaekQDO/SnP6SQ1Sk=;
        b=W0+dQ9A64Jd9ru7j8TrSbqyp4ODKDrTKBwaSe5EnLX7n9BoxyWtRCa+A/BszyF1atn
         DUdKWR7HCp5z8dFJLbTmXMMxWZs29w98jCViUNS4O3hFVWOxr8AXL7GtI+tZpOmNJ149
         b1VaZ59YIOfPr0Pv7UCHvhr0dMu9/Nd52XTbFc2xtXHMruNdqLyV+j8ICzUkwqaenhEd
         VpgiNNpAxr4BnBDr6WtjEgjo92vODXPAG8es6LoZEVmNWa6WrjpMO911l4M8F2gH5lyE
         +l3oTdS7tbVgZfdfpxBBzU3Q17rf3i4kF85OHEnHcrsg+2AGDgOwYN9hJ+PiBQx8Kk1K
         PNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ihsRshd7E5boAOnjzstMLA3RdmLaekQDO/SnP6SQ1Sk=;
        b=H5RAgIXqD8VSQLbSZ3+xR19/nLPgV347mk0olzG+1P87ni3FdlzHgry25ziHIIrt2B
         sOxVxM2ONWDaaD3So0aV2Lin5Vuf0ZJXWMw/lRDJv29oF3wSu4wMLG2uuy7iP/0x6gxB
         wiXpKVcn1Lx5GMYnZsbSKNfKTaD9bvPwtoCRHSYHacsmNQfl26vNoYhpVjccscD8VmQE
         2coQ5goASWXKoLUaYtlM1WDtEfYbTtKGOolPAceAqUCxoDy4natOovEWhTnUrJ3Ze90/
         wvjl/tqVvk5LA0KdIdGNaMLU7c5i+lCAVZ/TVV/AqADvubgGZuOcQsCw47DeDmyuuqQM
         Ad/w==
X-Gm-Message-State: AOAM531sde0x6SPVPC97Y4CNwJKiw3GA3pzvBf6VG2GszAD3DHAsieOy
        YYQ+tr8Ibh/uuDDWKucieiUN2Ox/k3gQJZKH
X-Google-Smtp-Source: ABdhPJyGQ2h9PNeQYOd7QYDOBunmenS2dBCBKSLbAudhAkBgZYDE8qEwcNByegI3K3jJwagD9S3msw==
X-Received: by 2002:a17:906:2dc9:: with SMTP id h9mr11226218eji.345.1626252006398;
        Wed, 14 Jul 2021 01:40:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j22sm506247ejt.11.2021.07.14.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:40:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6? 00/17] refs API: get rid of errno setting entirely
Date:   Wed, 14 Jul 2021 10:38:06 +0200
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
 <CAFQ2z_M7FzR6HEea2Xj-j=LiTsjQvpGJc+h+D+GgU=ZEkWm50A@mail.gmail.com>
 <87h7gy2hn1.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87h7gy2hn1.fsf@evledraar.gmail.com>
Message-ID: <87lf691e6t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Jul 13 2021, Han-Wen Nienhuys wrote:
>
>> On Sun, Jul 11, 2021 at 6:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> After starting a review of v5 of Han-Wen's where I was coming up with
>>> squashes-on-top I continued with it and saw if I could get rid of
>>> errno setting entirely in refs.
>>
>> thanks for taking this further! Is there a place where I can pull this
>> code (applying patches is bothersome).
>
> I've got it pushed to avar-review/pr-git-1012/hanwen/einval-sideband-v5
> at https://github.com/avar/git.git :
> https://github.com/avar/git/tree/avar-review/pr-git-1012%2Fhanwen%2Feinva=
l-sideband-v5
>
>> It adds resolve_refs_unsafe_with_errno() to the  public API in refs.h,
>> and I think it has an ugly signature, but I suppose it's better than
>> having the output be implicit through the global errno variable.
>
> Yeah it is a bit ugly, perhaps we should just end up using the old name
> once there's no callers of the old one?

I looked at doing this, I don't think it's worth it.

For my additional patches on top we need to somehow migrate all callers
incrementally, so we could
s/refs_resolve_ref_unsafe_with_errno/refs_resolve_ref_unsafe/g at the
end, but it just seems like a lot more churn, and for the patches to be
self-contained I'd need to re-indent all the argument lists again.

It's a relatively obscure & scary API. I think it's OK that it's got a
bit of a longer/more verbose name as a side-effect of the migration.

And in any case with reftable I suspect that we'll end up refactoring
further down the line sooner than later, i.e. to pass a "struct strbuf
*err" or something, so getting it 100% right here seems premature.
