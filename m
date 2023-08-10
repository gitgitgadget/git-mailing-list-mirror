Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C9C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjHJTKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJTKq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 15:10:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5624790
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691694634; x=1692299434; i=l.s.r@web.de;
 bh=UCfAYzir70zr3Rr45l6MR8hBWBPDwVlR/Oo6yPX8lGM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KDjKUNXonavOhQHRH5zni29dYGWXyv1GOa5FQzetQnOH1o73hSPCLMo4ZQ+eD6WdZv2fxmU
 afQSCmaIj1A2zRpHBU1QPwkBQpvngm9Mbu9jKL4T2Yr2uANuDavZe/XegnMWTk5yIdzjJMeh9
 2Htj+sachyYw95bfCeaGw73y0VAmQhlKxomwoW0iPZ4q5etJS8YxAxaDuU/gZ1NC3j/aC+WCY
 49rDPHEsbvtyvVCRGMd00DFUSxqM+VIJSxkLeBiKFtYSjFAdkTgwOJWr6hWHm2yG+KfQcNgcG
 +52hjKDFr/9A7NuK7EPQTLWF2pG9GP95POkpnjV2hSXW762s/Wxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDv9M-1qbq173yLs-00A9vV; Thu, 10
 Aug 2023 21:10:33 +0200
Message-ID: <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
Date:   Thu, 10 Aug 2023 21:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] describe: fix --no-exact-match
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230810004127.GD795985@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ryPRE+KftvcM5COaiwNCRUcVDqOf6r4vXNXbczjY495KoGTXyo8
 eY5/lhkhEAfbj2cCN4ycJevSs3MXZr2EUMZgJ/xjCWmQJbU65Wv983sFuj3iv0EL3jm7qtR
 XksAN6x+YFJCryGpVxruqNFzxzGhKH6XbzpuDoS2w5GrCitfj6mqHgnPBW2g4UV3jwwvyCT
 RqY9usDce1Q2wLP9Z9q5g==
UI-OutboundReport: notjunk:1;M01:P0:J58ubp/yI3o=;1Urz1rjyh0ltjXXAb649cNWIh14
 yqE8oaGpeMn1hcMIYjPVKJEYR691qxDoH0wwx3G0VD1PbjvcESIjwTzREOSZh7aKgaFDk7LCu
 5/91yqWLbMelOuFxcLxPJZuC232KB/dAB79SdSgPsBTq1QrYGBq8ToreBfvQh9Tl2kZUAMguc
 z1oFGBZ5YiSRsOBMN2/9yGXtpsa7mBeM0SqNP1rOLmhB/tvkPXWil9HlqPcNCz08tjYzjkWCo
 L54C0ybS86v+f/zEYeBgCuRFNwebCyKt2pRFNuw2kYWcxJpdYKZDuOVP+VFTVVJswUSbNgn5E
 2+ngWJ0NN2qfaRKBdaFZDZmmEZFHhuaZHHJEOnzLHLkkzAqTCvswkkq+K4h6KPL4mnCjFLQHD
 UxsUT5EEAvUa9YeCq4J9YReuaydF5N/RLPWI6rkEDFIoCiF5uCDdRPrHOszF33908xJGS5kSP
 jIsuHT+NEZJpu2IJT3fm8wbDiP7VHCLDAWBdXJrfnfuc1is8LiyJ4mlzjxPhGDnBzSWVy6Ivj
 aXsMF/aLnqitoLUADVoy/yt/lQhCDsba3YkqmsygNCxs2Pa0jauAXqbex35YrIVokiPstl8M9
 lkgjlaN5pbHeKd+wXBXDDVHCFhLJ3mvoueZ3A1ivPuYwkXSJAXH6byjZEyI01y2uNL6d+Vczr
 qYFmnIKfdC9HifvpbwyEN7sBhJ8i6fT234pwfxO/nyPV6kijCNuSAC6CwTOJUwPW7+nokdOgS
 k4biiGGUxsncwxfYR/RlScPP2SlmK9xOTssFMRT3VBEvQD9kEjtCQUN9fyCm64kN7+yAxlhIS
 O2tDNDvSWPxiyH9TaMXjzyQayC1M6WSVXJEQvKypwlLFocoZoluGsblhFQ0NpwwC7sj7l0fpL
 B17ueUOwIaglhixONy65s4mloAMgM+hyUbVtIB9YXBHIgCATQXnNIoEmvnrqVro3v9GvS4aAL
 6psP0Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 10.08.23 um 02:41 schrieb Jeff King:
> On Wed, Aug 09, 2023 at 06:41:13PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> And sorry for the unused parameter warning.  Just checked; there are
>> 170+ of those remaining before we can enable it in developer mode.  :-/
>> Seems worthwhile, though, especially not slapping UNUSED blindly on
>> them.
>
> I know, I'm working on it. :) There were more than 800 when I started.
> I'm hoping to send out the final patches during this 2.43 cycle.
>
>> Oh.  Do we really need all those?  Anyway, if we added at least the
>> most common ones, we'd be better off already, I'd expect:
>>
>>    $ % git grep -h ' =3D opt->value;' | sed 's/\*.*$//; s/^ *//' | sort=
 | uniq -c | sort -nr | head -10
>>      29 struct diff_options
>>      12 int
>>       7 struct grep_opt
>>       6 struct rebase_options
>>       6 struct apply_state
>>       5 struct strbuf
>>       5 char
>>       4 struct note_data
>>       3 struct string_list
>>       2 struct strvec
>>
>> Increasing the size of the struct like that would increase the total
>> memory footprint by a few KB at most -- tolerable.
>
> Hmm, I was thinking that "int_value" might not be so bad. But it seems
> like a pretty bad layering violation for parse-options.c to know about
> "struct apply_state" and so on. That really is what void pointers are
> for.

True, keeping a list of external types in parse-options.h is clumsy and
ugly.

> As for size, you should be able to use a union. All of the types inside
> the struct are pointers, so they'd all be the same size. Of course then
> you lose some of the safety. If the caller assigned to "int_value" that
> is distinct from "foo_value", then you can be sure you will get a NULL
> and segfault upon accessing foo_value. With a union, you get whatever
> type-punning undefined behavior the compiler sees fit. And the point is
> making sure the two match.

Which makes a union a non-starter -- we need a reliable error.

> We really don't care about separate storage, though. We want type
> safety. Maybe an option there would be to let the callback function take
> the appropriate type, and cast it. I.e., something like:
>
>   /* define a callback taking the real type */
>   int my_int_opt(int *value, struct option *opt, ...etc...) { ...body...=
 }
>
>   /* when mentioning a callback, include the type, and make sure that
>    * the value and the callback both match it */
>   #define OPT_CALLBACK(s, l, type, v, cb, ...etc...) \
>     { ..., \
>       value.type =3D (v), \
>       callback =3D (int (*)(type *, struct option *opt, ...etc...), \
>     }
>   ...
>   OPT_CALLBACK('f', "foo", int, &my_local_int, my_int_opt)

The idea is good, even though I don't understand how your specific
example would work.  Dabbled with something similar for typed qsort
(need to clean it up and submit it one of these days).

> I'm pretty sure that falls afoul of the standard, though, because we
> eventually need to call that function, and we'll do so through a
> function pointer that doesn't match its declaration.

Fighting possible type mismatches by adding a certain type mismatch
won't fly..

> I'm not sure there's a portable and non-insane way of doing what we want
> here. At least at compile-time.

We need a wrapper with the correct signature.  The wrapper is plugged
into struct option.  The typed callback is called by the wrapper and
can be used for a type check in the struct macro.  Demo patch below.


> At run-time you could record type
> information in an enum and check it in the callback. That seems like
> a lot of work for little reward, though.

Agreed -- runtime type checks are for scripting languages..

Ren=C3=A9



diff --git a/builtin/describe.c b/builtin/describe.c
index b28a4a1f82..ce16c36de2 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -558,15 +558,17 @@ static void describe(const char *arg, int last_one)
 	strbuf_release(&sb);
 }

-static int option_parse_exact_match(const struct option *opt, const char =
*arg,
-				    int unset)
+static int option_parse_exact_match(const struct option *opt UNUSED,
+				    const char *arg, int unset, int *value)
 {
 	BUG_ON_OPT_ARG(arg);

-	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
+	*value =3D unset ? DEFAULT_CANDIDATES : 0;
 	return 0;
 }

+DEFINE_PARSE_OPT_CB(option_parse_exact_match);
+
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains =3D 0;
@@ -578,9 +580,9 @@ int cmd_describe(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
 		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent=
")),
 		OPT__ABBREV(&abbrev),
-		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
-			       N_("only output exact matches"),
-			       PARSE_OPT_NOARG, option_parse_exact_match),
+		OPT_CALLBACK_F_T(0, "exact-match", &max_candidates, NULL,
+				 N_("only output exact matches"),
+				 PARSE_OPT_NOARG, option_parse_exact_match),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING_LIST(0, "match", &patterns, N_("pattern"),
diff --git a/parse-options.h b/parse-options.h
index 57a7fe9d91..f957931cfa 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -67,6 +67,14 @@ enum parse_opt_result {
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unse=
t);

+#define DEFINE_PARSE_OPT_CB(name)				\
+static inline int name ## __void(const struct option *opt,	\
+				 const char *arg, int unset)	\
+{								\
+	return name(opt, arg, unset, opt->value);		\
+}								\
+struct option
+
 struct parse_opt_ctx_t;
 typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx=
,
 					      const struct option *opt,
@@ -198,6 +206,16 @@ struct option {
 	.flags =3D (f), \
 	.callback =3D (cb), \
 }
+#define OPT_CALLBACK_F_T(s, l, v, a, h, f, cb) { \
+	.type =3D OPTION_CALLBACK, \
+	.short_name =3D (s) + (0 ? cb(NULL, NULL, 0, (v)) : 0), \
+	.long_name =3D (l), \
+	.value =3D (v), \
+	.argh =3D (a), \
+	.help =3D (h), \
+	.flags =3D (f), \
+	.callback =3D cb ## __void, \
+}
 #define OPT_STRING_F(s, l, v, a, h, f) { \
 	.type =3D OPTION_STRING, \
 	.short_name =3D (s), \
