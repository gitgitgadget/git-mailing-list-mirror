Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045CC6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiI0NtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiI0NtS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:49:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF09122616
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:49:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sd10so20872409ejc.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=/Ho825XsT4rTxUGY6TnpukCqh/eAxrYcNphCOYl0svM=;
        b=drzU3BYumDIlsFWaZuj3Wt+WJtUDCWn4vwpXmkvtknAE/vqVqZseydLepp6/Ve/wEU
         /72hFlDH5FycvVJ3S/DmcF114VteCiz/cX//hM89QCL9NmlTTxXDG7zcSoqv1kzZqeSY
         acRhPaBjifoH6SzU0qv7yQ7/JjLw+6lpM7SGx1DdrIlpzihtFR6j2Try7QUxFnpU27QI
         3phorrP3X2siXuCr4gEk4eValV0eSGf9IfJCprBdoOu6mE4rpoZv1kmBxDjuMkVzKQ/t
         r6IrkaMI88ooNATTi6wv9162snt4CMTp/uGXSlg3/ckGeq8JpfVMQjJgk7jUyZCE2c8/
         7yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/Ho825XsT4rTxUGY6TnpukCqh/eAxrYcNphCOYl0svM=;
        b=O4acvNdmW9o3t4PramNsjlkDPTEW219x9FNv+N1GQcf4JVSmv8aHLDINu82TIDc4Ux
         HeMeu/1F7kUDQMMyuznDFTPOgMx+KGJaNjvpDJkC45J66+ZCXcMo14qMoIdG3C/+nMlT
         edsymUlsWu+qEOHJOjyxwAp9Bkrhwt1LaMUIlmj+PFAx9IyAEMxXsC0a34TBmAtbm6BR
         aXvp1BhmuavQlxpO/GK8tSI5MU0mtCLnzNvNn260Ee2OJFmvQ01hxzeuXd45HLInDUUA
         CodimbPksX14WTUL0B8w5hdnJyM7EASBFhBgrJmoMH8dRXI8VS2nFlzRFQ428jz+NWyl
         In0w==
X-Gm-Message-State: ACrzQf1KOZQU5uRfjTZYO11Wc+XiF4Paz13P+o4s02ynIoUj4v+bNguW
        47YHDLUcIPV36kO/syuQJ2c=
X-Google-Smtp-Source: AMsMyM4zYt/JB43pCroMwg+Az/dKUlfAiAaLU2O+Capk8DQ5AfahrvnpEnETmv0zSdxgOiCfTCaH9Q==
X-Received: by 2002:a17:907:a47:b0:780:6883:2a37 with SMTP id be7-20020a1709070a4700b0078068832a37mr22881414ejc.219.1664286555960;
        Tue, 27 Sep 2022 06:49:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t10-20020aa7d4ca000000b004570ed2da1bsm1304819edr.38.2022.09.27.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:49:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odAxW-000NvE-1k;
        Tue, 27 Sep 2022 15:49:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
Date:   Tue, 27 Sep 2022 15:36:14 +0200
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
 <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
 <xmqqa66lby1w.fsf@gitster.g>
 <b1e6f118-046c-42f8-01a8-2543e792685a@github.com>
 <63aa68fb-c215-a79f-e3c6-1c1a489220e2@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <63aa68fb-c215-a79f-e3c6-1c1a489220e2@github.com>
Message-ID: <220927.86a66lylk5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Derrick Stolee wrote:

> On 9/27/2022 7:38 AM, Derrick Stolee wrote:
>> On 9/26/2022 5:55 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> @@ -1538,11 +1546,23 @@ static int maintenance_unregister(int argc, co=
nst char **argv, const char *prefi
>>>>  		usage_with_options(builtin_maintenance_unregister_usage,
>>>>  				   options);
>>>>=20=20
>>>> -	config_unset.git_cmd =3D 1;
>>>> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
>>>> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
>>>> +	for_each_string_list_item(item, list) {
>>>> +		if (!strcmp(maintpath, item->string)) {
>>>> +			found =3D 1;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>
>>> Just out of curiosity, I ran this in a fresh repository and got a
>>> segfault.
>>=20
>> Yikes! Thanks for catching. I think there was another instance in
>> the 'register' code that I caught by tests, but I appreciate you
>> catching this one.
>>=20
>>>  An attached patch obviously fixes it, but I am wondering
>>> if a better "fix" is to teach for_each_string_list_item() that it is
>>> perfectly reasonable to see a NULL passed to it as the list, which
>>> is a mere special case that the caller has a string list with 0
>>> items on it.
>>>
>>> Thoughts?
>>=20
>> I agree that for_each_string_list_item() could handle NULL lists
>> better, especially because it looks like a method and hides some
>> details. Plus, wrapping the for-ish loop with an if statement is
>> particularly ugly.
> ...
>> I'll get a patch put together that changes the behavior of
>> for_each_string_list_item() and adds the missing 'unregister' test
>> so we can avoid this problem.
>
> Of course, there is a reason why we don't check for NULL here,
> and it's because -Werror=3Daddress complains when we use a non-pointer
> value in the macro:
>
> string-list.h:146:28: error: the address of =E2=80=98friendly_ref_names=
=E2=80=99 will always evaluate as =E2=80=98true=E2=80=99 [-Werror=3Daddress]
>   146 |         for (item =3D (list) ? (list)->items : NULL;      \
>       |
>
> I tried searching for a way to suppress this error in a particular
> case like this (perhaps using something like an attribute?), but I
> couldn't find anything.

We discussed this exact issue just a few months ago, see:
https://lore.kernel.org/git/220614.86czfcytlz.gmgdl@evledraar.gmail.com/

In general I don't think we should be teaching
for_each_string_list_item() to handle NULL.

Instead most callers that need to deal with a "NULL" list should
probably just use a list that's never NULL. See:
https://lore.kernel.org/git/220616.86bkuswuh5.gmgdl@evledraar.gmail.com/

In this case however it seems perfectly reasonable to return a valid
pointer or NULL, and the function documents as much:
=09
	/**
	 * Finds and returns the value list, sorted in order of increasing priority
	 * for the configuration variable `key`. When the configuration variable
	 * `key` is not found, returns NULL. The caller should not free or modify
	 * the returned pointer, as it is owned by the cache.
	 */
	const struct string_list *git_config_get_value_multi(const char *key);

You also have code in 3/3 that uses that API in the correct way, I think
just adjusting this callsite in 1/3 would be the right move here.

This also gives the reader & compiler more information to e.g. eliminate
dead code. You're calling maintpath() unconditionally, but if you have
no config & the user provided --force we'll never end up using it, so we
can avoid allocating it in the first place.

