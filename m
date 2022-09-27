Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA8EC6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 17:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiI0Rc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiI0RcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 13:32:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439E1C4592
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 10:32:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r18so22155061eja.11
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=aA/BXeNrObzV6Nogq7B2SDHpkZd4W7bx9cQtDS5IDfg=;
        b=jbKlacoVnRUjc2hyd8ncMfirkKAgEfT3tIBBwftVXO8XjCkVI77ThnMKvqTfuQTK+D
         616V2d/LhpJMusWGtz8xv/z8gqiT3YqFl6RmWdhRXJZbs1FfpFK2ImBjbxaHbFPzYDj0
         uCuCEuYYiU2yqlEw7KIjTab8pcrW5fb0+98V7sR8d8oocLiQHGs9LKzqd9fGBZ2L3Sqo
         v4Vf0xyDATX94Ly2AYOwJIP/C617oL9ECsB8ib4e0ia+WdoVImXVWNV5y0BQcXOIFbjS
         wx4WtJX74tXFPVr9dsxTF7skvwiF05r/wTbZWJwyRfLtP3DigYiSH6XfEJ8IQZ1nSE9M
         FO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aA/BXeNrObzV6Nogq7B2SDHpkZd4W7bx9cQtDS5IDfg=;
        b=3fBOgsUP0iXRgA8In1G70MoG07wR5WWhdJveJ4NtOnh654GVDl1WaADOPnttk2kRpv
         FiAVmTKBggQ+XrKzNCATbVNoD9gt3RzDegmr0iBGxOtAt8XIHacUZJkQfmAlDUWF8i9A
         Tlyl3AotgUhil8f/O7tpLVrpGzoweu/R5DzkSDL6YLvcH3+potsqiP9+kXmkUN5DV3DJ
         FrydKxyXb0msTCi6jIr4fVfIK9fyOGAELdzAQvlx9rkruC/IgrUHCTrVvaY4N1Al4irm
         X/ilTSdpvICCGcZjiBYOdYbKwbeqPPrzEXjoiC79F1DJ75FqG3tKDcbN95yCLTTplHk2
         xUhA==
X-Gm-Message-State: ACrzQf1U2dicxMwSjrVBfKFeNqVzZ/SYdAN1a17PslMOV0pmIjxecTcK
        ODPwMZc8XtJNs3vbpyFRMM0nz8phiEY=
X-Google-Smtp-Source: AMsMyM7uPIe7Cu/p7pGjKjvA+iiz34/Nh9NYNucsEGm72hgUz0dKaDdXRG8KY/Or/SRUCv4DgcPIzw==
X-Received: by 2002:a17:907:a067:b0:77b:9672:3f83 with SMTP id ia7-20020a170907a06700b0077b96723f83mr23138683ejc.523.1664299935939;
        Tue, 27 Sep 2022 10:32:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n4-20020a1709065e0400b007822196378asm1116911eju.176.2022.09.27.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:32:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odERK-000TkZ-2Y;
        Tue, 27 Sep 2022 19:32:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] config: add BUG() statement instead of possible
 segfault
Date:   Tue, 27 Sep 2022 19:22:46 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <f277a7a429db8f54fa06dd1965d62ec491e6d84b.1664287711.git.gitgitgadget@gmail.com>
 <220927.86wn9oyejm.gmgdl@evledraar.gmail.com>
 <4d0cf1a7-0902-af0e-93b0-ad6727bf6c2c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4d0cf1a7-0902-af0e-93b0-ad6727bf6c2c@github.com>
Message-ID: <220927.86o7v0yb8h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Derrick Stolee wrote:

> On 9/27/2022 12:17 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> The git_die_config() method calls git_config_get_value_multi() but
>>> immediately navigates to its first value without checking if the result
>>> is NULL or empty. Callers should only call git_die_config() if there is
>>> at least one value for the given 'key', but such a mistaken use might
>>> slip through. It would be better to show a BUG() statement than a
>>> possible segfault.
>=20=20
>> AFAIKT the intent of the current code on "master" is that this will only
>> get called if the likes of git_configset_get_string() returns < 0, not
>> if it returns > 0.
>>=20
>> So isn't the combination of your 1/5 and this 3/5 now conflating these
>> two conditions? See e.g. repo_config_get_string_tmp() and when it would
>> call git_die_config().
>>=20
>> I.e. isn't the whole point of git_die_config() to print an error message
>> about a configuration *value* that we've parsed out of the config?
>>=20
>> If e.g. the key itself is bad we'll get a -1, but in this case it seems
>> we would have a BUG(), but it's not that we "expected a non-empty list
>> of values", but that the state of the world changed between our previous
>> configset invocation, no?
>
> If git_die_config() was static to config.c, then I would agree with you
> that its use is controlled enough to avoid that possibility. However, it
> is available in config.h and its doc comment does not say anything about
> "make sure 'key' properly parses at least one value".

It does, it's part of the configset API, which any non-trivial user
understands adhares to the semantics of the configset cache.

E.g. the fast-import.c caller is doing, basically:

	if (!git_config_get_int("pack.indexversion", &indexversion_value))
		/* ...if we're not happy with indexversion_value ...*/
		git_die_config("pack.indexversion", ...);

Anyway, I'm all for adding some extra paranoia with a BUG(), it was just
unclear to me if this was some segfault we were expecting to perhaps
have now, or with API use after this series.

AFAICT it's really neither of those, but just some side-paranoia added
while-at-it for a *different* use-case than the primary goal of this
series. I.e. one where you're looking up a key you don't know exists,
whereas git_die_config() is for a key we *know* exists, but don't like
its value.

I think it's better if we just clarify that it's supposed to be used by
that in the API docs, and if you insist on the BUG then the:

	BUG("expected a non-empty list of values");

Should really get to the point directly, and say something like:

	BUG("called with non-existing key '%s'? "
            "Call git_die_config(...) only with keys whose value you don't =
like", key);


