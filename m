Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72719C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 21:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJTVuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJTVus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 17:50:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F31B230A
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:50:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q18-20020aa79832000000b00562d921e30aso346542pfl.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pgs9fiX+3ljQNsLigH9SBeO1pQ+i/2x7Lu0eNgsoO5s=;
        b=lyJgYs9jokzaxNc1+sW7QL+l/wHVJez6Ob4IR0WS5tB9jyRZ2JAMUZidDBbxHi6mEz
         aKQ3578XTwKWnRdfKcqOIqOnHWZ7y5iq3oGjI8oHiskg0tnklSOxFrWHCTFKhMkaHQbf
         49pxNiARLye9tacLkAQwybo8qQdZf8HQobhLmL3lvOgqqUPnU+33/s0VG6uCtqMxc+hb
         fga+ocePIeGXsFdP1TBd0ZE0BGB8yAqJAWBnY6h7AwmZnr3SOJ04IevkVxOFBh8L0Doq
         8Mq0U3EqIyCyFKZt0zFLtwHoJZo/9rGrb7M4LRYnjXKRfJ+z6txBKICurByUhvO7wk4d
         65LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pgs9fiX+3ljQNsLigH9SBeO1pQ+i/2x7Lu0eNgsoO5s=;
        b=KLyrchxqjHg+U6kgCs+7Sa9fb6rI1AIZKrHe1uTPh29cdCEItFyjgobRzG2JmZjt5z
         amqxYEAbmJ4ojFdsdsb7Nsv3rVJARKcrbuVvnNGAz8zTX/Pr+mpvS/yCTOziu20bU1MI
         u/z5PsBYQJRV37FjDOsJAlruciDuQw6Rlnl2HbXFmUidkIQsk3L50NAn2bK4MsMfa9aE
         nWzrbZDsjiWekbaLzw0rQXiJ0PowU04yjnNLwD/1Ra/Cbf96/aOAc7227H8Ivy4FZPn2
         hpb3kmJBvvsgA0hDH9MCGiP+Bgwc1QV+E7diIoLurLit9glB4ZIxcjA/TrvMzZc3TaE6
         4BkA==
X-Gm-Message-State: ACrzQf2UaFCABeo42vJ4gHXPSD9OxFGUDJHUUKjnbtYz0GpGSaHpUenJ
        xZCM+bh9tILmABPjte8Tmfwi1RFjyPD/4g==
X-Google-Smtp-Source: AMsMyM4p7Wccm/4ir7o0lEIR+CqrWVE5sQiABKa34Jxmkqq0LJshDUCPZaLp2CJZXkDAnqMO1n+xKNaLI/iDmw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:958f:0:b0:563:6987:8b88 with SMTP id
 z15-20020aa7958f000000b0056369878b88mr15799593pfj.31.1666302646999; Thu, 20
 Oct 2022 14:50:46 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:50:45 -0700
In-Reply-To: <patch-05.10-7d9c13eb637-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-05.10-7d9c13eb637-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6lv8oexiyy.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 05/10] git-submodule.sh: dispatch "update" to helper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As noted in a preceding commit the only behavior change here should be
> the desirable change of better "-h" output, and that this
> implementation understands the "--verbose" synonym for "-v". Let's
> update the documentation to reflect the new "--verbose" synonym.

Hm, I didn't see this change in the patch.

> -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
> -		${quiet:+--quiet} \
> -		${force:+--force} \
> -		${progress:+"--progress"} \
> -		${remote:+--remote} \
> -		${recursive:+--recursive} \
> -		${init:+--init} \
> -		${nofetch:+--no-fetch} \
> -		${wt_prefix:+--prefix "$wt_prefix"} \
> -		${rebase:+--rebase} \
> -		${merge:+--merge} \
> -		${checkout:+--checkout} \
> -		${reference:+"$reference"} \
> -		${dissociate:+"--dissociate"} \
> -		${depth:+"$depth"} \
> -		${require_init:+--require-init} \
> -		${dissociate:+"--dissociate"} \
> -		$single_branch \
> -		$recommend_shallow \
> -		$jobs \
> -		$filter \
> -		-- \
> -		"$@"
> -}

[...]

> -
> -# This loop parses the command line arguments to find the
> -# subcommand name to dispatch.  Parsing of the subcommand specific
> -# options are primarily done by the subcommand implementations.
> -# Subcommand specific options such as --branch and --cached are
> -# parsed here as well, for backward compatibility.

This comment still seems relevant as of this patch.

>  while test $# !=3D 0 && test -z "$command"
>  do
> @@ -233,7 +80,8 @@ absorbgitdirs)
>  	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
>  	;;
>  update)
> -	cmd_update "$@"
> +	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
> +		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
>  	;;
>  add | foreach | init | deinit | set-branch | set-url | status | summary =
| sync)
>  	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \

I haven't read ahead to see whether this was fixed, but it looks like
the reason we couldn't combine "update" into this arms is that "update"
consumes "wt_prefix" twice.=20

There's no good reason to have "--prefix" at all actually. "git
submodule update" used to use that instead of -C, and we could have
removed it once we passed -C in 29a5e9e1ff (submodule--helper
update-clone: learn --init, 2022-03-04). That simplification got lost in
the big shell -> C conversion, but we could do it quite easily right
now, e.g.

  diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
  index d11e100301..a4f59e91c5 100644
  --- a/builtin/submodule--helper.c
  +++ b/builtin/submodule--helper.c
  @@ -2636,9 +2636,6 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
        N_("traverse submodules recursively")),
      OPT_BOOL('N', "no-fetch", &opt.nofetch,
        N_("don't fetch new objects from the remote site")),
  -		OPT_STRING(0, "prefix", &opt.prefix,
  -			   N_("path"),
  -			   N_("path into the working tree")),
      OPT_SET_INT(0, "checkout", &opt.update_default,
        N_("use the 'checkout' update strategy (default)"),
        SM_UPDATE_CHECKOUT),
  @@ -2694,6 +2691,7 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
    }

    opt.filter_options =3D &filter_options;
  +	opt.prefix =3D prefix;

    if (opt.update_default)
      opt.update_strategy.type =3D opt.update_default;
  diff --git a/git-submodule.sh b/git-submodule.sh
  index ac2f95c128..2787aaa60c 100755
  --- a/git-submodule.sh
  +++ b/git-submodule.sh
  @@ -79,11 +79,8 @@ case "$command" in
  absorbgitdirs)
    git submodule--helper "$command" --prefix "$wt_prefix" "$@"
    ;;
  -update)
  -	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
  -		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
  -	;;
  -add | foreach | init | deinit | set-branch | set-url | status | summary =
| sync)
  +
  +add | foreach | init | deinit | set-branch | set-url | status | summary =
| sync | update)
    git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
      ${quiet:+--quiet} ${cached:+--cached} "$@"
    ;;

> --=20
> 2.38.0.1091.gf9d18265e59
