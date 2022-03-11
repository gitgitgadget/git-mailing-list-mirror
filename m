Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A35C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 13:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiCKNmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCKNmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 08:42:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27912A75F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:41:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so19184604ejc.8
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=P2p4s2Q3lI9v58qP17sNhyngMD8L8SdDaWJPtHRv2H8=;
        b=De4ehcx0S+HYZA0Yqojm3AaOpE+RjbuI//0WgRAd3qLELKmuD7X2HH/HwN6Dl5t3sm
         XxoWSErFNdUwCM1tPaWZ/JhYADHzbeWog9wN6w2g2fnQrXrMj5xTpfybCUk37QwJD2Ue
         rTQE/9YHWDGB4hIhZzNxelde2/Lpq9Z2L9hHli06NuI01wwcY+jag37Xdd1QJR/Wy2Hu
         wZa+5hV6EESKRzKgibEzV7RnxjPe8ugsDSpty6HjjJH8wnIQMGb2xCYoIYiIcT4ZX5tf
         XJJndXsSMbrIqmKk6Zc/w5zx4U16xv1OPlTKp8VJNZzx7+k9FwS2fNejEKEszXSuXPDu
         QGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=P2p4s2Q3lI9v58qP17sNhyngMD8L8SdDaWJPtHRv2H8=;
        b=N8uAsfviMGDcoozxbjPadRvPOD6lud07NFoJJO0xYV8n2gIPol3GQgf5TfBDGTk6Ml
         pjVvg89k6/lVIWmbqAC07jkqvRQ6clXcOV5T11bDPO34eEj3kA4GgzpIMs/ooGbHq4Ph
         hEiO3ZP9WuiXXnh5C02EedcqO8Sc69AbU4y0ww2+2WMstnnN/dBAgWqSoiVoq+bmAKyF
         wHrSErpJ4eD21+nDjkvq8BmjuOhojqKOcUIG81u+sME4P6GT7N97qMcdlv4LYhJ33lKW
         qYqZLqlmBkgzzX9vgjXpTgmb05xFsfcoPaXxXCxz85SP7k76NKmCUgqrW6wafHfy+Erp
         Ig7w==
X-Gm-Message-State: AOAM5337SuadQvqdoUaSiCedELALJlTqfW36serX2twRwGMfOMddRIbn
        IZKfG/j/RVkrKP0OrLlGbS//hMtOq/te1w==
X-Google-Smtp-Source: ABdhPJw75trQJEZkUnFZaMtmB+whl3hCvHjcySiaoIgLhqNCUmdcoc63BxZXao7aNoNxQHWOXRzwTg==
X-Received: by 2002:a17:906:154c:b0:6ce:21d7:2826 with SMTP id c12-20020a170906154c00b006ce21d72826mr8742413ejd.9.1647006106441;
        Fri, 11 Mar 2022 05:41:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906815800b006dab4bd985dsm2927403ejw.107.2022.03.11.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:41:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSfWb-0012j9-8R;
        Fri, 11 Mar 2022 14:41:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        aevar@gmail.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 15/25] config: add git_config_get_timestamp()
Date:   Fri, 11 Mar 2022 14:32:33 +0100
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <7ec7ba3f328f9d6fa7f919ce18a138840d44ee49.1645641063.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <7ec7ba3f328f9d6fa7f919ce18a138840d44ee49.1645641063.git.gitgitgadget@gmail.com>
Message-ID: <220311.86pmmshahy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The existing config parsing methods do not include a way to consistently
> parse timestamps across all platforms. Recall that "unsigned long" is
> 32 bits on 64-bit Windows, so git_config_get_ulong() is insufficient.

They do. I think you've just missed the slightly non-obviously-named
expiry-date type:

    $ for t in $(date +%s) 2.days.ago 1.week.ago; do echo $t = $(git -c x.y=$t config --type expiry-date --get x.y); done
    1647005519 = 1647005519
    2.days.ago = 1646832719
    1.week.ago = 1646400719

AFAICT there's no need for these methods, except perhaps as some wrapper
for the existing git_config_expiry_date(), perhaps to have a flag passed
down to only allow epochs, and not the human-readable format?

But for the TOC proposal I don't see why it wouldn't allow the
human-readable format. You can arguably shoot yourself in the foot with
2.days.ago, but you can also provide absolute times in that format.

In any case, peeling out this patch from this series to fast-track it if
you do need it sounds like a good idea, it would need the relevant bits
of the CLI UX implemented & docs added.

There's also tests that you'll find by grepping for "expiry-date" to
extend.

> RFC-QUESTION: Would this be better to use uintmax_t, which could be cast
> to timestamp_t or other types more robust than "unsigned long"?

I think it's certainly legitimate to re-visit that when we're talking
about making it part of a network format.

But I think we should just go for timestamp_t, it will break 32 bit
clients around the year 2038, but I think that probably the intersection
between clients who'll find this useful and those still using 32 bit
systems then will be pretty much zero :)

So I think the only thing we need for bundle-uri if it has a TOC with a
timestamp is to have it die/fallback properly if it can't parse the
values.

> [...]
> +		*dest = git_config_timestamp(key, value);
> +		return 0;
> +	} else
> +		return 1;

Nit: missing {}

>[...]
> --- a/config.h
> +++ b/config.h
> @@ -206,6 +206,7 @@ int config_with_options(config_fn_t fn, void *,
>  
>  int git_parse_ssize_t(const char *, ssize_t *);
>  int git_parse_ulong(const char *, unsigned long *);
> +int git_parse_timestamp(const char *, timestamp_t *);
>  
>  /**
>   * Same as `git_config_bool`, except that it returns -1 on error rather
> @@ -226,6 +227,11 @@ int64_t git_config_int64(const char *, const char *);
>   */
>  unsigned long git_config_ulong(const char *, const char *);
>  
> +/**
> + * Identical to `git_config_int`, but for (unsigned) timestamps.
> + */
> +timestamp_t git_config_timestamp(const char *name, const char *value);
> +
>  ssize_t git_config_ssize_t(const char *, const char *);
>  
>  /**
> @@ -469,6 +475,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
>  int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
>  int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
>  int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
> +int git_configset_get_timestamp(struct config_set *cs, const char *key, timestamp_t *dest);
>  int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
>  int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
>  int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
> @@ -489,6 +496,8 @@ int repo_config_get_int(struct repository *repo,
>  			const char *key, int *dest);
>  int repo_config_get_ulong(struct repository *repo,
>  			  const char *key, unsigned long *dest);
> +int repo_config_get_timestamp(struct repository *repo,
> +			      const char *key, timestamp_t *dest);
>  int repo_config_get_bool(struct repository *repo,
>  			 const char *key, int *dest);
>  int repo_config_get_bool_or_int(struct repository *repo,
> @@ -558,6 +567,11 @@ int git_config_get_int(const char *key, int *dest);
>   */
>  int git_config_get_ulong(const char *key, unsigned long *dest);
>  
> +/**
> + * Similar to `git_config_get_int` but for (unsigned) timestamps.
> + */
> +int git_config_get_timestamp(const char *key, timestamp_t *dest);
> +

Not your fault, but it's really tiresome that whenever we need to add
stuff to this API it's this mostly copy/pasting of related methods. I
had some recent-ish patches that did something similar & it was a chore
:)
