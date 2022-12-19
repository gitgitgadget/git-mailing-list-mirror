Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29FAC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiLSPOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiLSPOV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:14:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5A5F1D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:14:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qk9so22260025ejc.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LOCOM/oyWoYfwOehvXnvgGzdFRMrpHA9kJIyEiPoPRA=;
        b=gCn453ev4e7HzLXKGbDFci8H78R4DWQUFyvNNwbCKtoZQJnRRwdm03Kl/7gojXltz4
         Nf9Uvp1yCxrX8Z7y1nv7x23qPWhYh8KXahae+Ed7knChGMr1D4AF+DpOAJfdE0ajlSV8
         UkFGSyvcwZSM9KsPxuhZxq5bLxsJ3uz3mcZCnOfSwYDlsUtnAXEcDJjKch3h+UOoM26l
         eiGqm0qlJ8BPKQU85ZSOqoaYDRMADmCTcAuk2IgoAN6rkTW9Do4e9zlPyPb7AavNxZoa
         VgS4gOHg3cAUUo5EYFRGQlQ8Q/8aRcxMKR/3g0BWplfB1vTm/7WcmdSYYJGs86VgwiAW
         zloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOCOM/oyWoYfwOehvXnvgGzdFRMrpHA9kJIyEiPoPRA=;
        b=qugYgzEfYtzXY75nmQrkZ9TS+2ysqvNZTWaECD/g0M9YJC9vVOqKPI0lebCX67FJEd
         t0bo5skmPEOJPRQgTETp5RfCa+LdqF/AoDO8xXP85WDbIJK402qj/ubzUcJb8/7/Csw4
         F7bQEGf9vT9bR4xrmRTpMREXoVcmUhnyiDjlQkjJSyXtjpqmBWYnkIDP8vGNHU6+A4WT
         orICQDOvdrgKj1I7S43Z5Yw/2Qi9ty4zcPwlN2uWu6qCzuJcv9e0l1dh048VdW3VH11z
         qi0bO1e5XCWNOhX7kWkChaqgf089ovOFay22xhQfqRyNCfvApl0fHeLkSHmbVhgmKDSn
         8Wwg==
X-Gm-Message-State: AFqh2krZPcqnECl3YjW8NzhfIx9FZvLl0kcbMeIs3K51C5R0IBMSH/Yx
        zaHzie37/0ynyiS6exTSf+o=
X-Google-Smtp-Source: AA0mqf4+gAqB2S5YbgN37X3QomJ5ltv5ZUfUbK5AflN38cBmIz8xpG0tPKocIqLCVzgdv1w+0mnO8g==
X-Received: by 2002:a17:906:ad0:b0:7c4:ed62:5b5d with SMTP id z16-20020a1709060ad000b007c4ed625b5dmr18367461ejf.49.1671462859246;
        Mon, 19 Dec 2022 07:14:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kw16-20020a170907771000b007ba46867e6asm4582077ejc.16.2022.12.19.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:14:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7HqL-006b13-3A;
        Mon, 19 Dec 2022 16:14:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Mon, 19 Dec 2022 16:11:36 +0100
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
 <11545cde-9ce2-acf4-7c08-1b49d2dbefa2@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <11545cde-9ce2-acf4-7c08-1b49d2dbefa2@dunelm.org.uk>
Message-ID: <221219.86cz8fzara.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 15/12/2022 09:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> My recent now-landed topic[1] to remove most use of
>> "USE_THE_INDEX_COMPATIBILITY_MACROS" was merged in 041df69edd3 (Merge
>> branch 'ab/fewer-the-index-macros', 2022-11-28).
>> It left out use of the macros that would have conflicted with
>> in-flight changes, but as those topics have landed we can now complete
>> the migration.
>> As before this is almost entirely a matter of applying the existing
>> "pending" coccinelle rules, the exceptions being 1/6, and the *.h
>> changes where we remove the macro definitions (the macro users being
>> edited by coccinelle).
>> The 4-5/6 then handle some edge cases we had left (but the code
>> change
>> itself is done by coccinelle).
>
> I've only given these patches a quick scan, but I think they look
> good. None of the callers that are converted here are in library code
> so using the_index makes perfect sense.

Thanks for the review.

That's correct, although even if that were the case that wouldn't be an
issue with this migration, as we'd have been using "the_index" before,
just indirectly through a macro.

That wasn't the case here, but I do I have another similar migration for
migrating "the_repository" wrappers.

In those cases there's surely instances where e.g. we really should be
using a "r" argument instead, but I've opted to leave that question out,
as it would make the coccinelle rules involved & diffs much harder to
deal with.

And because in the end the result is the same if viewed with "cc -E",
i.e. these are just the macro shims we've been meaning to stop using for
a while.

