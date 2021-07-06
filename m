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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE9AC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F6C61C30
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhGFUNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGFUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:13:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319BDC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:11:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s15so245516edt.13
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LCiSgvJVHvtPxmC+CZhRZ5EY5cF4xAoDSYnwIAF/Vdo=;
        b=E8xxK1bZ3q25DItoaG2DJ4BEl43JkWM4GrC5W5+zDqyRJ80ZdWoUuJPZh+FOFUCb1R
         XS+9SS623AIi/zc/exShVHkYKljHMS52cF9StJ3o6TpysxNawxE/URV49wkUhIi/iQZA
         08CftMaVG4NI5uAJRx4ymqONIc7sDG8gvFqiGQLEihqXWobncYjTiPM8jOcfRQFQCB5P
         Y8kVu1xewJmb2LNfPA0cJUkaaeem8ID7i1wtKQ8WLsWRXj/uMIFZJDkyKQ0ku4XjqwlH
         5KLM/DWYpybPwGeC3EML1TNnhHkkJsUmAxRsY+jxd+bedYF0Z+OiWDBhw/9HciYttzVy
         jP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LCiSgvJVHvtPxmC+CZhRZ5EY5cF4xAoDSYnwIAF/Vdo=;
        b=m8bAdiVPzDyJhQDsMkkWi9tJae9VFi4RcQjOtIs2SGEN1TYrAF4dTCKHePdZMcc9V1
         qev5cbpBFqei6C1MHIwI+0FMiqIjZBsmKXYbh1FC2bCUdXA9FVxQEqJLVAN0i5nIfoKq
         XGqXT+VJZW4+fk8l73dKyYt9QbHTDB0YBbnOOEKtx++dGMqsArn/oL290sCXW+4WHpCz
         iq04TlxKEtNFyCn5uUMWkFQhGQP/yFv7+Ojl4Yex/kdp6vyNZxkeOUVJAwR0W/jeJH1B
         xJWTP73gY33XPR4K/r5svWXamREGDImKRV5qACqyh4GnkhnL9y9v2cGP7CNDfJh9sqwY
         DLpg==
X-Gm-Message-State: AOAM531sLd+XqvxA19Tew3pgct5rHpiWyqXwfNo45zgZnU9MyM2wrqtG
        6AMmQU3OochbZKA72mCpB5t2OiqZwEY=
X-Google-Smtp-Source: ABdhPJzxnUdMbMV97sFVkQGIpfRMezTz1By+VN2ih/qFZ6gxhjmA3futEVOukg6+nFSnyKTlUwq9lA==
X-Received: by 2002:a50:99cf:: with SMTP id n15mr25917817edb.146.1625602266998;
        Tue, 06 Jul 2021 13:11:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dd24sm512745edb.45.2021.07.06.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:11:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 05/35] fast-forward: add advice for novices
Date:   Tue, 06 Jul 2021 22:09:57 +0200
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-6-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210705123209.1808663-6-felipe.contreras@gmail.com>
Message-ID: <878s2j5hk6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Felipe Contreras wrote:

> It doesn't hurt showing it on `git merge --ff-only` too.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  advice.c        | 11 +++++++++++
>  advice.h        |  1 +
>  builtin/merge.c |  4 +++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/advice.c b/advice.c
> index 0b9c89c48a..8f068c8be9 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -326,3 +326,14 @@ void detach_advice(const char *new_name)
>  
>  	fprintf(stderr, fmt, new_name);
>  }
> +
> +void diverging_advice(void)
> +{
> +	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
> +		"\n"
> +		"\tgit merge\n"
> +		"\n"
> +		"or:\n"
> +		"\n"
> +		"\tgit rebase\n"));
> +}
> diff --git a/advice.h b/advice.h
> index bd26c385d0..6ce967c962 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -97,5 +97,6 @@ void NORETURN die_resolve_conflict(const char *me);
>  void NORETURN die_conclude_merge(void);
>  void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
>  void detach_advice(const char *new_name);
> +void diverging_advice(void);
>  
>  #endif /* ADVICE_H */
> diff --git a/builtin/merge.c b/builtin/merge.c
> index e396943d37..1836f98f82 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1625,8 +1625,10 @@ static int merge_common(int argc, const char **argv, const char *prefix,
>  		}
>  	}
>  
> -	if (fast_forward == FF_ONLY)
> +	if (fast_forward == FF_ONLY) {
> +		diverging_advice();
>  		die(_("unable to fast-forward"));
> +	}
>  
>  	if (autostash)
>  		create_autostash(the_repository,

...ah, and re my comment on the earlier patch here's where we're adding
advice.

I'd think just squash that into this, or mention in the commit message
"a later commit will add an advice() before this, where this new wording
will make more sense" or something...
