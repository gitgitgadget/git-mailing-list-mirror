Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F1C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352145AbiCXRIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352135AbiCXRIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:08:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B2B0D11
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:06:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h1so6391330edj.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bvl973t3g+NX2omuARKsSZ2iCfpQrWzkXvxhdbP/KWA=;
        b=K5YSU7y/1zy6BxwM6XEgyvMWlcwXuU9D984/y4g27KT9smhGEVmMUBXrouWe++2CYm
         aKIAC5JhAB38f6s3Ni3tWw6nFUiKHh1c695ysoLk3zz6LG9eASUroyqhPHhEQpLKVS+a
         qYeg9rccAd6ONyWn+NsNGBO2t83Mrlzpv8zjsu/3I7KTL2n+qsNTQV38dd34KI1LUEkA
         VCgZlSW6Mgk0lHqq4qxV20lxMjocL/S/arigCzeeJTglpMnzCa2SqQubiZeSvG4KpBsW
         fYG4zv3Da/0NYgfZDh20a9dkeE8pE7hS7d+OweHCG2XvRPlli0+78pUhe86jlffpf8CC
         Pwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bvl973t3g+NX2omuARKsSZ2iCfpQrWzkXvxhdbP/KWA=;
        b=3cwWtQalxA2qSi4Rpq8id7B0ZGgCXgGsZBcSOnfv3I0LJt08XCRxZ3PfChd6CxZ223
         H4NgNJW8ggTAI4DUEbAKrPyMvq3m0S7i1dJmmDUP7ezomP2hlKPOkGmhbJqpahjQQ4P9
         cT06OVbvLyrMYz9J5q835YnGOsqUIJdtu3unxdlBQqYgDY5o5JBiDK7LZP13DYos59Df
         fNXRbvR/jgP/Tb2HULrPq3ydfQgu7GocnplIa35NyiB5jKrPrIEkFu5jTAWrE5eBuTMO
         jOaHvXryNpBQJedxIjEbpUbTe63sj719bTR3MLr4w/JJdrQkhHAnh0+J0W4U3KK2aDvR
         IMVA==
X-Gm-Message-State: AOAM530VzzWOWthIN9wcebiiMl/Qn3R02A+wi/abcWkW+LkLceHDapQw
        vvnhDTTqpnCaSyNiBamz710=
X-Google-Smtp-Source: ABdhPJwgv/J8V5/qWZ6Ei7ImwyoNRhkHJGURn3rXwA9XOmTevAXAAWnQl+1CCw0m9Gm6bOvMh3YI7g==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr7906341edt.359.1648141586676;
        Thu, 24 Mar 2022 10:06:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg39-20020a170907972700b006e047c810dbsm1376804ejc.56.2022.03.24.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:06:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQun-001jSa-EK;
        Thu, 24 Mar 2022 18:06:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 08/27] revisions API users: use release_revisions()
 needing "{ 0 }" init
Date:   Thu, 24 Mar 2022 18:04:34 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <patch-v2-08.27-42ad1208934-20220323T203149Z-avarab@gmail.com>
 <xmqqy210kl3i.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqy210kl3i.fsf@gitster.g>
Message-ID: <220324.868rszmga6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Use release_revisions() to various users of "struct rev_list" which
>> need to have their "struct rev_info" zero-initialized before we can
>> start using it. In all of these cases we might "goto cleanup" (or equiva=
lent),
>
> I didn't look at the bisect code, but the bundle one looks iffy from
> the point of view of API cleanliness.  If we have not yet called
> repo_init_revisions() on a revs, we should refrain from calling
> release_revisions() on it in the first place, no?

It could be avoided, but I'd really prefer not to for this series.

repo_init_revisions() is a non-trivial function, and changing the
various bits in this series that can easily have a "goto" pattern
because we assume that { 0 }-init'd is safe to pass to
release_revisions() would be a larger change...

We assume that in a lot of other destructors throughout the codebase, I
figured we could leave this for later.

Is that OK with you?
