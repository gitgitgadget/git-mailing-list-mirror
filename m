Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7513FC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbhKVS2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhKVS2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:28:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41AEC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:25:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v1so47306773edx.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wStYdvUgl1A7IK07H17PqRwrRu0bWt/L+twSjpSZeCI=;
        b=D8kODCeutjuo1nA/JCmL+pTcAT1JjLs/Ner9OVx7zBzChjHcP8AaTk2KSgO2akmf6F
         cAj4u7xCHgmuxzpS5Tnx1oEdv1b+W9wKoBUfRbacaXTUZaY18EYPHGp6Bg9d8Bv1bOI4
         W+gAK1mrXsfUQIPsqH0d0Heg8a8wQw8+ZqMIrtfa5MTbVJ5OE9DYHha60mJ2J/HwPo0H
         BLl8lmhtgwh96MPwo8E8l/FrWevLlzbQa3GXD25RoVqH0VDFuDlhJGLJ1cE1MnVVXt3P
         Gsd0k/P1nfZvKPikA9ivwKz6LldtIKeYgJR2H+VMfNWdW8fYlWcOnfe3bXBpk4MvFOkF
         DFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wStYdvUgl1A7IK07H17PqRwrRu0bWt/L+twSjpSZeCI=;
        b=Mlc5mwu5D4JJimqxsIR5VRrX29lt7jwg306NQgIJSlvUlw1oUqELt589M7pPvON4P5
         Z0ZycBazNgPyX7tHiKMHS3q/7vvhzwwDdMI0dtXq5og4h8pjWHOlHFIzidZsrTCtY1XL
         Ti/fuwqiJ7Jue9ncKNDhj/DE594L7mWsW5a9MvCgiDlCqCfCgHVATYdUHzPjXQTh8OEy
         ylMwar+2fgTTbyFMj5yjmvNJyjDFgibxf2nb/YbM1zR9IKGv7gnNEEOII2WAzQGp94Zn
         Pn1tDygG/j/M2TYryQHeGgEolVLJNqRg7yazvTu11FpnnKeT29lNkhMUxECuzNQuUBM8
         NTNQ==
X-Gm-Message-State: AOAM533wJTLfQbEIeQRp1DghoWQ8eSxbh8Nwlnp8aGkhwm90WLph4YII
        DTNgCDKVzj9YMZs8BoUBipA=
X-Google-Smtp-Source: ABdhPJx9lOZcIp8pXL+5NxDsKBzcLBzQenNv4vBDxRA/GQKsE8qUcbJnt3czFQ8+7WrT33iW3vSB4w==
X-Received: by 2002:a05:6402:5242:: with SMTP id t2mr64284620edd.98.1637605541098;
        Mon, 22 Nov 2021 10:25:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q7sm4475870edr.9.2021.11.22.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 10:25:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpE0Z-001A8O-Ux;
        Mon, 22 Nov 2021 19:25:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 5/5] run-command API: remove "argv" member, always use
 "args"
Date:   Mon, 22 Nov 2021 19:19:14 +0100
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com>
 <YZvUN0kuTpmf9Q7P@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZvUN0kuTpmf9Q7P@coredump.intra.peff.net>
Message-ID: <211122.86wnl0xd24.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Jeff King wrote:

> On Mon, Nov 22, 2021 at 05:04:07PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This change is larger than I'd like, but there's no easy way to avoid
>> it that wouldn't involve even more verbose intermediate steps. We use
>> the "argv" as the source of truth over the "args", so we need to
>> change all parts of run-command.[ch] itself, as well as the trace2
>> logging at the same time.
>
> Yeah, agreed most of this needs to come in a bundle. But at least few spo=
ts
> could be split out into the earlier patches:
>
>>  builtin/worktree.c          |  2 --
>>  t/helper/test-run-command.c | 10 +++++---
>
> as they are just users of the API.

Will split these out, I had test-run-command.c split initially, but
squashed it locally, which did away with having to explain leaving this
area untested as an intermediate step. But will split again.

>> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
>> index 3c4fb862234..b5519f92a19 100644
>> --- a/t/helper/test-run-command.c
>> +++ b/t/helper/test-run-command.c
>> [...]
>> @@ -396,7 +396,8 @@ int cmd__run_command(int argc, const char **argv)
>>  	}
>>  	if (argc < 3)
>>  		return 1;
>> -	proc.argv =3D (const char **)argv + 2;
>> +	strvec_clear(&proc.args);
>> +	strvec_pushv(&proc.args, (const char **)argv + 2);
>>=20=20
>>  	if (!strcmp(argv[1], "start-command-ENOENT")) {
>>  		if (start_command(&proc) < 0 && errno =3D=3D ENOENT)
>> @@ -408,7 +409,8 @@ int cmd__run_command(int argc, const char **argv)
>>  		exit(run_command(&proc));
>>=20=20
>>  	jobs =3D atoi(argv[2]);
>> -	proc.argv =3D (const char **)argv + 3;
>> +	strvec_clear(&proc.args);
>> +	strvec_pushv(&proc.args, (const char **)argv + 3);
>>=20=20
>>  	if (!strcmp(argv[1], "run-command-parallel"))
>>  		exit(run_processes_parallel(jobs, parallel_next,
>
> These two in particular are tricky. This second strvec_clear() is
> necessary because we are overwriting what was put into proc.args by the
> earlier strvec_pushv(). I think this is one of two interesting ways
> these kinds of trivial conversions can fail:
>
>   - somebody is relying on the fact that "argv =3D whatever" is an
>     assignment, not an append (which is the case here)
>
>   - somebody is relying on the fact that assignment of the pointer is
>     shallow, whereas strvec_push() is doing a deep copy. So converting:
>
>       cp.argv =3D argv;
>       argv[1] =3D "foo";
>
>     to:
>
>       strvec_pushv(&cp.args, argv);
>       argv[1] =3D "foo";
>
>     is not correct. We wouldn't use the updated "foo". I didn't notice
>     any cases like this during my rough own rough conversion, but they
>     could be lurking.

Yes, I tried to eyeball all the code involved & see if there were any. I
could amend this to start renaming variables, but that'll be a much
larger change.

> The strvec_clear() in the first hunk above is also not necessary (nobody
> has written anything before it), but I don't mind it for consistency /
> being defensive.

*nod*, will remove.

>> @@ -902,8 +900,9 @@ int start_command(struct child_process *cmd)
>>  #else
>>  {
>>  	int fhin =3D 0, fhout =3D 1, fherr =3D 2;
>> -	const char **sargv =3D cmd->argv;
>> +	const char **sargv =3D strvec_detach(&cmd->args);
>>  	struct strvec nargv =3D STRVEC_INIT;
>> +	const char **temp_argv =3D NULL;
>
> I wondered about detaching here, because other parts of the code
> (finish_command(), tracing, etc) will be looking at cmd->args.v[0] for
> the command name.
>
> But we eventually overwrite it with munged results:
>
>> @@ -929,20 +928,26 @@ int start_command(struct child_process *cmd)
>>  		fhout =3D dup(cmd->out);
>>=20=20
>>  	if (cmd->git_cmd)
>> -		cmd->argv =3D prepare_git_cmd(&nargv, cmd->argv);
>> +		temp_argv =3D prepare_git_cmd(&nargv, sargv);
>>  	else if (cmd->use_shell)
>> -		cmd->argv =3D prepare_shell_cmd(&nargv, cmd->argv);
>> +		temp_argv =3D prepare_shell_cmd(&nargv, sargv);
>> +	else
>> +		temp_argv =3D sargv;
>> +	if (!temp_argv)
>> +		BUG("should have some cmd->args to set");
>> +	strvec_pushv(&cmd->args, temp_argv);
>> +	strvec_clear(&nargv);
>
> So we have to do some replacement. I think the memory management gets
> confusing here, though.
>
> At this point "temp_argv" might point to nargv.v (in which case it is a
> dangling pointer after we clear nargv) or to the original sargv (in
> which case it is memory owned by us that must be freed). The former is
> OK, because we never look at it again. And the latter we eventually
> reattach into &cmd->args, but:
>
>> -	strvec_clear(&nargv);
>> -	cmd->argv =3D sargv;
>> +	strvec_pushv(&cmd->args, sargv);;
>> +	free(sargv);
>
> I think we still have all the entries we pushed into cmd->args from
> temp_argv earlier. So we'd need to strvec_clear() it before pushing
> sargv again.
>
> And then the free(sargv) is too shallow. It's just freeing the outer
> array, but sargv[0], etc, are leaked.

I'll try to fix that, but updates to this part are very painful, since
I've needed to wait 30m for each change in the Windows CI.

> I think what you really want is the equivalent of strvec_attach(). We
> don't have that, but it's basically just:
>
>   void strvec_attach(struct strvec *s, const char **v)
>   {
> 	/*
> 	 * this is convenient for our caller, but if we wanted to find
> 	 * potential misuses, we could also BUG() if s.nr > 0
> 	 */
> 	strvec_clear(&s);
>
>         /* take over ownership */
> 	s->v =3D v;
>
> 	/* v must be NULL-terminated; count up to set number */
> 	s->nr =3D 0;
> 	for (; *v; v++)
> 		s->nr++;
> 	/*
> 	 * we don't know how big the original allocation was, so we can
> 	 * assume only nr. But add 1 to account for the NULL.
> 	 */
> 	s->alloc =3D s->nr + 1;
>   }
>
> I do think this whole thing would be easier to read if we left cmd->argv
> intact, and just operated on a separate argv strvec. That's what the
> non-Windows side does. But that distinction is nothing new in your
> patch, and I'm not sure if there is a reason that the Windows code does
> it differently.

I did have this with a strvec_attach() locally, but figured I'd get
comments about growing scope & with just one caller.

This version seems to be duplicating things in the existing API though,
I just had the below, which I think works just as well without the
duplication. Perhaps you missed strvec_push_nodup()?

diff --git a/strvec.c b/strvec.c
index 61a76ce6cb9..c10008d792f 100644
--- a/strvec.c
+++ b/strvec.c
@@ -106,3 +106,9 @@ const char **strvec_detach(struct strvec *array)
                return ret;
        }
 }
+
+void strvec_attach(struct strvec *array, const char **items)
+{
+       for (; *items; items++)
+               strvec_push_nodup(array, *items);
+}
