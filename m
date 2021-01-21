Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F89C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F2A221F0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbhAUDq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393179AbhAUCW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:22:29 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C6C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 18:21:48 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x78so589835ybe.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 18:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z1Ra4WAB9nJf5lGs46CT/M46hCBrDd33x7HGfS0ru8E=;
        b=l3CunXsyEzzueHJoxaK1K24iYo7lgpjKDLNlthxX3LDBuY5P3JIEjqm6vDi+mGRSKC
         sTiifT5TtHqXPy9GBgLHVDCQ//xCXyS6V3Rb/htf1McSuYAJtzVxWAfsYNJNl/t3r4ey
         YtbBeEDHNS94s3RdMG68EctcuKc7sA21T8j2ySk3MBB4FqD65PyuzovvTuGW8q1G0vzP
         8n1EJW4/85HGCUKa9scH1v1Pm1vDu7WeU/MyMR4LcGJbCBHw5/K6f1Ktb2r2mCQIA4Qf
         7ogYidjlHB6gUTzlX5JLgpDRg/lVY85zJRRrVET9h6c0PJ+ZvNf/ctGxvCfg9vHyxmFf
         UOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z1Ra4WAB9nJf5lGs46CT/M46hCBrDd33x7HGfS0ru8E=;
        b=ltWxI0zS6WzT84nWWIyxdAm3+vMBvK9UC32emGDtP4EOftR448yKKTBwJwmkAlx1ep
         c3f7Ij8gDMtZpOvq44grpoS3StNAVFdyHJpC5tiykSgBNGxPB9hPs0WZ24IZTpGy1k0p
         vQ23NNSkBFxT44NiyQdTwAXVaHWV8g0NwyUOwjaAKl+67JEDjZrRgMkvf1U0NOl553Ck
         YA6UIjIhmp8c4qjjlhTkIgv81mbgx075eW5dEAi8j9pRSMuYxBM6OzrIK8x7dV9fZqiY
         VoCJbgmUow+Y06ZFZjgDKz/OSc/VrXfABC2GfO+J3Zj3hPSWCAX9eYnA0qmslAuGIvSs
         QAgQ==
X-Gm-Message-State: AOAM530PxnWR+8YpugP4ccgRWYPrvlOuy4pvkMpqCDPTb/o9X0vFdlzr
        PVh3ZmMHn+h+h6uQic+iIDA6x7blGn4MyxN4j64=
X-Google-Smtp-Source: ABdhPJylBwcDNc6LbSudTJ8N8ijcpkY+CXL7rahIGT91jrKq7iFRPEr05EzXxXZkawYCLWk24wliMC8EiWFEILMqDuI=
X-Received: by 2002:a25:3ac3:: with SMTP id h186mr16434339yba.155.1611195708058;
 Wed, 20 Jan 2021 18:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20200824174202.11710-1-worldhello.net@gmail.com>
 <20200827154551.5966-4-worldhello.net@gmail.com> <20210117222151.GY8396@szeder.dev>
 <CANYiYbE358amO95JStnspS-N-9WMYENiYspdKtsGsUc7Hv5jWw@mail.gmail.com> <20210120122858.GZ8396@szeder.dev>
In-Reply-To: <20210120122858.GZ8396@szeder.dev>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 21 Jan 2021 10:21:36 +0800
Message-ID: <CANYiYbEKi=DD5-7Ss4KMF4zXNxGr2cABed--T-uwAzSf2KA-nw@mail.gmail.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:29=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Mon, Jan 18, 2021 at 04:24:11PM +0800, Jiang Xin wrote:
> > SZEDER G=C3=A1bor <szeder.dev@gmail.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=
=8818=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=886:21=E5=86=99=E9=81=93=
=EF=BC=9A
> > >
> > >
> > > This patch added a whole lot of test cases, and two of them '86 -
> > > proc-receive: not support push options (builtin protocol)' and '95 -
> > > proc-receive: not support push options (builtin protocol/porcelain)'
> > > are prone to rare failures.
> > >
> > > On Thu, Aug 27, 2020 at 11:45:44AM -0400, Jiang Xin wrote:
> > > > diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-=
push-options.sh
> > > > new file mode 100644
> > > > index 0000000000..d0c4da8b23
> > > > --- /dev/null
> > > > +++ b/t/t5411/test-0026-push-options.sh
> > >
> > > > +# Refs of upstream : master(A)
> > > > +# Refs of workbench: master(A)  tags/v123
> > > > +# git push -o ...  :                       refs/for/master/topic
> > > > +test_expect_success "proc-receive: not support push options ($PROT=
OCOL)" '
> > > > +     test_must_fail git -C workbench push \
> > > > +             -o issue=3D123 \
> > > > +             -o reviewer=3Duser1 \
> > > > +             origin \
> > > > +             HEAD:refs/for/master/topic \
> > > > +             >out 2>&1 &&
> > >
> > > Three relevant things are happening here:
> > >
> > >   - 'git push' is executed with its standard output and error
> > >     redirected to the file 'out'.
> > >
> > >   - 'git push' executes 'git receive-pack' internally, which inherits
> > >     the open file descriptors, so its output and error goes into that
> > >     same 'out' file.
> > >
> > >   - 'git push' is expected to fail when it finds out that the other
> > >     side doesn't support push options, but it does so with a simple
> > >     die() right away, without waiting for its child 'git receive-pack=
'
> > >     process to finish.
> > >
> > > > +     make_user_friendly_and_stable_output <out >actual &&
> > > > +     test_i18ngrep "fatal: the receiving end does not support push=
 options" \
> > > > +             actual &&
> > > > +     git -C "$upstream" show-ref >out &&
> > >
> > > Here the shell opens and truncates the file 'out' to write 'git
> > > show-ref's output, i.e. it is still the same 'out' file that was used
> > > earlier.
> > >
> > > Consequently, it is possible that 'git receive-pack' is still running=
,
> > > its open file descriptors to 'out' are still valid, and its "fatal:
> > > the remote end hung up unexpectedly" error message about the suddenly
> > > disappeared 'git push' can partially overwrite the output from 'git
> > > show-ref'.
>
>
> > > I think these are the only two tests that can cause this racy
> > > behavior: by instrumenting finish_command() I found that in all other
> > > tests where 'git push' is expected to fail it errors out gracefully
> > > and waits for its 'git receive-pack' child process.
> >
> > Atomic push may have the same problem.
>
> I don't think so, because send_pack() doesn't die() when a ref is
> rejected in an atomic push, but returns, and lets its caller terminate
> in an usual way, including waiting for 'git receive-pack'.

I find many places where the client side will die() before closing the
service side gracefully:

 + In `transport_push()`, if fail to push a submodule, will die().
 + In `git_transport_push()`, will die() for an unimplemented v2 protocol.
 + In `send_pack()`, will die() if
    the server side has an incompatible hash algorithm, or
    the receiving end does not support --signed push, or
    the receiving end does not support --atomic push, or
    the receiving end does not support push options
