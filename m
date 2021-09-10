Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23ACC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01BA61167
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhIJTmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJTmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 15:42:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64D5C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 12:41:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y23so1279533edi.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oo/3iOgG83vInvQvSntRchXJFX/4qvWP+WPQ7x2y1iI=;
        b=MTrLYdmB0RRd/0H9zhifsWHd7KOOk/mHKA9hDA70K/ZpCLHgGDAvVdJLiXLbf/NzOG
         uOGGlCvNqoZcxafFvNlHTKQOknW801SDKHCln7ffkBvtkwYVEDtWJHZc58OVeJVy0FJ9
         bt6+vWfF5Co+v4cgaQxGEqcT7mXs5t3i4bp1Bs6/F4HVyJcEgkC/Aj3nW1Svd8YFLVvA
         QqKTUaXfkAhz4YXCHVbKUsX4jzjYqxIJU6+F+v6+KDOPowUMzCy0Jk2pi0AUpMuGbqVc
         X6M71mXOAHTEeWdDL+V4Q4CfzTvlqfnh9EdSh8FhyRVkQl5WmdjwLfSb3fSizpsRbQ/X
         8HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oo/3iOgG83vInvQvSntRchXJFX/4qvWP+WPQ7x2y1iI=;
        b=1noBar3GyVu1Fmnp3VwVmnZihpBLxdISUnHgGyJsDi4Y2hGS7EX713kaN2OBwmyvPn
         5B4JbxwBrfYGtUq0CJJV/URkqoBQydcT9GoSJpqeSSyTGUhK6U+nBTHlaB6lvIq22dUB
         mVUFjnccvQwZe+vRWMBpilNPRrNsuLZuazJfQ5Eg/h5EJxN8OkUDwvzX610jEpzyndoW
         gK7O1ezeOriS7dG1GdBhxpLj7GSq5auZj6Fq8lA4XjPw5VXcrV+LCb8bCK2TsO25kJeP
         azksAH81W8JYi6eqGR/kzm9DsMOFe0DK1L0l8hYlDgXLdQvHCkATwdqy5AKO8ul6rStO
         1PWg==
X-Gm-Message-State: AOAM531CvtkSJAB3FHEh8rbV7ckb0tO7aCG5rBPmUevuNypbYgI8vqVG
        dJnRKMSiaCfCsDjYSD7F/RA=
X-Google-Smtp-Source: ABdhPJxM9Wx2+c8V0f8Zl0PZglyIYl9faVxKfL61E1We/N4eNNYeyj5snjSBdw2tRXrpBqyRt8OYZw==
X-Received: by 2002:a05:6402:5:: with SMTP id d5mr10817762edu.359.1631302889384;
        Fri, 10 Sep 2021 12:41:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l23sm3320372eds.29.2021.09.10.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:41:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-tool run-command: fix confusing init pattern
Date:   Fri, 10 Sep 2021 21:32:03 +0200
References: <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>
 <patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2109101319110.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109101319110.59@tvgsbejvaqbjf.bet>
Message-ID: <87pmtgb4m1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> the commit title is misleading: it suggests that there is a bug that needs
> to be fixed.

I picked "confusing" because this doesn't impact the end-state of the
program, it's just confusing to do:

    x =3D -1

Followed by:

    x =3D 0

Which the reader might wonder about, only to find that the initial
assignment wasn't needed or used for anything.

> The idea of the patch, however, is to avoid redundant code, and if
> described that way, the patch is a lot better for it.
>
> On Thu, 9 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> In be5d88e1128 (test-tool run-command: learn to run (parts of) the
>> testsuite, 2019-10-04) an init pattern was added that would use
>> TESTSUITE_INIT, but then promptly memset() everything back to 0. We'd
>> then set the "dup" on the two string lists. Our setting of "next" to
>> "-1" thus did nothing, we'd reset it to "0" before using it.
>>
>> Let's just use the init macro for the STRING_LIST members, we can then
>> remove the already redundant memset().
>>
>> Note that while we compile this code, there's no in-tree user for the
>> "testsuite" target being modified here anymore, see the discussion at
>> and around <nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet>[1].
>>
>> 1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbe=
jvaqbjf.bet/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> This patch is the immediate reason for why I submitted
>> https://lore.kernel.org/git/patch-1.1-d1e464da0a9-20210906T002938Z-avara=
b@gmail.com/,
>> since Johannes would prefer to keep it let's fix this init pattern.
>
> The diff does too many things, some of which are your purely personal
> preferences and do not actually need to be changed. This is a much more
> to-the-point diff:

We've been slowly converting everything to designated initializers. It
seems to make sense to just do that if the line is being touched anyway.

For instance my d385784f89b (fsck.h: use designed initializers for
FSCK_OPTIONS_{DEFAULT,STRICT}, 2021-03-28) was part of a series whose
initial version just changed one field at a time as you're doing below,
but during early review I was asked just to use designated initializers
already.

But yes, it is strictly unrelated. It's a judgement call when to do
cleanups on lines you touch while you're at it, v.s. turning one patch
into a potential series of really tiny changes.

Then there's the change of "struct foo x, y" to "struct foo x;\nstruct
foo y;\n" above. I changed that because that tends to be the usual
style, it also preempts feedback / reviewers having to look at the code
out-of-bounds to see what the struct looks like in the default diff
-U<n>.

So, in advance addressing another type of question, or needing to
describe the context, as you brought up in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091222260.59@tvgsbejvaqbj=
f.bet/
:)


> -- snip --
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 7ae03dc7123..14c57365e76 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -61,7 +61,7 @@ struct testsuite {
>  	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
>  };
>  #define TESTSUITE_INIT \
> -	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
> +	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0 }
>
>  static int next_test(struct child_process *cp, struct strbuf *err, void =
*cb,
>  		     void **task_cb)
> @@ -142,9 +142,6 @@ static int testsuite(int argc, const char **argv)
>  		OPT_END()
>  	};
>
> -	memset(&suite, 0, sizeof(suite));
> -	suite.tests.strdup_strings =3D suite.failed.strdup_strings =3D 1;
> -
>  	argc =3D parse_options(argc, argv, NULL, options,
>  			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> -- snap --
>
> I would strongly suggest to use this diff instead.
>
> Ciao,
> Johannes
>
>
>>
>>  t/helper/test-run-command.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
>> index 7ae03dc7123..8e42516bdc1 100644
>> --- a/t/helper/test-run-command.c
>> +++ b/t/helper/test-run-command.c
>> @@ -56,12 +56,15 @@ static int task_finished(int result,
>>  }
>>
>>  struct testsuite {
>> -	struct string_list tests, failed;
>> +	struct string_list tests;
>> +	struct string_list failed;
>>  	int next;
>>  	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
>>  };
>> -#define TESTSUITE_INIT \
>> -	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
>> +#define TESTSUITE_INIT { \
>> +	.tests =3D STRING_LIST_INIT_DUP, \
>> +	.failed =3D STRING_LIST_INIT_DUP, \
>> +}
>>
>>  static int next_test(struct child_process *cp, struct strbuf *err, void=
 *cb,
>>  		     void **task_cb)
>> @@ -142,9 +145,6 @@ static int testsuite(int argc, const char **argv)
>>  		OPT_END()
>>  	};
>>
>> -	memset(&suite, 0, sizeof(suite));
>> -	suite.tests.strdup_strings =3D suite.failed.strdup_strings =3D 1;
>> -
>>  	argc =3D parse_options(argc, argv, NULL, options,
>>  			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>>
>> --
>> 2.33.0.867.g88ec4638586
>>
>>

