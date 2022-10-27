Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B14ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiJ0WkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiJ0WkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 18:40:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B85B103
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:40:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k2so8846109ejr.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xK1ZLEv8bI+tZSLQDEvuDEQXxAtxAfjcAbvMMyuVEpY=;
        b=WD45DJjinyX5BWxlYLP0qIs1qbAbV5tpXwWxmchG1JP0c61KNxnaYCUJ2FX9MaGcCh
         GmpJNcTYox6mCEJWTOlIuWMVlNUHdA0mIj7QDWlWlyksELH4iFcQg+pmMDrSE4GoH6Oo
         uSvkMteeqQL6so6Q1Nt/akbi6ViIk2Fl4uT8aY7dezkD0DP8o9q9L7gM/BCwnw+pUUTi
         cn3gl+X6bxGQpszl14kdNB6sbjIQA8ObT41JH/GIW0WHx2A9TgkjQnZ+WOWn0fvzfiab
         Wm05QO5wLsOdOqH+gbizJaPRH0PZr42AcxwPxM50kW0FE6uocQ5UZpMmg+Vgt8uprKJy
         /UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xK1ZLEv8bI+tZSLQDEvuDEQXxAtxAfjcAbvMMyuVEpY=;
        b=pRKhx49N2hGbfJ3EBqNfVK/O75W49VSHOINtj2zAwS75kzbU8VIfOidinmfBHWVnT3
         c5ZuqFYzQZUfOKgwR3vt0tvaK6oALGpNLpQYgNR8r8TwNDhGG+01Vlm/VBC7hzcLf8Fd
         4xXTJmBwSj1oREzODuU8R3f/SmfHJ2zs1VEQpkFtx8pg8B2JVQwNxSEDTKKoryoWKtg6
         q3qo9TWX0zulUxh6WwqJE7S9Szsm+FRH6lenn9+rSpCJ0c/TZmyGifH7JrPfrviOdUwB
         dRj0q8GQqbanO++dGe8o2+I8mqmVtdvxx6NV3LcQwFgT2AwnqF4U1mcfR+LcFDhf34mB
         GNJQ==
X-Gm-Message-State: ACrzQf0ApxE/zBByYm14BLX+QLFl67xNKNcRWP8388VQU4WykhyIuA7a
        Pwwu5i5O15sF5CV8QE/mBs4=
X-Google-Smtp-Source: AMsMyM7LO+iHRXa2cLchpxu0k5YQ+YHcXnunW7oCdMQ6EkrSn00SaFBHfdtneWaNjZEZZES5W8RIfw==
X-Received: by 2002:a17:907:320c:b0:77b:6f08:9870 with SMTP id xg12-20020a170907320c00b0077b6f089870mr43768010ejb.249.1666910417152;
        Thu, 27 Oct 2022 15:40:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx26-20020a170907775a00b0073ae9ba9ba8sm1391863ejc.3.2022.10.27.15.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:40:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooBXr-009ddA-2o;
        Fri, 28 Oct 2022 00:40:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] use child_process members "args" and "env" directly
Date:   Fri, 28 Oct 2022 00:37:09 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <672e4176-81b4-bb9c-5a14-e558d24b0c0d@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <672e4176-81b4-bb9c-5a14-e558d24b0c0d@web.de>
Message-ID: <221028.86r0ysao1c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

> Build argument list and environment of child processes by using
> struct child_process and populating its members "args" and "env"
> directly instead of maintaining separate strvecs and letting
> run_command_v_opt() and friends populate these members.  This is
> simpler, shorter and slightly more efficient.

General comment: Here you make 2x of the flags in in run-command.h
orphans, we could just remove them here atomically. I.e. squash in part
of 8/8.

>  static int similarity_index(struct diff_filepair *p)
> diff --git a/git.c b/git.c
> index ee7758dcb0..6662548986 100644
> --- a/git.c
> +++ b/git.c
> @@ -787,7 +787,7 @@ static int run_argv(int *argcp, const char ***argv)
>  		if (!done_alias)
>  			handle_builtin(*argcp, *argv);
>  		else if (get_builtin(**argv)) {
> -			struct strvec args =3D STRVEC_INIT;
> +			struct child_process cmd =3D CHILD_PROCESS_INIT;
>  			int i;
>
>  			/*
> @@ -804,18 +804,21 @@ static int run_argv(int *argcp, const char ***argv)
>
>  			commit_pager_choice();
>
> -			strvec_push(&args, "git");
> +			strvec_push(&cmd.args, "git");
>  			for (i =3D 0; i < *argcp; i++)
> -				strvec_push(&args, (*argv)[i]);
> +				strvec_push(&cmd.args, (*argv)[i]);
>
> -			trace_argv_printf(args.v, "trace: exec:");
> +			trace_argv_printf(cmd.args.v, "trace: exec:");
>
>  			/*
>  			 * if we fail because the command is not found, it is
>  			 * OK to return. Otherwise, we just pass along the status code.
>  			 */
> -			i =3D run_command_v_opt_tr2(args.v, RUN_SILENT_EXEC_FAILURE |
> -						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");

^^ here, I didn't look carefully at the rest of the commits, but maybe
there's similar squashes elsewhere...
