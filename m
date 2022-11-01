Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCCBECAAA1
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 14:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKAOCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKAOCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 10:02:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6301A396
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 07:02:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n12so37147350eja.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yHN/xbeuwUIUhdjSdfXIB76ZxZ9ltXeeaqb0a2IWO3c=;
        b=JgUYe6s/nHQKtsLgnJPfv8JCVoj6aUqKn51VtLFI7AzuFah5kiZAQEsnMVOwpm6o+q
         ixAMcGSqBUdTD7ivaH08FgqdEMrWh+HGOTNnxAvTv5gqN5td/2iRaMDc7GQnRclIrZPm
         xOUe5r5BjC4cKXzUbVWTnuy3AFfZ/S5tkeAW6FZGAFP9ExDLzo7IBCrDxBdt1bf+fK6G
         w2+cA7cibKlSzqRgU9jmVSBov8TuQEgrdz2Zv7fR7n/ZMu4dQUQHxZZpmZ2R8rIUBxKZ
         8uQCzLns7KzIfCbv3K0eDG61wdCCAJsFm6/g6zIMbKwLor0eI7jiYd35CTsFGumSLG2V
         dnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHN/xbeuwUIUhdjSdfXIB76ZxZ9ltXeeaqb0a2IWO3c=;
        b=ptIP9+uRZz7ULhr/8ypmamClYRiB4k+4vvBz00rRI6Jme3Ub3Wt857ryU/UcZ2Fp9q
         iZ6G/67Vc96J9JCMr91v0MkyGrB0RT1KZxQj0w0LbfMxQ4vUoOJjupEAg0UoygI+A9h0
         HzknX6NbqAEoFkk0YvF4leBkY8LMy28D8ifqd+cEXKWZninbTHX8qx+elhS3jjwit1Y8
         pKKTVtQd/PW8sOP9Hc9T1OyEANzq4L/hgMvVk6InIJ5uYgdzwJGs0xmxusmWraNLAdtC
         Y85SgGTo5n4O5+9+GLBs47dB1aRsXF1omB6c9X1oe8vEt8BDEH41nXVDk/xVHbB279gr
         t5Dw==
X-Gm-Message-State: ACrzQf0IAigcci9OOtLC0EVIr+AJz/cmDxsfYLxyfjI6Jo2a04ZfMLWb
        SDAQkFcMQSZ5qWiuYixfKRQ=
X-Google-Smtp-Source: AMsMyM7GIjHJUQ5X2p2nVdVIw9CmyOWxuhJ1lQBoQ6elE5a72Y1UOvvCc68cC1zfGdrIuAmn+Pl++A==
X-Received: by 2002:a17:906:444d:b0:7ad:eb7f:8697 with SMTP id i13-20020a170906444d00b007adeb7f8697mr3615181ejp.770.1667311370429;
        Tue, 01 Nov 2022 07:02:50 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id la10-20020a170907780a00b0079dbf06d558sm4172302ejc.184.2022.11.01.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:02:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oprqq-00BKy9-1y;
        Tue, 01 Nov 2022 15:02:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Date:   Tue, 01 Nov 2022 14:07:39 +0100
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
        <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
        <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
        <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
Message-ID: <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Jeff King wrote:

> On Mon, Oct 31, 2022 at 10:32:36PM -0400, Jeff King wrote:
>
>> On Mon, Oct 31, 2022 at 09:47:08PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>=20
>> >  * When we invoke e.g. "git-remote-https" (aka. "git-remote-curl")
>> >    from "git fetch". For those cases let's pass down the equivalent of=
 a
>> >    "-c transfer.credentialsInUrl=3Dallow", since we know that we've al=
ready
>> >    inspected our remotes in the parent process.
>> >=20
>> >    See 7390f05a3c6 (fetch: after refetch, encourage auto gc repacking,
>> >    2022-03-28) for prior use of git_config_push_parameter() for this
>> >    purpose, i.e. to push config parameters before invoking a
>> >    sub-process.
>>=20
>> So I guess I don't have any _specific_ thing that goes wrong with this
>> approach, but it really feels sketchy to me. We are lying to
>> sub-processes about the config the user asked for. And again, I see how
>> it works, but I wonder if this kind of approach would ever backfire on
>> us. For example, if transfer.credentialsInUrl=3Dwarn ever ended up having
>> any side effects besides the warning, and the sub-processes ended up
>> skipping those effects.
>>=20
>> I know that's a hypothetical, and probably not even a likely one, but it
>> just gets my spider sense tingling.
>
> So inherently this is going to be ugly because it's crossing process
> boundaries. But the more minimal fix I was thinking of would be
> something like this:
>
> diff --git a/remote.c b/remote.c
> index 60869beebe..af5f95c719 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -615,6 +615,14 @@ const char *remote_ref_for_branch(struct branch *bra=
nch, int for_push)
>  	return NULL;
>  }
>=20=20
> +static int test_and_set_env(const char *var)
> +{
> +	int ret =3D git_env_bool(var, 0);
> +	if (!ret)
> +		setenv(var, "1", 0);
> +	return ret;
> +}
> +
>  static void validate_remote_url(struct remote *remote)
>  {
>  	int i;
> @@ -634,6 +642,9 @@ static void validate_remote_url(struct remote *remote)
>  	else
>  		die(_("unrecognized value transfer.credentialsInUrl: '%s'"), value);
>=20=20
> +	if (test_and_set_env("GIT_CHECKED_CREDENTIALS_IN_URL"))
> +		return;
> +
>  	for (i =3D 0; i < remote->url_nr; i++) {
>  		struct url_info url_info =3D { 0 };
>=20=20
>
> You can also put it lower in the function, when we actually warn, which
> saves adding to the environment when there is nothing to warn about
> (though this way, we avoid doing the redundant work).
>
> Compared to munging the config, this seems shorter and simpler, and
> there's no chance of us ever getting confused between the fake
> "suppress" value and something the user actually asked for.

Sure, we can do it with an environment variable, in the end that's all
git_config_push_parameter() is doing too. It's just setting things in
"GIT_CONFIG_PARAMETERS".

And yes, we can set this in the low-level function instead of with
git_config_push_parameter() in builtin/*.c as I did. I was aiming for
something demonstrably narrow, at the cost of some verbosity.

But I don't get how other things being equal you think sticking this in
"GIT_CHECKED_CREDENTIALS_IN_URL" instead of "GIT_CONFIG_PARAMETERS"
helps.

We already pass config to ourselves like that (and via "-c") in other
places. Can you think of a case where these would be different?

The only ones I can think of are e.g. because we know about
"GIT_CONFIG_PARAMETERS", and not this new custom variable, e.g. in
"prepare_other_repo_env()", but those seem like exactly the reason to
use the existing variable.

I can think of potential pitfalls here, e.g. how does it interact with
submodules? That's one reason I submitted it as an RFC, the tests need
to be better (with or without this change). E.g. "git ls-remote" is also
not covered by the upthread patch.

But that's all separate from what the environment variable is named, or
if it lives in the config space.
