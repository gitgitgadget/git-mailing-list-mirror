Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31193C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbjAITcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbjAITcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:32:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEB26950B
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:32:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ja17so7052951wmb.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcMhYoGPhT3rzgqBWEorKUmFUsNJdJGFS4nJy6g/4Ek=;
        b=cA4Zk70qDD2iOobAbD2ps70upzble41EDzE2fBZEglifuK29snnIvo/8DT9aQcYAaE
         tWR9RU0sApCda/eA8AP3oflS84dc6ef8gomlG9gz+VGuW5weH2ILjL/amj4EZw3JiRjl
         QjGB1vKjlbEJb1QvYjuKP2chSdomPyNlvf6hvC/gbDVf5KCkM/hIfw89luStFdnoDr5B
         VcJ9A6uxyGUuFdBRIffDVjKC4m2QFuxPWyTQG9Uoyu85sRZlCp+RwDZWqXdwZlR3Ust+
         /w/TiuStbWZ/uhIA9qn0WB7b4J85TXbw75KkpFDgmjhwTFq5YyvDPDYVUFpou1Z6zecS
         /UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcMhYoGPhT3rzgqBWEorKUmFUsNJdJGFS4nJy6g/4Ek=;
        b=0jTScSAcpeEaSHAW+rt5Q9QSXIVClerwq1aEPFvTPczhA1ER2d+tscW2M8Th/c+pG3
         tEEqMzd0K/XRJO1UEZOpHgBn8FLP/tm9a1RVGAjiPnoTizFujgGY/ddp2L80N9bkRA+d
         F1zjeq1MG/cDCNHxYLbxjRzCYJ8G54KJkFy4hqC9HVdpFbKKmxZ6yGnbs9nWhTfQYynP
         Ru4hg7XEJN5w7R/2xeV8atg/i/0O89EUipC6MgyvoAv2H5ugj/ELdLDCtKtUfBpHRtnW
         0aXiwY5w8TaVGsTvF6XuueMegB4ugtnlQ8Vt/k8Ziok2i9q8mHwKPLXzQubxc/RdWmoS
         81jA==
X-Gm-Message-State: AFqh2kqTTQuraKmS1qymfDuCvbyy5GnT1MbiWuR8XY0AcCT7SolCP4SC
        4zRsvfuFCqDvk3hPT1yshbiCrQQ3Au8=
X-Google-Smtp-Source: AMrXdXuMj3QPE7CUNTPMclfu+T9jfdsPi995qOUnZGfbcZBeR/4NBgqnNmsZz1fQ9QMwsCKljrVEfQ==
X-Received: by 2002:a05:600c:6d3:b0:3cf:e91d:f263 with SMTP id b19-20020a05600c06d300b003cfe91df263mr50176380wmn.4.1673292732169;
        Mon, 09 Jan 2023 11:32:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id az20-20020a05600c601400b003d96bdddd3dsm12926143wmb.15.2023.01.09.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:32:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pExsR-000BJZ-07;
        Mon, 09 Jan 2023 20:32:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
Date:   Mon, 09 Jan 2023 20:22:11 +0100
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
 <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
 <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com>
 <xmqqmt6vqo2w.fsf@gitster.g>
 <bb48b1e2-819f-8bf3-ef4a-b9e4d23080b2@github.com>
 <230109.86mt6r1v6d.gmgdl@evledraar.gmail.com>
 <8bb310ff-5dd1-1470-18ac-68b81d2f488c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <8bb310ff-5dd1-1470-18ac-68b81d2f488c@github.com>
Message-ID: <230109.86a62r1p38.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 09 2023, Derrick Stolee wrote:

> On 1/9/2023 12:15 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Jan 06 2023, Derrick Stolee wrote:
>>> On 1/6/2023 5:45 PM, Junio C Hamano wrote:
>
>>>> We probably should start paying down such technical debts.  We've
>>>> punted on them too many times, saying "yes this is klunky but what
>>>> we have is good enough for adding this feature", I suspect?
>>>
>>> Yes, I'll make note to prioritize this soon.
>>=20
>> I noted in passing in [1] that I had those patches locally, if I'm
>> understanding you correctly and you're planning to work on changes
>> that'll make "istate->repo" always non-NULL.
>>=20
>> I've rebased those on top of your "ds/omit-trailing-hash-in-index". I'm
>> CI-ing those now & hoping to submit them soon (I've had it working for a
>> while, but there was some interaction with your patches). Preview at
>> [2].
>>=20
>> 1. https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.c=
om/
>> 2. https://github.com/avar/git/compare/avar-ds/omit-trailing-hash-in-ind=
ex...avar/do-not-lazy-populate-istate-repo
>
> Thanks for doing this so I don't need to.
>
> Some quick pre-submission feedback: your "treewide" patch [1] is far
> too big and doing too much all at once. It's difficult to know why
> you're doing things when you're doing them, especially the choices
> for the validate_cache_repo() calls.

Yeah, I don't like it either :)

I'm mulling over whether to keep it at all. I.e. the fix to pass the
data is relatively small, but most of that patch is validation paranoia.

It was helpful to write that to validate it for my own sanity, but maybe
it's not worth keeping it.

Ultimately it's just making things BUG(...)  during testing that would
otherwise be a NULL-pointer dereference, so I'm currently leaning
towards (especially with this early feedback) just skipping it.

Now that we have a SANITIZE=3Daddress CI job the error feedback if/when
that would happen is arguably worse than the BUG(...) output.

> In particular, I noticed that you used "the_repository" in some cases
> where a local "struct repository *" would be better (even if it is
> currently pointing to the_repository as in builtin/sparse-checkout.c
> in update_working_directory()). These would be easier to catch in
> smaller diffs.

Yes, definitely. I was careful to use an existing "struct repository *"
in favor of "the_repository", but clearly not careful enough!

I'll fix that, and look carefully over the rest before submission in
case I've missed other similar cases.

> [1] https://github.com/avar/git/commit/7732a41800dfc8f5dbf909560615d6048d=
583ed9
>
> Looking forward to your series.

Thanks, since I sent the above CI passed, so it'll be sooner than later,
but I'll massage it a bit per the above before submission.
