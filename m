Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE84C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 20:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbhKVU7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhKVU7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 15:59:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB5C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 12:55:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so82666895edb.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NjuEQbRhQlm0P88juGjXCoGMEYy435QO5ihRzVF5e3I=;
        b=Nm7Ub+KVZUFMVTADgdUPOIES3LI4m+TKk1ci9sTfVzIg/EYa2ps+2Fc/WyIyzNVTM1
         navDM41A8fGt8O+yeyl8qNRwj5RB/1RR8Bobawf9a4YNTY1iq6luJJ29QEzCQlcAfRJY
         rvAqsk//eE5BegG6J0cBSl79JPtBagpyeHtVKHEGHYhQ9dCL3r6E4Lw5Hg6x4J6kkQt8
         2j7zTaHPrZ43R4uDverUCGms7g43WD+pkCTGsNVnVHQ3VPG4etGj1CBRFNpypeokPe/O
         RRcFankmvMfjmPgi8RwyvLFtfA80uX/Dw+QXMEtwmw0WLST2qEh8tcHdGrUUacHabl5H
         SRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NjuEQbRhQlm0P88juGjXCoGMEYy435QO5ihRzVF5e3I=;
        b=6AM3nRuM7Rri6jx6IMGW0oCjNh13C0LDZVUPQX3pXD3DCp+vDgW2uZjnu1wnW/ifYu
         7D7MFvr9hKM7fWKKCPgNcM3EpgNQeTeTpj3effRCGKeDP1GivteFzN50Ayqi9e/4mrBB
         OVFjDTIz/bgKHWOVEXs+XvHo29ANuEAKga5opeoiDAk2mQm/+ozx5BXAsTycMB0BUyLk
         eoCmvKu55B7yDaHHbj3XZKtSGi7i0oIFqBI3cPIjwTkI5ZqGYdLwIovYt/ldrO/4jHjX
         5W0U6RJqsj9A0keZNVSDL2u4FpErv3Z+gZAdyg6DESM8OlrTCfCwASupswPCifYProx5
         vffA==
X-Gm-Message-State: AOAM53277P4wJYhoi6u438iL/gp+ARfvMm2Z3kVu8tDYwXqfth29J1Rb
        +JCPBtto0owEocbIq1Ri7itHtKJd2MJbXQ==
X-Google-Smtp-Source: ABdhPJxERvLQvbGH4baTrUk1sV1x/t0E0jPb/GLJyQ1XHZ+32g4VfZe8JuzmAzb0ug2ZnSDj843Btw==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr69997376edk.154.1637614557118;
        Mon, 22 Nov 2021 12:55:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z22sm4973461edd.78.2021.11.22.12.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:55:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpGLz-001Azt-Bq;
        Mon, 22 Nov 2021 21:55:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/5] upload-archive: use regular "struct child_process"
 pattern
Date:   Mon, 22 Nov 2021 21:53:34 +0100
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <patch-2.5-a411098699d-20211122T153605Z-avarab@gmail.com>
Message-ID: <211122.86fsrnyko4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This pattern added [1] in seems to have been intentional, but since
> [2] and [3] we've wanted do initialization of what's now the "struct
> strvec" "args" and "env_array" members. Let's not trample on that
> initialization here.
>
> 1. 1bc01efed17 (upload-archive: use start_command instead of fork,
>    2011-11-19)
> 2. c460c0ecdca (run-command: store an optional argv_array, 2014-05-15)
> 3. 9a583dc39e (run-command: add env_array, an optional argv_array for
>    env, 2014-10-19)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/upload-archive.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 24654b4c9bf..b4b9b3a6262 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -77,7 +77,7 @@ static ssize_t process_input(int child_fd, int band)
>=20=20
>  int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>  {
> -	struct child_process writer =3D { argv };
> +	struct child_process writer =3D CHILD_PROCESS_INIT;
>=20=20
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage(upload_archive_usage);
> @@ -92,6 +92,9 @@ int cmd_upload_archive(int argc, const char **argv, con=
st char *prefix)
>  	argv[0] =3D "upload-archive--writer";
>  	writer.out =3D writer.err =3D -1;
>  	writer.git_cmd =3D 1;
> +	strvec_push(&writer.args, "upload-archive--writer");
> +	if (argc > 1)
> +		strvec_pushv(&writer.args, &argv[1]);
>  	if (start_command(&writer)) {
>  		int err =3D errno;
>  		packet_write_fmt(1, "NACK unable to spawn subprocess\n");

Changing it to argv + 1 makes sense, I don't know why I did it like
that. It works, but is unusual.

But as to skipping the "argc > 1" test I've got this still:
=20=20=20=20
    @@ -89,9 +89,11 @@ int cmd_upload_archive(int argc, const char **argv, =
const char *prefix)
             * multiplexed out to our fd#1.  If the child dies, we tell the=
 other
             * end over channel #3.
             */
    -       argv[0] =3D "upload-archive--writer";
            writer.out =3D writer.err =3D -1;
            writer.git_cmd =3D 1;
    +       strvec_push(&writer.args, "upload-archive--writer");
    +       if (argc > 1)
    +               strvec_pushv(&writer.args, argv + 1);
            if (start_command(&writer)) {
                    int err =3D errno;
                    packet_write_fmt(1, "NACK unable to spawn subprocess\n"=
);

We'll segfault if we give NULL to strvec_pushv() so we still need that
check. Were you thinking of strvec_pushl(), or am I missing something?

(Even with strvec_pushl() we can't interpolate it as-is into the list,
since it'll point to uninitialized memory in this case).
