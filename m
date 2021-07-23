Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF59C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7CF60E52
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhGWItH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhGWItF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:49:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E1BC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:29:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e19so2655767ejs.9
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=s3uvsUNpNwfOlRhAYq/lusJrvXIA+7xp0BG81pyrW/s=;
        b=hAEZdXvzEUjZ28lFDkk85ClQF/ItyZrkM38i8TQ6+Ii1aWu0L/sAB5+X1hcRr0wKgA
         acsoaMPx0rcbITnwKYo1Ay8KnEQIvCU4UtX8Z+z3omC8+o/YnwOaTsFQL5n0TM9Cv0Wx
         p9AaDU1cZgQ7RdjgfwBZuJt9Y/+w/Eugxkf4hv+lfcg0i0A5+iDy939zmqPdKnAHpXWD
         xNN0kENjjT8iuaii2K+1wkFZ3XncQBrO6P6P8b5P3Npz4FGuIyTTWqFnjs2hG1eneYki
         RLqpI0Glwys2XvyIfpsq5PGBIJcjwCShTpQVH74SGo8nkOrp30ingnFIE4l5EmTW5W8G
         iJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=s3uvsUNpNwfOlRhAYq/lusJrvXIA+7xp0BG81pyrW/s=;
        b=TCfMbjqAVU3OChkNbLj4EdRvTskaE4gLlPqqA2EwMxjvESrBWqTZieUWm6oD7ayqF1
         S9pTMccA4df0VFkptHAQ7Ux1sRvtPZKS98E4qU3lqYyxo9jbVs9Iv+FCVSsR6Rx4hvTT
         P4ydMPfj6rhwTvz36G+MbIYKKIoSkhQjgMyM52lXEB5lmvVkGzFCHcyMnAB6K8rYnY2R
         YI1W5Z59BL2m4jnY7guPgMJOzG4MxRpmjDYPjxMPlEnv6i533KaZd61FLQ2Jy0ZmdCmW
         xsUXClWytM8ripQpdvxrwQbd3dT3G4MPfBKu1F/B1BRhq3QWTpss+7gLhapf196HtzSS
         wzaA==
X-Gm-Message-State: AOAM530lCm84t13KXATNeInZmTV0NCReFhRTCN9sfOdF7nCky0sgBh8P
        nBNYPBUyD5yySHargO/XXF8=
X-Google-Smtp-Source: ABdhPJwLgwv0JFN3+J0uCXTk33bFVCBtivKMq1n3p6e3VdfDIHNworBtIW8mC0DWDyjmweZUO3Ijow==
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr3706081ejj.157.1627032574516;
        Fri, 23 Jul 2021 02:29:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jw8sm10275182ejc.60.2021.07.23.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:29:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] hook: introduce "git hook list"
Date:   Fri, 23 Jul 2021 11:29:04 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-4-emilyshaffer@google.com>
 <87o8b2y6u1.fsf@evledraar.gmail.com> <YPnuvRQLzKa6h9kk@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPnuvRQLzKa6h9kk@google.com>
Message-ID: <87zguds7ho.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Emily Shaffer wrote:

> On Fri, Jul 16, 2021 at 10:52:27AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 15 2021, Emily Shaffer wrote:
>>=20
>> >  static const char * const builtin_hook_usage[] =3D {
>> >  	N_("git hook <command> [...]"),
>> > +	N_("git hook list <hookname>"),
>> >  	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
>> >  	NULL
>>=20
>> Uses <hook-name> already, let's use that too. I can't remember if it's
>> something I changed myself, or if your original version used both and I
>> picked one for consistency, or...
>>=20
>> Anyway, I can re-roll the base topic or whatever, but let's have the end
>> result use one or the other.
>
> 'hook-name' is fine, I'll use that. Thanks for pointing it out.
>
>>=20
>> > +	if (argc < 1) {
>> > +		usage_msg_opt(_("You must specify a hook event name to list."),
>> > +			      builtin_hook_usage, list_options);
>> > +	}
>>=20
>> {} braces not needed.
> ACK
>>=20
>>=20
>> > +	if (!strcmp(argv[0], "list"))
>> > +		return list(argc, argv, prefix);
>> >  	if (!strcmp(argv[0], "run"))
>>=20
>> This should be "else if" now.
>>=20
>> (Doesn't matter for code execution, just IMO readability, but I'll leave
>> that to you ... :)
>
> Eh, I think it's easier to read in the strcmps line up, so I will leave
> it this way ;)

*nod*

>>=20
>> >  		return run(argc, argv, prefix);
>> >  	else
>> > diff --git a/hook.c b/hook.c
>> > index 935751fa6c..19138a8290 100644
>> > --- a/hook.c
>> > +++ b/hook.c
>> > @@ -104,22 +104,20 @@ int hook_exists(const char *name)
>> >  struct list_head* hook_list(const char* hookname)
>> >  {
>> >  	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
>> > +	const char *hook_path =3D find_hook(hookname);
>> > +
>> >=20=20
>> >  	INIT_LIST_HEAD(hook_head);
>> >=20=20
>> >  	if (!hookname)
>> >  		return NULL;
>> >=20=20
>> > -	if (have_git_dir()) {
>> > -		const char *hook_path =3D find_hook(hookname);
>> > -
>> > -		/* Add the hook from the hookdir */
>> > -		if (hook_path) {
>> > -			struct hook *to_add =3D xmalloc(sizeof(*to_add));
>> > -			to_add->hook_path =3D hook_path;
>> > -			to_add->feed_pipe_cb_data =3D NULL;
>> > -			list_add_tail(&to_add->list, hook_head);
>> > -		}
>> > +	/* Add the hook from the hookdir */
>> > +	if (hook_path) {
>> > +		struct hook *to_add =3D xmalloc(sizeof(*to_add));
>> > +		to_add->hook_path =3D hook_path;
>> > +		to_add->feed_pipe_cb_data =3D NULL;
>> > +		list_add_tail(&to_add->list, hook_head);
>>=20
>> Maybe we should have a INIT for "struct hook" too? This also needlessly
>> leaves behind an un-free'd hook struct in a way that it wouldn't if we
>> just had this on the stack, no?
>
> I can clean it up here, but I don't think we need an initializer for
> struct hook. This code chunk gets moved into one of the list
> manipulators (append_or_move() or something) after the config is
> introduced.
>
> I don't think it leaves an unfreed hook laying around, does it?
> list_add_tail() uses the malloc'd pointer, and we free() in
> clear_hook_list(). What am I missing?

I don't think you're missing anything. I replied on that "struct hook"
in another E-Mail, i.e. I think I just misread parts of this. Thanks.
