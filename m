Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A2BC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHIQl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIQl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 12:41:26 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF171982
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691599274; x=1692204074; i=l.s.r@web.de;
 bh=encSKcAlAjsRUgUkjL/qEnqH1vn1qvYLQrMFzisQO34=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LiKacCKKJm8aFEpyRnozztcz0ShOqeq/6cEAppTB314cL2i4rSJZOEoxVLimHX8HiDI2u7x
 TMa/tDY00OggV4wPsZchHdyKDP4iWC8mSFPUMJUf7CCVJ144vYrOSTbw23R9GhmepeyX9M9al
 gCshfdsYtP1QlslBeeRucoZ33sKUKpj4uNpeDv157soH+pEoxzqQYigBnR9YmEFZsLaBxPVTu
 75HH/Oal01r+v1WqFyiIeWAZlsjFnifrnKkycpxKVlercoOG77fsFir4J0HsrGFYjTfg9Cfct
 WJ1Gm7XDaYSRd3qAh9JdfNCAMiaH5CS5DOBL+KARfALW4YAJkmoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgiXO-1ptN6E0xVk-00hLuV; Wed, 09
 Aug 2023 18:41:14 +0200
Message-ID: <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
Date:   Wed, 9 Aug 2023 18:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] describe: fix --no-exact-match
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230809140902.GA775795@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B20airoyK/KqtZ8EUbmJ97HgpYfCkB/U4sJVJQn4y5Cksi2lmsd
 Sk/s1ncGv9V//RE3KrvRG4zUsMiyTot4tcWYO8c4zoynyDlhgddNCx29b0GT7+/6BtOX8/I
 wu/7uIO0Tt7P4VKpO2gli3/uWNdnZOWxQA+QP4h3LgIrSVwT75vmJ+4IUoHAwiMMsiMhkm0
 ZLJaNOKuIBuh/MPsCfUEg==
UI-OutboundReport: notjunk:1;M01:P0:bODIlYIHrEI=;1tJMabSJDqCCT1NPAGg/cKqRlRK
 ZGeZVm9Qle/u+NN5AbJmf//ssH39+DJNuL5eT8nQDGBX2lCNr/CDQyE/CVsqr8S9JXToD15GM
 2hNUyFen1LHmPIVGxFZhumeAQ6VRGTAtAXQJN/PakKEggcSYHM1ZuJmF7QhJZY48kVgsXc+4m
 6nzPqHQDTVENt1MlX2r4rjHOSb6VOra9MJSjxTtDSWmW77aADi++pgy99QEv00gfyTcoW72TW
 py0jkgbxS/QfEWu77EbiAtSToFZI1+JzZ1P14eOLT/ka2Ah6A4sG0t+vDdECc9pjZVj2b7HNb
 I0/tlAi+P1cMZ1yKPlsT8p7KY2E+IhSI+Ni+RlM/BXi6lSmYFEPho/LM209m+0F07wWh3T02l
 lawqVOF6JoGzqTtC0HTDwP0UZ6Fw1ILmo3Y+FiFXSDaSPiedgvEA24D2q2jSo/S/W3nuNAfG3
 HjJMnm+0SHCY8gsdInrCSjFu8CYl2Xr46EeEKH8zCPoK7CJ1oWNDaY9ym1RZFRbzjY93K9vuE
 uEt3J65aghVVnJZaQhs57TBqNzJgbNiiOrZojXh4FwNLs0h3NZ2jz+36JfR5gfGQIIW+QMIkP
 JgF1e2B+Fd36q0SsvpezhoGpjX6jJr3c+Yzl8XORkYSuXCZ8zZ2ftqFvCzf0vk/4htcvVfMnE
 8C4p+azQ9VFWVorTfLQd1ZG9A2XftX5yngFiYIw6MGtozqVWvFEwjyxEGU0AwPT0jWxH5F01p
 ncdQZoNT9q7ThlqrL3GtvJ3kzqltss+kmZ9xFrmwiy1zoRkny1731HtG5UP4MgCaFyMbXoEFq
 8bJKR1m3fuVnMwH/osHlqcdStJIjgee9pBs2IjyOnLdE+6jvJwn3OIkwAfkwq9QihR02cRPyv
 nmfIsy/ELlaG2svblP0Z2e/WElCu0VWRqpzNloQpi1ACozofxp71xFcvXcqbXWecznNKElqxJ
 lER0MBbroZGsWIDw8pK1229J4NY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.23 um 16:09 schrieb Jeff King:
> On Tue, Aug 08, 2023 at 06:43:41PM -0700, Junio C Hamano wrote:
>
>>> So before I sent a patch (either to switch to using opt->value, or to
>>> add an UNUSED annotation), I wanted to see what you (or others) though=
t
>>> between the two. I.e., should we have a rule of "try not to operate on
>>> global data via option callbacks" or is that just being too pedantic f=
or
>>> one-off callbacks like this?
>>
>> So, that was my preference, but I may be missing some obvious
>> downsides.  I am interested in hearing from Ren=C3=A9, who often shows
>> better taste than I do in these cases ;-)
>
> Me too. :)

I'm pretty sure I didn't think much about it, copied the style from the
other callback functions in builtin/pack-objects.c and was glad to not
have to deal with void pointers.

And sorry for the unused parameter warning.  Just checked; there are
170+ of those remaining before we can enable it in developer mode.  :-/
Seems worthwhile, though, especially not slapping UNUSED blindly on
them.

> The main downsides, I think, are:
>
>   1. It's a little more ugly.
>
>   2. We lose type safety, as the variable address passes through a void
>      pointer (but that is true of all option callbacks).

An upside is that we can reuse the callback if we are careful to wire
it up to a variable of the correct type.  Another is that we can use
it on local variables.

Hmm, we could make these callbacks type-safe fairly easily by adding
pointers of all relevant types to struct option, like "int *value_int".
How many types would we need?

   $ git grep -h ' =3D opt->value;' | sed 's/\*.*$//; s/^ *//' | sort -u |=
 wc -l
   37

Oh.  Do we really need all those?  Anyway, if we added at least the
most common ones, we'd be better off already, I'd expect:

   $ % git grep -h ' =3D opt->value;' | sed 's/\*.*$//; s/^ *//' | sort | =
uniq -c | sort -nr | head -10
     29 struct diff_options
     12 int
      7 struct grep_opt
      6 struct rebase_options
      6 struct apply_state
      5 struct strbuf
      5 char
      4 struct note_data
      3 struct string_list
      2 struct strvec

Increasing the size of the struct like that would increase the total
memory footprint by a few KB at most -- tolerable.

> Here's what it looks like, for reference.
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index b28a4a1f82..718b5c3073 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -561,9 +561,11 @@ static void describe(const char *arg, int last_one)
>  static int option_parse_exact_match(const struct option *opt, const cha=
r *arg,
>  				    int unset)
>  {
> +	int *val =3D opt->value;

This line would assign opt->value_int instead...

> +
>  	BUG_ON_OPT_ARG(arg);
>
> -	max_candidates =3D unset ? DEFAULT_CANDIDATES : 0;
> +	*val =3D unset ? DEFAULT_CANDIDATES : 0;
>  	return 0;
>  }
>
> @@ -578,7 +580,7 @@ int cmd_describe(int argc, const char **argv, const =
char *prefix)
>  		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
>  		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first pare=
nt")),
>  		OPT__ABBREV(&abbrev),
> -		OPT_CALLBACK_F(0, "exact-match", NULL, NULL,
> +		OPT_CALLBACK_F(0, "exact-match", &max_candidates, NULL,

... but the macro OP_CALLBACK_F could no longer be used, because we'd
need to select one of the many typed pointers.

Macros like OPT_BOOL could be changed to use the appropriate typed
pointer.

Thoughts?  Too much churn?

>  			       N_("only output exact matches"),
>  			       PARSE_OPT_NOARG, option_parse_exact_match),
>  		OPT_INTEGER(0, "candidates", &max_candidates,
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d2a162d528..74c2225620 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4120,12 +4120,14 @@ static void add_extra_kept_packs(const struct st=
ring_list *names)
>  static int option_parse_quiet(const struct option *opt, const char *arg=
,
>  			      int unset)
>  {
> +	int *val =3D opt->value;
> +
>  	BUG_ON_OPT_ARG(arg);
>
>  	if (!unset)
> -		progress =3D 0;
> -	else if (!progress)
> -		progress =3D 1;
> +		*val =3D 0;
> +	else if (!*val)
> +		*val =3D 1;
>  	return 0;
>  }
>
> @@ -4190,7 +4192,7 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  		LIST_OBJECTS_FILTER_INIT;
>
>  	struct option pack_objects_options[] =3D {
> -		OPT_CALLBACK_F('q', "quiet", NULL, NULL,
> +		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
>  			       N_("do not show progress meter"),
>  			       PARSE_OPT_NOARG, option_parse_quiet),
>  		OPT_SET_INT(0, "progress", &progress,
