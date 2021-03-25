Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F6C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 01:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807C461A16
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 01:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhCYBNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 21:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbhCYBNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 21:13:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8BC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:13:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a7so245998ejs.3
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aosmo2diEZYOlyISw/x0KCQw3D4FSlATyzTE/BT1WE0=;
        b=UsJ71Lk4F+gPyGn1OofGuTQ6Khz6mYr0MlVIboig/TBcdmEj+VDFFIwwkUeAw48CeF
         JmLYAphhwJoOYNPF7+zDESTwYOqBh8fGGyCP8zkJ5gYMh3LkWwtToiY9qVvbVVkGwYPX
         8rOl827klhTAS5gdm5pLdI+nXuHmK42PBK1zO6JV3ZL+IlilhHQtEpWQMQbCRp+slp2Y
         FNK9H340xOXxGmX0ylklJ449mlJ77SmlspBCDboSvJsRD4j0mIBMXsNNkdmepunniz5h
         fIYZA2V3RXruCDg4dV0pMEnoeDN0N/f5Fjq43b+G1zrRxqBtGX3MHK8MRxrbxthrwLYd
         jBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=aosmo2diEZYOlyISw/x0KCQw3D4FSlATyzTE/BT1WE0=;
        b=X5SYWJJldQFoWT6lgeWJpvSp6Mf50i9WEQU5WHoGRmZAsi7/KjEXVauMg6GoHIeV8+
         9n5e9H5I3UM9KzziFYl0Uw/9a7GYINubOZVX2paZDvbhx2SRH0FQrsdAp1DJEOngqSRP
         DEGe29Rnjz9QZf8fRKTLSv6jCgjHNzRmK2kw1yu5gJIUCP7VH1daBPgCN+79uhrrMKAm
         iciEEGuCBkDpdX3HYFOYBnd7rZwuAC2/8R0Db5frLYdLZ75b+qyerhJyv23aNIjaHWNn
         DuDbBzgB1OC30Sklc6ub/5EcNKuvAKLExoIcQ4Itu5EaubDzl/he8gWGbWdOldhFCAAD
         Amyw==
X-Gm-Message-State: AOAM533+01i8RHthtiG9x3iF28aM+dXMz24ARP1S1O2NLwE8FEG7lxvL
        ynNncbpJkBF9EssceiGk/dg=
X-Google-Smtp-Source: ABdhPJyrJ/WX99+uU/wKKM1KXUzPZExDzeYT8JHYFc4o/c4Qb9fthkevJZ3pDQiBsFnewjPKnyo7rw==
X-Received: by 2002:a17:907:788e:: with SMTP id ku14mr6873590ejc.17.1616634787906;
        Wed, 24 Mar 2021 18:13:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g20sm1894005edb.7.2021.03.24.18.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:13:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.c: remove last remnant of GIT_TEST_GETTEXT_POISON
References: <20210111144740.6092-3-avarab@gmail.com>
 <patch-1.1-ea968affa8c-20210324T233254Z-avarab@gmail.com>
 <YFvbE1K2tZ5ych7z@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFvbE1K2tZ5ych7z@coredump.intra.peff.net>
Date:   Thu, 25 Mar 2021 02:13:07 +0100
Message-ID: <87ft0kox24.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 25 2021, Jeff King wrote:

> On Thu, Mar 25, 2021 at 12:36:09AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Remove a use of GIT_TEST_GETTEXT_POISON added in f276e2a4694 (config:
>> improve error message for boolean config, 2021-02-11).
>>=20
>> This was simultaneously in-flight with my d162b25f956 (tests: remove
>> support for GIT_TEST_GETTEXT_POISON, 2021-01-20) which removed the
>> rest of the GIT_TEST_GETTEXT_POISON code.
>
> Yay. :)
>
>> diff --git a/config.c b/config.c
>> index 6428393a414..870d9534def 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1180,20 +1180,6 @@ static void die_bad_number(const char *name, cons=
t char *value)
>>  	}
>>  }
>>=20=20
>> -NORETURN
>> -static void die_bad_bool(const char *name, const char *value)
>> -{
>> -	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
>> -		/*
>> -		 * We explicitly *don't* use _() here since it would
>> -		 * cause an infinite loop with _() needing to call
>> -		 * use_gettext_poison().
>> -		 */
>> -		die("bad boolean config value '%s' for '%s'", value, name);
>> -	else
>> -		die(_("bad boolean config value '%s' for '%s'"), value, name);
>> -}
>> -
>>  int git_config_int(const char *name, const char *value)
>>  {
>>  	int ret;
>> @@ -1268,7 +1254,7 @@ int git_config_bool(const char *name, const char *=
value)
>>  {
>>  	int v =3D git_parse_maybe_bool(value);
>>  	if (v < 0)
>> -		die_bad_bool(name, value);
>> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
>>  	return v;
>>  }
>
> This code change looks good, but...
>
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index e0dd5d65ced..2280c2504ac 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -679,7 +679,7 @@ test_expect_success 'invalid unit boolean' '
>>  	git config commit.gpgsign "1true" &&
>>  	test_cmp_config 1true commit.gpgsign &&
>>  	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
>> -	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." =
actual
>> +	grep "bad boolean config value .1true. for .commit.gpgsign." actual
>>  '
>
> why are we losing test_i18ngrep here? The message is still marked for
> translation. I know we've discussed dropping all of the test_i18n
> helpers, but that seems unrelated to the rest of the patch.

For new tests we're suggesting not to use it, so while I'm holding off
on some general s/test_i18ngrep/grep/ refactoring, it seemed natural to
adjust the test added by the commit whose code I'm modifying.

It also shows reviewers that there is such a test, so e.g. I didn't
invert the name/value parameters or something in refactoring this.
