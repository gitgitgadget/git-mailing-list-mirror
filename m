Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7588EC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhLJKRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhLJKRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:17:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3CC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:13:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so28622099eds.10
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5pyJCcgbVUautit+BMDCJ/OFrHL+WF/d4LYf5e9wlk0=;
        b=W8BdP3B6BnK+O+x6ANmzVWZaWDIPqk5lXNGZg27MD8cXJ0hHekgGNAKinP4ZIFtnoe
         72sTTp0gnoqgCoITjfpDsSYDn8zlEtPe9b5nJiuCNQ+e79dtIzqVFP+C2QwjW/x99ZvA
         Qbc2voLYdNUrPuA72+WCyN2VlemfE60DKnKT/S4wHm5C7uS6T80nxpl+VgHdJrLzKefo
         DjMiEI1+lGrPbW0KWen02nwB0fRq0/zteROwoU5EFPrJbo2XpKfE8kto76G03rs9PbnI
         My1YiUbrGYvcJWREkNtz4TK3KxZ/yWqJRESdkq0DXzs3devDpA3+x+Vc8dA0aG1q72aL
         2m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5pyJCcgbVUautit+BMDCJ/OFrHL+WF/d4LYf5e9wlk0=;
        b=C8SNzcJFllTQnU+TmbUaySiQO6UNDa01cJKaTQ0gjjjVa0nBL61ql+s07L/EagM869
         6FjJ/OYuj5UT6szXFuMJtYA0qJYyGYhVqfpnNmIE0g7xHvs9OfOZj//YX1rYLBE5ZkpS
         9uyztahclGmmZgkPCltmdJaQrZjRzj9ILdOypI6OuAITA80z+7+hWFO9P61K2pPXje2F
         4sYiXwjzBE1J6YnkBkxLYQBvV45oVTqvBr6oVhrEnQDcHsP+FQqbwrMtSRJCmR2To0Do
         MzT1mC/+wqQU1MrGwKZ4rhF64QvzgKR7yAjXJSbWzG8+pEH7ZaOSjwQb4ANLX5WFM9gm
         GMkg==
X-Gm-Message-State: AOAM530YpkOv+bTD7MSvNbr8/YcguClJV7h/u7054kvmqQzyzLpQ3JgT
        5atzleQg1SUp7xDyuWacIis=
X-Google-Smtp-Source: ABdhPJypwKa4CUiDVSYSg8UByZ5Afol3qNOVyU7Mxlqftt73DNPae87jdhXKWHNrocEyb0e6KTRn+Q==
X-Received: by 2002:a05:6402:174c:: with SMTP id v12mr37806927edx.168.1639131238325;
        Fri, 10 Dec 2021 02:13:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s16sm1178552edt.30.2021.12.10.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 02:13:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvcub-000GSV-9D;
        Fri, 10 Dec 2021 11:13:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] t1510: remove need for "test_untraceable",
 retain coverage
Date:   Fri, 10 Dec 2021 11:08:06 +0100
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <patch-v2-1.2-91402624777-20211201T200801Z-avarab@gmail.com>
 <20211202191635.GB1991@szeder.dev>
 <YbMiK1wHzBfYvK2a@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YbMiK1wHzBfYvK2a@coredump.intra.peff.net>
Message-ID: <211210.86pmq4daxm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Jeff King wrote:

> On Thu, Dec 02, 2021 at 08:16:35PM +0100, SZEDER G=C3=A1bor wrote:
>
>> > @@ -62,7 +59,7 @@ test_repo () {
>> >  			export GIT_WORK_TREE
>> >  		fi &&
>> >  		rm -f trace &&
>> > -		GIT_TRACE_SETUP=3D"$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
>> > +		GIT_TRACE_SETUP=3D"$(pwd)/trace" git symbolic-ref HEAD >/dev/null 2=
>>stderr &&
>>=20
>> I suspect that it's lines like this that make Peff argue for
>> BASH_XTRACEFD :)
>>=20
>> While this is not a compound command, it does contain a command
>> substitution, and the trace generated when executing the command in
>> that command substitution goes to the command's stderr, and then,
>> because of the redirection, to the 'stderr' file.
>
> Better still, the behavior varies between shells:
>
>   $ bash -c 'set -x; FOO=3D$(echo foo) echo main >stdout 2>stderr; set +x=
; grep . stdout stderr'
>   ++ echo foo
>   + FOO=3Dfoo
>   + echo main
>   + set +x
>   stdout:main
>
>   $ dash -c 'set -x; FOO=3D$(echo foo) echo main >stdout 2>stderr; set +x=
; grep . stdout stderr'
>   + FOO=3Dfoo echo main
>   + set +x
>   stdout:main
>   stderr:+ echo foo
>
> -Peff

I just re-rolled a v3 with a fix for this and the general issue pointed
out by SZEDER, thanks both.

But as far as keeping test_untraceable goes, isn't this a good argument
for dropping it?

I.e. if bash was the odd shell out that included the $(...) command in
the trace output it would be a good reason to keep it, then we could
perhaps use it without worrying about our trace output being corrupted
when we did a "test_cmp" on "stderr" later.

But it's "dash" that's including it, so unless we're going to outright
forbid it to have -x output (which is inconvienent) we'll need to deal
with t either way (in my re-roll I just replaced $(pwd) with $PWD).
