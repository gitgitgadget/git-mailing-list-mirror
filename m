Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE9AC43381
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2700207BC
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbhADPPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 10:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbhADPPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 10:15:04 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E1C061794
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 07:14:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t16so7662102ejf.13
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gBZLt1jMIEqSK8Fcrqk/pgC+aD79Z2y3FC6V4fQ0Lg4=;
        b=SS0zN6KZlk9UzPMJ84zYZ5jLtXzkM70enuR6xMKYzjSS/OsyVYMHOUKN/i2KJfX4a2
         epuDPojMq1GXmq5lV1A3qqzcMrotoJLX5pk93Or+AuvlrkDOnrZrRXqItsN4WhKvRML5
         0uEk4RlVyl2iUN0JvOadT+baMyoRvTkMRkR86wB4LuT6nwnpM5hSIloC/BblpmLB3+cQ
         pBr5rfZ8Pmu78Cjrv1H6nAuqRl5AOiVm9zvIQ67GZMXYNu78V1ipPMIhIiFcWYI0BPME
         4O8hYl+vX9A8hL/a1dcCW9h/+n2ClXuiELepFbdLag10hEY3GebYh+mrxEBeOIAcFYEm
         t+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gBZLt1jMIEqSK8Fcrqk/pgC+aD79Z2y3FC6V4fQ0Lg4=;
        b=gOr02D8J5baVUpkqnBNboN19RIT5Fy6qsFayWOKdeTfjS3Ig7gr/IOXY1PB3Ib9D/y
         aY6KBboBEAHdO66kPw91Uhzw6nssafCBLeJXcaQu3FLn/WJkvgtE5iAeuDMH29BS4C05
         YPcdBIASVjzuSYevoCgeuROB0y+Ge15+yG4EVFknMOXJEwObWzkVbaZQiZIyukVBjdfy
         QqbbAXYLhZiGHps26ZuAVfG0wKBpof5VjzIN5xuIfbFfkStN6lNUhN18rSweMDk2fPfe
         E8TbWPvFhEC8lklj1YTPCJI1xh1vCgTJ48bHbTOjMLSPkrH5g29otboOaw0jAvCYf4Bl
         24IA==
X-Gm-Message-State: AOAM532jyGUqy256nDlQ+7Tg5WWmHdNPKL0+jO470UdG1t744+vsVjBo
        98cl+MRE9iulxa6Hl0HNBcI=
X-Google-Smtp-Source: ABdhPJyGMlmaYg2jNl+svRw6r8xBYAqO3KnTvdgqL4sJgX1jtbNDPWFJX5wigqSqusic2ZjdPjjFLg==
X-Received: by 2002:a17:906:4a4f:: with SMTP id a15mr69118394ejv.541.1609773262182;
        Mon, 04 Jan 2021 07:14:22 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id p3sm11748384edh.50.2021.01.04.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:14:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/5] mailmap: add a function to inspect the number of
 entries
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210103211849.2691287-2-sandals@crustytoothpaste.net>
Date:   Mon, 04 Jan 2021 16:14:20 +0100
Message-ID: <87im8cvinn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 03 2021, brian m. carlson wrote:

> We're soon going to change the type of our mailmap into an opaque struct
> so we can add features and improve performance.  When we do so, it won't
> be possible for users to inspect its internals to determine how many
> items are present, so let's introduce a function that lets users inquire
> how many objects are in the mailmap and use it where we want this
> information.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  mailmap.c | 5 +++++
>  mailmap.h | 1 +
>  pretty.c  | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mailmap.c b/mailmap.c
> index 962fd86d6d..c9a538f4e2 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -361,3 +361,8 @@ int map_user(struct string_list *map,
>  	debug_mm("map_user:  --\n");
>  	return 0;
>  }
> +
> +int mailmap_entries(struct string_list *map)

We're returning ->nr here from string_list, whose "nr" is unsigned
int. Wouldn't it make more sense to do the same here?...

> +{
> +	return map->nr;
> +}
> diff --git a/mailmap.h b/mailmap.h
> index d0e65646cb..ff57b05a15 100644
> --- a/mailmap.h
> +++ b/mailmap.h
> @@ -5,6 +5,7 @@ struct string_list;
>  
>  int read_mailmap(struct string_list *map, char **repo_abbrev);
>  void clear_mailmap(struct string_list *map);
> +int mailmap_entries(struct string_list *map);
>  
>  int map_user(struct string_list *map,
>  			 const char **email, size_t *emaillen, const char **name, size_t *namelen);
> diff --git a/pretty.c b/pretty.c
> index 7a7708a0ea..43a0039870 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -681,7 +681,7 @@ static int mailmap_name(const char **email, size_t *email_len,
>  		mail_map = xcalloc(1, sizeof(*mail_map));
>  		read_mailmap(mail_map, NULL);
>  	}
> -	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
> +	return mailmap_entries(mail_map) && map_user(mail_map, email, email_len, name, name_len);

...and isn't this introducing a bug where the number of entries is
beyond "signed int" but not "unsigned int" by overflowing?

Bikeshedding: For both hashmap and strmap we have a
{hashmap,strmap}_get_size() function. I think a "static inline unsigned
int mailmap_get_size()" here would be more consistent & obvious.

>  }
>  
>  static size_t format_person_part(struct strbuf *sb, char part,

