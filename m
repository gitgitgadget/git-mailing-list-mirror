Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BAC0015E
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjF1VW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjF1VWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 17:22:18 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBD268A
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:17:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-263047f46f4so189935a91.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687987071; x=1690579071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6pgR9b9lq2TmpDOrJ27sIxBh0Xpkg9iM9D0q2Cr6xs=;
        b=Om+jG7a0BHWZkD4n7zkYRcIfVHTJnjv7PBwuoZyuy8JPMSVVxzyixUA/ZHNAwKgPXc
         JIr4G7+4Vhmu4SjQNCBeiEzn2vQO5ZfIykfFWnUJ9rN1nQyIos3zod1MHpB9jpq5EDSQ
         z9UcgIJeAkL1BJXEO2U1T8B5P8uxmjFC8NnMwgfg/MlTza5euzY73/dZb4k6vN37fYZg
         jggxTW+/1kRqgz8HbK71jybUC8f0XtWBf8tEXO5RQoG4XJsyw+E6ZeaCqMnY4tucaJQq
         Ogeie/gVpOlCdfnjHD9K2c0Ul+ltgRRPPZ0LbmI2Alvu9AsE7vBolxSlGAwrjMYDcd8H
         iP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987071; x=1690579071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6pgR9b9lq2TmpDOrJ27sIxBh0Xpkg9iM9D0q2Cr6xs=;
        b=GTgAUAVCaVeofA0aF5YV327Pfz6OHcS6DmV5/cZPMnD2n5fmUTRlZjuamD9OQ7r/dB
         Phkb7suWeqtOI/hK7and7a5MNZSbj484RgZXwFxLPgnJ17ajpaB5HDeHnRemZbLXFiSQ
         tEDfDBQFenT5WcNgOdTnGiToJmgVRDnCseDpgXmyyt6BdUTfv5UzfyV3+LrI0HoL+b7M
         u/z3M5qlL4Co0vV3p1IsEQVM//8n/lf4f6qkoM3oWP3ZUmQ7krTDVK3qbavgj7A1/Ao2
         6L2GKvPLl0STjXFKKPn9fcd/XrpbmuPrIHU1JfAM9N+j26z9KtKUI0XjNHfzF9EEyNYW
         6yfg==
X-Gm-Message-State: AC+VfDwByEEDzppGigGlljwilwHqghUVtgADJ/gM87vR/5MbpLDFiCr9
        VOift2/atxB4mPBteNiJ3pDqQhq9mKA=
X-Google-Smtp-Source: ACHHUZ783PUr9/ENkAR2x0yTJVK5dqfaIE8ZNICEz1pD2qCBJ1TRWVavIEJIwRZLuTmuywzsyXFOy/C3Pp0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:164f:b0:263:1117:32da with SMTP id
 il15-20020a17090b164f00b00263111732damr670559pjb.2.1687987071170; Wed, 28 Jun
 2023 14:17:51 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:17:48 -0700
In-Reply-To: <a6dff108-6946-71e7-99dc-ac3b70f7d7fa@gmail.com>
Mime-Version: 1.0
References: <20230427175007.902278-1-calvinwan@google.com> <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com> <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com> <owly8rcc3j1u.fsf@fine.c.googlers.com>
 <a6dff108-6946-71e7-99dc-ac3b70f7d7fa@gmail.com>
Message-ID: <owlyfs6b8ewz.fsf@fine.c.googlers.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
From:   Linus Arver <linusa@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Phillip Wood <phillip.wood123@gmail.com> writes:
>> - Make the 'TEST' macro accept the test description first. Or, keep the
>>    'TEST' macro but also name a new macro 'IT' that accepts the
>>    description first, to encourage usage that reads in a
>>    behavior-driven-development (BDD) style, like 'IT("should accept foo",
>>    t_bar(...))'. I find some test descriptions easier to write this way.
>
> The test description is a printf style format string followed by 
> arguments. This allows parameterized tests to include the parameter 
> values in the description to aid debugging but it means the test 
> function must be the first parameter. We could have IT("should accept 
> %d", t(), i) but that would be a bit weird.

I see. I agree that

  IT("should accept %d", t(), i)

would look rather odd.

> I hope that we will end up with some guidelines for writing unit tests 
> that recommend testing the expect behavior and to avoid testing 
> implementation details. I'm don't think we necessarily need an IT() 
> macro to do that.

The IT() macro idea was only suggested as a stylistic choice. I also
agree that an IT() macro is not necessary to test the expected behavior.

>> - The 'check_int(result, ==, expected)' usage would be better without
>>    the commas, like 'check_int(result == expected)'. Is this possible?
>
> I don't particularly like the comma's either but in order to have decent 
> diagnostic messages we need to pass 'result' and 'expected' as separate 
> parameters so we can print them. We could have separate macros for 
> different comparisons check_int_eq(a, b), check_int_lt(a, b), ... I 
> don't have a strong preference either way.

I see. If it's a one-time cost to do this (enable comma-less usage) then I
strongly favor doing so. But I guess it's the kind of thing where we
could easily have a mechanical conversion from one style to the other in
the future, so it can certainly wait.

>> - It would be nice to report the test name for failing tests, so that
>>    this output can be parsed to check for the failing test name.
>
> I'm not quite sure what you mean here. The test name in printed in the 
> "not ok" lines for failing tests as shown in the output from your tests 
> below.

It would be nice if the failing output (in my example) also printed the
"t_same_token" function name.

>> There are other smaller changes I'd like (such as optional
>> colorization), but I think these bits can be sorted out much later.
>
> Sure
>
>> My patch can be found at
>> 
>>     git fetch https://github.com/listx/git trailer-unit-tests
>> 
>> and also inline at the bottom of this email message.
>> 
>> Build and test with
>> 
>>      make unit-tests && t/unit-tests/t-trailer
>> 
>> Sample output:
>> 
>>      $ make -j47 unit-tests && t/unit-tests/t-trailer
>>          CC t/unit-tests/t-trailer.o
>>          LINK t/unit-tests/t-trailer
>>      ok 1 - empty trailer_item and arg_item
>>      ok 2 - identical
>>      ok 3 - case should not matter
>>      ok 4 - arg_item is longer than trailer_item
>>      ok 5 - trailer_item is longer than arg_item
>>      ok 6 - no similarity
>>      ok 7 - accept WHERE_AFTER
>>      ok 8 - accept WHERE_END
>>      ok 9 - reject WHERE_END
>>      ok 10 - token with trailing punctuation (colon)
>>      ok 11 - token without trailing punctuation
>>      ok 12 - token with spaces with trailing punctuation (colon)
>>      ok 13 - token with spaces without trailing punctuation
>>      ok 14 - token with leading non-separator punctuation
>>      ok 15 - token with leading non-separator punctuation and space
>>      ok 16 - one-letter token
>>      ok 17 - token with punctuation in-between
>>      ok 18 - token with multiple leading punctuation chars
>>      # check "result == expected" failed at t/unit-tests/t-trailer.c:25
>>      #    left: 1
>>      #   right: 0
>>      not ok 19 - empty trailer_item
>
> This test fail because same_token() tests that the longer of its two 
> arguments starts with the shorter argument, not that the two arguments 
> are equal. As the shorter argument is empty in this case it returns 
> true, not false.

To me this behavior is surprising because this means that we could have,
for example,

    1. "" and "foo"
    2. "" and "bar"

and in both cases the empty string would be considered the "same token"
as "foo" and "bar". I think we should rename the function to something
other than same_token(), perhaps same_prefix_token() or similar.

>>      # check "result == expected" failed at t/unit-tests/t-trailer.c:25
>>      #    left: 1
>>      #   right: 0
>>      not ok 20 - empty arg_item
>>      1..20
>>
>> Note that some of the tests I expect to fail are passing.
>
> Which ones are those?

Oops. Disregard my comment here (it was from an earlier draft of the
email).

>> These may be
>> bugs but I am not sure because I don't fully understand the
>> interpret-trailers machinery yet.
>
> Thanks for sharing these tests, it is helpful to see examples of the 
> test framework being used. In this case the tests are checking static 
> functions from trailer.c. This mean that you have to export a number of 
> functions and structs that are really implementation details.

Indeed. I had a feeling that what I was doing was probably not the best
idea (exposing previously private internals of the trailer.c logic). I
agree with your analysis.

> Where 
> possible I think we want to concentrate our testing effort on the public 
> API as (a) that is what matters to callers and (b) it avoids having to 
> export internal functions and encourages people to test behavior rather 
> than implementation details.

Agreed. This is the "libification" work that needs to be done here so
that we can test the public API behaviors, not the internal functions. I
merely chose to sidestep that work in my example to keep the patch small.

> There may be some cases where there are 
> internal helpers that would benefit from tests. In those cases we can 
> either hide the export behind a #define so it is only visible to the 
> test code or just #include the file being tested in the test file (gross 
> but works).

My C is rusty so it would be great if such an example can be contributed
to the codebase in the future.

> An alternative to both of those is for the tests to live in 
> the implementation files and have them conditionally compiled (a bit 
> like rust).

Ditto.

> Thanks again for your comments, Best Wishes

You're welcome. Thank you for showing us what a minimal test framework
could look like.

Linus

> Phillip
>
>
>> Linus
>> 
>> ---- >8 ----
>>  From e5907b328d35eb37cfd1feb3a2431cb672beb4c8 Mon Sep 17 00:00:00 2001
>> From: Linus Arver <linusa@google.com>
>> Date: Thu, 15 Jun 2023 18:25:47 -0700
>> Subject: [PATCH] add some unit tests for interpret-trailers
>> 
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>   Makefile                 |  5 +++
>>   t/unit-tests/t-trailer.c | 77 ++++++++++++++++++++++++++++++++++++++++
>>   trailer.c                | 33 ++---------------
>>   trailer.h                | 32 +++++++++++++++++
>>   4 files changed, 117 insertions(+), 30 deletions(-)
>>   create mode 100644 t/unit-tests/t-trailer.c
>> 
>> diff --git a/Makefile b/Makefile
>> index f0ca5bae4b..9d68518168 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2668,6 +2668,7 @@ scalar-objs: $(SCALAR_OBJS)
>>   
>>   UNIT_TEST_PROGRAMS += t-basic
>>   UNIT_TEST_PROGRAMS += t-strbuf
>> +UNIT_TEST_PROGRAMS += t-trailer
>>   UNIT_TEST_PROGS = $(patsubst %,t/unit-tests/%$X,$(UNIT_TEST_PROGRAMS))
>>   UNIT_TEST_OBJS = $(patsubst %,t/unit-tests/%.o,$(UNIT_TEST_PROGRAMS))
>>   UNIT_TEST_OBJS += t/unit-tests/test-lib.o
>> @@ -3848,5 +3849,9 @@ t/unit-tests/t-strbuf$X: t/unit-tests/t-strbuf.o t/unit-tests/test-lib.o $(GITLI
>>   	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>>   		 $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
>>   
>> +t/unit-tests/t-trailer$X: t/unit-tests/t-trailer.o t/unit-tests/test-lib.o builtin/interpret-trailers.o $(GITLIBS) GIT-LDFLAGS
>> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>> +		 $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
>> +
>>   .PHONY: unit-tests
>>   unit-tests: $(UNIT_TEST_PROGS)
>> diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
>> new file mode 100644
>> index 0000000000..150b5606fa
>> --- /dev/null
>> +++ b/t/unit-tests/t-trailer.c
>> @@ -0,0 +1,77 @@
>> +#include "test-lib.h"
>> +#include "trailer.h"
>> +
>> +static void t_token_len_without_separator(const char *token, size_t expected)
>> +{
>> +	size_t result;
>> +	result = token_len_without_separator(token, strlen(token));
>> +	check_uint(result, ==, expected);
>> +}
>> +
>> +static void t_after_or_end(enum trailer_where where, int expected)
>> +{
>> +	size_t result;
>> +	result = after_or_end(where);
>> +	check_int(result, ==, expected);
>> +}
>> +
>> +
>> +static void t_same_token(char *a, char *b, int expected)
>> +{
>> +    struct trailer_item trailer_item = { .token = a };
>> +	struct arg_item arg_item = { .token = b };
>> +	size_t result;
>> +	result = same_token(&trailer_item, &arg_item);
>> +	check_int(result, ==, expected);
>> +}
>> +
>> +int cmd_main(int argc, const char **argv)
>> +{
>> +	TEST(t_same_token("", "", 1),
>> +		 "empty trailer_item and arg_item");
>> +	TEST(t_same_token("foo", "foo", 1),
>> +		 "identical");
>> +	TEST(t_same_token("foo", "FOO", 1),
>> +		 "case should not matter");
>> +	TEST(t_same_token("foo", "foobar", 1),
>> +		 "arg_item is longer than trailer_item");
>> +	TEST(t_same_token("foobar", "foo", 1),
>> +		 "trailer_item is longer than arg_item");
>> +	TEST(t_same_token("foo", "bar", 0),
>> +		 "no similarity");
>> +
>> +	TEST(t_after_or_end(WHERE_AFTER, 1), "accept WHERE_AFTER");
>> +	TEST(t_after_or_end(WHERE_END, 1), "accept WHERE_END");
>> +	TEST(t_after_or_end(WHERE_DEFAULT, 0), "reject WHERE_END");
>> +
>> +	TEST(t_token_len_without_separator("Signed-off-by:", 13),
>> +	     "token with trailing punctuation (colon)");
>> +	TEST(t_token_len_without_separator("Signed-off-by", 13),
>> +	     "token without trailing punctuation");
>> +	TEST(t_token_len_without_separator("Foo bar:", 7),
>> +	     "token with spaces with trailing punctuation (colon)");
>> +	TEST(t_token_len_without_separator("Foo bar", 7),
>> +	     "token with spaces without trailing punctuation");
>> +	TEST(t_token_len_without_separator("-Foo bar:", 8),
>> +	     "token with leading non-separator punctuation");
>> +	TEST(t_token_len_without_separator("- Foo bar:", 9),
>> +	     "token with leading non-separator punctuation and space");
>> +	TEST(t_token_len_without_separator("F:", 1),
>> +	     "one-letter token");
>> +	TEST(t_token_len_without_separator("abc%de#f@", 8),
>> +	     "token with punctuation in-between");
>> +	TEST(t_token_len_without_separator(":;*%_.#f@", 8),
>> +	     "token with multiple leading punctuation chars");
>> +
>> +	/*
>> +	 * These tests fail unexpectedly. They are probably bugs, although it may be
>> +	 * the case that these bugs never bubble up to the user because of other
>> +	 * checks we do elsewhere up the stack.
>> +	 */
>> +	TEST(t_same_token("", "foo", 0),
>> +		"empty trailer_item");
>> +	TEST(t_same_token("foo", "", 0),
>> +		"empty arg_item");
>> +
>> +	return test_done();
>> +}
>> diff --git a/trailer.c b/trailer.c
>> index a2c3ed6f28..9f59d8d7a6 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -13,35 +13,8 @@
>>    * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
>>    */
>>   
>> -struct conf_info {
>> -	char *name;
>> -	char *key;
>> -	char *command;
>> -	char *cmd;
>> -	enum trailer_where where;
>> -	enum trailer_if_exists if_exists;
>> -	enum trailer_if_missing if_missing;
>> -};
>> -
>>   static struct conf_info default_conf_info;
>>   
>> -struct trailer_item {
>> -	struct list_head list;
>> -	/*
>> -	 * If this is not a trailer line, the line is stored in value
>> -	 * (excluding the terminating newline) and token is NULL.
>> -	 */
>> -	char *token;
>> -	char *value;
>> -};
>> -
>> -struct arg_item {
>> -	struct list_head list;
>> -	char *token;
>> -	char *value;
>> -	struct conf_info conf;
>> -};
>> -
>>   static LIST_HEAD(conf_head);
>>   
>>   static char *separators = ":";
>> @@ -62,7 +35,7 @@ static const char *git_generated_prefixes[] = {
>>   		pos != (head); \
>>   		pos = is_reverse ? pos->prev : pos->next)
>>   
>> -static int after_or_end(enum trailer_where where)
>> +int after_or_end(enum trailer_where where)
>>   {
>>   	return (where == WHERE_AFTER) || (where == WHERE_END);
>>   }
>> @@ -73,14 +46,14 @@ static int after_or_end(enum trailer_where where)
>>    * 13, stripping the trailing punctuation but retaining
>>    * internal punctuation.
>>    */
>> -static size_t token_len_without_separator(const char *token, size_t len)
>> +size_t token_len_without_separator(const char *token, size_t len)
>>   {
>>   	while (len > 0 && !isalnum(token[len - 1]))
>>   		len--;
>>   	return len;
>>   }
>>   
>> -static int same_token(struct trailer_item *a, struct arg_item *b)
>> +int same_token(struct trailer_item *a, struct arg_item *b)
>>   {
>>   	size_t a_len, b_len, min_len;
>>   
>> diff --git a/trailer.h b/trailer.h
>> index 795d2fccfd..b2031eb305 100644
>> --- a/trailer.h
>> +++ b/trailer.h
>> @@ -146,4 +146,36 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
>>    */
>>   void trailer_iterator_release(struct trailer_iterator *iter);
>>   
>> +int after_or_end(enum trailer_where where);
>> +size_t token_len_without_separator(const char *token, size_t len);
>> +
>> +struct conf_info {
>> +	char *name;
>> +	char *key;
>> +	char *command;
>> +	char *cmd;
>> +	enum trailer_where where;
>> +	enum trailer_if_exists if_exists;
>> +	enum trailer_if_missing if_missing;
>> +};
>> +
>> +struct trailer_item {
>> +	struct list_head list;
>> +	/*
>> +	 * If this is not a trailer line, the line is stored in value
>> +	 * (excluding the terminating newline) and token is NULL.
>> +	 */
>> +	char *token;
>> +	char *value;
>> +};
>> +
>> +struct arg_item {
>> +	struct list_head list;
>> +	char *token;
>> +	char *value;
>> +	struct conf_info conf;
>> +};
>> +
>> +int same_token(struct trailer_item *a, struct arg_item *b);
>> +
>>   #endif /* TRAILER_H */
