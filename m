Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4AC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 10:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BD6619BF
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 10:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhCWKfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 06:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhCWKfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 06:35:17 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89EC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 03:35:16 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z15so16485999oic.8
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nIAmCcucsWGwv5o8xPnH81YHjBauAvslXnSkRltYTgU=;
        b=p0KfOVdbd5Pj/50F9laQx3BKa742cfVgm0M6GdZjwkSqBdMQ1JdKzho1RBeDrBLVBb
         3NBBGuY76RFLO1qnRhx319ANm7kZB2DmEuuQAap05T+UyjQi/pgAWEodrmHh35bCu+B5
         orfFgA+ZmOPyvJ7w/QpsYUZexHqRBwTRZvQ0dkn6MKok+EWG4i+8vXgaFHc6UZxM77gT
         wbndU5g7iTSRgY+5eEARzv17GlsFV4nup2atJ3JDkO8TBgrsJQweKhwM2B3byt7RWFti
         pPaC3Kx3IlNKq93wt6y0RcNCr23Dq3n3EmcJPFRG0n0QqF+pmn1V+fLfipa2WFaV02Kc
         VS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nIAmCcucsWGwv5o8xPnH81YHjBauAvslXnSkRltYTgU=;
        b=ALDPyVHWznHaw2Ac3uPeYGvCxKYZkas8QPxSDKq3mbFL86xhGuqFuytqnIzg/za/O4
         3lhKMmzNgFRVJ8GbNGq8LoodUYt9FDDMWeeh3vW+mijSxpwDEZbU5PqIMakrH2dHa33P
         N8mIzwVRJJgVn1f1UbuJQo8VHQOhRxNduFLwsi0Z8grhuBFoygv2Myt6TH4BvggDnzD7
         gpv8ph+8al/2jMP87/RZXjtnb3gwgm3daxLE8qmA0zdgAXiNScyVcYTU3q/0zDyEj3Yg
         fWnJ9Ya3Vw2mW7awt7ACY+KjdVV8V69Fm1KiiaEb2fIpz8lHWaUGCOl5qvuTmrTHWk7C
         C7ig==
X-Gm-Message-State: AOAM530eLuVGu083AVMVqAEp6vROls1vY59MNGvEFaHBlj1MlSGNYl2b
        dE3yKhb5ZUgUEdX3YTZ6RQN0xW2C+qUYqkjvopE=
X-Google-Smtp-Source: ABdhPJx+idRgGVtDVGUt//u7fU79/jGOLqUxYY1tlHaNi4sR+u5rEtL+BoRtxepM/j7SVHjx0Oiujv54D3oo+nj5vrM=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr2900027oia.44.1616495716141;
 Tue, 23 Mar 2021 03:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
 <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com> <xmqqv99i4ck2.fsf@gitster.g>
In-Reply-To: <xmqqv99i4ck2.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 23 Mar 2021 18:35:04 +0800
Message-ID: <CAOLTT8TKqDWnu3k1Xz=qBhmdZYFhM452WzVGG=OArgJL3z0yGQ@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > If you want nothing to happen when $ARG isn't set, you can change the
> > config option to something like:
> >
> > $ git config trailer.sign.command "NAME=3D'\$ARG'; test -n \"\$NAME\" &=
&
> > git log --author=3D\"\$NAME\" -1 --format=3D'format:%aN <%aE>' || true"
> >
> > (This is because it looks like $ARG is replaced only once with the
> > actual value, which is perhaps a bug. Otherwise something like the
> > following might work:
>
> I do not know the origin of that code in trailers.c but it feels
> quite confused and error prone to use textual replacement with
> strbuf_replace().  Why doesn't the code, which knows it will use
> shell to execute the command line given by the end user in the
> configuration, to just export ARG as an environment variable and
> be done with it?  It would also avoid quoting problem etc.
>

Maybe like this?

-#define TRAILER_ARG_STRING "$ARG"
-
static const char *git_generated_prefixes[] =3D {
       "Signed-off-by: ",
       "(cherry picked from commit ",
@@ -222,13 +220,17 @@ static char *apply_command(const char *command,
const char *arg)
       struct strbuf buf =3D STRBUF_INIT;
       struct child_process cp =3D CHILD_PROCESS_INIT;
       char *result;
+       const char *const *var;

       strbuf_addstr(&cmd, command);
-       if (arg)
-               strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+       for (var =3D local_repo_env; *var; var++)
+               strvec_push(&cp.env_array, *var);
+       if (arg) {
+               strvec_pushf(&cp.env_array, "ARG=3D%s", arg);
+       }

       strvec_push(&cp.args, cmd.buf);
-       cp.env =3D local_repo_env;
+
       cp.no_stdin =3D 1;
       cp.use_shell =3D 1;
