Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A845BC64EC7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBUSGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 13:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBUSGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 13:06:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694592FCEB
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:06:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s22so6748154lfi.9
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e67VL4YznTMDHdfA+IsnTAP4pR3uCwOt+L2v2RxYUhw=;
        b=MAg+oH1XHVTZiIfIeKub626BGDJbNsJ1EPABe9rRlila8qnqSeQvUR0leLt7J+GPbS
         n5of9JBlo5ckRefBc7MmHa7Jsky7xnV+DA9jvZs3Fs8uZIqEoduXLSpIgWFCl+fEbV80
         BBvkkUrqGi3rYywkXzepAkvprluEgUGWXwhD9/xxdqbovQUOATZWIHFVj9xSHPyZAyAZ
         +aK80AjedGX4XWCq9b9YDS5W/e9N6ViwaTxprtA5wwD5bLy9GwEYQNdZ9MbXeO1vXmL+
         qkEluhzESXs+LUC+BxqIhlstl5vFrtYFyiSWV9NDnjSYGTEuLnPeS+IQYJQ/agdu8aS+
         ynKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e67VL4YznTMDHdfA+IsnTAP4pR3uCwOt+L2v2RxYUhw=;
        b=uHk0nWceXG1P9KG2PpLO2LwppxrEfUySpreTEdzgk3/GijaUXQOzsHmrW+nqUKAx2G
         JcEv1M2eHXi+QCI0ArHOuUW26lOxNFJ7LAkXedj0yVxSRnp6Us1+osTrio7TZNQHqTUN
         r9EVmUL1HOyeCNZllHZTC2ghF3lUxe9dQvvo8Rr2M5KGFUhdDOCLvb8DYKRDt0T8KGpT
         ysRZ+4Ug1Y/Zp9/chEfdyvxE+mRHFv63mj91Qz92nhioXEyrKVVOX9JolPMwG2ZZtXvu
         EnPxxl97OFKihvJzMiJ3fkg3Efd6eGSk7+bgsYO2p3uecxYmuYhBh6mzy+NQNeLJ/IL3
         laew==
X-Gm-Message-State: AO0yUKVWdd/Bxb+7t/9+/Vg6CF6ALAH6gsz97WCARpfQh2y7iVnpTkdH
        /bTwm0HtkhvW40JL2G7ZMDQutoFS8Jw8c7xAWwA=
X-Google-Smtp-Source: AK7set/ttMjsulvcABO0i45G/6KMNgzjr9yrvsDeFi9Bj1NxbqEiG0n21BukIuFiT4Z2NYf1NDqiAkf1XtMVCFjGq5s=
X-Received: by 2002:a19:5207:0:b0:4db:1326:79b2 with SMTP id
 m7-20020a195207000000b004db132679b2mr1987086lfb.2.1677002762619; Tue, 21 Feb
 2023 10:06:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com> <xmqq5ybuhqhc.fsf@gitster.g>
In-Reply-To: <xmqq5ybuhqhc.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Feb 2023 10:05:50 -0800
Message-ID: <CABPp-BEAB6jKXeo=DHiimQUDj=5i7U5MQPXTEsAagLVAuk7FOQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Teach diff to honor diff algorithms set through
 git attributes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 9:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > When a repository contains different kinds of files, it may be desirabl=
e to
> > use different algorithms based on file type. This is currently not feas=
ible
> > through the command line or using git configs. However, we can leverage=
 the
> > fact that gitattributes are path aware.
> > ...
> > To address some of the performance concerns in the previous series, a
> > benchmark shows that now only a minor performance penalty is incurred, =
now
> > that we are no longer adding an additional attributes parsing call:
> >
> > $ echo "*.[ch] diff=3Dother" >> .gitattributes $ hyperfine -r 10 -L a
> > git-bin-wrapper,git '{a} -c diff.other.algorithm=3Dmyers diff v2.0.0 v2=
.28.0'
> > Benchmark 1: git-bin-wrapper -c diff.other.algorithm=3Dmyers diff v2.0.=
0
> > v2.28.0 Time (mean =C2=B1 =CF=83): 716.3 ms =C2=B1 3.8 ms [User: 660.2 =
ms, System: 50.8 ms]
> > Range (min =E2=80=A6 max): 709.8 ms =E2=80=A6 720.6 ms 10 runs
> >
> > Benchmark 2: git -c diff.other.algorithm=3Dmyers diff v2.0.0 v2.28.0 Ti=
me
> > (mean =C2=B1 =CF=83): 704.3 ms =C2=B1 2.9 ms [User: 656.6 ms, System: 4=
4.3 ms] Range (min =E2=80=A6
> > max): 700.1 ms =E2=80=A6 708.6 ms 10 runs
> >
> > Summary 'git -c diff.other.algorithm=3Dmyers diff v2.0.0 v2.28.0' ran 1=
.02 =C2=B1
> > 0.01 times faster than 'git-bin-wrapper -c diff.other.algorithm=3Dmyers=
 diff
> > v2.0.0 v2.28.0'
>
> Hopefully this round can immediately be merged down to 'next'?
> Thanks.

I'll leave that up to you and John, but are we risking merging code
that could go unused or that we need to fundamentally change?  I don't
see how to handle the issues over at
https://lore.kernel.org/git/647D3D49-B85B-4B66-A857-695CFF9685EE@gmail.com/
(not that I've spent much thought on it besides asking how things are
going to work), and would be worried that we'd end up needing to
change the mechanism somehow to cover the things John ultimately
wants.
