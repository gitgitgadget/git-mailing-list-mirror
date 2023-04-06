Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308EAC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 10:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjDFKzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDFKzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 06:55:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F365AD
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 03:55:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-93071f06bd1so117711166b.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680778515;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqprmdP7W2P4v4wxnCT7fz3VpTrjQp9mNng+wUHtF+M=;
        b=RR8srPUWdW9nxI3IOzpatT/8QZTTLsdqBiyVpVrW8P5q78C9Fq/01AgVI20bJbhoxg
         5C2HP6a85grAuT9DPjGQtQXTrRgVkVTgGZwFJgIxcGodt8/E2Cntg0t8pWi+QwF2jbqA
         WYdmCw2LpVA6BJcyv7X11q/Ni3AbbEljE52GmGPYeazPwhzHRC4fA3FI/CpOkTNhxyT1
         j+YbGHt78MSm+RF3TWTEj3UmQXr21P9UoUWt8Rm8bdmATd8n58wEpgJncj5/SUNAb79O
         eE9UNNh1U1vtHv2rJWzX91JEUjgW1qyyRXufPa+Uazz3gYiFXD9Xkm1xo8zE4ko9jvAK
         YKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778515;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqprmdP7W2P4v4wxnCT7fz3VpTrjQp9mNng+wUHtF+M=;
        b=ojgUmoKC9Mju553CNhGcqhn1jBw5Iyb4R4qNr2hY8FcCJVFmDo5BIkFCqk+/Z3a6ij
         ahle1dhwy0IBFdIP8w3+gVQPTwQXIRAHYs/1FJOmFPLuYgv/fceUZ2E1jukxC8+5JJ2Y
         HEp8OxtNGogZ2qq0t/IQ81z0VfrXedaxr3RdEzFNiPZExySE19GGLYR/ca7BdeH93ek2
         qH/5khqBSJ+VJax3kWDd5OxxiLWQzkIWYR8xznNnxS6X5Fq6NpDEvdCv78cLkJ83yH9/
         B0I4WtKhLuWWNlMOD3nOvgOGlfZpj+y7Q8A+MPMtUa/e/CRRLF/Pl0DWsq7Js2hB6OHS
         Gohg==
X-Gm-Message-State: AAQBX9egRsrM+KZXyUEUzRrK7IYjsWE7YU10tkPVSm+4nG5b+popJMud
        0At9Pjp6kl6JcS7uRwWPyEFrsuBpfHQ=
X-Google-Smtp-Source: AKy350a/C9OCfuCZG6ke6TAJyWrp514HNuKF3CWTzDNpAknARBJrRNRCeHj+v+lQ/oNI+WhiGvW0rw==
X-Received: by 2002:aa7:d851:0:b0:4fb:999:e052 with SMTP id f17-20020aa7d851000000b004fb0999e052mr4535705eds.33.1680778514759;
        Thu, 06 Apr 2023 03:55:14 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t19-20020a50d713000000b005021d17d896sm596549edi.21.2023.04.06.03.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:55:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkNGs-005TWM-0I;
        Thu, 06 Apr 2023 12:55:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
Date:   Thu, 06 Apr 2023 12:45:02 +0200
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de> <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de> <ZC2Qhi73YKSOJrM2@ugly>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <ZC2Qhi73YKSOJrM2@ugly>
Message-ID: <230406.86zg7ls2jx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 05 2023, Oswald Buddenhagen wrote:

> On Wed, Apr 05, 2023 at 02:07:29PM +0200, Johannes Schindelin wrote:
>> This question brings me back to the initial question: What problem
>> do we try to solve here? (This is a question that try as I might, I
>> cannot see answered in the proposed commit message.)
>>
> and i, try as i might, don't understand what you're not understanding
> ...
>
>>[...] In other words, I need a nested rebase.
>>
> that's just *your* private terminology. i don't apply the term
> "nested" here, because for me that implies the possibility to
> "unnest", which my patch doesn't implement. instead, it just continues
> past the point where the rewind was initiated. it's the difference
> between a loop and recursion.
> but outside this difference in terminology, for all i can tell, my
> patch implements *exactly* what you're asking for, and i don't
> understand why that's not obvious to you, given how well you
> understand the problem space yourself.
> please describe what you want with _a few_ words and without
> introducing any new terminology first, i.e., something you'd actually
> want to see in the feature's summary documentation. that should
> illuminate what keywords you find critical.
>
> i just gave rewinding rebasing merges a shot, and it didn't work for
> the simple reason that --rebase-merges is not saved in the state
> (understandably, because that was unnecessary so far) and the
> combination of --rewind --rebase-merges is being rejected. i'll need
> to fix that.
>
> then there is the problem that --rebase-merges only redoes merges
> rather than replaying them. but it seems that the simple case with
> unmodified parents actually does get replayed (or rather, skipped
> over, just incredibly slowly), so rewinding to just the last merge
> would work fine.  other than that, i'm declaring the matter out of
> scope and deferring to your "replaying evil merges" sub-thread.

Not Johannes, but I'd also like to have "nested", but maybe your feature
would also provide that. I haven't had time to test it, sorry.

But isn't the difference noted in this aspect of your commit message:
"where one can return to the pre-rewind state even after committing the
todo edit".

My most common use-case for "nested" is certainly less complex that
Johannes's, and is the following:

 * I've got e.g. a 10 patch series

 * I start rebasing that on "master", solve conflicts with "1..4", and
   am now on a conflict on 5/10.

 * It now becomes obvious to me that the even larger conflict I'm about
   to have on 6/10 would be better handled if I went back to 2/10 or
   whatever, did a change I could do here in 5/10 differently, and then
   proceeded.

I.e. when I'm at 5/10 I'd conceptually like to do another "git rebase -i
HEAD~5" or whatever, use the *already rewritten* commits (otherwise I'd
just abort and restast), re-arrange/rewrite them, and when I'm done
return to 5/10.

Then do another "continue".

From a UX perspective I think just as our $PS1 integration can be made
to show "5/10" it would be ideal if in this case we could show
e.g. "5/10 -> 1/5" or whatever. I.e. I'm in a nested rebase of 1/5,
which started from that 5/10".

Right now I do this sort of thing manually, i.e. note the SHA-1's I've
got so far, --abort at 5/10, then start a rebase for all 10 again, but
manually replace the SHA-1's for 1-5 with the ones I had already.

Which, I suppose I could also do the other way around, i.e. at 5/10 I'd
--edit-todo, wipe away 6/10, "finish" my rebase, then use "git rebase
--onto" later when I'm done to transplant the remaining 6-10/10 on the
1-5/5 I'm now happy with.

But here's the important bit: Sometimes I'm just wrong about my re-edit
to 2/10 being the right thing, and it would actually just make things
worse, as I might discover in my "nested" rebase once I'm at 4/5 or
whatever.

So being able to do an "--abort" ot that point to go back to the
"un-nested" 5/10 (*not* "original" 5/10) and proceed from there would be
nice.

But I think what you've implemented doesn't do that at all, or am I
misunderstanding you?

I think a relatively simple hack to "restart" might still be very nice,
just clarifying.

