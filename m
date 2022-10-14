Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C337C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJNPOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJNPOh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:14:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF073EC
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:14:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k2so11201451ejr.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pIQNKRMyPODe9a9thOvHNQVHXfP7SpSGYiJOKYC2GaU=;
        b=dh+ZSpTJskYrS9G3t99NdiOAR5c1dcu7IPKOinmBHRj60GPijAw2DanGLTMj/7YYpo
         zKW1lbp3OxAG8ZnUE9pdWbUVmDQCGI4uCl3lkTCXijxaV2zHx+tNBx0RHs+fE/Z+6+IB
         VAI3/UsKuKCSS/hk8lZYOOUHskipHFEiWepE6FDInFZzVVzEEdlTWb7G4fQSZZzpnQTZ
         l/flw6ScmM/UUYss//zKmQ5/lyEkwEctYhhu5XD5aYPYeDfNvWd0R9/8RbwdU0qF0GNy
         pKG16Qwe8ZNNQ8PXippSWE6VMBIBixV5UhQQxAn9mnWge8kVsK6WfzD0R8r9D6FRaU0b
         YU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIQNKRMyPODe9a9thOvHNQVHXfP7SpSGYiJOKYC2GaU=;
        b=7Mo2t4dYwfE31ckFbCR/5yORDh7iKwT47f7M+OHlQsxQ7XSPJlqzGHPpLaxRF1PHWX
         zENFXg6x/HwJ6pKpOeQzt3zVxlTDp55l9+Rhcc1tJKsMe6lZpKk5RC3d+e65JdzWu+bG
         3nnNzLt7E8KdWrwwFRCh36K3/DhAZdwSybQUjwYSfGdbNqZVMrP1AQ5zSiK3P37P2zJK
         nb5FOwJn/9IxCjSgRxqmjs2OO5bHXN3sGqArFE6rrFQeEdh+i12mu6bEZWG8XDIdqlJJ
         du2WT+kO3MH33WcFBl139kUz6P1/N84ZD/z/M0tgMVRfvEiz/tnVobfzTC4UqGBcoCL5
         N/2g==
X-Gm-Message-State: ACrzQf2ERXwC8xgtTYUvIMGdatWVu5ymZNLHf+xfgGMdIqnPf7mneSln
        k65SisxRKkx+YgpLiXt3HlQ=
X-Google-Smtp-Source: AMsMyM7AGI+H4isk6bJhHQe9p1EGTOEttkzB8rXgBmf3l/sTgsEQygvDIabMnqB5QB0gnTQkPagH7w==
X-Received: by 2002:a17:907:1624:b0:78d:d61c:2b4a with SMTP id hb36-20020a170907162400b0078dd61c2b4amr3899723ejc.208.1665760474190;
        Fri, 14 Oct 2022 08:14:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906701300b0078d25e0f74bsm1680579ejj.46.2022.10.14.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:14:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ojMOO-0059sI-0X;
        Fri, 14 Oct 2022 17:14:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/15] run-command API: pass functions & opts via struct
Date:   Fri, 14 Oct 2022 16:50:41 +0200
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
 <06bc6ffe-3f64-481e-5c54-156a39865e25@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <06bc6ffe-3f64-481e-5c54-156a39865e25@dunelm.org.uk>
Message-ID: <221014.86y1tijv3b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 14 2022, Phillip Wood wrote:

> Hi =C3=86var

Hi, thanks for taking a look again.

> On 12/10/2022 22:02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> For a general overview see the v2 CL:
>> https://lore.kernel.org/git/cover-v2-00.22-00000000000-20221012T084850Z-=
avarab@gmail.com/
>> Changes since v2:
>>   * Ejected various not-to-the-point of converting to the "opts
>> struct"
>>     per feedback about attempting to make this leaner.
>
> We're back to the same number of patches as v1 but you've removed
> three test cleanups and squashed three patches together which means
> there are five new patches in this version - what are they doing?

There's nothing *new* in this version, but per the range-diff of v2 some
of the new ones in that version were kept here. I think that's what
you're taling about.

Mainly it's the 'Only the "ungroup" was here in v1[...]' part of the v2
CL:

1. https://lore.kernel.org/git/cover-v2-00.22-00000000000-20221012T084850Z-=
avarab@gmail.com/

>>   * I kept the size_t change & the online_cpus() fallback, and updated
>>     a commit message for the latter. For "int" v.s. "size_t" once we're
>>     not handling "-1" to mean "use the default" it makes sense to be
>>     unsigned, and if we're re-doing that at this point we'd need
>>     rewrites for "!processes" assumptions.
>
> I left some comments about this, I think the size_t change is taking
> us in the wrong direction as it is introducing a number of new
> implicit signed->unsigned conversions. I'm still not sure why you need
> the online_cups() changes c.f.=20
> https://lore.kernel.org/git/8f95fbdb-b211-56af-8693-0e5a84afebac@gmail.co=
m/
> which has never had a reply

Sorry about the non-reply there, between that & later discussion I tried
to address that in the "Keeping this default behavior just for[...]"
commit message update in this v3 (see range-diff).

But no, those changes are not strictly needed. But it's a trade-off I
decided to take.

In the v1 (linked above) you pointed out that we could simply copy this
field to the "struct pp" (a shorthand for "struct parallel_processes", I
assume).

That's true, but for maintaining & understanding this API I think it's
much easier to reason about it when all of our user options are "const",
and we don't second guess any of those, and the "struct
parallel_processes"

For the v1 I can see what that was easy to miss, as we still kept the
copy of the number of processes in the "struct parallel_processes". In
the v2 and this v3 we get to the point where we can remove that, and
"ungroup", the copies of the callbacks etc.

So, leaving out the "provide a default" seemed worth it in the end, it's
just 4 additional lines in the callers per the 05/15 (most of them had
those already).

You also had a related concern in 04/05 (which I'm taking the liberty of
replying ot here):

	https://lore.kernel.org/git/a7463bc5-9a92-8f0f-c0ee-e72fbbeedc09@dunelm.or=
g.uk/

So, first I disagree with it "going in the wrong direction". We've been
converting more things to size_t. For e.g. an "int nr_processes" we can
expect that we'll want to e.g. have a corresponding "struct string_list"
whose "nr" is a "size_t" (or similar aggregate types).

By mixing the two we're mixing types forever with associated warnings (&
suppressions). We've been changing these sort of things to a "size_t"
elsewhere, e.g. dd38e9e510c (trace2: use size_t alloc,nr_open_regions in
tr2tls_thread_ctx, 2022-10-12) is one recent example..

But yes, we do incur warnings under DEVOPTS=3Dextra-all now because things
outside of the API are still "int" in some cases, just as we do with
e.g. "struct string_list" and its users.

As to your:

	Before this patch we could have caught a negative value of n
	with an assertion. After this patch a negative value passed will
	become a large positive value (you have audited the current
	callers but that does not protect us from future mistakes).

I that's a good point. In this case I thought the likelihood that anyone
would accidentally pass ".processes =3D -1" or whatever wasn't worth
worrying about. If you think it's worth worrying about I think that
concern would be easily addressed e.g. with:

	if (n =3D=3D SIZE_MAX)
        	BUG("overflow?");

Or whatever.

A much likelier edge case IMO is that you'd have some pattern where you
init a "processes" with "{ 0 }" or whatever, so it's zero, and then we'd
interpret that zero as online_cpus(), which e.g. for the in-flight
paralellizing of certain "git submodule" operations is probably too high
a number.

Since we don't interpret !n or n < 1 as online_cpus() anymore we can
BUG() out on it, which I think is an improvement. The 4 lines of
additions to the relevant callers to call online_cpus() themselves are
better than having those or a new caller potentially have this DWYMery
from the low-level API.

>>   * Squashed the multi-step introduction of the "opts" struct, per
>>     Phillip's suggestion.
> That's most welcome, thanks

Glad you like it!

