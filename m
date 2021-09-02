Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3BDC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066F9610A4
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbhIBO4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbhIBO4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:56:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC17EC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 07:55:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a25so5052407ejv.6
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XxeZr/AMR8wIIfNCRzYaNl/HziC92bKFYs3hNeE5ghA=;
        b=nRO9dWaetDYCXsatfxiylTneSWW8biqOBAQdFPyf2qDu/XY3pGY2Auctzfr1k6gMRI
         dF4T9u9i4AGevd0EPciaNyoIhBTUYUn5kElllJH5Py9yk/8J+750lsp03p6beF5q91Aj
         LE946kRVO3P0FZ1smv3YRLtnjG98HWeGlY41VPGTPiNPYuS0x1l1VFhWEMjMHw9AulEX
         mNkSOI+90hGK2TgTHHvxECJvnLLTgs4vWiOfyHwqpwJbHK5KFK01uESlakOnqA5k6tpI
         gSJbCnYuqiRYMpf8vSBD8/6Cdy+o8MS1ncSMtjJcfwuyv8mlYMySoEa069L6T/oCohkp
         eniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XxeZr/AMR8wIIfNCRzYaNl/HziC92bKFYs3hNeE5ghA=;
        b=HplS9HyeGnKQAVi9szYn/tr/39YosGxY3ayzwdehoJcAzuRpuuEvUhwE2fWD1mqb7R
         dVWVezpEoS0NhwgkNnlgAT/kFTlZn37byaCKMzhjlllDINeFI30EXoHRFvpH2i2xRTy6
         yzyIkVMrEZpspttMwZbgmzZyDjQPGb4wccKhUzSoN9lWFkKbrz8/oiqlt2+PkP7L03SZ
         vhyZQZ6cTkgiHqejqnbanjsGsxhBJSiQRZdNGkB608Q4qQnlQcWnjSUaUDIhiv3UhLnm
         CIq51kY1ZM9HpCuQFUD9V59gHMFRna0t5alMCvfYyVQ8hEcNbXKCqnAQyEM6a1hdoB+e
         kPoA==
X-Gm-Message-State: AOAM533V7MJMTEun8DsEFP8gf3fFCWTL1wo3rWXzOZ5aKR/doUVB0Z4a
        DQZxlbRHmvQXLn5LLTFS6+oUBqMnyBLzcA==
X-Google-Smtp-Source: ABdhPJx8M6OqcN0kr2oBR+xqGvkZtuaA1GKb+28hG3jpyOoxjyoESr7Htb7NE2s1YGB36fc3+WQ2Tw==
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr4185988ejc.299.1630594550348;
        Thu, 02 Sep 2021 07:55:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p23sm1481919edw.94.2021.09.02.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:55:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
Date:   Thu, 02 Sep 2021 16:51:28 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <87r1e8v26x.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109021609220.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109021609220.55@tvgsbejvaqbjf.bet>
Message-ID: <87h7f39gcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (whic=
h was
>> > included in v2.22.0), we officially deprecated the --preserve-merges
>> > backend. Over two years later, it is time to drop that backend, and he=
re is
>> > a patch series that does just that.
>> >
>> > Changes since v1:
>> >
>> >  * Rebased onto v2.33.0
>>
>> I'm very much in favor if this series.
>>
>> I independently came up with pretty much the same at the beginning of
>> last month before finding your v1 in the list archive. The comments I
>> left inline are based on the diff between our two versions, i.e. I found
>> some spots you missed (and your version has spots I missed).
>>
>> You're also leaving behind a comment in builtin/rebase.c referring to
>> PRESERVE_MERGES. Perhaps we should just turn that into an "else if"
>> while we're at it (the "ignore-space-change" argument won't need
>> wrapping anymore then):
>>
>> builtin/rebase.c-       } else {
>> builtin/rebase.c:               /* REBASE_MERGE and PRESERVE_MERGES */
>> builtin/rebase.c-               if (ignore_whitespace) {
>> builtin/rebase.c-                       string_list_append(&strategy_opt=
ions,
>> builtin/rebase.c-                                          "ignore-space=
-change");
>> builtin/rebase.c-               }
>> builtin/rebase.c-       }
>
> While it would be technically correct to turn this into an `else if`, by
> all other standards it would be incorrect. As I commented on your earlier
> comment: just because it uses less lines does not make the intention
> clearer. In this instance, I am actually quite certain that it dilutes the
> intention. The `if (options.type =3D=3D REBASE_APPLY)` clearly indicates a
> top-level decision on the rebase backend, and an `else if
> (ignore_whitespace)` would disrupt that idea to be about distinguishing
> between completely unrelated concerns.
>
> In other words: while I accept that your taste would prefer the suggested
> change, my taste prefers the opposite, and since I am the owner of this
> patch series contribution, I go with my taste.

Sounds good.

>> I do find the left-behind "enum rebase_type" rather unpleasant, i.e. we
>> have a REBASE_UNSPECIFIED during the initial parse_options() phase, and
>> after that just REBASE_{APPLY,MERGE}, but some of those codepaths use
>> switch(), some just check on or the other, and it's not immediately
>> obvious where we are in the control flow. Ideally we'd take care of
>> parsing out the option(s) early, and could just have an "int
>> rebase_apply" in the struct to clearly indicate the rarer cases where we
>> take the REBASE_APPLY path.
>
> Thank you for offering your opinion.
>
> This encourages me to offer my (differing) opinion to keep the `enum
> rebase_type` to clarify that we have multiple rebase backends, and even
> leave Git's source code open to future contributions of other rebase
> backends.

Just to clarify this isn't a comment describing the suggested is_merge()
changes I had elsewhere, or that we should get rid of "enum
rebase_type".

But rather that if we were to split up the "we haven't decided on the
type yet" from "we know the rebase type, let's act on it" which only
happens around the option/config/directory introspection etc. from the
rest of the code, we could stick on the "real" rebase types in the enum.

We could then have just two enum arms for switches (less verbosity) and
no "default: BUG(...)" case.

Such a change should make it easier for contributors to add new
backends, as they'd get the compiler helping them to see where they'd
need to add their code. Now you need to hunt around for various
is_merge, "opts.type =3D=3D " etc, switches with "default" etc. comparisons.

Of course such a change might not be worth it, i.e. maybe it's too
painful to untangle REBASE_UNSPECIFIED from the existing enum. I just
wanted to clarify what it was that I was suggesting here.
