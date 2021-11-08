Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5CC433FE
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE7961361
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 16:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhKHQeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhKHQeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 11:34:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ECDC061714
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 08:31:19 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so64205204edz.2
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 08:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=r7Ip5dRuS9GtiCwdejamWYfJxUYZ7vyaefJAKkDpC34=;
        b=c0hQAoea+4R4DBvXUGbGg5yjbJf35ZmvPaLLijQj1ItZki5gOZfxRv7HUN60LBWNkq
         ECZAZ0eMlihVGkIXXyKi9ZRcbzVsEGfSj/s66U6k6A/p6PTbkqmSC8Pfa5RV6T88ko4Y
         R/2Y7hqDoAAoMIrydsJsLqJUXJPx23zHud+KWrZi+JJcvCWBfCBrXhG2zsbJKshNqg1z
         MS2m0pJRaxSH3/AU6gwNRCfvvb7CfRFPGW37IqNRI4/CSR/7K2alwciCCh+UbxDEQj6H
         TXLUOEn7UqLibuROs0ZLfBXKdVKu8JEGgmG+4PHbL4GfD6HoZTINprhww71anI5XDLfs
         gP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=r7Ip5dRuS9GtiCwdejamWYfJxUYZ7vyaefJAKkDpC34=;
        b=TxB83pIjguRWd+02XW15OsBK5ynR4m2/hnLbDXcMu37WVSg8e8djlWlZmAUjTA3U09
         enNiSmAp6WANddFIRlcOMGrEEGj5CQw3K0ZsTYP4v5G10I4B8clw6kKRrwKbiEMNH+sJ
         Q8JupD0N0Qp1+wZiBv9SAoUZLvQN34568YDUfKaUZd22YJw4ePvAautRJxJrEpTCF/eX
         q8HGXt7bA/qHgs1qNB/6CFz7NURMG6rAjBfW69F7WsZwgbS3DlRfWCYr1ymw+wZlhMmY
         HAEIbTlDDqa+Ilde5hpWQGqaGUNiSKNDn0B03asJ4R5KjxrpTWTvyaJiHKHtRX66YTqj
         mcNg==
X-Gm-Message-State: AOAM532S2nqnPMu7k1ZMDQ5CphTPARhZUkQISESX1zLJadtEaAuXFocN
        M2njlaPFTY3vVef/arQu+iI=
X-Google-Smtp-Source: ABdhPJziizj9ZDInkIaFmsI+synaAv1o4957tv2wBMpxHtVzMFswN3DpShVbldurMSlQHTn9kjeYMw==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr654311ejc.385.1636389073765;
        Mon, 08 Nov 2021 08:31:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bo20sm3516644edb.31.2021.11.08.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:31:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mk7Y8-001BNN-6m;
        Mon, 08 Nov 2021 17:31:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <jcai@gitlab.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file: force flush of stdout on empty string
Date:   Mon, 08 Nov 2021 16:15:38 +0100
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
 <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
 <xmqqsfwaumlc.fsf@gitster.g> <211106.86k0hmgc8q.gmgdl@evledraar.gmail.com>
 <20211108034254.ycdhvkdng63abput@Johns-MacBook-Pro-3.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211108034254.ycdhvkdng63abput@Johns-MacBook-Pro-3.local>
Message-ID: <211108.86h7cmfw33.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 07 2021, John Cai wrote:

> O Sat, Nov 06, 2021 at 05:01:10AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason wrote:
>>=20
>> On Fri, Nov 05 2021, Junio C Hamano wrote:
>>=20
>> > "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >
>> >> @@ -405,6 +405,11 @@ static void batch_one_object(const char *obj_nam=
e,
>> >>  	int flags =3D opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
>> >>  	enum get_oid_result result;
>> >>=20=20
>> >> +	if (opt->buffer_output && obj_name[0] =3D=3D '\0') {
>> >> +		fflush(stdout);
>> >> +		return;
>> >> +	}
>> >> +
>> >
>> > This might work in practice, but it a bad design taste to add this
>> > change here.  The function is designed to take an object name
>> > string, and it even prepares a flag variable needed to make a call
>> > to turn that object name into object data.  We do not need to
>> > contaminate the interface with "usually this takes an object name,
>> > but there are these other special cases ...".  The higher in the
>> > callchain we place special cases, the better the lower level
>> > functions become, as that allows them to concentrate on doing one
>> > single thing well.
>> >
>> >>  	result =3D get_oid_with_context(the_repository, obj_name,
>> >>  				      flags, &data->oid, &ctx);
>> >>  	if (result !=3D FOUND) {
>> >> @@ -609,7 +614,11 @@ static int batch_objects(struct batch_options *o=
pt)
>> >>  			data.rest =3D p;
>> >>  		}
>> >>=20=20
>> >> -		batch_one_object(input.buf, &output, opt, &data);
>> >> +		 /*
>> >> +		  * When in buffer mode and input.buf is an empty string,
>> >> +		  * flush to stdout.
>> >> +		  */
>> >
>> > Checking "do we have the flush instruction (in which case we'd do
>> > the flush here), or do we have textual name of an object (in which
>> > case we'd call batch_one_object())?" here would be far cleaner and
>> > results in an easier-to-explain code.  With a cleanly written code
>> > to do so, it probably does not even need a new comment here.
>> >
>> > This brings up another issue.  Is "flushing" the *ONLY* special
>> > thing we would ever do in this codepath in the future?  I doubt so.
>> > Squatting on an "empty string" is a selfish design that hurts those
>> > who will come after you in the future, as they need to find other
>> > ways to ask for a "special thing".
>> >
>> > If we are inventing a special syntax that allows us to spell
>> > commands that are distinguishable from a validly-spelled object name
>> > to cause something special (like "flushing the output stream"),
>> > perhaps we want to use a bit more extensible and explicit syntax and
>> > use it from day one?
>> >
>> > For example, if no string that begins with three dots can ever be a
>> > valid way to spell an object name, perhaps "...flush" might be a
>> > better "please do this special thing" syntax than an empty string.
>> > It is easily extensible (the next special thing can follow suit to
>> > say "...$verb" to tell the machinery to $verb the input).  When we
>> > compare between an empty string and "...flush", the latter clearly
>> > is more descriptive, too.
>> >
>> > Note that I offhand do not know if "a valid string that name an
>> > object would never begin with three-dot" is true.  Please check
>> > if that is true if you choose to use it, or you can find and use
>> > another convention that allows us to clearly distinguish the
>> > "special" instruction and object names.
>>=20
>> I had much the same thought, this is a useful feature, but let's not
>> squat on the one bit of open syntax we have.
>>=20
>> John: I think a better direction here is to add a mode to cat-file to
>> emulate what "git update-ref --stdin" supports. Here's a demo of that
>> (also quoted below):
>> https://github.com/git/git/commit/7794f6cfdbdca0dd6bab0dea16193ebf018b86=
a9
>>=20
>> That's on top of some general UI improvements to cat-file I've got
>> locally:
>> https://github.com/git/git/compare/master...avar:avar/cat-file-usage-and=
-options-handling
>>=20
>> That WIP patch on top follows below, of course it's a *lot* more initial
>> scaffolding, but I think once we get past that initial step it's a much
>> better path forward. As noted the code is also almost entirely
>> copy/pasted from update-ref.c, and perhaps some of the shared parts
>> could be moved to some library both could use.
>>=20
>> I couldn't think of a better name than --stdin-cmd, suggestions most
>> welcome.
>>=20
>> From 7794f6cfdbdca0dd6bab0dea16193ebf018b86a9 Mon Sep 17 00:00:00 2001
>> Message-Id: <patch-1.1-7794f6cfdbd-20211106T040307Z-avarab@gmail.com>
>> From: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjarm=
ason?=3D
>>  <avarab@gmail.com>
>> Date: Sat, 6 Nov 2021 04:54:04 +0100
>> Subject: [PATCH] WIP cat-file: add a --stdin-cmd mode
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>=20
>> This WIP patch is mostly stealing code from builtin/update-ref.c and
>> implementing the same sort of prefixed command-mode that it
>> supports. I.e. in addition to --batch now supporting:
>>=20
>>     <object> LF
>>=20
>> It'll support with --stdin-cmd, with and without -z, respectively:
>>=20
>>     object <object> NL
>>     object <object> NUL
>>=20
>> The plus being that we can now implement additional commands. Let's
>> start that by scratching the itch John Cai wanted to address in [1]
>> and implement a (with and without -z):
>>=20
>>     fflush NL
>>     fflush NUL
>>=20
>> That command simply calls fflush(stdout), which could be done as an
>> emergent effect before by feeding the input a "NL".
>>=20
>> I think this will be useful for other things, e.g. I've observed in
>> the past that a not-trivial part of "cat-file --batch" time is spent
>> on parsing its <object> argument and seeing if it's a revision, ref
>> etc.
>>=20
>> So we could e.g. add a command that only accepts a full-length 40
>> character SHA-1, or switch the --format output mid-request etc.
>>=20
>> 1. https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget=
@gmail.com/
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/cat-file.c | 116 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 115 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index b76f2a00046..afdb976c6e7 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -26,7 +26,10 @@ struct batch_options {
>>  	int unordered;
>>  	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>>  	const char *format;
>> +	int stdin_cmd;
>> +	int end_null;
>>  };
>> +static char line_termination =3D '\n';
>>=20=20
>>  static const char *force_path;
>>=20=20
>> @@ -507,6 +510,106 @@ static int batch_unordered_packed(const struct obj=
ect_id *oid,
>>  				      data);
>>  }
>>=20=20
>> +enum batch_state {
>> +	/* Non-transactional state open for commands. */
>> +	BATCH_STATE_OPEN,
>> +};
>> +
>> +static void parse_cmd_object(struct batch_options *opt,
>> +			     const char *next, const char *end,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	size_t len =3D end - next - 1;
>> +	char *p =3D (char *)next;
>> +	char old =3D p[len];
>> +
>> +	p[len] =3D '\0';
>> +	batch_one_object(next, output, opt, data);
>> +	p[len] =3D old;
>> +}
>> +
>> +static void parse_cmd_fflush(struct batch_options *opt,
>> +			     const char *next, const char *end,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	if (*next !=3D line_termination)
>> +		die("fflush: extra input: %s", next);
>> +	fflush(stdout);
>> +}
>> +
>> +static const struct parse_cmd {
>> +	const char *prefix;
>> +	void (*fn)(struct batch_options *, const char *, const char *, struct =
strbuf *, struct expand_data *);
>> +	unsigned args;
>> +	enum batch_state state;
>> +} command[] =3D {
>> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
>> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
>> +};
> I think overall this approach is cleaner and makes sense. My only
> question is, are there more commands in the future that will need some
> special command syntax? Just wondering whether YAGNI applies here.

An obvious addition is to at least add the ability to set the various
options on the fly, i.e. now you need to use --batch-check, and then
kill it and restart if you'd like the content with --batch, ditto for
--textconv.

E.g. the gitaly backend for gitlab.com keeps two cat-filfe processes
around just to flip-flop between those two, sometimes you want the
content, sometimes you're just checking if the object exists.

I'd also like to add something to expose the likes of -e and -t
directly, i.e. even with --batch-check you often want to just check
existence, but get the size too, you could supply a format, but like the
above you sometimes want the size or whatever, and killing/starting a
new process just for that is a hassle...
