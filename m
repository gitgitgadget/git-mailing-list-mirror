Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B7EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFTTlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFTTlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:41:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90351E7D
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:41:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-518b69d5b5dso7007160a12.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1687290098; x=1689882098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qria3XsyJLB0JWShaFSWMsgBiWM/MbE9GtVXoGmppFU=;
        b=AY91p8ZSN6LFhhyQdlQZZZ8as3q9EsmdKeRZ0lqN64W418VFairFCzk3D4pV0BBoGM
         1/9p3LOTzxFbEBeMfW58MjZ69l+/MQ1DIN0xS94MozDCAO/iGYGAdMUU2UMYk7Y9hKAE
         ABOMbBV/vpP5XgGTOUgn3umv8B0g3Z+HWQ8lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290098; x=1689882098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qria3XsyJLB0JWShaFSWMsgBiWM/MbE9GtVXoGmppFU=;
        b=YGDZ18Y3aeBAtasvW+G7Fl2lNBCw2NzTkFQyfwQCSF0YYHjqrmlGjWkCM70ksTz2hY
         x/c9lsNuY81MC76N3FpknBcpCYD7P1KVLWTHGLo63wBYoro90Sx2W8Zf4/oH1heQRn+H
         EUM5ldCKe9yi2uH4IuTsrpNNGjT2ZJpCaW57Pxf128Tck6P/bicQhjyY6Iy1D8+siDbg
         OlfZyg0SQPTYZpACKo1RkKC5Ul23HrXfFW2St+kVzNPpg0j+FVgei2ticrZ3n+m4g9dv
         RoAHFEQxaj/6BE4ibvxMGeQAs3+49i4TyIosrpd3LzBv1hWv0ni9D62mxrNTD65WHyvQ
         LQBg==
X-Gm-Message-State: AC+VfDxuWYv/DOA4oFRx2lR7g2YGgVC4MSkgOkEbY2rvqLCboHHSg+Nc
        +zWGA/MiQomuwbWsMrIvrIu12QrB43VQE2hhsE+XFPZ87MFdgvXIHHc=
X-Google-Smtp-Source: ACHHUZ4lekC7Z1OuCgIy3sheZj9kvTHtyYpyrFDjFxJzCODQnCXiChahIiqU1UCqJSWGRmahMxHa70yYaDeJW4bvvzs=
X-Received: by 2002:aa7:cf16:0:b0:51a:40ca:d081 with SMTP id
 a22-20020aa7cf16000000b0051a40cad081mr7655860edy.27.1687290098026; Tue, 20
 Jun 2023 12:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
 <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com> <xmqqo7lam1ei.fsf@gitster.g>
In-Reply-To: <xmqqo7lam1ei.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 20 Jun 2023 21:41:27 +0200
Message-ID: <CAPMMpoj+5XT9LwL==ih-cmdYyz6RN6Ysr=g661keTOTH-QrK-g@mail.gmail.com>
Subject: Re: Determining whether you have a commit locally, in a partial clone?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 8:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > My apologies for the self-reply, I did find a workaround here:
> >
> > git -c remote.origin.url log SOME_HASH_NOT_IN_REFSPEC
> >
> > I don't understand what's happening here at all, because setting
> > "remote.origin.url" to "True" in this way works to prevent the
> > normally configured URL from kicking in, ...
>
> Interesting.  This happens inside remote.c:handle_config() where
> git_config_string() is used to reject a non-string value given to
> the "remote.<name>.url" variable and abort the process to read from
> the configuration file by returning -1 and causes whoever uses that
> configuration value to die.  As the command line configuration is
> read first, aborting the configuration reader early would mean that
> the configured values would not even be read.
>
> I am not sure why this does not cause the entire thing to die,
> though.  It requires further digging, for which I do not have time
> for right now..

I'm reasonably sure this is because the process that reads this config
value is a subprocess, and that subprocess dying was actually
*helping* me in this case.

>
> > ... but setting a different value
> > (or empty value) does not.
>
> Most likely, this is because you are giving a syntactically correct
> value so the usual "last one wins" logic kicks in.
>

I don't understand - surely what's provided "-c" should beat what's in
the repo's .config? "Last one wins" is exactly what I would expect,
but don't seem to be seeing...

> In hindsight, I think (1) the first one should probably fail the
> "git log" process (not just the lazy fetch subprocess), and (2)
> there should be an explicit way, e.g. giving an empty string, to
> "clear" the list of .url accumulated so far.
>
> (2) may look something silly like this:
>
>  remote.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git c/remote.c w/remote.c
> index 0764fca0db..ecc146856a 100644
> --- c/remote.c
> +++ w/remote.c
> @@ -64,12 +64,22 @@ static const char *alias_url(const char *url, struct =
rewrites *r)
>
>  static void add_url(struct remote *remote, const char *url)
>  {
> +       if (!*url) {
> +               remote->url_nr =3D 0;
> +               return;
> +       }
> +
>         ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
>         remote->url[remote->url_nr++] =3D url;
>  }
>
>  static void add_pushurl(struct remote *remote, const char *pushurl)
>  {
> +       if (!*pushurl) {
> +               remote->pushurl_nr =3D 0;
> +               return;
> +       }
> +
>         ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushu=
rl_alloc);
>         remote->pushurl[remote->pushurl_nr++] =3D pushurl;
>  }
>


Thank you, I'll play with this when I get the chance.
