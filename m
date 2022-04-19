Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A3C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357810AbiDSU4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiDSU4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 16:56:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602084160E
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 13:53:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so35406955ejn.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bV30f/FO3ihrKK7o7iqkrmrfdTbiiFoJunMWtBTZj1E=;
        b=edvzZM/sbMy80ypQFfzkRT+tnBi2lbuLyGtWzgGS0+bqXkUoANoI7zW1xdZXWPvNGl
         s9aiYjvu7EztqQfsEUBPiaOYvv4xcK54Gvjg7wZCuORdFZwwhEmcUBF58Va/lm9LnIlK
         k/gnUDIyBXx0O6Ftcv1s/jivko3teExbhplr4+RPJ52xunC5LLcfu9BnCMLvdhxmtCjU
         uV5I4Kswt5xOSlBIP4mVeisHk8g6xYaLS3mmwtb8tYkJqfs9J5+y+ENcc7vKjy8lxqCO
         RJLh3yqYvB0zdGRPjpXrRKL18iWKIi7nQQhKvT/q2aFCerNoNM1b3jrDw+EhDM6loA7F
         BFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bV30f/FO3ihrKK7o7iqkrmrfdTbiiFoJunMWtBTZj1E=;
        b=ojNJ4hiG8GgJb3nXfvzZVMr0BUNMNUO8cXRUZoPAIqDAjq2xsQDhbNF7F3ryOaHqO+
         gB4ru8bY5JqoZ1XzAPP2T9jlVbJadaylBaH8Tl6EPi/pQErfdbQXS9WbqT4tlTnnXe6u
         E4Ovi9HI/veGWL3BEzY57GRRMBnyymNZif84k1gS8DYPJfQ6ijpwwTJng+ftN6j/gssa
         3eiasM8aZ+5xvvLdMUjlifBIjnI+Quc0jj6uTG75HuEYgeqYPN+GAmMZwmS9rnKmKgHc
         ulw4lfiiwAGV2aPBfnVtCqrCTKBZrUz5U9Eq94ICRE4Tjjgeq/3LjnyKcCdsofOKCApF
         ZiIA==
X-Gm-Message-State: AOAM530NVpecxWjrCOgfjHYlXBMeT1a0Ko3PAEneH0PNGnP0ofy8l667
        QuPk3Cs1/yyOLx0Sdp/ftBRwlTPB95c=
X-Google-Smtp-Source: ABdhPJx10okAYJxlbpKJeoNwTJ7GhlVqxxLOWSXIDXWt/j+QYax1T9EMxHCcWcmvPL4WR9fRHoZUTg==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id ht19-20020a170907609300b006e0dabf1a9fmr15289555ejc.424.1650401615434;
        Tue, 19 Apr 2022 13:53:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906938f00b006e8afb5a7d9sm5960509ejx.33.2022.04.19.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:53:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nguqs-0074Qx-KK;
        Tue, 19 Apr 2022 22:53:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory David <gregory.david@p1sec.com>
Cc:     git@vger.kernel.org, ptm-dev <ptm-dev@p1sec.com>
Subject: Re: [PATCH] show-branch: fix SEGFAULT when `--current` and
 `--reflog` together
Date:   Tue, 19 Apr 2022 22:49:19 +0200
References: <a36fd2b0-0573-b93e-a765-ce57a651934e@p1sec.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <a36fd2b0-0573-b93e-a765-ce57a651934e@p1sec.com>
Message-ID: <220419.86ee1s94mp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 19 2022, Gregory David wrote:

> If run `show-branch` with `--current` and `--reflog` simultaneously, a
> SEGFAULT appears.
>
> The bug is that we read over the end of the `reflog_msg` array after
> having `append_one_rev()` for the current branch without supplying a
> convenient message to it.
>
> It seems that it has been introduced in:
> Commit 1aa68d6735 (show-branch: --current includes the current branch.,
> 2006-01-11)
>
> Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
> Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/show-branch.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index e12c5e80e3..892241ce0d 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -812,6 +812,26 @@ int cmd_show_branch(int ac, const char **av, const
> char *prefix)
>  		}

Hi. Thanks for sticking with this.

First, your patch is corrupt, I think because your mailer is wrapping it
for you. The Documentation/SubmittingPatches has some advice on how to
use "git format-patch/send-email" directly.

It would be great to have a test case for the existing segfault, is it
sometihng you think you could add to t/t3202-show-branch.sh?

>  		if (!has_head) {
>  			const char *name =3D head;
> +			struct object_id oid;
> +			char *ref;
> +			unsigned int flags =3D 0;
> +			char *log_msg;
> +			char *end_log_msg;
> +			timestamp_t timestamp;
> +			int tz;
> +
> +			if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
> +				die(_("no such ref %s"), *av);
> +			if(read_ref_at(get_main_ref_store(the_repository),

Please use the usual coding style & one in that file, e.g. "if (" not
"if(".=20

> +					ref, flags, 0, i, &oid, &log_msg,
> +					&timestamp, &tz, NULL)) {
> +				end_log_msg =3D strchr(log_msg, '\n');
> +				if (end_log_msg)
> +					*end_log_msg =3D '\0';
> +			}

Most of this code is copied from a few lines above where we do much the
same for another case, I wonder if it's worth it to combine the two into
a helper.

> +			if(log_msg =3D=3D 0 || *log_msg =3D=3D '\0')

if (!log_msg || !*log_msg) instead, but I see some of this is using a
pattern copied from above...

> +				log_msg =3D xstrfmt("(none)");
> +			reflog_msg[ref_name_cnt] =3D xstrfmt("(%s) (current) %s",
> show_date(timestamp, tz, DATE_MODE(RELATIVE)), log_msg);


This code already leaks memory, but we can avoid this case easily by
making that "(none)" part of the second xstrfmt()'s argument list
(i.e. as a ternary).

>  			skip_prefix(name, "refs/heads/", &name);
>  			append_one_rev(name);
>  		}

