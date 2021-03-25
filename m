Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A0C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 12:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3AB61A13
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 12:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCYMgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCYMgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 08:36:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52633C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 05:36:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so2214801edb.8
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ueyjxigKfgDyS9BFLkDRnLbAgsJUvmkz9ShqiceP8mU=;
        b=Q2q5ZDF7NPjiuZ3vi7E28BEkl/VeKdDSL7DcTwSthbXSWRD26dXZkbDxrpxaai3FeK
         G6X6SXlSxmSh1aACF1u+uv25PU8swxwjs8j453Jqi7OCIwdMuGI9o6YflvXTa/K3fZHX
         kg+I2+XRmq6NQ/GZN07Z6kz6KhKg6N7/RQ4/GFp5x4U2dwyhGbexOnPCs3aQejOW79rP
         LngOxmP7lCEZtsYSSIfjBoknLZT0iqb3+ON1YLvbTWPbMiMwgxj/+mkQYz86ctISnSaA
         nvRTXMYRMj0T1O980a0uQ5CW1wWIi/P8ATQFbvAxsoddQt2diXD01xf2tw82H7SuJmUT
         77wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ueyjxigKfgDyS9BFLkDRnLbAgsJUvmkz9ShqiceP8mU=;
        b=bYPULfz8xKdrpq2RXM/5a+cvDN8AU1K9xM5XdeaLVh/JW6KUcsjvCCbjXNteqep9fH
         Va+uK/7pBXdYiIEAlJN5FwmL0FUZoRmp1e+pRy3+nn4h1RgTVklEU/U1DWHgBiWSjEYL
         5BMud5MVqP+cmSiEV+Jk3fikVKMt913Rydolq8QXbSUcX0XiZeZ0bV5UiTwd4FEC3ruK
         0fGAaiSzRaksEsQDEXNu7xBXBCnnUqSGM9m3Qz00431XcErxaO3A2HXzXET1/J0+G/59
         4jGwP8fYrdpFchBNYV6qR+M36HYLDksx/c3FLz0FUyMRlaVj0Bmgd1pl4GWZjTFhpaWa
         cb9A==
X-Gm-Message-State: AOAM531XXsd6H3lSgp87DnL/0OB6qB1cD5lSuUMK3ws15iDU6Hcxt+2Y
        XqsLp6sLZvjQ3wBc2ZIsMm330d2/EZXGag==
X-Google-Smtp-Source: ABdhPJzXWGG500NCqWtuUZSyvzSZJ2y5+rDcf+ef0yAEGNrFmj93gKNmJ5w93JQ/AZp+NjJdxtr+Yw==
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr8770596edb.113.1616675772921;
        Thu, 25 Mar 2021 05:36:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id da17sm2661752edb.83.2021.03.25.05.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 05:36:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 03/37] hook: add list command
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-4-emilyshaffer@google.com>
 <87o8fohjgq.fsf@evledraar.gmail.com> <YFt3WOAGVKohAF6X@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFt3WOAGVKohAF6X@google.com>
Date:   Thu, 25 Mar 2021 13:36:11 +0100
Message-ID: <871rc3pg04.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, Emily Shaffer wrote:

> On Fri, Mar 12, 2021 at 09:20:05AM +0100, =C3=AF=C2=BF=C2=BDvar Arnfj=C3=
=AF=C2=BF=C2=BDr=C3=AF=C2=BF=C2=BD Bjarmason wrote:
>>=20
>>=20
>> On Thu, Mar 11 2021, Emily Shaffer wrote:
>>=20
>> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook=
.txt
>> > new file mode 100644
>> > index 0000000000..71449ecbc7
>> > --- /dev/null
>> > +++ b/Documentation/config/hook.txt
>> > @@ -0,0 +1,9 @@
>> > +hook.<command>.command::
>> > +	A command to execute during the <command> hook event. This can be an
>> > +	executable on your device, a oneliner for your shell, or the name of=
 a
>> > +	hookcmd. See linkgit:git-hook[1].
>> > +
>> > +hookcmd.<name>.command::
>> > +	A command to execute during a hook for which <name> has been specifi=
ed
>> > +	as a command. This can be an executable on your device or a oneliner=
 for
>> > +	your shell. See linkgit:git-hook[1].
>> > diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
>> > index 9eeab0009d..f19875ed68 100644
>> > --- a/Documentation/git-hook.txt
>> > +++ b/Documentation/git-hook.txt
>> > @@ -8,12 +8,65 @@ git-hook - Manage configured hooks
>> >  SYNOPSIS
>> >  --------
>> >  [verse]
>> > -'git hook'
>> > +'git hook' list <hook-name>
>>=20
>> Having just read this far (maybe this pattern is shared in the rest of
>> the series): Let's just squash this and the 2nd patch together.
>>=20
>> Sometimes it's worth doing the scaffolding first, but adding a new
>> built-in is so trivial that I don't think it's worth it, and it just
>> results in back & forth churn like the above...
>
> Yeah, I think you are right here :)
>
>> > +void free_hook(struct hook *ptr)
>> > +{
>> > +	if (ptr) {
>> > +		strbuf_release(&ptr->command);
>> > +		free(ptr);
>> > +	}
>> > +}
>>=20
>> Neither strbuf_release() nor free() need or should have a "if (ptr)" gua=
rd.
>
> I'll take free() out of the if guard, but I think
> 'strbuf_release(&<null>->command)' will go poorly - dereferencing the
> NULL to even invoke strbuf_release will not be a happy time, and
> strbuf_release internally is not NULL-resistant.

Sorry I meant something like:

    if (ptr) strbuf_release(&ptr->command);
    free(ptr);

But maybe even more idiomatic would be:

    if (!ptr)
	return;
    strbuf_release(&ptr->command);
    free(ptr);

Or some other variant of checking teh container struct early. Anyway,
this doesn't really matter, per a below comment I had more meaningful
feedback in [1]. Most of my other traffic on this topic (including this)
was some stream-of-consciousness notes as I went along.

>> > +struct list_head* hook_list(const struct strbuf* hookname)
>> > +{
>> > +	struct strbuf hook_key =3D STRBUF_INIT;
>> > +	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
>> > +	struct hook_config_cb cb_data =3D { &hook_key, hook_head };
>> > +
>> > +	INIT_LIST_HEAD(hook_head);
>> > +
>> > +	if (!hookname)
>> > +		return NULL;
>>=20
>> ...if a strbuf being passed in is NULL?
>
> Yeah, I think this is misplaced. But since it sounds like generally
> folks don't like having the strbuf at the input here, I will address the
> error checking then also.
>
>>=20
>> > [...]
>> > +ROOT=3D
>> > +if test_have_prereq MINGW
>> > +then
>> > +	# In Git for Windows, Unix-like paths work only in shell scripts;
>> > +	# `git.exe`, however, will prefix them with the pseudo root directory
>> > +	# (of the Unix shell). Let's accommodate for that.
>> > +	ROOT=3D"$(cd / && pwd)"
>> > +fi
>>=20
>> I didn't read up on previous rounds, but if we're squashing this into 02
>> having a seperate commit summarizing this little hack would be most
>> welcome, or have it in this commit message.
>
> Sure. I squashed it in from a commit dscho sent, so I can preserve that
> commit in tree instead.
>
>>=20
>> Isn't this sort of thing generally usable, maybe we can add it under a
>> longer variable name to test-lib.sh?
>
> I wonder. `git grep cd \/ &&` shows me that this hack also happens in
> t1509-root-work-tree.sh. I think most tests must use relative paths, so
> this must not be in broad use? But since it's not used elsewhere I feel
> ambivalent about adding a helper to test-lib.sh. I can if you feel
> strongly :)

After I sent this I saw that pretty much the same thing is happening in
t1300-config.sh for the --show-origin option.

    ! test_have_prereq MINGW ||
    HOME=3D"$(pwd)" # convert to Windows path

I don't feel strongly about this at all, but per the outstanding
feedback I had in[1] I wondered whether this whole thing wouln't be
better as some variant of "git config --show-origin",

1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/#t
