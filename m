Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E2C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 00:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhLHAUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLHAUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 19:20:47 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9721C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 16:17:16 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so529746pjl.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 16:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NIVXXRzSZfk4URMf3J8uL8VXNM2nTp+YWT8VnUm2TIw=;
        b=Pnjb0t00HvdE0x63ga485KSmrl06Zd9srmHpkYast614AeyjJosUbvT8YuqUVJt9a4
         enUfvj4TSJcv1Pw9CPnDhokPko7yFR3NIXDi4StDPMpVxU3BAqDvDHDYnvdz09Vm55Kg
         hnBQ8eB13mrySZpfnGoAeocrqzkeyaz3av8ajNdBiEaiVUymIuyh7ssLSrXmhOTdLSOn
         1tfJM+s/dIQG3HmOpmowTT6Z3hKY9MqjkKcHbT1+ymqjRjThecozHVTIxwig2YNx2gEX
         lysCReYiv1DSNs+ef7sHo9RE4R46AhWvzlN428+EF/GnAmYQnFCpMd1bs4BT3UZsXaVJ
         GqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NIVXXRzSZfk4URMf3J8uL8VXNM2nTp+YWT8VnUm2TIw=;
        b=ghotvavinRL39m3Q0dmQyTuLAE9CaE8nLKP2Fog5Zk2lE4SARBmYdBMlgyScghBwzy
         ESomnZY6yN4isp/FiU+Cd32Rwe3rMv0D7ZgU0jGEz4mfQnb4PGLzpGM/VuKmpMLvYie0
         H9KpKf7E9hrf3y+7rf6tMndH7U4CO9Wun02gLgSwfg0ZS36kL3UlsXgLvee8G8JO5VOq
         zzgXXxtbwFFIAl1wtaFjWy64RYSBw5ZEnH01lDF0j+hnSVgOjJYjSzG/EtJ06XhMu7Mi
         3lUFHZcEwNbvYWKjIpxqqfPf1ClBJfvfSpRy/2pTfWS5RQUdzn9yC+/CN2M8+IG1rNNl
         fDlA==
X-Gm-Message-State: AOAM532q4VW6dg6nz1YOZDKybcb08+ktNBIwZa8KwM0/xBtriH1ec78k
        r1dP3I9BHXKoFSH33HHa2HEpEEBj/p+5Lw==
X-Google-Smtp-Source: ABdhPJy6fF9fljoSYQT40ckCwSLXefNH4IU3b+gj4PSOufKCwX7LWOc+pONsM4u9ZCxGlZbR78JCqVrx5qSJEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8645:b0:142:8c0d:3f4a with SMTP
 id y5-20020a170902864500b001428c0d3f4amr54490979plt.3.1638922636413; Tue, 07
 Dec 2021 16:17:16 -0800 (PST)
Date:   Tue, 07 Dec 2021 16:17:14 -0800
In-Reply-To: <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Message-Id: <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local,=
 const char *origin, const
> =20
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	/*
> +	 * We want to overwrite any existing config with all the branches in
> +	 * "remotes". Override any existing config with the first branch, but i=
f
> +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> +	 * we've written so far.
> +	 */
> +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
>  		goto out_err;
> +	for (i =3D 1; i < remotes->nr; i++)
> +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, =
CONFIG_REGEX_NONE, 0) < 0)
> +			goto out_err;

I think that instead of overriding all config with the first value and
then appending every value after that, it'll be more obvious to readers
if we first unset all of the config, then write every value (then the
comment wouldn't have to justify why we make two calls and iteration
starts at 1).

I believe that unsetting all values for a key is supported by
git_config_set_multivar_gently() with value =3D=3D NULL, i.e.

  /*
   * unset with value =3D NULL, not sure how this interacts with
   * CONFIG_REGEX_NONE
   */
  if (git_config_set_multivar_gently(key.buf, NULL,
    CONFIG_REGEX_NONE, 0))
    goto out_err;

  for_each_string_list_item(item, remotes) {
    git_config_set_multivar_gently(key.buf, item, CONFIG_REGEX_NONE, 0);
  }

> @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *loc=
al, const char *origin, const
>  	advise(_(tracking_advice),
>  	       origin ? origin : "",
>  	       origin ? "/" : "",
> -	       shortname ? shortname : remote);
> +	       remotes->items[0].string);
> =20
>  	return -1;
>  }

When there is more than one item in remotes->items, this advice is
_technically_ incorrect because --set-upstream-to only takes a single
upstream branch. I think that supporting multiple upstreams in
--set-upstream-to is a fairly niche use case and is out of scope of this
series, so let's not pursue that option.

Another option would be to replace the mention of --set-upstream-to with
"git config add", but that's unfriendly to the >90% of the user
population that doesn't want multiple merge entries.

If we leave the advice as-is, even though it is misleading, a user who
is sophisticated enough to set up multiple merge entries should also
know that --set-upstream-to won't solve their problems, and would
probably be able to fix their problems by mucking around with
.git/config or git config.

So I think it is ok to not change the advice and to only mention the
first merge item. However, it might be worth marking this as NEEDSWORK
so that subsequent readers of this file understand that this advice is
overly-simplistic and might be worth fixing.

> =20
> +int install_branch_config(int flag, const char *local, const char *origi=
n, const char *remote) {
> +	struct string_list remotes =3D STRING_LIST_INIT_DUP;
> +	string_list_append(&remotes, remote);
> +	return install_branch_config_multiple_remotes(flag, local, origin, &rem=
otes);
> +	string_list_clear(&remotes, 0);
> +}

string_list_clear() is being called after `return`.

=C3=86var and Junio have commented on i18n, but I'm unfamiliar with that, s=
o
I won't comment on that :)
