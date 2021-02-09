Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC8C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D37F64EE0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBIVoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:44:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58615 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhBIVDs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 16:03:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A640124D02;
        Tue,  9 Feb 2021 16:02:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t7sQ/bUTYm1fBR+LNA8ycqS9v8M=; b=JpE67Z
        cA6vnu14/age7u3ae6gAefL91TyyN45or0GPvUo/eLOl7lcfliEPev0V2yQhU1Tg
        MrR5hhSMiX1+PlUDPmXJvi8ZoLgf3fRI7Dxkcy+kq/2xsPCmEdt82j9xEufwcTue
        H2/i5ck4DXRhEsrXRsX9mPMqNd4pvDRQs6sn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0Ala3h1TR8Lk/7724YHTFX5RQEM1XqL
        1HBXtwXp/dlikzkIjOxSj8XVw8/jD+z7zRBY8GBFJ/jjKt9kwFdzcZAUzMZWyAmc
        7EdNtG3IpidshLGxw1/IUbFGytBl+tdjErt6XNgpS0Wik+iBdTuRj9R/FdSH9Omw
        ltwk2GGi+R8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82B19124D01;
        Tue,  9 Feb 2021 16:02:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC34B124D00;
        Tue,  9 Feb 2021 16:02:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH v2] config: improve error message for boolean config
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
        <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
        <YCK9iRyQGTl+5J4g@coredump.intra.peff.net>
Date:   Tue, 09 Feb 2021 13:02:18 -0800
In-Reply-To: <YCK9iRyQGTl+5J4g@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 9 Feb 2021 11:51:21 -0500")
Message-ID: <xmqqczx90xb9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 190CBF3A-6B1A-11EB-B54D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 09, 2021 at 01:25:08AM +0000, Andrew Klotz via GitGitGadget wrote:
>
>> Currently invalid boolean config values return messages about 'bad
>> numeric', which is slightly misleading when the error was due to a
>> boolean value. We can improve the developer experience by returning a
>> boolean error message when we know the value is neither a bool text or
>> int.
>
> Thanks for keeping at this. The goal makes sense. The implementation
> looks OK to me, but I had a few really tiny comments.
>
>> before with an invalid boolean value of `non-boolean`, its unclear what
>> numeric is referring to:
>> ```
>> fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
>> ```
>> 
>> now the error message mentions `non-boolean` is a bad boolean value:
>> ```
>> fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
>> ```
>
> Our commit messages aren't generally formatted as markdown. So this
> looks a little nicer using indentation (which also happens to generate
> nice markdown output):
>
>   numeric is referring to:
>
>       fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
>
>   now the error message mentions `non-boolean` is a bad boolean value:
>
>       fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
>
> Not worth a re-roll on its own, though.
>
>> +NORETURN
>> +static void die_bad_bool(const char *name, const char *value)
>> +{
>> +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
>> +		/*
>> +		 * We explicitly *don't* use _() here since it would
>> +		 * cause an infinite loop with _() needing to call
>> +		 * use_gettext_poison().
>> +		 */
>> +		die("bad boolean config value '%s' for '%s'", value, name);
>> +	else
>> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
>> +}
>
> The duplication is ugly, but I think it's the least-bad solution (and I
> still dream that GETTEXT_POISON may one day go away :) ).
>
>> @@ -1102,8 +1116,11 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
>>  
>>  int git_config_bool(const char *name, const char *value)
>>  {
>> -	int discard;
>> -	return !!git_config_bool_or_int(name, value, &discard);
>> +	int v = git_parse_maybe_bool(value);
>> +	if (0 <= v)
>> +		return v;
>> +	else
>> +		die_bad_bool(name, value);
>
> I had to look at this a minute to be sure we always returned a value.
> But the compiler knows that die_bad_bool() doesn't return, and that we
> always take one of the two conditionals.
>
> I do think it might be easier to read as:
>
>   int v = git_parse_maybe_bool(value);
>   if (v < 0)
>           die_bad_bool(name, value);
>   return v;
>
> but I admit that's nit-picking.

Combined together with the log message formatting, they already make
it worth an updated patch.

>> diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
>> index f9fa16ad8363..b66d34c6f2bc 100755
>> --- a/t/t0205-gettext-poison.sh
>> +++ b/t/t0205-gettext-poison.sh
>> @@ -33,7 +33,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
>>  
>>  test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
>>  	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
>> -	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
>> +	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
>>  "
>
> Do we want a separate test in t1300 that doesn't rely on GETTEXT_POISON
> continuing to hang around (the idea has been thrown around elsewhere of
> it maybe going away entirely)?

Yeah, I do not think it is a good idea to add more test that depends
on GETTEXT_POISON and assumes how it works.

We certainly wish that we want to ensure more quality translation
and more complete i18n coverage, but the "pretend as if the test
passed if it tries to judge the success/failure by looking at the
output string from the command that can be translated, to ferret out
mistakenly marked machine readable string for translation", which is
what the current GETTEXT_POISON thing is, does not contribute much
to improving translation.
