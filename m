Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD14C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiJZTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiJZTiy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:38:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C797678
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:38:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t25so18794546ejb.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wj427tZkLM8tYXmI29HMqqoLjQaCHnxd2o4niQjMWMU=;
        b=e9xa1upfeNxwH6vch7iuGQQuxzNntcTNcAqdcjJr+lV8f59e9t7dTtpPAEjFBsQzf9
         hGConMvO4tBsROtGHbs7wHHaVDesGV8ZypyZnWHnQ+3XC8ioAS8ovPWuOMbvKjGvAimT
         91n/LGTI+qYB04ttuoklbkidytU9bCfIJxMkK1pWT/29K7kgYI5+niVxPIIuT5GlQVWY
         JLowK4HLfkDXsBV7aN5rwmn4cwXbJqox6GRHSl799KVEKLWQsj7LDbitVdFfgEBqrxX9
         dpmatRLy38hzDCq4qmJnyF9Nst0tyEHQY1+SehVjTqXvN7tKL0JbvY3QwtGD+gdzHh6H
         +aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wj427tZkLM8tYXmI29HMqqoLjQaCHnxd2o4niQjMWMU=;
        b=laeyhdW3J8CMyUJO5r/yonBZ+PdsxEwRT69h9WZpjJBIvACk0QcH1D4n7h5MJ8vbFj
         qfNOhTSG2VoC3u9OkkQMvUw1/HrN2JQfA5lHQAireg0LbAGTHbRAO/m8zG2KX5Bdfb4i
         XREZMij4VCQkQvuEnHmGawpcWxKBAErnDXVHw5wWFFjzeSOW9+ubEPHa46hi6O+aLrqS
         Ci8M49WS7Q43OYhoBwUlgFXFyJUGH0tyB5QdCoI994xmvf3IhPEWXm1kLYYC1aqEaY5S
         OXZiDQDL9W9LXDAYbkCqKdigh33SunwMdKHUuoh5Q3a/pflW7QPXCuUK1YCCJqY5dLCt
         49/Q==
X-Gm-Message-State: ACrzQf0ObRRJ7yZbiTmVkmw7ru3ogABkLlAVoQQPM6GkqeaMCGZcqXTC
        YhdhkHchXeScsokAlpUVkB8=
X-Google-Smtp-Source: AMsMyM6wWuHHn2p8R6IV6VBF9LBRL/NAgb94Bk1s3g6kriIG6kY3DSuDXSIdwfZmA+KsfUBTkmFnkQ==
X-Received: by 2002:a17:907:980e:b0:78d:b6ea:25b3 with SMTP id ji14-20020a170907980e00b0078db6ea25b3mr38949726ejc.98.1666813132456;
        Wed, 26 Oct 2022 12:38:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906328f00b007933047f930sm3386265ejw.157.2022.10.26.12.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:38:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onmEk-008ruW-2g;
        Wed, 26 Oct 2022 21:38:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 01/10] config API: have *_multi() return an "int" and
 take a "dest"
Date:   Wed, 26 Oct 2022 21:33:34 +0200
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
 <patch-01.10-eefa253ab1f-20221026T151328Z-avarab@gmail.com>
 <20221026184915.GA1828@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221026184915.GA1828@szeder.dev>
Message-ID: <221026.86pmeebcj9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 26 2022, SZEDER G=C3=A1bor wrote:

> On Wed, Oct 26, 2022 at 05:35:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The git_configset_get_value_multi() function added in 3c8687a73ee (add
>> `config_set` API for caching config-like files, 2014-07-28) is a
>> fundamental part of of the config API, and
>> e.g. "git_config_get_value()" and others are implemented in terms of
>> it.
>>=20
>> But it has had the limitation that configset_find_element() calls
>> git_config_parse_key(), but then throws away the distinction between a
>> "ret < 1" return value from it, and return values that indicate a key
>
> Shouldn't that be "ret < 0"?

Yes, sorry, that's just a typo. It's <0 for API errors (e.g. unable to
parse your key bad key), 0 for OK, 1 for key doesn't exist.

>> doesn't exist. As a result the git_config_get_value_multi() function
>> would either return a "const struct string_list *", or NULL.
>>=20
>> By changing the *_multi() function to return an "int" for the status
>> and to write to a "const struct string_list **dest" parameter we can
>> avoid losing this information. API callers can now do:
>>=20
>> 	const struct string_list *dest;
>> 	int ret;
>>=20
>> 	ret =3D git_config_get_value_multi(key, &dest);
>> 	if (ret < 1)
>
> This catches all negative values and zero.
>
>> 		die("bad key: %s", key);
>> 	else if (ret)
>
> This catches all non-zero values.
>
>> 		; /* key does not exist */
>> 	else
>
> So how could this ever be executed?!

Yes, sorry. It's the same typo/thinko.

>> 		; /* got key, can use "dest" */
>>=20
>> A "get_knownkey_value_multi" variant is also provided, which will
>> BUG() out in the "ret < 1" case. This is useful in the cases where we
>
> Shouldn't that be "ret < 0" as well?  The condition in that "knownkey"
> variant added in this patch is:
>
>   +	ret =3D configset_find_element(cs, key, &e);
>   +	if (ret < 0 && knownkey)
>   +		BUG("*_get_knownkey_*() only accepts known-good (hardcoded) keys, bu=
t '%s' is bad!", key);

Yes, FWIW the code isn't incorrect in this regard, I just screwed up the
commit message, sorry.

The canonical example that isn't tricky is in builtin/for-each-repo.c, i.e.:

        err =3D repo_config_get_value_multi_string(the_repository, config_k=
ey, &values);
        if (err < 0)
                usage_msg_optf(_("got bad config --config=3D%s"),
                               for_each_repo_usage, options, config_key);
        else if (err)
                return 0;

I.e. it wants to ignore non-existing config ("else if"), but now we
distinguish that from errors. The *_multi() API on master doesn't allow
for that.
