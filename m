Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CAAC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 04:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjERERH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 00:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjERERF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 00:17:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D182D64
        for <git@vger.kernel.org>; Wed, 17 May 2023 21:17:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13c577e36so1908998e87.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 21:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684383422; x=1686975422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPqAp4/nlrJDTRR2eymo16R0Qsck/HxeLP4FT+nFfcY=;
        b=r6eXP/qfNj7G201VZYWXtYPMRuepXuNYmy/act+jINTntPzXQQ4SMLc2M24ugaF7p7
         f2sX+Lxl9GiE0n7h+m1OvhN4k/SAvZsbU+ja0s091no9S5Lqs3fMKGV0CokTx7GgzUmC
         H8AmVnYzm8FIt4cKaC76LB/uHbQWMt5+n4rAorKszx6CUAXlngrrZs/ry1BjV8oh3PYY
         GeQejF7tKqSsDWfnpe5EiLveimik8VjaqGqVSfLGQoNA92EwN0yMhLhZpGWpGQwGoI8w
         jfkI2kmPKGGF2/GxZPixXUl6B99zOjwufl7aDT45fCmzrsel0zUxUHm7GA7D3+5UmnzJ
         dkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383422; x=1686975422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPqAp4/nlrJDTRR2eymo16R0Qsck/HxeLP4FT+nFfcY=;
        b=SOCNqBU+0OSS5lzt+iNkNBODyeVbU4rK2h2GCosxwOpTB+VupCaxtKHVQAP9YimkLd
         xry5qAcTa6NEJmltgllmjsfyzqYwQlQqQoMDdJjqTdWoUvokTi7QB4ugOoO6VptLOJz6
         XDu3nA8NAVh7tLhike/Tz7Ye+RcUwKiRI1kcrcwsp70SQYKVAj/gOyDjcCUkS35dIJ6r
         y6Vm9f31pAEvsa6+SyEhzlkDSXHn24X/lhAVyjpxdQwjmf9O4jIk6aGWFvOKR9EEN7a5
         awUrFWeeagWDmcWC2+rkqDwzsWL2hWI9GX8ke+NjjYKDAhqzYM7UGcqsCVmk/ULwJe3R
         ss5w==
X-Gm-Message-State: AC+VfDxWwR3mRZapO7vIE1qMdbXfZbgpn4K3f6fyBfPzt/skyEmV81rt
        JGflnYszSHWXNEOZwkfrs3Z6IiuRrExOoBWdZeY=
X-Google-Smtp-Source: ACHHUZ4FqnbZQoTKTbPLKWO2HZIhO+w8C07ULuM4AXvW4uwOb6NSo2gZMKsOC/RtAWkG5kBTqdH1yFxLJ0A6+RfHUgI=
X-Received: by 2002:a19:ae19:0:b0:4ee:5aeb:e2f2 with SMTP id
 f25-20020a19ae19000000b004ee5aebe2f2mr747085lfc.38.1684383421800; Wed, 17 May
 2023 21:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZGO4LesPe4A2ftdm@nand.local> <db403de74da839084165f11dab05d71484457c6f.1684259780.git.me@ttaylorr.com>
 <xmqqh6sct7jx.fsf@gitster.g> <ZGP2tw0USsj9oecZ@nand.local>
In-Reply-To: <ZGP2tw0USsj9oecZ@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 May 2023 21:16:48 -0700
Message-ID: <CABPp-BFvCQKspFhq-NKnjjAx4V3jFpcV60N-WRD2HZHy4BQtHg@mail.gmail.com>
Subject: Re: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <randall.becker@nexbridge.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2023 at 2:33=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, May 16, 2023 at 12:12:02PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > When building git with `NO_PTHREADS=3DYesPlease`, we fail to build
> > > run-command.o since we don't have a definition for ALLOC_GROW:
> > >
> > >     $ make NO_PTHREADS=3D1 DEVELOPER=3D1 run-command.o
> > >     GIT_VERSION =3D 2.41.0.rc0.1.g787eb3beae.dirty
> > >         CC run-command.o
> > >     run-command.c: In function =E2=80=98git_atexit=E2=80=99:
> > >     run-command.c:1103:9: error: implicit declaration of function =E2=
=80=98ALLOC_GROW=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> > >      1103 |         ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_=
hdlrs.nr + 1, git_atexit_hdlrs.alloc);
> > >           |         ^~~~~~~~~~
> > >     cc1: all warnings being treated as errors
> > >     make: *** [Makefile:2715: run-command.o] Error 1
> >
> > I am OK to give a reproduction recipe, i.e. the "$ make" command
> > line, to make it easy for people, who cannot remember how to define
> > make variables from the command line, to try out themselves, but I
> > hate the "build transcript" in the log message, when a few lines of
> > prose suffices.
>
> Much appreciated. Here's a version with your changes include that is
> suitable for queueing:
>
> --- 8< ---
>
> Subject: [PATCH] run-command.c: fix missing include under `NO_PTHREADS`
>
> Git 2.41-rc0 fails to compile run-command.c with `NO_PTHREADS` defined,
> i.e.
>
>   $ make NO_PTHREADS=3D1 run-command.o
>
> as `ALLOC_GROW()` macro is used in the `atexit()` emulation but the
> macro definition is not available.
>
> This bisects to 36bf195890 (alloc.h: move ALLOC_GROW() functions from
> cache.h, 2023-02-24), which replaced includes of <cache.h> with
> <alloc.h>, which is the new home of `ALLOC_GROW()` (and
> `ALLOC_GROW_BY()`).
>
> We can see that run-command.c is the only one that try to use these
> macros without including <alloc.h>.
>
>   $ git grep -l -e '[^_]ALLOC_GROW(' -e 'ALLOC_GROW_BY(' \*.c | sort >/tm=
p/1
>   $ git grep -l 'alloc\.h' \*.c | sort >/tmp/2
>   $ comm -23 /tmp/[12]
>   compat/simple-ipc/ipc-unix-socket.c
>   run-command.c
>
> The "compat/" file only talks about the macro in the comment,
> and is not broken.
>
> We could fix this by conditionally including "alloc.h" when
> `NO_PTHREADS` is defined.  But we have relatively few examples of
> conditional includes throughout the tree[^1].
>
> Instead, include "alloc.h" unconditionally in run-command.c to allow it
> to successfully compile even when NO_PTHREADS is defined.
>
> [^1]: With `git grep -E -A1 '#if(n)?def' -- **/*.c | grep '#include' -B1`=
.
>
> Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  run-command.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/run-command.c b/run-command.c
> index d4247d5fcc..60c9419866 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -16,6 +16,7 @@
>  #include "packfile.h"
>  #include "hook.h"
>  #include "compat/nonblock.h"
> +#include "alloc.h"
>
>  void child_process_init(struct child_process *child)
>  {
> --
> 2.41.0.rc0.dirty

Thanks everyone for fixing up my issue, and my other issue in the
imap-send/strbuf.h thread.  Sorry for any headaches.
