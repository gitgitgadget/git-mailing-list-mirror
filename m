Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D71C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421A622245
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOEX9tYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKMNML (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKMNML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:12:11 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7FAC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:11:58 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id dk16so13292825ejb.12
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uGxN0lBHY09bPh79G4JPGwGYKMY7ndOxAaSzW9QUF3Y=;
        b=GOEX9tYkPDAapJF7315e+nf1YkahNNhzLoRCGgHeOTFQw8wu5shDQaGz9E0ptGuXqQ
         lKhPhwM1jTWENLiLyccpIeqxvwOmh2z9jvbcuG3n9m3IjAjkuy0Mp4PBgjScF/Z2py+/
         CCpFxBrBSnpfITYXm8BxXJxKfVG89B2/jrKT4jfoeLLkh+Z6nm39SWEc2Ca+VaeUvAad
         BcaKhB5lIFTm3sgV96/giw+WsFhtpdacrWopIg+scWyjCfT3Gfdy2XnQIW+7pp8qPuPd
         9/uQr3m1bzKKQ0e2maYRonjrFarjUupFFgSioHWir41TbXPcsP8oD9VM+ijQ2FsAKPci
         fGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uGxN0lBHY09bPh79G4JPGwGYKMY7ndOxAaSzW9QUF3Y=;
        b=OGW0W4lD6h3JuVTMDBcwLumQ6IDLs0v6Dzy/HRBxhrq1hX5Q+KLjy9OfkaIZNIY18A
         qL224li/REr+euNsjwR1Qv03HVezLpdwvU+eFE3n9WmwEltxjJlhSycpC5umUvuzFe/J
         3gILiv2QR6gdzeRwqInm3zo5CJlUjSLru6eRgJiRZFxW3MANa7wazypJJdUhkvSZody4
         Z8+JcgyKcIrL7tx/ryejzpauKbrkD3Wl1z1W2wQYZ1WpW3I+pttGQchV9nEE3ykYAlxI
         pthcb6mi0VpyqVS2CWzCbs+Dw4xI0WOs9N83KcKQMzrxkrY1AkmaxFGsJd2R5Pl7n+dd
         lz8Q==
X-Gm-Message-State: AOAM532xhdHyAC0ABFifkNFZGUPakZdPXnOl9cTfLazdH8eIGaFFSIMm
        g4UUlYzSvDqu0Q/uKB8RtLnEtPTznZQ=
X-Google-Smtp-Source: ABdhPJwT0btfyfgeKc6Kaw9XjLXh84dkJkvL1KNaY60h8af8rF5HgnoIhzd4clDwPIP8MrnChrhdFg==
X-Received: by 2002:a17:906:19cf:: with SMTP id h15mr1804666ejd.74.1605273116708;
        Fri, 13 Nov 2020 05:11:56 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id p91sm4007808edp.9.2020.11.13.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:11:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] config: allow specifying config entries via envvar pairs
References: <cover.1605269465.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <cover.1605269465.git.ps@pks.im>
Date:   Fri, 13 Nov 2020 14:11:55 +0100
Message-ID: <87k0upflk4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 13 2020, Patrick Steinhardt wrote:

> this patch series adds a way to specify config entries via separate
> envvars `GIT_CONFIG_KEY_$n` and `GIT_CONFIG_VALUE_$n`. There's two main
> motivations:
>
>     1. `GIT_CONFIG_PARAMETERS` is undocumented and requires parsing of
>        the key-value pairs. This requires the user to properly escape
>        all potentially harmful characters, which may be hard if the
>        value is controlled by a third party.
>
>     2. `git -c key=val` is not really suited to contain sensitive
>        information, as command line arguments trivially show up in e.g.
>        ps(1).

FWIW we had an off-list discussion about this where the desire was to
have the equivalent of a transitory password in a config file without
the bad pattern of putting it in an on-disk config file. The advertised
solution we have now is core.askpass, but a user might for some reason
not want the hassle of an external program.

I noted that you can do that with some clever hacks that aren't
explicitly documented:

1) Use the insteadOf config to on-the-fly rewrite a password-less https
   URL to have a user/password:

    git -c url.https://user:password@.insteadOf=https:// push

   But that has the downside of showing the password in "ps" as Patrick
   notes. That's OS dependant, but is the default on e.g. Linux, as
   opposed to envars. See "hidepid" in the "procfs" manpage.

2) Doing the same via an env var, but via GIT_CONFIG_PARAMETERS:

    GIT_CONFIG_PARAMETERS="'url.https://user:password@.insteadOf=https://'" git push

3) This doesn't work, but I wish it did. First put:

    [include]
    path = /dev/fd/321

   In your .git/config. Then:

    (echo "[url \"https://user:password\"]" && echo "insteadOf = https://") | { git remote get-url origin; } 321<&0

   The reason it doesn't work is because the "git remote" config
   machinery, unlike the general machinery, explicitly doesn't handle
   includes. I didn't poke at that for long, but I expect that's just an
   omission. It wants to not read remote.origin.url from ~/.gitconfig or
   whatever, but I don't see why we wouldn't follow includes in
   .git/config.
