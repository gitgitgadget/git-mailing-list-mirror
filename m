Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765AC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbiDCOso (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiDCOsm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:48:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062339B85
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:46:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bh17so15061391ejb.8
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OA2T3DoNQLCcVK8MrcJzo1iWvdrgc5FsT1A2Tlx+qCw=;
        b=OyME7buVc1l+XVzjqpEaKW2B/4ASqkh/HmqbYlYLVEyczEDaiFa/eG01HnlcupVgRj
         giayTO3VWPu/ewZeFuoU/culfoW4DNDV1FNkY868G9qgLQe1TQj68GGaYxK8HJzgVYat
         JkWpV197qLUIir3UJ3Fut4crFdkFj8Dcru2svvDGhWuL+V2byjNE+iC0SpxbIdUrj8bQ
         82KFHFQB63VxvVuHcmOSXDudie5GY0AcMp6/HzIRoBtEUJLiBQYrUMrCmCW7Osb2vBtM
         CEJHXBpOVClBZL/FngRCnW1hlpJS3VdLgZYrKwoeOuZ5yfspOPOcdhML2XGMpkNQiy1Z
         /u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OA2T3DoNQLCcVK8MrcJzo1iWvdrgc5FsT1A2Tlx+qCw=;
        b=cfZEC47rZNsq4INsDio4ZxjVLR2S06y47/rDQdSM7rmk2HpJiJ8y6TOKB0rTczlYw2
         dPSltJ1fMlue9mV0igLIqEgQ0DSnvljieW2MvZhxHG/OZps/rn64Z90h5WouFm4Kh5Kt
         7xetQe/Q0xC4gNGYlxf7f/cJEzXUphd4FHpZZZuuTjx2Jer75A5H7B+o6PRPH+9FxBGP
         hRD7VScTcMlAwfzFx87t2C465HDk4bYdsiXyC9MmoIPMWHoesVbOdISMPq/ujmVixr2u
         icYNhNBoe0RRkGauOeH4u5ybUbMVMPX2PmhpSGy0eQIpQItYqa6etIMhPe/6CMA80VDU
         h7zg==
X-Gm-Message-State: AOAM5332hQYnPmw0jg844iPdlB2hZquHppRFfHE5Z3kAJC2yTqX+4KVI
        8ux40x9eC3k+C3L9WljpuS56p1/cijI=
X-Google-Smtp-Source: ABdhPJwKTM2PEGG3G8ff1g2LlECPAb82nCF+Wabq5TXkd7r4atMSSmt8Fw798t0zH9ei7dKsarOSbQ==
X-Received: by 2002:a17:906:dc8e:b0:6e7:1713:5de9 with SMTP id cs14-20020a170906dc8e00b006e717135de9mr4419687ejc.71.1648997206626;
        Sun, 03 Apr 2022 07:46:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l11-20020a509dcb000000b0041cbaf0ce2asm1750373edk.6.2022.04.03.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:46:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb1V7-002FBU-Bp;
        Sun, 03 Apr 2022 16:46:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 6/6] i18n: factorize "bad argument" messages
Date:   Sun, 03 Apr 2022 16:41:39 +0200
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
 <febe64a8a069dd81523c33a93cfea9553e40c283.1648915853.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <febe64a8a069dd81523c33a93cfea9553e40c283.1648915853.git.gitgitgadget@gmail.com>
Message-ID: <220403.86o81ikywa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 02 2022, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> We also quote the placeholders as they replace constant strings.

I don't think this change is good in that it takes two different cases
we cared about distinguishing before, and squashes them into one. I.e.:

> +++ b/builtin/bisect--helper.c
> @@ -268,7 +268,7 @@ static int bisect_write(const char *state, const char=
 *rev,
>  	} else if (one_of(state, terms->term_good, "skip", NULL)) {
>  		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
>  	} else {
> -		res =3D error(_("Bad bisect_write argument: %s"), state);
> +		res =3D error(_("bad '%s' argument: '%s'"), "bisect_write", state);
>  		goto finish;
>  	}

I think these should all say "bad value provided for '%s' argument:
'%s'", or similar, or maybe the terse version is better. Just a
suggestion.

> diff --git a/builtin/config.c b/builtin/config.c
> index e7b88a9c08d..2ac36e4f641 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -106,7 +106,7 @@ static int option_parse_type(const struct option *opt=
, const char *arg,
>  		else if (!strcmp(arg, "color"))
>  			new_type =3D TYPE_COLOR;
>  		else
> -			die(_("unrecognized --type argument, %s"), arg);
> +			die(_("bad '%s' argument: '%s'"), "--type", arg);
>  	}

I thought some of these were introducing logic errors, because we were
conflating unrecognized arguments with bad values, but these all seem to
actually mean "bad value", not "unknown flag".

> diff --git a/grep.c b/grep.c
> index 82eb7da1022..6aabfc58bb3 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -43,7 +43,7 @@ static int parse_pattern_type_arg(const char *opt, cons=
t char *arg)
>  		return GREP_PATTERN_TYPE_FIXED;
>  	else if (!strcmp(arg, "perl"))
>  		return GREP_PATTERN_TYPE_PCRE;
> -	die("bad %s argument: %s", opt, arg);
> +	die("bad '%s' argument: '%s'", opt, arg);
>  }

This and many other changes that follow have nothing to do with i18n.

I think it's a worthwhile cleanup to mark some of these for _(), but
shouldn't that come first, or at least after?
