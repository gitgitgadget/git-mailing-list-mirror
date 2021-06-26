Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA93C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035A261C35
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 14:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFZOz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZOz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 10:55:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6BC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 07:53:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id yy20so12365685ejb.6
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HKQHTSgyGOpC6HpG2nqBhycSYu/KvRkv6+eGcT8vEco=;
        b=JyezNMTDthiN+6ATZJWr8RvpKqhe6FlmOXfwnyT37BP90JhqZoHSBc+SOTSaEdcHQv
         TmUd00rzjvNAIuM30270Zn74QwfE6lhzQjabhKTLa3/Bz5uN1DkhJQtu58MWDnSLZfe3
         QD/g7d6voenWmtjtHrGuI5losndP4ig3wTsxAeMidDtCdOs5L3ZvBKgJ3BOI18YlC3/R
         LOnpQnfDxZN659p8VrM6cqo9YteEwOvGYIAUcGQLkb8N5Sh+5livcLt6KRb1TuX13F9W
         k/qpUZPDKfJwTxJx+ayIpXlvyPBGMN/gLP4D+QLkOKPv6ydIqR2oayUviM/1WRQGfInx
         9cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HKQHTSgyGOpC6HpG2nqBhycSYu/KvRkv6+eGcT8vEco=;
        b=NM/n1tFnJlNB2s6oBjrLalQ+VvluuvkaBFj34DtE6LRc9qKwhqgxux/2d5JTZxHXMV
         WQxOh0ryQrRnpNgS7B4GftEHGTXBip9IV8ZnPpggl31d831NwzT78+MU19Mx67GFJc0V
         AZTD/I1L8uw0uBWMK9AB4AYYqakjGt6lZAvaIY96evcP2xNjwCeQP6S32VhihJymKWb1
         aTnv4J0dm6EoICRbNk6U2YKHq9kmkIfcWwUw1SBFnb8A65zPHuwUx3crmIWIU2jrcZAD
         VGf9LaTz3oypwmZc1nmsxK+4nDnitzWkbpt8AGKNrQ6YlM2FOMI+TTPIsiK6O8hTGaC9
         Mb2Q==
X-Gm-Message-State: AOAM531u3R6f9wYAfBq9FTAv11xIvf2lA8lCo/MtTnVHDj9TbqouQPYJ
        HDRRY29PStnvKm45obaHhWk=
X-Google-Smtp-Source: ABdhPJz6jDODK2JCGdCV5tW9y8tnYg4M12ITN0OdfJmw1a4VmDbUBN6SQL0VjBp7YblgHR07TPK2Bw==
X-Received: by 2002:a17:906:a28b:: with SMTP id i11mr16882874ejz.143.1624719182197;
        Sat, 26 Jun 2021 07:53:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ia20sm4346437ejc.96.2021.06.26.07.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 07:53:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8] help: add option to colorize man pages under less
Date:   Sat, 26 Jun 2021 16:49:46 +0200
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
 <20210626025040.104428-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210626025040.104428-1-felipe.contreras@gmail.com>
Message-ID: <877digy8xe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 25 2021, Felipe Contreras wrote:

> This a reroll of =C3=86var's v7 with comments from Jeff King so that
> color.ui=3Dnever doesn't disable color.man, and the documentation was
> updated accordingly.
>
> Additinally I removed one call to colorize_man() in exec_man_cmd() which
> is not meant for the man command (although it could be used for that).
>
> Plus a bunch of style changes to the commit message.

This version looks good to me, thanks for the style & grammar fixes on
my commit message additions.

>           1. color.man=3Dtrue must be set in the config
>           2. The user must use less
>           3. Not have the same LESS_TERMCAP variables set (we call setenv=
(3) with overwrite=3D0)
>     -     4. Have color.ui enabled
>     -     5. Not have color.pager disabled
>     -     6. Not have git with stdout directed to a file
>     +     4. Not have color.pager disabled
>     +     5. Not have git with stdout directed to a file

Even better.

>  static struct cmdnames main_cmds, other_cmds;
> diff --git a/color.h b/color.h
> index 98894d6a17..d012add4e8 100644
> --- a/color.h
> +++ b/color.h
> @@ -51,6 +51,7 @@ struct strbuf;
>  #define GIT_COLOR_FAINT		"\033[2m"
>  #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
>  #define GIT_COLOR_REVERSE	"\033[7m"
> +#define GIT_COLOR_UNDERLINE	"\033[4m"
>=20=20
>  /* A special value meaning "no color selected" */
>  #define GIT_COLOR_NIL "NIL"

Not really needing, but I note that this adds something that we don't
have in test_decode_color(), not that we're testing this output
directly, so it doesn't matter for now.
