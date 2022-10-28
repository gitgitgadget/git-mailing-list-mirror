Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8136AC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJ1OXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJ1OXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:23:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A94B7FE7C
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666967012; bh=kru/XxaEn9CGJlEEznJQsX5hKx2BaQ2jamoqJj+a2+4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FQn3rsUagPTi9Jwj/pDoz3xYYO09spVinb1CiQWWxS9bLtJL9CK7kuX98TvCEuWm6
         giVhKqKiiAM4V8MiXS1s+qM5eV8U/NR/BFAeGI8e138j7Uyehgl3BrS0R1oesUghOv
         u3khErxxBWdQMjMo1TGHolTluLzs7EKAjC85SSzPGZDfsp30ILbb70zHZ6nh7ImZ6C
         Z6/p5wjW89ARaZkvwlKi2y/CTUdXseD9eUf+RxFnSzLeccR8KQNWv3L4ubsQm9AuhX
         9uddleWilzFOPL6IZK421wLMCy5cgzRYMw0SagtVR+TIEXqp9tjSBTHyWP5/yO/KGs
         XU+4tF3ggetEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1pOZtv3Ose-00aSbg; Fri, 28
 Oct 2022 16:23:31 +0200
Message-ID: <6c30a1f6-8d89-31b9-faf8-c695c46173cd@web.de>
Date:   Fri, 28 Oct 2022 16:23:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 4/8] use child_process member "args" instead of string
 array variable
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
 <221027.86zgdh9cqg.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221027.86zgdh9cqg.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QNaWu2l1R1pUOQD9M/lg2w5JOCeNfad74ZTlu9jC9vgYuQTLoZ3
 SAWrlv7v3yY2qf5zC+ukQAvu5dp/bzTraVCLWfgVKIwofL33bKbI3tsc0z56SE1gW7KTROW
 H3v5589wrFLnARB/cOgwiQyPJK7Y3qAUNJAmH4HOxxVpYvC2CbF7Iop21LemNoqdv8rEx9L
 hlJmcJrUtZMyJY6ojSJFw==
UI-OutboundReport: notjunk:1;M01:P0:FGjDmlGqwG8=;Ql6gJcVVrypeW5xhb5OH+keUULm
 wp7lVZ/X9G6d/O19XEfxCXLcJDS2PdMLo+PZ7UxbntJDf5uD7vvEo+6v8XFfhOUxqqk6++f22
 DNLZS+TL5VQTgnYwZ+uBrBrfZaJaiA6oV4Tm7LQILjTGB+eUXDpHAvmIFlOggI2LGnsF1PizM
 cxqq74aJ+CK8Udjz7vUdd6w3Ih+r0bHiRnevskBjRdu4q8gk7aYlM+6YQvItGeZImX/+rFrlE
 H6x8ql9Kv4EAnULUYG2u4/lt09z3r8SmtvWvMLDkYehHNzDdX0ixaDstwX5jzkq/4bcH9RPPH
 VY1+UbYB7ZCgrksT5AREiGsT3MYxSVvc3egPgXHVb4MGHfKkqjK0proPkTaahnscWRP4CiDXJ
 N/VLD8ZyZn68jJGEkkhDgpd8tpic7/TNa10157afNJk/r2rpg3kYv4BK0IzOx1RE99X3MkZ3M
 G/KTZ9tuHDDGtg2lxePdfpQng3K0mGZOWfj0MyZ4kDDJ0oBIFTELzYKZooTWRaUQLjZf9vuqC
 5zbh5FePFny2mIdh6t5Z3AQLdx9cVuJW9peI1hgW0WRjrG7Aei0pwHQEcCBh0npaQq34gL69F
 06BfArZvfOtKhDzSb1t7mtLVMWiiMJIGjwo6o7jM0L+0oYzPfO5VPRF+sOcxMpwqXtDMphC94
 7AcHeNzPNaHL3+Rw/t0Om/6Bt7eiv5WLknm1f87aGrGpTBoovmO2DEQ0b4VDHV/8SSYYcLNOl
 VG79EJysfEoLE52JVT69gHheVmxOZ8rp7bRcqznQ+EIWZtcXfXUV6KjoIqrKzPvEja3LgsZ9X
 lHL/LWJxq2a3M9YR4sIqeMqBXprMtZK+V0cURNk+2kSBRxUiCO4WbnGRvfEmQz/H/jXn2lRTK
 6rKhwAfhYsMDh2Vh3BAXhflKXj21eH2mSFCXNdAk0KyRfKqVadfYo77Ny6jGhgDMF7RzHHKAI
 iXFzeiCrsAQFL0rHn8J6GlKA2dg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.22 um 23:09 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:
>
>> @@ -729,20 +727,22 @@ static int is_expected_rev(const struct object_id=
 *oid)
>>  enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
>>  				  int no_checkout)
>>  {
>> -	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>>  	struct commit *commit;
>>  	struct pretty_print_context pp =3D {0};
>>  	struct strbuf commit_msg =3D STRBUF_INIT;
>>
>> -	oid_to_hex_r(bisect_rev_hex, bisect_rev);
>>  	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_R=
EFS_DIE_ON_ERR);
>>
>> -	argv_checkout[2] =3D bisect_rev_hex;
>>  	if (no_checkout) {
>>  		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
>>  			   UPDATE_REFS_DIE_ON_ERR);
>>  	} else {
>> -		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
>> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
>> +
>> +		cmd.git_cmd =3D 1;
>> +		strvec_pushl(&cmd.args, "checkout", "-q",
>> +			     oid_to_hex(bisect_rev), "--", NULL);
>> +		if (run_command(&cmd))
>>  			/*
>>  			 * Errors in `run_command()` itself, signaled by res < 0,
>>  			 * and errors in the child process, signaled by res > 0
>
> Perhaps I went overboard with it in my version, but it's probably worth
> mentioning when converting some of these that the reason for the
> pre-image of some is really not like the others.
>
> Now that we're on C99 it perhaps make s no difference, but the pre-image
> here is explicitly trying to avoid dynamic initializer elements, per
> 442c27dde78 (CodingGuidelines: mention dynamic C99 initializer elements,
> 2022-10-10).

True, some cases could be converted to string array initializations,
which also would get rid of magic numbers.  This would make the final
patch to convert them to run_command() longer.

> Well, partially, some of it appears to just be based on a
> misunderstanding of how our own APIs work, i.e. the use of
> oid_to_hex_r() over oid_to_hex().
>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index 39fea24833..20aea0d248 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -2187,14 +2187,12 @@ static int show_patch(struct am_state *state, e=
num show_patch_type sub_mode)
>>  	int len;
>>
>>  	if (!is_null_oid(&state->orig_commit)) {
>> -		const char *av[4] =3D { "show", NULL, "--", NULL };
>> -		char *new_oid_str;
>> -		int ret;
>> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
>>
>> -		av[1] =3D new_oid_str =3D xstrdup(oid_to_hex(&state->orig_commit));
>> -		ret =3D run_command_v_opt(av, RUN_GIT_CMD);
>> -		free(new_oid_str);
>> -		return ret;
>> +		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
>> +			     "--", NULL);
>> +		cmd.git_cmd =3D 1;
>> +		return run_command(&cmd);
>>  	}
>
> The same goes for this, FWIW I split this one out into its own commit (I
> left the earlier one alone):
> https://lore.kernel.org/git/patch-v2-04.10-5cfd6a94ce3-20221017T170316Z-=
avarab@gmail.com/;
> It uses the same pattern

OK, I just chalked that up as "slightly odd" and bulldozed over them
without a second thought.  Hmm.

>
>> diff --git a/builtin/difftool.c b/builtin/difftool.c
>> index 4b10ad1a36..22bcc3444b 100644
>> --- a/builtin/difftool.c
>> +++ b/builtin/difftool.c
>> @@ -360,8 +360,8 @@ static int run_dir_diff(const char *extcmd, int sym=
links, const char *prefix,
>>  	struct pair_entry *entry;
>>  	struct index_state wtindex;
>>  	struct checkout lstate, rstate;
>> -	int flags =3D RUN_GIT_CMD, err =3D 0;
>> -	const char *helper_argv[] =3D { "difftool--helper", NULL, NULL, NULL =
};
>> +	int err =3D 0;
>> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
>
> In general, I like the disection of this series, but with this...
>
>>  	struct hashmap wt_modified, tmp_modified;
>>  	int indices_loaded =3D 0;
>>
>> @@ -563,16 +563,17 @@ static int run_dir_diff(const char *extcmd, int s=
ymlinks, const char *prefix,
>>  	}
>>
>>  	strbuf_setlen(&ldir, ldir_len);
>> -	helper_argv[1] =3D ldir.buf;
>>  	strbuf_setlen(&rdir, rdir_len);
>> -	helper_argv[2] =3D rdir.buf;
>>
>>  	if (extcmd) {
>> -		helper_argv[0] =3D extcmd;
>> -		flags =3D 0;
>> -	} else
>> +		strvec_push(&cmd.args, extcmd);
>> +	} else {
>> +		strvec_push(&cmd.args, "difftool--helper");
>> +		cmd.git_cmd =3D 1;
>
> ...and the frequent occurance of just e.g. "cmd.git_cmd =3D 1" and nothi=
ng
> else I'm wondering if we're not throwing the baby out with the bath
> water in having no convenience wrappers or macros at all.
>
> A lot of your 3-lines would be 1 lines if we just had e.g. (untested,
> and could be a function not a macro, but you get the idea):
>
> 	#define run_command_git_simple(__VA_ARGS__) \
> 		struct child_process cmd =3D CHILD_PROCESS_INIT; \
> 		cmd.git_cmd =3D 1; \
> 		strvec_pushl(&cmd.args, __VA_ARGS__); \
> 		run_command(&cmd);
>
> But maybe nobody except me thinks that's worthwhile...

I have similar temptations; you could see that in my scratch patch
https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/
which added run_git_or_die() in builtin/gc.c.  Why, oh why?  Perhaps
because taking a blank form (CHILD_PROCESS_INIT), ticking boxes
(.git_cmd =3D 1), filling out text fields (strvec_push(...)) and
submitting it (run_command()) feels tedious and bureaucratic, Java-esque
even.  And some patterns appear again and again.

How bad is that?  Is it bad at all?  I think overall we should try to
reduce the number of external calls and make those we have to do
self-documenting and leak-free.  A bit of tedium is OK; this API should
be used rarely and sparingly.  Still I get the urge to search for
patterns and define shortcuts when I see all those similar calls..

run_command_git_simple as defined above wouldn't compile, but I get it.
Reducing the number of lines feels good, but it also makes the code less
flexible -- adding a conditional parameter requires converting back to
run_command().

>
>>  static void read_empty(const struct object_id *oid)
>>  {
>> -	int i =3D 0;
>> -	const char *args[7];
>> -
>> -	args[i++] =3D "read-tree";
>> -	args[i++] =3D "-m";
>> -	args[i++] =3D "-u";
>> -	args[i++] =3D empty_tree_oid_hex();
>> -	args[i++] =3D oid_to_hex(oid);
>> -	args[i] =3D NULL;
>> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
>> +
>> +	strvec_pushl(&cmd.args, "read-tree", "-m", "-u", empty_tree_oid_hex()=
,
>> +		     oid_to_hex(oid), NULL);
>> +	cmd.git_cmd =3D 1;
>>
>> -	if (run_command_v_opt(args, RUN_GIT_CMD))
>> +	if (run_command(&cmd))
>>  		die(_("read-tree failed"));
>>  }
>>
>>  static void reset_hard(const struct object_id *oid)
>>  {
>> -	int i =3D 0;
>> -	const char *args[6];
>> -
>> -	args[i++] =3D "read-tree";
>> -	args[i++] =3D "-v";
>> -	args[i++] =3D "--reset";
>> -	args[i++] =3D "-u";
>> -	args[i++] =3D oid_to_hex(oid);
>> -	args[i] =3D NULL;
>> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
>> +
>> +	strvec_pushl(&cmd.args, "read-tree", "-v", "--reset", "-u",
>> +		     oid_to_hex(oid), NULL);
>> +	cmd.git_cmd =3D 1;
>>
>> -	if (run_command_v_opt(args, RUN_GIT_CMD))
>> +	if (run_command(&cmd))
>>  		die(_("read-tree failed"));
>>  }
>
> Two perfect examples, e.g. the former would just be:
>
> 	if (run_command_git_simple("read-tree", "-m", "-u", empty_tree_oid_hex(=
),
> 				   oid_to_hex(oid), NULL))
> 		die(...);
