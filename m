Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E872C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 08:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330702253A
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 08:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbhARIZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 03:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbhARIZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 03:25:03 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC4C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 00:24:23 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k4so11908939ybp.6
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MfKazEF5EF3iT9ec0jRoLRRIxMNaZh0hBNjYc08n0Z0=;
        b=i5rlZe1+rt4UUcK5walp5JR3qRqZ65SOlBmFDJPnkVIdPPdcb+sw01yi2DLQjSQpLi
         RVpr57CUJaVsTjIL3TQKk318SLn+HGJ0/QeTYjaU1Zgk1Tbd8ZyJDED8is3ZHM5ywHWa
         eIR5rwJlakvobzoE1pR5OChOtcy2QIe0DzFxJoVf5T69zcUhfUgLDGivgvO4QK6Wy4wD
         p0KKsRrnppRTDk7hhl8xt3EY5f4jJdDe1/pqiXq/teGkMitz3CD3qrKvAIDytx5/63qu
         aZRixlA3i5PY5ndpA3fcV67XU40EZ9axjMTrcv5JmHpL0WBkKMjpYq4ozGwTnZQs0z/w
         vThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MfKazEF5EF3iT9ec0jRoLRRIxMNaZh0hBNjYc08n0Z0=;
        b=Mlfr+0y5d9AnK2HtiIBrSN0QMJ2bxG8jKh0H9RLhaXGpdQLn/oDQaEzFEhEJo1WWk6
         /+LelxpXvNEqNiWVaKYRcdCywBzA6xsjwgtt+RFYlOSdxtGMg+/0Y4AgeLcUiIgok5qW
         7lwUWAujq18mow8deOnFfMjbT7WhCN2bPnkzOjBzwOeKubkqN1g5zAMDqEY/TQJwZsBw
         9TEmcVQSCefo9dpEj7IoCeCfuH1KdETedjmalNSmJiiGYAUNIzCceC2IJcj3v8X9HoEI
         rHc9YG/bzzRKvjjvKj/R8+HrWawtsThifP1rMa85O06HSgfzRnaeuP41NPQFb/WnjGiw
         rOpg==
X-Gm-Message-State: AOAM532acJNX44XHEvu+kAliqGLIdsqUVcuK2fOUOjoqeJHb/Cv+v6yT
        hxttUOgu4oJekSg+FSIqSJpDmuyaSud+nkX6cyk=
X-Google-Smtp-Source: ABdhPJxBjLibwu53CGnNbGQ1aFxCHclWxqslMT55TfBFn6RS9ZV+FSyU5Q8+QW6LaXnXDvV3kIlFPqY/ZFvXie7X1Ic=
X-Received: by 2002:a25:cb0b:: with SMTP id b11mr7111458ybg.323.1610958262248;
 Mon, 18 Jan 2021 00:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20200824174202.11710-1-worldhello.net@gmail.com>
 <20200827154551.5966-4-worldhello.net@gmail.com> <20210117222151.GY8396@szeder.dev>
In-Reply-To: <20210117222151.GY8396@szeder.dev>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 18 Jan 2021 16:24:11 +0800
Message-ID: <CANYiYbE358amO95JStnspS-N-9WMYENiYspdKtsGsUc7Hv5jWw@mail.gmail.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=886:21=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> This patch added a whole lot of test cases, and two of them '86 -
> proc-receive: not support push options (builtin protocol)' and '95 -
> proc-receive: not support push options (builtin protocol/porcelain)'
> are prone to rare failures.
>
> On Thu, Aug 27, 2020 at 11:45:44AM -0400, Jiang Xin wrote:
> > diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push=
-options.sh
> > new file mode 100644
> > index 0000000000..d0c4da8b23
> > --- /dev/null
> > +++ b/t/t5411/test-0026-push-options.sh
>
> > +# Refs of upstream : master(A)
> > +# Refs of workbench: master(A)  tags/v123
> > +# git push -o ...  :                       refs/for/master/topic
> > +test_expect_success "proc-receive: not support push options ($PROTOCOL=
)" '
> > +     test_must_fail git -C workbench push \
> > +             -o issue=3D123 \
> > +             -o reviewer=3Duser1 \
> > +             origin \
> > +             HEAD:refs/for/master/topic \
> > +             >out 2>&1 &&
>
> Three relevant things are happening here:
>
>   - 'git push' is executed with its standard output and error
>     redirected to the file 'out'.
>
>   - 'git push' executes 'git receive-pack' internally, which inherits
>     the open file descriptors, so its output and error goes into that
>     same 'out' file.
>
>   - 'git push' is expected to fail when it finds out that the other
>     side doesn't support push options, but it does so with a simple
>     die() right away, without waiting for its child 'git receive-pack'
>     process to finish.
>
> > +     make_user_friendly_and_stable_output <out >actual &&
> > +     test_i18ngrep "fatal: the receiving end does not support push opt=
ions" \
> > +             actual &&
> > +     git -C "$upstream" show-ref >out &&
>
> Here the shell opens and truncates the file 'out' to write 'git
> show-ref's output, i.e. it is still the same 'out' file that was used
> earlier.
>
> Consequently, it is possible that 'git receive-pack' is still running,
> its open file descriptors to 'out' are still valid, and its "fatal:
> the remote end hung up unexpectedly" error message about the suddenly
> disappeared 'git push' can partially overwrite the output from 'git
> show-ref'.

Thank you for providing the accurate analysis of the root cause of this pro=
blem.

> I saw these tests fail in Travis CI's s390x environment a couple of
> times, and, alas, that is the only environment where I was able to
> reproduce the failure with '--stress' with an unmodified Git.
>
> The diff below adds a couple of strategically-placed delays to
> reliably demonstrate these failures:

To solve this problem, instead of adding delays, we can simply remove
the "out" file before creating a new one, thus the two "out" files
have two different file descriptors, and the process in background
won't break the new "out" file.

>
>   ---  >8  ---
>
> diff --git a/pkt-line.c b/pkt-line.c
> index d633005ef7..3b26631948 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -307,6 +307,7 @@ static int get_packet_data(int fd, char **src_buf, si=
ze_t *src_size,
>                 if (options & PACKET_READ_GENTLE_ON_EOF)
>                         return -1;
>
> +               sleep(1);
>                 die(_("the remote end hung up unexpectedly"));
>         }
>
> diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-o=
ptions.sh
> index e88edb16a4..a1e896f404 100644
> --- a/t/t5411/test-0026-push-options.sh
> +++ b/t/t5411/test-0026-push-options.sh
> @@ -21,6 +21,7 @@ test_expect_success "proc-receive: not support push opt=
ions ($PROTOCOL)" '
>         test_i18ngrep "fatal: the receiving end does not support push opt=
ions" \
>                 actual &&
>         git -C "$upstream" show-ref >out &&
> +       sleep 2 &&
>         make_user_friendly_and_stable_output <out >actual &&
>         cat >expect <<-EOF &&
>         <COMMIT-A> refs/heads/main
> diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-=
0027-push-options--porcelain.sh
> index 3a6561b5ea..f97cef440f 100644
> --- a/t/t5411/test-0027-push-options--porcelain.sh
> +++ b/t/t5411/test-0027-push-options--porcelain.sh
> @@ -22,6 +22,7 @@ test_expect_success "proc-receive: not support push opt=
ions ($PROTOCOL/porcelain
>         test_i18ngrep "fatal: the receiving end does not support push opt=
ions" \
>                 actual &&
>         git -C "$upstream" show-ref >out &&
> +       sleep 2 &&
>         make_user_friendly_and_stable_output <out >actual &&
>         cat >expect <<-EOF &&
>         <COMMIT-A> refs/heads/main
>
>   ---  8<  ---
>
> I think these are the only two tests that can cause this racy
> behavior: by instrumenting finish_command() I found that in all other
> tests where 'git push' is expected to fail it errors out gracefully
> and waits for its 'git receive-pack' child process.

Atomic push may have the same problem.
