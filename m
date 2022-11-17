Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6FC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiKQSPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiKQSPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 13:15:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53C7FC2D
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:15:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so7122538ejc.7
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=isiKB84kC8OR2nMEdK29MmwmSzSZNWhwWgeUOL+SOYE=;
        b=EhWpvIhFfa+WSj3XFie7mc8NkHDKJG6wOFVD5vy7mdS+wJjU3MPvOyV3QgxRJMDESC
         pNAKoAi6Adv6w2IxMtBERTmAsniAr6heFl0VwxrFOAGXQ1iWteIMNeDtT68Y0LePjFB2
         8t6aGkCF42xBUSkcFt+VbscPHgp6oMnW2DWy32ELcisf/HmhCMUdSMObJGPA2s47h1BY
         szmHStSLJS4y9pqVyD0Eip8gMtPRU9K9nwqiiGCzh/lYzC9ddh6S8EYx6DyHuz+Jgw3Q
         pTIN3c8m9XCXzEu/gpE8i2cCrY6VDnxnl9WbhFB7lARopZQrrA2HCB0DhXdp7gQtNmLq
         RW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isiKB84kC8OR2nMEdK29MmwmSzSZNWhwWgeUOL+SOYE=;
        b=qvHzqAWjcUZ9fXRNNQEZYcRDyFetHPNcM9vfEslsNOM5WYmk9aMimfsaU71vsssTVv
         JVTCq40+3HAkFRiKFgBa/CRjSYpwaSkCKzTYC85mQJ3U7tEIM2Lfu5MtBAfTTBQRgRbG
         pNIOm6pyIEbosVDBr3AA6SHmshQU84NOkivC9zbEKTiJdDNQ4N9j3HxTb7NKwH2DLV4E
         e6lD7VUvWmF11xCHYj36VP55WympL4RBw1St493yi76VduwRLO0iNxs+CJjxnp348jGg
         Kexk2cMI/18sK5YbNfys1R663rAovlwcdSYZ8cOXr3rY1M1QPzNN8nVsa+NgO4SLlIJ0
         fxvA==
X-Gm-Message-State: ANoB5pnHVbDUdUxJgDuMAPnJ2sn6G7VaZ6FHeRg4c7IT2hoeXm1uPZ/Z
        e77zkIFWtoGE6IeDOygW4qmTcE0lCiKNNg==
X-Google-Smtp-Source: AA0mqf6VBpBozX4ukalQXkFfNdJ63t0laMH0C/QA42DzT0hBLMmT5KtbGaszuRB2uwlPb8ClgF4Dsg==
X-Received: by 2002:a17:906:fca4:b0:7ae:acea:fca6 with SMTP id qw4-20020a170906fca400b007aeaceafca6mr3202121ejb.150.1668708907041;
        Thu, 17 Nov 2022 10:15:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id eq12-20020a056402298c00b00461c1804cdasm842194edb.3.2022.11.17.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:15:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovjPm-004woY-0F;
        Thu, 17 Nov 2022 19:15:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 04/10] submodule--helper: convert "foreach" to its
 own "--super-prefix"
Date:   Thu, 17 Nov 2022 19:14:54 +0100
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <patch-v2-04.10-935d8070834-20221114T100803Z-avarab@gmail.com>
 <kl6l7czxp5dd.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6l7czxp5dd.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221117.86pmdlh2hh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> As with a preceding commit to convert "absorbgitdirs", we can convert
>> "submodule--helper foreach" to use its own "--super-prefix", instead
>> of relying on the global "--super-prefix" argument to "git"
>> itself. See that earlier commit for the rationale and background.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index c4d5e029b37..989c75280af 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -396,7 +398,9 @@ static int module_foreach(int argc, const char **arg=
v, const char *prefix)
>>  	struct foreach_cb info =3D FOREACH_CB_INIT;
>>  	struct pathspec pathspec =3D { 0 };
>>  	struct module_list list =3D MODULE_LIST_INIT;
>> +	const char *super_prefix =3D NULL;
>>  	struct option module_foreach_options[] =3D {
>> +		OPT__SUPER_PREFIX(&super_prefix),
>>  		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodul=
e command")),
>>  		OPT_BOOL(0, "recursive", &info.recursive,
>>  			 N_("recurse into nested submodules")),
>> @@ -417,6 +421,7 @@ static int module_foreach(int argc, const char **arg=
v, const char *prefix)
>>  	info.argc =3D argc;
>>  	info.argv =3D argv;
>>  	info.prefix =3D prefix;
>> +	info.super_prefix =3D super_prefix;
>
> (Also applies to subsequent patches) Why don't we assign the super
> prefix directly to the struct's field? e.g.
>
> 		OPT__SUPER_PREFIX(&info.super_prefix),

Good point! I've done that consistently in my WIP re-roll.
