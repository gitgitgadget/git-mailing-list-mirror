Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460BC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 13:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiKHN0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiKHN0a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 08:26:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3E1834A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 05:26:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id 13so38651176ejn.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 05:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7p0B20EmDvqkP+jr4OJqvINC6P76UjghP67YFTwg/8w=;
        b=RBHOUjKv85CT+yODM6/Geixse9gBivwJpvOcNFH0gT0qkpQE6yYlLsNN3jTPjX47nA
         IjB3aMTDV44yZ+gL+vJHxdvzrUCXIQYlRzinbQhQhpoGZ9qLXUmT0Amz7qtWHUvfvnpk
         lKk2s3MPYfizlEAHoP+Cu/VdUIGz2BXDzwegEc5EtfudsLECKHMus1RM183cCWOc3uWH
         6iyuNeCizMZOFS73v02Dzs+RY0R47Efu6wf3pF+aidK6bbPpaEX3N+7qH7OZFc0rnryj
         +o+8cfFd+Gva4UvHG03QfPurHaQ6Ev1Unc/Tyx8+IMeJUJEa8Lp9AQ1rzrdbjVUIQohS
         YnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7p0B20EmDvqkP+jr4OJqvINC6P76UjghP67YFTwg/8w=;
        b=VF7rd0IgsCyin7OYNQuFbU/ufpgslXrlTadUDqSr7PvBvEG8rjOY4RBK237HeH/e7f
         +KTjgcC+pSppjshnZJfhTLQEJygEHDKLSGIf5GCYMa7+NfGM8T4kkKc7H+g5Gm2dz8Lh
         j0c4FKcnqsQwufdDxzgSU1aWMcqlByuahRbD7SuuqhHTNynokwUZlIaHYjsh1nwxOzuX
         1IS6jPQw/hov29yeHxITalWnKc2TzYoke9w1YLkBoxmCNicWHlN3Xw44jMyt9HWQdB6r
         OYbb4tQXcttSqNLCcnrxXPyzS92748MZtkfjZpWqvARBn3ygEZTcRh1MLeam9ls6HmQi
         VnPQ==
X-Gm-Message-State: ACrzQf3L9fOqOa0c1lkV+49fqxU8tKyFrI+Zk+BK6WACcXMCkTozCY1u
        q/u6N9jnKtsdic3AIdAJdUo=
X-Google-Smtp-Source: AMsMyM5zm/4cUiogA/JjGp65VCSCk/LmlMwz5P79Fw6sGMyCtrgbTwl01rbUQmr6OmN4Vd//8VHbsw==
X-Received: by 2002:a17:906:da85:b0:741:40a7:d08d with SMTP id xh5-20020a170906da8500b0074140a7d08dmr55740108ejb.263.1667913988102;
        Tue, 08 Nov 2022 05:26:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0078df3b4464fsm4690820eje.19.2022.11.08.05.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:26:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osOcU-000Y3w-26;
        Tue, 08 Nov 2022 14:26:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Tue, 08 Nov 2022 14:22:41 +0100
References: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
 <20221108130606.82005-1-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221108130606.82005-1-tenglong.tl@alibaba-inc.com>
Message-ID: <221108.86pmdxshkt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Teng Long wrote:

> "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avarab@gmail.com> writes:
>
>> >  	int allow_empty =3D 0;
>> > +	int blankline =3D 1;
>>
>> So keep this...
>>
>> >  	const char *object_ref;
>> >G  	struct notes_tree *t;
>> >  	struct object_id object, new_note;
>> > @@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv=
, const char *prefix)
>> >  			parse_reuse_arg),
>> >  		OPT_BOOL(0, "allow-empty", &allow_empty,
>> >  			N_("allow storing empty note")),
>> > +		OPT_BOOL(0, "blank-line", &blankline,
>>
>> ...and just make this "no-blank-line", and parse_options() will do the
>> right thing. I.e. PARSE_OPT_NONEG is implied.
>
> Sorry for another question. By the explanation of "api-parse-options.txt"=
 :
>
> `OPT_BOOL(short, long, &int_var, description)`::
> 	Introduce a boolean option. `int_var` is set to one with
> 	`--option` and set to zero with `--no-option`
>
> I think it means the same as "parse_options() will do right thing" as you=
 said
> to me , but...after the modification the effect is opposite:
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index a6273781fb8..73427ea8dff 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -562,6 +562,7 @@ static int copy(int argc, const char **argv, const ch=
ar *prefix)
>  static int append_edit(int argc, const char **argv, const char *prefix)
>  {
>         int allow_empty =3D 0;
> +       int blankline =3D 1;
>         const char *object_ref;
>         struct notes_tree *t;
>         struct object_id object, new_note;
> @@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, c=
onst char *prefix)
>                         parse_reuse_arg),
>                 OPT_BOOL(0, "allow-empty", &allow_empty,
>                         N_("allow storing empty note")),
> +               OPT_BOOL(0, "no-blank-line", &blankline,
> +                       N_("insert paragraph break before appending to an=
 existing note")),
>                 OPT_END()
>         };
>         int edit =3D !strcmp(argv[0], "edit");
> @@ -618,7 +621,7 @@ static int append_edit(int argc, const char **argv, c=
onst char *prefix)
>                 enum object_type type;
>                 char *prev_buf =3D read_object_file(note, &type, &size);
>
> -               if (d.buf.len && prev_buf && size)
> +               if (blankline && d.buf.len && prev_buf && size)
>                         strbuf_insertstr(&d.buf, 0, "\n");
>                 if (prev_buf && size)
>                         strbuf_insert(&d.buf, 0, prev_buf, size);
>
> ----
> So, I am a bit confused and I guess maybe somewhere I misunderstood or di=
dn't
> notice some details.
>
> Thanks.

Sorry, I meant that in both cases it will expose the same options to the
user: --blank-line and --no-blank-line. I.e. if you create options
named:

	"x" "x-y"

Their negations are: --no-x and --no-x-y. But if their names are:

	"x" "no-x"

The negations are:

	--no-x and --x

But as your example shows that's unrelated to whether the *variable in
the code* is negated.

So however you structure the code, which would be:

	int blankline =3D 1:
        [...]
	OPT_BOOL(0, "blankline", &blankline, [...]);

Or:

	int no_blankline =3D 0:
        [...]
	OPT_BOOL(0, "no-blankline", &no_blankline, [...]);

The documentation could in both cases say:

	--no-blankline:
		describe the non-default[...]
