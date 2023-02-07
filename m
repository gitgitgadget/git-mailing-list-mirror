Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5979AC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 10:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjBGKtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjBGKtE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 05:49:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3E1C321
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 02:48:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr8so42000848ejc.12
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AQK9K082mnvbdzpNQ2j/3VVXyMKRd7+az1XfeZaGdeY=;
        b=gOHZA2+dKB9F/9CZwQ5oCPxt6RhKnG+tkKkKc1h3y287o493CNAhHPJnfuFrEzFL20
         g22yFEYf9XlmQtLkV+Y43gsI/bFA2guLdrCLbcHsDj1P4qMtQzPx9oraLmyFIGm2J30m
         uCoHprF7tJTqeED/Usg9mFllbfquiNRqk4sS7Dr3lnWEySZI1BQqd01QMIMks6e8cOCn
         m0+2qF+mFxysomNaFNmQVB7ai1B2pM6/PsfsComNT9pCvrjPTCeLGXpMHOBMuSRcm71f
         jvIVaZMMhRnjJcYpTda4ge00n5ZsicnCnrCCK837K+9O5Ffq0u3ftwgP/texbx/HdgHk
         sq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQK9K082mnvbdzpNQ2j/3VVXyMKRd7+az1XfeZaGdeY=;
        b=QM/UGHixmG9nqUk5xECOxSd7jWu5seQUCkbbZ12FpCFazeMMAdP5RnNT/g/SHJPrGh
         +QzmAdzcRd9GmcZ+2YWWlrxmW1+qFuLjEHtOWvm2Hfawb6sKNdD5uWqifXiByoy9aZei
         n2U5/DJ0ahBPq6Kmy/PTw2X4S1Cdrv5Zol5DSo60UqSXHwqtMgubSWnhooEGSSXsOUPw
         IkOmmYygbnKo3dyqHyBTifQkBG6hYYFo9hmJyh6IiOYPjuMhe38z5TBl+qr52ICxJGww
         JBK+Kv0J8Y5H4+kaNtLFuq3SHm/FVBOzSkqZ9uXJxCJ/tCL9QZv1VTttmlMzKVeYUzPh
         y5jQ==
X-Gm-Message-State: AO0yUKWehLbTXaMHZgaCE74bcJSL1lSrelejLjUBTa82HiFuK/IwjhKL
        U7sQlNC8itA7XSlRUXhCilc=
X-Google-Smtp-Source: AK7set86kOLIRZbFuBQGtkoIo75jm7BuxGUhL10owIAt0v7RqIOjlNioAUKEnAutTEor226ArFRQLA==
X-Received: by 2002:a17:907:1612:b0:82e:a57b:cc9b with SMTP id hb18-20020a170907161200b0082ea57bcc9bmr3880055ejc.24.1675766920788;
        Tue, 07 Feb 2023 02:48:40 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id qh18-20020a170906ecb200b008784bc1dd05sm6740295ejb.76.2023.02.07.02.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:48:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPLWh-000i74-1J;
        Tue, 07 Feb 2023 11:48:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v4 3/9] config API: add and use a "git_config_get()"
 family of functions
Date:   Tue, 07 Feb 2023 11:29:15 +0100
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
 <xmqqv8kjpqoe.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqv8kjpqoe.fsf@gitster.g>
Message-ID: <230207.865ycd4upk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> We already have the basic "git_config_get_value()" function and its
>> "repo_*" and "configset" siblings to get a given "key" and assign the
>> last key found to a provided "value".
>>
>> But some callers don't care about that value, but just want to use the
>> return value of the "get_value()" function to check whether the key
>> exist (or another non-zero return value).
>>
>> The immediate motivation for this is that a subsequent commit will
>> need to change all callers of the "*_get_value_multi()" family of
>> functions. In two cases here we (ab)used it to check whether we had
>> any values for the given key, but didn't care about the return value.
>
> So, the idea is that=20
>
> 	if (!git_config_get_string(key, &discard))
> 		free(discard);
> 	else
> 		... the key is missing ...
>
> becomes
>
> 	if (git_config_get(key))
> 		... the key is missing ...
>
> In other words, git_config_get() returns 0 only when the key is
> used, and non-zero return signals that the key is not used?
>
> Similarly, get_value_multi() was an interface to get to the
> value_list associated to the given key, and was abused like
>
> 	if (git_config_get_value_multi(key))
> 		... the key exists ...
>
> which will become
>
> 	if (!git_config_get(key))
> 		... the key exists ...
>
> right?

Yes, I've amended this in a re-roll to add tests to the configset tests,
so how the new API should be used becomes obvious.

>> @@ -3185,7 +3184,7 @@ static void configure_added_submodule(struct add_d=
ata *add_data)
>>  	 * is_submodule_active(), since that function needs to find
>>  	 * out the value of "submodule.active" again anyway.
>>  	 */
>> -	if (!git_config_get_string_tmp("submodule.active", &val)) {
>> +	if (!git_config_get("submodule.active")) {
>
> string_tmp() variant is to retrieve borrowed value, and it returns 0
> when there is a value.  If it is a valueless true, we get -1 back
> with an error message.  What does the updated version do in the
> valueless true case?

No, we'll get back 0, as a value-less key exists.=20

This sort of code would be correct in general, as if we really want to
check if the key exists a value-less is a valid boolean true.

In this case we happen to segfault later on if we encounter such a key,
but that's unrelated to this being correct.

The segfault is then fixed later in this topic.

>> @@ -2425,8 +2433,25 @@ int git_configset_get_value(struct config_set *cs=
, const char *key, const char *
>>=20=20
>>  const struct string_list *git_configset_get_value_multi(struct config_s=
et *cs, const char *key)
>>  {
>> -	struct config_set_element *e =3D configset_find_element(cs, key);
>> -	return e ? &e->value_list : NULL;
>> +	struct config_set_element *e;
>> +
>> +	if (configset_find_element(cs, key, &e))
>> +		return NULL;
>> +	else if (!e)
>> +		return NULL;
>> +	return &e->value_list;
>> +}
>
> OK.  !e means "we got a healthy key and peeking into the hash table,
> there wasn't any entry for the key", and that is reported with NULL.
> Do we evern return a string list with .nr =3D=3D 0, I wonder.  Having to
> deal with such a list would make the caller's job more complex, but
> perhaps we are not allowing the code to shrink value_list.nr to
> avoid such a situation?

No, we never return a list with .nr =3D=3D 0. That's why Stolee's earlier
RFC tried to solve a subset of the problem this topic addresse by
returning such a list as a way to indicate "does not exist".

That would work to an extent, but would leave the main problem (which
Stolee wasn't aware of at the time) of having a ".nr > 0" list with
"NULL" elements in it.

It also wouldn't be idiomatic with the rest of the API, as this topic
shows, and means you can't distinguish non-existence from other errors.

>> +int git_configset_get(struct config_set *cs, const char *key)
>> +{
>> +	struct config_set_element *e;
>> +	int ret;
>> +
>> +	if ((ret =3D configset_find_element(cs, key, &e)))
>> +		return ret;
>> +	else if (!e)
>> +		return 1;
>> +	return 0;
>>  }
>
> OK.  So 0 return from the function means there is a value (or more)
> for a given key.  Good.
>
>> diff --git a/config.h b/config.h
>> index ef9eade6414..04c5e594015 100644
>> --- a/config.h
>> +++ b/config.h
>> @@ -471,9 +471,12 @@ void git_configset_clear(struct config_set *cs);
>>=20=20
>>  /*
>>   * These functions return 1 if not found, and 0 if found, leaving the f=
ound
>> - * value in the 'dest' pointer.
>> + * value in the 'dest' pointer (if any).
>>   */
>
> Now the returned non-zero values are no longer 1 alone, no?
> Whatever lower-level functions use to signal an error is propagated
> up with the
>
> 	if ((ret =3D func())
> 		return ret;

That's still mostly true, but I should have added the new
git_configset_get() below this comment, and split it up, i.e. it's still
true for the functions that populate "dest".

I have a topic-on-top to fix those (to propagate them up), and it was
hard to know where to draw the line, in this case I got it wrong. Will
fix it.
