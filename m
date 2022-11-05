Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2152CC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 14:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKEOWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKEOWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 10:22:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF347CE1C
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 07:22:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v27so11414354eda.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Zmq/d6FkLzI2TCUYrSZeXjRPqHBgr++myh4Kz+/rlE=;
        b=WSbXTpeD0AE6KlrANKItslH7cZJEsWXnXG3HYRS1ycNj1+NhV1NUHjY3N9q8gWe+js
         KC1ICFse5l1b+lxZERi4caar5LjKusHp5H9SpxOGfsLHkuWYbi+CdfmY/eQ5vgkGJ/hX
         V2iz+7CHx+qNmQ6kSHIyLBM3LQ2r9g3ZG7ZY7kK+uAhetpYonIphh7wVNxciUAOEwnde
         U3jAnC74yIyCyDKT6J9GgeM2KVPgN8+bewGxVYQ77kNs9qzJLCrkpKpjn+oub3GePddk
         bBvr+8HiDPkpJ6Mr6HqKn/UCvCcVlcRrJUg5+vfBcENkJNJl6BMVUZQhqviCnZpP9gFy
         /sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Zmq/d6FkLzI2TCUYrSZeXjRPqHBgr++myh4Kz+/rlE=;
        b=JEoM+Zhn5lLIUP1le7vak37lRE+7MBQ/dgDbqeQ62z9KTKSAAlQOoD6A1qpyNBzcCy
         rGCt8yWWAnfGcd1X0W+ala9vly3itDb7bVNJX0vDcvr6QStYlM12Q/XqWmNZWcCpNZUa
         rb5IqJ07za3ySf7N2zJXboSMGkxB6VKDdXtYD5eYm8FtRIXiI+P4RrFiVIJZ4qsZsfx1
         XjpW6mDp4C5suFJpmFnxW+prDvEzcYVWpsiiW1dUK+9knc/kQ00ZY52IARgusG/5nibJ
         O8xsab9NhngaLjnKyk2bVyzMrMHYeyiPhM/7yxZ3TTDXirQ6eb1xzuD0lka6tS23p5/3
         Ba0A==
X-Gm-Message-State: ACrzQf0DYenyHQ/xCrMrJ0tv18YeQT2RzzYJXlmdaouX6vdMJkGcxvQ+
        ay4vjgyA6P2vhSZl34IU/r0=
X-Google-Smtp-Source: AMsMyM7fuRvWCrMSZSCH/0vATQaf5gy+kySByM0xZ85WLI+f++ZYOnUOFFZLNXc1XjLlCUMyg4sfmw==
X-Received: by 2002:a05:6402:2813:b0:461:e7bc:560a with SMTP id h19-20020a056402281300b00461e7bc560amr41154474ede.340.1667658104304;
        Sat, 05 Nov 2022 07:21:44 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b0078e0973d1f5sm998729ejk.0.2022.11.05.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:21:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orK3L-000Qdw-09;
        Sat, 05 Nov 2022 15:21:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy?= =?utf-8?B?4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict
 OPT_SUBCOMMAND() to one *_fn type
Date:   Sat, 05 Nov 2022 14:52:59 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
Message-ID: <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 05 2022, Ren=C3=A9 Scharfe wrote:

> Am 04.11.22 um 14:22 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> When the OPT_SUBCOMMAND() API was implemented in [1] it did so by
>> adding a new "subcommand_fn" member to "struct option", rather than
>> allowing the user of the API to pick the type of the function.
>>
>> An advantage of mandating that "parse_opt_subcommand_fn" must be used
>> is that we'll get type checking for the function we're passing in, a
>> disadvantage is that we can't convert e.g. "builtin/bisect--helper.c"
>> easily to it, as its callbacks need their own argument.
>>
>> Let's generalize this interface, while leaving in place a small hack
>> to give the existing API users their type safety. We assign to
>> "typecheck_subcommand_fn", but don't subsequently use it for
>> anything. Instead we use the "defval" and "value" members.
>>
>> A subsequent commit will add a OPT_SUBCOMMAND() variant where the
>> "callback" isn't our default "parse_options_pick_subcommand" (and that
>> caller won't be able to use the type checking).
>>
>> 1. fa83cc834da (parse-options: add support for parsing subcommands,
>>    2022-08-19)
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  parse-options.c |  9 ++++++---
>>  parse-options.h | 25 +++++++++++++++++++++----
>>  2 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/parse-options.c b/parse-options.c
>> index a1ec932f0f9..1d9e46c9dc7 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -427,7 +427,8 @@ static enum parse_opt_result parse_subcommand(const =
char *arg,
>>  	for (; options->type !=3D OPTION_END; options++)
>>  		if (options->type =3D=3D OPTION_SUBCOMMAND &&
>>  		    !strcmp(options->long_name, arg)) {
>> -			*(parse_opt_subcommand_fn **)options->value =3D options->subcommand_=
fn;
>> +			if (options->callback(options, arg, 0))
>> +				BUG("OPT_SUBCOMMAND callback returning non-zero");
>>  			return PARSE_OPT_SUBCOMMAND;
>>  		}
>>
>> @@ -506,8 +507,10 @@ static void parse_options_check(const struct option=
 *opts)
>>  			       "That case is not supported yet.");
>>  			break;
>>  		case OPTION_SUBCOMMAND:
>> -			if (!opts->value || !opts->subcommand_fn)
>> -				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand func=
tion");
>> +			if (!opts->value || !opts->callback)
>> +				optbug(opts, "OPTION_SUBCOMMAND needs a value and a callback functi=
on");
>> +			if (opts->ll_callback)
>> +				optbug(opts, "OPTION_SUBCOMMAND uses callback, not ll_callback");
>>  			if (!subcommand_value)
>>  				subcommand_value =3D opts->value;
>>  			else if (subcommand_value !=3D opts->value)
>> diff --git a/parse-options.h b/parse-options.h
>> index b6ef86e0d15..61e3016c3fc 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -128,19 +128,24 @@ typedef int parse_opt_subcommand_fn(int argc, cons=
t char **argv,
>>   *			 the option takes optional argument.
>>   *
>>   * `callback`::
>> - *   pointer to the callback to use for OPTION_CALLBACK
>> + *   pointer to the callback to use for OPTION_CALLBACK and OPTION_SUBC=
OMMAND.
>>   *
>>   * `defval`::
>>   *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
>>   *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value =
when met.
>> + *   OPTION_SUBCOMMAND stores the pointer the function selected for
>> + *   the subcommand.
>> + *
>>   *   CALLBACKS can use it like they want.
>>   *
>>   * `ll_callback`::
>>   *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
>>   *
>>   * `subcommand_fn`::
>> - *   pointer to a function to use for OPTION_SUBCOMMAND.
>> - *   It will be put in value when the subcommand is given on the comman=
d line.
>> + *   pointer to the callback used with OPT_SUBCOMMAND() and
>> + *   OPT_SUBCOMMAND_F(). Internally we store the same value in
>> + *   `defval`. This is only here to give the OPT_SUBCOMMAND{,_F}()
>> + *   common case type safety.
>>   */
>>  struct option {
>>  	enum parse_opt_type type;
>> @@ -217,12 +222,24 @@ struct option {
>>  #define OPT_ALIAS(s, l, source_long_name) \
>>  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
>>
>> +static inline int parse_options_pick_subcommand_cb(const struct option =
*option,
>> +						   const char *arg UNUSED,
>> +						   int unset UNUSED)
>> +{
>> +	parse_opt_subcommand_fn *fn =3D (parse_opt_subcommand_fn *)option->def=
val;
>> +	*(parse_opt_subcommand_fn **)option->value =3D fn;
>
> ->defval is of type intptr_t and ->value is a void pointer.  The result
> of converting a void pointer value to an intptr_t and back is a void
> pointer equal to the original pointer if I read 6.3.2.3 (Pointers,
> paragraphs 5 and 6) and 7.18.1.4 (Integer types capable of holding
> object pointers) in C99 correctly.
>
> 6.3.2.3 paragraph 8 says that casting between function pointers of
> different type is OK and you can get your original function pointer
> back and use it in a call if you convert it back to the right type.
>
> Casting between a function pointer and an object pointer is undefined,
> though.  They don't have to be of the same size, so a function pointer
> doesn't have to fit into an intptr_t.  I wouldn't be surprised if CHERI
> (https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/) was an actual
> example of that.

I should have called this out explicitly. I think you're right as far as
what you're summarizing goes.

To elaborate on it, paragraph 8 of 6.3.2.3 says:

	A pointer to a function of one type may be converted to a
	pointer to a function of another type and back again; the result
	shall compare equal to the original pointer. If a converted
	pointer is used to call a function whose type is not compatible
	with the pointed-to type, the behavior is undefined.

And 7.18.1.4 says, when discussing (among other things) "intptr_t"
("[such" added for clarity:

	[...]any valid [such] pointer to void can be converted to this
	type, then converted back to pointer to void, and the result
	will compare equal to the original pointer:

But as you point out that doesn't say anything about whether a pointer
to a function is a "valid .. pointer to void".

I think that's an "unportable" extension covered in "J.5 Common
extensions", specifically "J.5.7 Function pointer casts":

	A pointer to an object or to void may be cast to a pointer to a
	function, allowing data to be invoked as a function

Thus, since the standard already establishes that valid "void *" and
"intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
gap between the two saying a function pointer can be converted to
either.

Now, I may be missing something here, but I was under the impression
that "intptr_t" wasn't special in any way here, and that any casting of
a function pointer to either it or a "void *" was what was made portable
by "J.5.7". We're only discussing "intptr_t" here, so it's just a point
of clarification.

Anyway, like ssize_t and a few other things this is extended upon and
made standard by POSIX. I.e. we're basically talking about whether this
passes:

	assert(sizeof(void (*)(void)) =3D=3D sizeof(void*))

And per POSIX
(https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlsym.html):

	Note that conversion from a void * pointer to a function pointer
	as in:

		fptr =3D (int (*)(int))dlsym(handle, "my_function");

	is not defined by the ISO C standard. This standard requires
	this conversion to work correctly on conforming implementations.

So I think aside from other concerns this should be safe to use, as
real-world data backing that up we've had a intptr_t converted to a
function pointer since v2.35.0: 5cb28270a1f (pack-objects: lazily set up
"struct rev_info", don't leak, 2022-03-28).

> Why is this trickery needed?  Above you write that callbacks in
> builtin/bisect--helper.c can't use subcommand_fn because they need
> their own argument.  Can we extend subcommand_fn or use a global
> variable to pass that extra thing instead?  The latter may be ugly, but
> at least it's valid C..

Yeah, there's ways around it. Less uglier in this case would probably be
to just have the callback set a function pointer in your own custom
struct (which we'd point to with "defval).

I.e. if our callabck is the one to populate the "fn" even without J.5.7
there's no portability issue, and that's just a convenience.

>> +	return 0;
>> +}
>> +
>>  #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
>>  	.type =3D OPTION_SUBCOMMAND, \
>>  	.long_name =3D (l), \
>>  	.value =3D (v), \
>>  	.flags =3D (f), \
>> -	.subcommand_fn =3D (fn) }
>> +	.defval =3D (intptr_t)(fn), \
>> +	.subcommand_fn =3D (fn), \
>> +	.callback =3D parse_options_pick_subcommand_cb, \
>
> Getting the address of an inline function feels weird, but the compiler
> is free to emit to ignore that keyword and will provide an addressable
> function object here.

*nod*, I thought about adding this to parse-options-cb.c, but it seemed
 small enough...
