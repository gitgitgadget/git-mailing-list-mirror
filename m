Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED1DC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 03:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4860560
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 03:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhHUDTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 23:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhHUDTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 23:19:51 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E6C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 20:19:12 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h18so11450963ilc.5
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 20:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ebkUM6WkYcboylT0xYhO4Un6oKNv1DcabMRinFCE2LQ=;
        b=PJB1Gf7u76aDeUgYJ5PAHIIRJMSBE7Pdiue3dOi/WKLx3lJUDe+48jHmXG6ZafHVTL
         WbbrUxgXPk+q8ueS2IL6Y6niwCEGXAoed3ykoIX7eRxTV+hWSiH/KEexjExyaVBp4KmV
         Rs1UKBDzL95IDYHBIQg8EdgFCaSFJwYqLsL6N76QjjftQ9JN3OqQrLjcPQAWdkS1zox3
         DkAGPRXOO3BRGegqhRQ+1/c1+jRexS8O+K5ioqA4R2z49qF0iRN9zXkln4E/+hf1fQbX
         U5D0EQpbtR3AWEdILkmCkoZykdlCJ2ANj0zPxmkXTo0zfLPN/+ktV4ZgkCwheQDxkIvs
         GznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ebkUM6WkYcboylT0xYhO4Un6oKNv1DcabMRinFCE2LQ=;
        b=njOuX+3QLMd+KvBASu/7c8hfCrFP0ef+IdtD0eB8YjDGusGG+dEcQFEHuRl/TtOYnJ
         SobmMTsXMf5VkfCp8CaMxKtIvO3OtMZNq5vzAkHv3dGizvMo8FsE/BBKloWBqKSfEf36
         9Yf+7FDmp4mPo7XDmpC3DzcJaziiDzMcTzvm4Tob4GkvxDO7GXxNxGqHkf8PaTA0ukBJ
         jJxYVrFjpaXeQv0dRi0uxAFP01Yhyh+8vN+cCYMbP5irY+n3GqzMv/M/q/PUFEPn4t33
         WDRp32ezMnjUvJWXMBU+AlqQ+Y4Je3PImfXjQyNZ0dzk3Mw0kjfLrRoCnljrDBrpgE52
         us3Q==
X-Gm-Message-State: AOAM531FAibU2xijFovoBJbRpET3CQExSrQ8r4izVub9mEqHKWDmTa1B
        Nx4NXghdyR81v8VLvUlvd+hWTeGKYGl6rxkC45Y=
X-Google-Smtp-Source: ABdhPJzODIcm67HHvbjwmw4lYaLyoTse4AgGco3Wr6DUpbqR9l0DrNiBES7ijHlxjC4Ii5ltg4m9/n4jXPdWvgjBa8E=
X-Received: by 2002:a92:d7c1:: with SMTP id g1mr16188226ilq.24.1629515951866;
 Fri, 20 Aug 2021 20:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com> <xmqq4kbl2sre.fsf@gitster.g>
In-Reply-To: <xmqq4kbl2sre.fsf@gitster.g>
From:   Xiaowen Xia <haoyurenzhuxia@gmail.com>
Date:   Sat, 21 Aug 2021 11:19:00 +0800
Message-ID: <CAHLXgnYsQcfgddNHdH+geoczq8isgLaf-b3oLzjNS+m96N5ESg@mail.gmail.com>
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio:

Thank You so much for your reply!!

> > The default is unlimited, same if the value is 0 or negative.
> Let's error it out when the configuration gives a value that does
> not make sense instead. That way, we could in the future use some
> of these invalid values to signal special behaviour if we wanted to.
But this patch is similar to the `http.lowspeedlimit` and `http.lowspeedtim=
e`.
And `http.lowspeedlimit` will not error out the negative values:

        if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
            curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
                 curl_low_speed_limit);
            curl_easy_setopt(result, CURLOPT_LOW_SPEED_TIME,
                 curl_low_speed_time);
        }

> We are likely be raising the floor versions of libcURL to 7.16.0 or
> even 7.19.4 soonish.
OK, I will remove the #if #endif block for libcurl 7.15.5.

> Let's error it out when the configuration gives a value that does
> not make sense instead.
The same as above.

> I wonder if ssize_t is overkill for our purpose, though.
You are right, I will change it to long type.

> This call, if you use anything but curl_off_t as the type for
> curl_max_receive_speed variable where it is declared, needs a cast,
You are right.

> Unlike curl_max_receive_speed that must be visible and
> understandable long haul in this file, the temporary string variable
> lives only during these handful of lines and shortened name is
> easier to see and understand what is going on.
OK.


Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Xia XiaoWen <haoyurenzhuxia@gmail.com> writes:
>
> > Sometimes need to limit the receive speed of git `clone/fetch`
> > because of the limited network bandwidth, otherwise will prevent
> > other applications from using the network normally.
>
> No subject in these two half-sentences.
>
>     In order to avoid hogging all the available bandwidth, users may
>     want to limit the speed to receive traffic for "git clone" or
>     "git fetch".
>
> perhaps.
>
> > Add `http.maxReceiveSpeed` to limit `git-receive-pack` receiving
>
> "limit `git-receive-pack`'s" or "limit receiving speedk of ..."
>
> > speed, Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` eivironment
> > variable.
> >
> > The default is unlimited, same if the value is 0 or negative. The
>
> Let's error it out when the configuration gives a value that does
> not make sense instead.  That way, we could in the future use some
> of these invalid values to signal special behaviour if we wanted to.
>
> > default unit is Bytes/s, common unit suffixes of k, m, or g are support=
ed.
>
> OK.
>
> > this configuration is valid for `clone`, `fetch`, `pull` commands of th=
e
>
> s/this/This/
>
> > https protocol, and only supports libcurl 7.15.5 and above.
>
> We are likely be raising the floor versions of libcURL to 7.16.0 or
> even 7.19.4 soonish.  It probably would make it easier to allow it
> unconditionally (otherwise you'd probably need to implement error or
> warning messages when configuration is given but the libcURL version
> used is too old, etc.).
>
> > ---
> >  http.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/http.c b/http.c
> > index 8119247149..12030cf3bc 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -83,6 +83,9 @@ static const char *ssl_pinnedkey;
> >  static const char *ssl_cainfo;
> >  static long curl_low_speed_limit =3D -1;
> >  static long curl_low_speed_time =3D -1;
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +static ssize_t curl_max_receive_speed =3D -1;
>
> On cURL side, CURLOPT_MAX_RECV_SPEED_LARGE takes curl_off_t, which
> is typically off_t (which is signed).
>
> I wonder if ssize_t is overkill for our purpose, though.  Can't this
> be a plain vanilla "int" or perhaps "long", just like the variable
> defined above uses "long" for "speed"?  Or is 2gb/s too low to be
> practical and we must use a 64-bit type?
>
> > +#endif
> >  static int curl_ftp_no_epsv;
> >  static const char *curl_http_proxy;
> >  static const char *http_proxy_authmethod;
> > @@ -361,7 +364,12 @@ static int http_options(const char *var, const cha=
r *value, void *cb)
> >               curl_low_speed_time =3D (long)git_config_int(var, value);
> >               return 0;
> >       }
> > -
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     if (!strcmp("http.maxreceivespeed", var)) {
> > +             curl_max_receive_speed =3D git_config_ssize_t(var, value)=
;
>
> Check for nonsense values, so that we can later use them to mean
> something special.  It is good to remember is that you can always
> loosen the rules after you give your software to your users, but it
> is very hard to tighten the rules.  As you never need more than one
> way to specify "the default" (aka "unlimited"), reserving any
> non-positive value to mean the default is a design that is
> extensible poorly.
>
> I.e. insert something like
>
>                 if (curl_max_receive_speed < 0)
>                         die("negatigve number for %s: %s", var, value);
>
> here.
>
> > +             return 0;
> > +     }
> > +#endif
> >       if (!strcmp("http.noepsv", var)) {
> >               curl_ftp_no_epsv =3D git_config_bool(var, value);
> >               return 0;
> > @@ -974,6 +982,12 @@ static CURL *get_curl_handle(void)
> >                                curl_low_speed_time);
> >       }
> >
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     if (curl_max_receive_speed > 0)
>
> The "result" handle was created anew in this function, so the
> distinction does not really matter in practrice, but since you are
> carefully initializing the variable to "-1" so that we can
> differentiate the case where it is unconfigured (hence we want to
> use the default) and it is set to zero (hence we want to use the
> default), it would be more consistent and future-proof if you also
> allowed 0 to be passed here, i.e.
>
>         if (curl_max_receive_speed >=3D 0)
>
> > +             curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
> > +                              curl_max_receive_speed);
>
> This call, if you use anything but curl_off_t as the type for
> curl_max_receive_speed variable where it is declared, needs a cast,
> like in the example https://curl.se/libcurl/c/CURLOPT_MAX_RECV_SPEED_LARG=
E.html
>
> > +#endif
> > +
> >       curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
> >  #if LIBCURL_VERSION_NUM >=3D 0x071301
> >       curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> > @@ -1105,6 +1119,9 @@ void http_init(struct remote *remote, const char =
*url, int proactive_auth)
> >  {
> >       char *low_speed_limit;
> >       char *low_speed_time;
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     char *max_receive_speed;
> > +#endif
> >       char *normalized_url;
> >       struct urlmatch_config config =3D { STRING_LIST_INIT_DUP };
> >
> > @@ -1196,6 +1213,11 @@ void http_init(struct remote *remote, const char=
 *url, int proactive_auth)
> >       low_speed_time =3D getenv("GIT_HTTP_LOW_SPEED_TIME");
> >       if (low_speed_time !=3D NULL)
> >               curl_low_speed_time =3D strtol(low_speed_time, NULL, 10);
> > +#if LIBCURL_VERSION_NUM >=3D 0x070f05
> > +     max_receive_speed =3D getenv("GIT_HTTP_MAX_RECEIVE_SPEED");
> > +     if (max_receive_speed && !git_parse_ssize_t(max_receive_speed, &c=
url_max_receive_speed))
>
> Overlong line.
>
> Unlike curl_max_receive_speed that must be visible and
> understandable long haul in this file, the temporary string variable
> lives only during these handful of lines and shortened name is
> easier to see and understand what is going on.  Also, you can avoid
> repeated spelling out of the environment variable name by giving a
> constant for it near the top of this function, e.g.
>
>         static const char mrs_env[] =3D "GIT_HTTP_MAX_RECEIVE_SPEED";
>
> Then this part would become:
>
>         if (mrs) {
>                 if (!git_parse_ssize_t(mrs, &curl_max_receive_speed))
>                         die(_("invalid number for %s: %s", mrs_env, mrs);
>                 if (curl_max_receive_speed < 0)
>                         die(_("negative number for %s: %s", mrs_env, mrs)=
;
>         }
>
> > +             warning("failed to parse GIT_HTTP_MAX_RECEIVE_SPEED: %s",=
 max_receive_speed);
>
>
> Thanks.
