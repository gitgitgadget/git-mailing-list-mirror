Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E48C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiFXP3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiFXP3K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:29:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB32871C
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:29:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ge10so5416119ejb.7
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gybGBl7xyOSmv0GtH9fYn42ZgnKwt5vw+a9Hvdnr+X8=;
        b=TDBFP4aZ8W6UQpyULyJmf2xF+A2ux2vqmYXRBC6nT2q/ajQ54x71G56t6pO+buHAu7
         foQENoKlk1PZTTBVhZwcwfaIyHMUDmb8+EL7sGKBShsLTUXnVn4TGTkxFvdi87o3uzRn
         0QazQ/7le/+/BsrSL6Wmzi7Q7d9BmYDzL3DfYiYbw8wXLGQqNHB/X1uJnWZASn+SAqFP
         l1JN0SCys7xEBTNj23jNYcVeY0AT/bln50UGfBzePVE3HZyeBCUCcD9rIzledUSD1Can
         SBqxk8C8tAAU/a8N7v3Yp1/JoDmTtjGoiWNfP9+OUdtkTEQEAN+Dh8ZD3cCRdlO7m3wI
         mDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gybGBl7xyOSmv0GtH9fYn42ZgnKwt5vw+a9Hvdnr+X8=;
        b=G8zF8KKNYzOgvCe6znkFl+tkCwHKC1E4FIsZJukzSC4KtLZtIcV8VDzzElRoPdtDsE
         b/UMbi1ZUHUkRYinz9Kmf3AC1oO93FrP25Tv/2kmHh9QviEDPXr6kKgrWuyqn6oBDosI
         P+tKxk3QjOztUp0oh+QTU0ewHkuUXyzIK0ufXvTv+VwewT3eqnZS8JO5YrU8gBXRZFWV
         N4Ih2gcaUuvrb2yBT4n/NajSjt1buMa+YBqPPtZg4VgornZeE3PQBBhD2CdjkpdARQe7
         Iry2deaHnl0EBbQaTLBsfm3f+y+ktg7oiuPbterqzSWti8KdHnv+Nqw5Qq4vZ2XFxQA3
         CpUA==
X-Gm-Message-State: AJIora+uMfCDofJf5OuOOVs1drv17XZv6UxMomB3Wb+0/xrKXtxg2jpx
        /b32Y2WoekOB6AfHfYtqQpVrMHr5YZCUxQ==
X-Google-Smtp-Source: AGRyM1uT1nmfcSzeHM0gNBEI43xpAfK5Oog8VC/RVXhWzaQqyB8uPUTYNq4G+oK0iCWEnL3xN0l+sQ==
X-Received: by 2002:a17:907:608f:b0:722:fcf1:d222 with SMTP id ht15-20020a170907608f00b00722fcf1d222mr10346369ejc.484.1656084547385;
        Fri, 24 Jun 2022 08:29:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a25-20020a50f0d9000000b004357f391015sm2251818edm.97.2022.06.24.08.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:29:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4lF4-001NV3-5D;
        Fri, 24 Jun 2022 17:29:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [PATCH v3 02/12] git-submodule.sh: remove unused $prefix var
 and --super-prefix
Date:   Fri, 24 Jun 2022 17:07:24 +0200
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
 <patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com>
 <kl6ltu8ci7r5.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6ltu8ci7r5.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220624.86h74ahygt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Remove the $prefix variable which isn't used anymore, and hasn't been
>> since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
>> 2022-03-15).
>>
>> Before that we'd use it to invoke "git submodule--helper" with the
>> "--recursive-prefix" option, but since b3c5f5cb048 that "git
>> submodule--helper" option is only used when it invokes itself.
>>
>> Since we haven't used it since then we haven't been passing the
>> --super-prefix option to "git submodule--helper", and can therefore
>> remove the handling of it from builtin/submodule--helper.c as well.
>>
>> Note also that the still-existing code in builtin/submodule--helper.c
>> to invoke other "git submodule--helper" processes with
>> "--super-prefix" is not passing the option to
>> "cmd_submodule__helper()", rather it's an argument to "git" itself.
>>
>> One way to verify that this is indeed dead code is to try to check out
>> b3c5f5cb048^ and apply this change to a part of the code being removed
>> here:
>>
>> 	-#define SUPPORT_SUPER_PREFIX (1<<0)
>> 	+#define SUPPORT_SUPER_PREFIX 0
>>
>> Doing that will cause t7406-submodule-update.sh to fail with errors
>> such as:
>>
>> 	-Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa73=
9807ce3521'
>> 	+Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa73980=
7ce3521'
>>
>> I.e. the removal of the --super-prefix handling broke those cases, but
>> when doing the same ad-hoc test with b3c5f5cb048 all of our tests will
>> pass, since the "--super-prefix" will now be handled by earlier by
>> "git" itself.
>
> Your finding is correct, but I just can't figure out why it is this way.
> Neither b3c5f5cb048 nor b3c5f5cb048^ make any use of "--super-prefix"
> (both use "--recursive-prefix"). And what's most puzzling to me is...
>
>> @@ -3402,15 +3399,9 @@ int cmd_submodule__helper(int argc, const char **=
argv, const char *prefix)
>>  	if (argc < 2 || !strcmp(argv[1], "-h"))
>>  		usage("git submodule--helper <command>");
>>=20=20
>> -	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> -		if (!strcmp(argv[1], commands[i].cmd)) {
>> -			if (get_super_prefix() &&
>> -			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
>> -				die(_("%s doesn't support --super-prefix"),
>> -				    commands[i].cmd);
>> +	for (i =3D 0; i < ARRAY_SIZE(commands); i++)
>> +		if (!strcmp(argv[1], commands[i].cmd))
>>  			return commands[i].fn(argc - 1, argv + 1, prefix);
>> -		}
>> -	}
>>=20=20
>>  	die(_("'%s' is not a valid submodule--helper "
>>  	      "subcommand"), argv[1]);
>
> that all we do here is die() if we see "--super-prefix" but it is not
> supported. I wouldn't expect that the printed result is different; I'd
> expect git to die(). This isn't even an issue with SUPPORT_SUPER_PREFIX
> either - if we just had:
>
> 	if (get_super_prefix())
> 		die(_("%s doesn't support --super-prefix"),
> 		    commands[i].cmd);
>
> we still see the same failure. At any rate, we don't seem to need
> "--super-prefix" any more, so I didn't look deeper into it.
>
> One thing that I noticed (while trying to replace "--recursive-prefix"
> with "--super-prefix" is that since this check checks the environment
> for the super prefix and not the CLI option, it will complain if we do
> "git --super-prefix=3Dfoo submodule unsupported-command", and e.g. t7407
> will fail if we add
>
>   -	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>   +	{"foreach", module_foreach, 0},
>
> I don't like this check but for another reason: the super prefix is set
> in a GIT_* environment variable so it gets passed to all child
> processes. So e.g. if we teach "git submodule update" to use
> "--super-prefix", we must mark module_update with SUPPORT_SUPER_PREFIX.
> But because that invokes "git submodule clone", "module_clone" must also
> be marked SUPPORT_SUPER_PREFIX.
>
> Frankly, I'm not sure why we need to check for SUPPORT_SUPER_PREFIX in
> the "git submodule--helper" subcommand. I see that it was introduced in
> 89c8626557 (submodule helper: support super prefix, 2016-12-08) as part
> of what eventually became absorbgitdirs, but I couldn't find any
> discussion of why we need this check when it was first proposed [1].
>
> I'm not 100% sure of why we need the top level check either, but as I
> understand it, it's a way of saying whether a command "supports
> submodules" or not [2]. If so, then checking whether a "git
> submodule--helper" command can recurse into submodules sounds like a
> pointless exercise.
>
> I'm still all for deleting this because it really doesn't seem useful,
> but I'd be lot more confident if someone knows why we have this to begin
> with.
>
> [1] https://lore.kernel.org/git/20161122192235.6055-1-sbeller@google.com/
> [2] https://lore.kernel.org/git/1474930003-83750-2-git-send-email-bmwill@=
google.com/

I think I figured this out. I'm right about it being unnecessary, but
the explanation in the commit message is wrong.

What threw me off the trail is that the series that included b3c5f5cb048
(submodule: move core cmd_update() logic to C, 2022-03-15) has in
intra-series regression, which is what you're seeing here.

I.e. its parent 75df9df0f81 (submodule--helper: reduce logic in
run_update_procedure(), 2022-03-15) will fail with the above "../super"
error without that local change. You won't get the failure on its
parent, c9911c9358e (submodule--helper: teach update_data more options,
2022-03-15).

I.e. 75df9df0f81 & b3c5f5cb048 should have been squashed, anyway.

The actual point *for that test* at which we could have deleted that
"define" is 29a5e9e1ffe (submodule--helper update-clone: learn --init,
2022-03-04), but other tests fail.

The actual point is this commit in this series, I'll dig some more,
sorry about sending you down the wrong path. That digression was just
about chechking if we'd passed --super-prefix, which is changed in this
same commit...

I'll dig some more and re-roll.
