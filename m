Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0BC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiHRPIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbiHRPIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:08:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C758DF6
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:08:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so2052630wrp.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=X4cD3ji5+adJzKBbQtuYjGiDx1lm836k4bVfl21Mh24=;
        b=jSl8kkLe/OFMB+tGNP0h9mdWYobgMuQMANvifGzzT3huCEKuv5m6uOTuBfvicO+LaJ
         LefqDY2TpEcxbt0lKhrXuhJzXTJCTGd7x2SHyfzEtAhLazgXsUTfaNcfOeMknI4/M12m
         7vbfrZz0kbz0nQzTb+2Tmjg16hK//xSpdxM0lDaUAVYGrrkIdQVukwMk3h56du8c3iTN
         9iKVt4C90RcuuYT88X9mjyPT10JzUDk5N7xNwirQCtLFsaHDjm3uWAHJUxsrGVnByDUr
         C2XNzhFJ+W1ZtdoA6TRW4VV5DNXEJZxnN0bJrQpcVXc0LI85LTqPdkjvU7cezaiUjIrt
         k9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=X4cD3ji5+adJzKBbQtuYjGiDx1lm836k4bVfl21Mh24=;
        b=4KCIxRHvhFODuPvNkR3JVHHOl+iD1ewPt2kZgK0HpLxcq4L5zdS+42wO5zP9bEf8on
         8b9lo1ilFF8IP+40d7xy7sdQMwkTyLkygZ+lpuBrAfPSHWWvDoIk1eoo4mVWF0h1a5B9
         z+XWeItWBQJQgjUylmwXLV2DUmdUPXJ8o0WcOjOi1y08hJnW9pbOiXFPnA3+X2+wURXo
         suk8MqiZNQMpHmc3bdMqHFX4sgucnxOsioSc98H3QWTlDaWNsrvhbxPZXN0LvI5EFtVl
         hY6fgAPeM/jvR4ieKCRew5d4lmQz8H3L491ht5i6fPosEGHGQnCnQvrJIca9SGUovGVy
         ZGIQ==
X-Gm-Message-State: ACgBeo2VtgQsGf4OSoqIrByONmugzXQ+tZIDvJvaInX7HQHmesD58zf3
        /TNlzycMzHq6DTW593zSLvs=
X-Google-Smtp-Source: AA6agR7UWyh8pSDXi8UmS6UmSJ8TOFo2Q0+BFpRMgi+VCdBOSOdXFLlSkLdIOsCY8f0x2M1O1a/Q8Q==
X-Received: by 2002:a05:6000:222:b0:225:26cf:57bd with SMTP id l2-20020a056000022200b0022526cf57bdmr1911510wrz.324.1660835308245;
        Thu, 18 Aug 2022 08:08:28 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b002252f57865asm1725586wrs.15.2022.08.18.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:08:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOh8E-000HUZ-02;
        Thu, 18 Aug 2022 17:08:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 4/4] po: adjust README to code
Date:   Thu, 18 Aug 2022 17:03:18 +0200
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
 <cover.1660828108.git.git@grubix.eu>
 <e163c87b3efc1571cb3657df6459583af92f9f2b.1660828108.git.git@grubix.eu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e163c87b3efc1571cb3657df6459583af92f9f2b.1660828108.git.git@grubix.eu>
Message-ID: <220818.86r11d8u8m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Michael J Gruber wrote:

> When we talk about sequencer action names as such (as opposed to command
> names) we do translate the action name. Adjust the po README to reflect
> this and to match the code base.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  po/README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/README.md b/po/README.md
> index 3e4f897d93..90b8455401 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -273,7 +273,7 @@ General advice:
>  
>    ```c
>    /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -  die(_("%s: Unable to write new index file"), action_name(opts));
> +  die(_("%s: Unable to write new index file"), _(action_name(opts)));
>    ```
>  
>  We provide wrappers for C, Shell and Perl programs. Here's how they're

Is the end-state of this series such that we do that anywhere? Perhaps
that's OK for an isolated fix, but it would really be preferred to avoid
the "lego" with:

	die(action == REVERT ? _("revert: Unable to write new index file") : ...);

Or whatever.

The "TRANSLATORS" comment above the example you're modifying is now
inaccurate, the "%s" will *not* be "revert" or "cherry-pick" in the
post-image.

I think the right thing here would be to grep our source for TRANSLATORS
comments that mention %s and replace this existing example with an
entirely different one...
