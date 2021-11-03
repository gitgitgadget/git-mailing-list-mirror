Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080CC43217
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B9D6109F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 15:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhKCPTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhKCPSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 11:18:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474CDC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 08:16:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w1so10622701edd.10
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RApc61XtzoZDqTuOT2lypu1lNqQF6r5yWovLrGxIDeo=;
        b=EFACCFpec2Fg5qEPr07V3tlDZbFDswNaGU6wVL7PM/aZQmhXo9dHqZxxhwIvvIHF6a
         XmffFmMeiaCbvOfElZ+d6rDcYvB45+mOqq/NE+zTR2c4toevgVLCNrsrm+tw6uL9iaYT
         KTKDrEqirCkgW8e38kQsCrhTetGibJGVGYYS92YXoKl99Qld7RHxle5P6y0ElUdbZg7Q
         Ca/5DsTg0fg8rvdAxFSeQJfdCogBfrMsdhOQnWhDYwgcnt21wKIYhseft4gs1WRJaLzA
         NIvjKwFZ3W2Fh/oJBdWcBgnTc9bKy79KzTN/V6stksvbR0JgDMFMN0vxvdExu0o90nXs
         oAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RApc61XtzoZDqTuOT2lypu1lNqQF6r5yWovLrGxIDeo=;
        b=FeIqt6wcrX32tqj+3+ucJgLATzj+BNx8VSP9kqnuxGldYRaymXIRhVIqqAUX2NFBGN
         9+FgVtnG0i8y9exYCsfO7BsAuiF6qHGwNoh3UxiiUNK2nPcHcWBtcgbUBhIzSCqm/GfX
         Lzu/+FheaQiN+6gnsuiwVysAL83QKc0dOlgQl+6DdGae4muA/aFKvAceC8BqTQc7v+lH
         nmbJn1UeRIaVlFJXdEnWcAM7T5EquLq4QohBojYiznMopxr1LcuplkOkyZg+O/h0wjcx
         i57LnUpVMvBvPoU5hot28bcAKUvyeRgpQ9IMgtPcTmPmv7FP2bVmBD7Y5JDtfgUAfoO7
         Gi5Q==
X-Gm-Message-State: AOAM533GHlipa3KBfuTGJYARZ2YcBnVJX3QVef3z3VmxFkNuLScIcaFH
        zugiXZsJmzAGKQ/CIKFqIo5lEq2t/yY88g==
X-Google-Smtp-Source: ABdhPJxw7UOTMS94Jy7mdrmwcaLcJrhZC9TH5Whrrr6d9m9mRvyn6HLsJ6+pbz6WzPCCFYO7jtDnMQ==
X-Received: by 2002:a50:be8f:: with SMTP id b15mr61727231edk.200.1635952559702;
        Wed, 03 Nov 2021 08:15:59 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q2sm1310130eje.118.2021.11.03.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:15:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miHza-0001M3-Pm;
        Wed, 03 Nov 2021 16:15:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a GIT_TEST_TERMINAL_PROMPT=true
Date:   Wed, 03 Nov 2021 16:12:43 +0100
References: <20190524062724.GC25694@sigill.intra.peff.net>
 <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com>
 <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com>
 <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net>
Message-ID: <211103.864k8tjmmp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 03 2021, Jeff King wrote:

> On Tue, Nov 02, 2021 at 05:48:10PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> In 97387c8bdd9 (am: read interactive input from stdin, 2019-05-20) we
>> we fixed a behavior change in the conversion of git-am from a
>> shellscript to a C program by changing it from using git_prompt() to
>> using fgets(..., stdin). This ensured that we could run:
>>=20
>>     echo y | git am --interactive [...]
>>=20
>> But along with that in the subsequent 6e7baf246a2 (am: drop tty
>> requirement for --interactive, 2019-05-20) we had to remove support
>> for:
>>=20
>>     git am --interactive </dev/null
>>=20
>> This change builds on the refactoring of git_prompt() into "normal
>> prompt" and "wants password" functions in the preceding commit, and
>> moves "git am --interactive" back to using the prompt function.
>
> Why do we want to do that? The only reason I mentioned that "/dev/null"
> thing in the earlier commit is that it's pointless.
>
> IMHO nothing should be using git_prompt() outside of the credential
> code. They should just be reading from stdin, which is much more
> flexible. If a caller knows that stdin is coming from elsewhere, they
> can redirect from /dev/tty.
>
>> It seems to me that using /dev/tty is desirable over using stdin,
>> these prompts are meant to be interactive, and our acceptance of stdin
>> was an artifact of how these commands were originally implemented in
>> shellscript.
>
> Basically, I think I just disagree with this paragraph entirely. Moving
> to stdin in the commits you referenced was done to help testing, but I
> also think it's just a more flexible direction overall.

I'm fine with it either way, my reading of your 2019-ish commits was
that you did that not to intentionally get that behavior, but to work
around that test issue.

So we do always want the "read from stdin" behavior, so I can get those
bisect tests by just changing its behavior too, with no need for the
test variable? If so I'm fine with that.

I think it's a good thing in general to have a not-for-password
git_prompt() API, because it makes it easy to make that use some
readline-like API, i.e. one that would have tab completion, and handle
the loop some (but not all) callers have around handling retries etc,
we'd also be able to translate the "Y" "n" characters...
