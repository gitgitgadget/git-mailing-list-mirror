Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CF6C77B7C
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 01:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjDRB53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 21:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDRB51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 21:57:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136704219
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 18:56:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8c51ba511so9906701fa.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 18:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681783015; x=1684375015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOMqsxFVqKUZ8Vnr2Ye8yn55hA6CokPPmX+2jpIfx4A=;
        b=QlcWsgrfr0djhG4m5N1mnXAJo2gSBR2HyzKpRSKSHi/VOLafhJsT/X5Rp5f4IMu3sz
         YI35vN9VbmW3vCOpofnRxlqWpoJDsjVqHrwpwRwB9HlU71dc8Zl2RTe749T3HuaHdvdQ
         RihqaJghcF1X3Q/0l6ZfY+Jvzsr7smAXmKWP36Nd1Hh0IQYShlRMM/LKH9kt64FthBbS
         li3RHWEkktlfNJylt7EUd3A6EdXZCXzh8JHlEn7f3SJ669ylAWJQ/Qfbqym4hxjujXT4
         JiwjcVBHVnTmopDX1vOoAi4I4/zrZNr2adhFbU22Iqd5De5365AnU4ViiTisjTQgh7wM
         LDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681783015; x=1684375015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOMqsxFVqKUZ8Vnr2Ye8yn55hA6CokPPmX+2jpIfx4A=;
        b=DnLqOIM8X3BOElapJUEGn1Sz81NWPvPNYTroJtQoZyRm57tEukdkqFCKcnHGWCz6s3
         6/80BXQAX9gePvQY1kOlCUmqjQkkfwXnuUb51G2Bi22sLDxwpPTtq1PQlVJ/+FJxnhy4
         v3yezGeS+AUgMtckPkIknJxl8ovTjDvNNUwGKL/ZCbUFRNHBR7PWvmzjGRdOXc3lLzXd
         oELUf1q4xgK+6YhICJ8f5GbRHxZKdv0KKLQzTtdu/SvPYl+p0ZNXPbljjLAUBtrBQLiE
         knR8E53TuZDHlFoAp8HgdTX1Ma1+9zoy8K84xG8Ceo/bGYY8lSd4Og5yKgww4CjGBDXo
         zAOA==
X-Gm-Message-State: AAQBX9cK/X99YAEXBcGFgFVAczT+SET6yzR0/LPivyem4jDvNnmRJVmN
        +ERYp2Tdc6+b0OcpiL48ZxkQxMZlPZn0w4O5ARI=
X-Google-Smtp-Source: AKy350aS+4h3MQaJiXhBRkKvUMBUvRxr2E4KHIF12S4GvjSG+6yvDPy4VIzhKplnbMGCNfwInlZjC5U86pziUuJkGrY=
X-Received: by 2002:a19:f50b:0:b0:4e9:22ff:948d with SMTP id
 j11-20020a19f50b000000b004e922ff948dmr2750979lfb.7.1681783014994; Mon, 17 Apr
 2023 18:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com> <20230417073827.GA39931@coredump.intra.peff.net>
In-Reply-To: <20230417073827.GA39931@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 18:56:42 -0700
Message-ID: <CABPp-BHW8Xi+=+GG4Z+-cf1a365eO6AzBifRjB+3600G5yyY9A@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 12:38=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Sat, Apr 15, 2023 at 10:47:35PM -0700, Elijah Newren wrote:
>
> > On Sat, Apr 15, 2023 at 4:06=E2=80=AFAM Michael J Gruber <git@grubix.eu=
> wrote:
> > >
> > > 5579f44d2f ("treewide: remove unnecessary cache.h inclusion", 2023-04=
-11)
> > > broke connections via git protocol because it removed the inclusion o=
f
> > > the default port macro. While some may consider this transport to be
> > > deprecated, it still serves some purpose.
> >
> > In particular the problem is that
> >
> >       const char *port =3D STR(DEFAULT_GIT_PORT);
> >
> > translates now to
> >
> >       const char *port =3D "DEFAULT_GIT_PORT";
> >
> > instead of
> >
> >       const char *port =3D "9418";
> >
> > Since both compile and nothing in the testsuite tests this, I just
> > missed this problem when making the other changes.
>
> Your fix looks obviously correct, but the much more interesting thing to
> me is how surprising it is that neither the compiler nor tests caught
> it.  The tests don't catch it because we never use the default port for
> our daemon tests, since we don't want two scripts running in parallel to
> conflict. And your example above shows what the compiler sees, but root
> issue is this funky string-ification macro:
>
>   #define STR_(s) # s
>   #define STR(s) STR_(s)
>
> The preprocessor doesn't know that we'll be confused if "s" isn't
> resolved, and by the time the compiler sees it, it's a string already.
>
> Obviously we could add a test that catches this at run-time, but we
> should be able to do better (catch it earlier, and with less code).
>
> My first thought was: why can't we just treat the port as an "int" in
> the first place? The answer is mostly that getaddrinfo() expects it as a
> string. It could even be a non-numeric service like "http" in theory
> (and looked up in /etc/services; Debian's even has "git" in it!), but
> our get_host_and_port() refuses to allow that. But even if we didn't
> want to ever support non-numeric service names, it makes the code more
> awkward (we have to format the port into an extra buffer).
>
> This would work:
>
> diff --git a/connect.c b/connect.c
> index fd3179e545..1eba71e34c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -753,7 +753,7 @@ static char *host_end(char **hoststart, int removebra=
ckets)
>  }
>
>  #define STR_(s)        # s
> -#define STR(s) STR_(s)
> +#define STR(s) (STR_(s) + BUILD_ASSERT_OR_ZERO(s))
>
>  static void get_host_and_port(char **host, const char **port)
>  {
>
> The error message is a bit verbose, but it starts with:
>
>   connect.c: In function =E2=80=98git_tcp_connect_sock=E2=80=99:
>   connect.c:801:32: error: =E2=80=98DEFAULT_GIT_PORT=E2=80=99 undeclared =
(first use in this function)
>   801 |         const char *port =3D STR(DEFAULT_GIT_PORT);
>       |                                ^~~~~~~~~~~~~~~~
>
> which seems OK in practice.

Seems pretty good to me.

> Another alternative is to just declare this STR() thing too clever, and
> put:
>
>   #define DEFAULT_GIT_PORT_STR "9418"
>
> next to the int declaration. It's not like its going to change. But the
> BUILD_ASSERT doesn't seem too bad to me.

Yeah, I like the BUILD_ASSERT.
