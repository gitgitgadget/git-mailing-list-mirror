Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB737C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E1E60F9B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 17:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhJ3RYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3RYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 13:24:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8B5C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 10:22:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z20so49811338edc.13
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GFZxcDb2M4bjcX59QrTAPc5PhjkG00B9ouTL5ml7InE=;
        b=JrvD2hjj8pGSAHwMsvkl3StAEvByk94bNBfX6GW1qTa7UIuMIg6nrHCmoEgDMxfxOC
         T12FQ5KpIqolFCn9p9OsmEsmnRh/sLiBOGd0A2MPmScoxw9nMlY/fCOioTvi6mYQHjF8
         QJb8h4CAQmM/Qd/vhYDBN2uXMTYB1y3anRiBh3DM8ulBcUuMz8MDdAIhWoNq5Zfv50dC
         PCM7oSFpiFS6FjEnEg42bnJIYT51ZQ01J+4do6vlDOERRu3UUkZ1bBccWEYivsPCqokO
         yxjN0GYJgel+uWPUQS0WsJtUmtwK9r8OwLrJsuC2vf5mm3HdyaVueoBD6pB+hgTdhbdy
         fm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GFZxcDb2M4bjcX59QrTAPc5PhjkG00B9ouTL5ml7InE=;
        b=aw7aZlb8bCAG1n05WgbapPHpkWD6CEC5YKNHUemE7FuZxEPD/GC54CtHY3/KR4Gvx5
         RgvMew4zxhBama0U795ytiH6l9Q1GI0AmgVL3T9ryugqV/Gfn+iRtvREoV4lBeIU88TU
         hzu/RG7FCz43kWWpVCT9oMeZEPATkjuXEedp0ZBckVpuT/KbWhmB2KKxphdklAHUk/hB
         bVYnX/N1Y2JuckOzUgcrxe/C0EGHt4c8aYFS6eNsvdlxmYzp62+nw1FP0AV3EyxkX7FA
         RraoAV+F/zf1dRBqQQ4qxdiKxBzXXqMcEuR/f4EeVbiZLRplxNJI4cX5hYlpPPVeOuNx
         Lhzw==
X-Gm-Message-State: AOAM530olFFNol63kNVxY4JbxdZUSPoZwq++6juZIzI/xuvqQRLusTPw
        wmAAqXC+SD0QWzQ7+6W5Rmmc2M3l+vY=
X-Google-Smtp-Source: ABdhPJyIuFTiwr6m8i5v5Yqq4PX/78tbO51jNEFA9GGN7f3OvNT9S/HbCAgUwQsWpOgUXVKWtnag/Q==
X-Received: by 2002:a17:907:e86:: with SMTP id ho6mr3408348ejc.197.1635614518830;
        Sat, 30 Oct 2021 10:21:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g8sm6025811edb.71.2021.10.30.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 10:21:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgs3J-0027IV-OL;
        Sat, 30 Oct 2021 19:21:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin: add git-default-branch command
Date:   Sat, 30 Oct 2021 19:18:26 +0200
References: <20211030140112.834650-1-thomas@t-8ch.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211030140112.834650-1-thomas@t-8ch.de>
Message-ID: <211030.86ilxe4edm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 30 2021, Thomas Wei=C3=9Fschuh wrote:

> Introduce command `default-branch` which allows to retrieve the branch
> that will be used by git-init.
>
> Currently this command is equivalent to
> 	git config init.defaultbranch || 'master'
>
> This however will break if at one point the default branch is changed as
> indicated by `default_branch_name_advice` in `refs.c`.
>
> By providing this command ahead of time users of git can make their
> code forward-compatible.

Recently there was a discussion on a similar topic, i.e. to have git
explicitly aware of "default config" as far as "git config -l" etc. go:

    https://lore.kernel.org/git/87czvoowg2.fsf@evledraar.gmail.com/

I'd much rather see as add this as some mode of git-config, even if it's
a new --get-or-git-default switch:

    git config --get-or-git-default init.defaultBranch

That would just currently die if you fed it any other value than
init.defaultBranch, i.e. that (or similar) would be a generic enough
interface that we could expand on it.

Whereas having a new-built in just for this one config variable...

> +test_expect_success 'without configuration' '
> +	b=3D$(git default-branch) &&
> +	verbose test "$b" =3D master
> +'
> +
> +test_expect_success 'with configuration' '
> +	git config init.defaultbranch foo &&
> +	b=3D$(git default-branch) &&
> +	echo $b &&
> +	verbose test "$b" =3D foo
> +'
> +

Should lose the echo, and these comparisons should be using test_cmp,
also use "test_config" not "git config" unless in a sub-repo or similar.
