Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE158C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 19:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350732AbiDLTUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiDLTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 15:20:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7136B7C
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:18:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g18so14315616ejc.10
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Tp4+rrvNnf7FyGbcl0xEDGYPiVB/WxOPwDa3eg7ntcw=;
        b=CiQbCYzFvzwCLYFZ962i+hHquA4CAZRoIchpE2D3e25KEVpdzlk7GrouS0QZ9TjNDd
         8nKqelUB9kge4vgT4vYBt6tZKKAhD8Md5j3xrQztydAPUt0sVJyTjDpud6wT8jtBcqje
         9QG31Gyo/GFIz9bv3VeQzVhUD4NVMadCpqOus5xk21EeNKc7ZHvE3RmEzERJC1Vvvd3G
         y10zRGZ7JN5veqWi3azouc1ACEhj8/S/drjEZtWPZxvEzHC6ECN3Yfm/7PQEpZTWSdkl
         dBGEScLBiwofJBV7OueXYldUEXwzmwgrTMRKer5ag1adAHq4tihHzyEBDp0vu2DseEdl
         sVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Tp4+rrvNnf7FyGbcl0xEDGYPiVB/WxOPwDa3eg7ntcw=;
        b=7rh9NGzZCuG9SSzhA5PqEaM0emCDFqeeFeIU0YK2SgL44y2q5TgB052QovIjH9Zbxd
         sgPcxKE7bVpyaez4rMjxja7qiEygGAlueyS/Vz89f4OAx1t5215ZPglftG/b+pEwXC4t
         ipObow0durQ741NJndI5DhRjfF69R5iMnnYmrQbd0X2oB0w2yOEHK4VBwuKfLpsjiUy1
         IEUALmQ8n0nw5/mPpTaYCfvLcwemtapiABF42USS31ZQ00NRxyb7frO3TZVjnG+9YjFh
         sV+GQ23VwYJmQNjdIpPB2Ub7xDfmJN9BUaW+PLhxn8v//jVQ4hX8VbKnfSfU/jiQXkPY
         sK7g==
X-Gm-Message-State: AOAM530U/SCo1QkzDMewG1oZlH8xeSssmKLo7zF9drA8ys9iaLDcS+Ey
        vDJz7Ju6g0AQqAY91edHudE=
X-Google-Smtp-Source: ABdhPJwo8mFc5yc6X+6eo6ym5G8awbqZlA/5KtiaRYP8jWelHk8nzc341JAL2Vsy90gQKUp4xOZCVA==
X-Received: by 2002:a17:907:3e82:b0:6e1:3fe3:9b14 with SMTP id hs2-20020a1709073e8200b006e13fe39b14mr35709210ejc.561.1649791110734;
        Tue, 12 Apr 2022 12:18:30 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906180600b006e88b6bf988sm3285275eje.166.2022.04.12.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:18:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neM21-004n7l-HH;
        Tue, 12 Apr 2022 21:18:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: CVE-2022-24765 and core.sharedRepository (was: What's cooking in
 git.git (Apr 2022, #03; Tue, 12))
Date:   Tue, 12 Apr 2022 20:55:50 +0200
References: <xmqq8rsab5do.fsf@gitster.g>
 <8698e468-5552-77a3-10c7-933affd98832@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8698e468-5552-77a3-10c7-933affd98832@gmail.com>
Message-ID: <220412.86h76yglfe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Philippe Blain wrote:

[A change of $subject seems in order]

> Le 2022-04-12 =C3=A0 13:04, Junio C Hamano a =C3=A9crit=C2=A0:
>>=20
>>=20
>> Security releases for the 2.30-2.35 maintenance tracks have been
>> tagged to address CVE-2022-24765, which allows a user to trick other
>> users into running a command of their choice easily on multi-user
>> machines with a shared "mob" directory.  The fix has been also
>> merged to Git 2.36-rc2 and to all integration branches.
>>=20
>
> This is quite a big behaviour change for some environments [1], so I woul=
d think maybe it
> deserves to be fully spelled out in the release notes for 2.36.0,
> instead of just referring readers to the release notes for the maintenance
> release, where they can read a full description only in the release notes
> for 2.30.3 ?

Yes, I think it deserves to be noted very prominently, and also that we
had some mechanism for publishing relevant git-security@ discussions
(possibly with some parts redacted) after the issues become public.

Non knowing if others involved are OK with being quoted I'll just say
that this issue was discussed at some length on the list, in particular
that it'll severely hinder some core.sharedRepository workflows.

Quoting (part of) my own reply from one of those exchanges (this is in
reply to Johannes Schindelin):

	But I don't understand why we need to immediately die() when we detect
	this situation in setup.c.
=09
	Why don't we just detect it, then set a:
=09
	        naughty_fsmonitor =3D "/scratch/.git"
=09
	And then later:
=09
	        diff --git a/config.c b/config.c
	        index 383b1a4885b..c9ac12e47b0 100644
	        --- a/config.c
	        +++ b/config.c
	        @@ -2630,6 +2630,9 @@ int git_config_get_fsmonitor(void)
	         {
	                if (git_config_get_pathname("core.fsmonitor", &core_fsmoni=
tor))
	                        core_fsmonitor =3D getenv("GIT_TEST_FSMONITOR");
	        +       else if (naughty_fsmonitor)
	        +               die(_("zOMG we got a core.fsmonitor setting from a=
 possibly bad path '%s' ..."),
	        +                   git_config_get_fsmonitor);
=09
	                if (core_fsmonitor && !*core_fsmonitor)
	                        core_fsmonitor =3D NULL;
=09
	Where the "..." would be some version of your advice in 2/2 about
	safe.directory, which would also cause "naughty_fsmonitor" to remain
	NULL in this case.
=09
	Doesn't that give us all of the relevant security mitigation without
	potentially breaking users in the wild who are relying on git to work in
	the core.sharedRepository case?
=09
	To Edward's upthread "I will wager a handsome sum[...]" comment: An
	ex-employer has exactly that setup, with AFAIK on the orders of thousand
	of users (a shared directory deployment system across a fleet of
	"staging" servers).
=09
	I'd really like us to avoid unduly disrupting those kinds of setups if
	we can help it.
=09
	In this case doing so seems like a rather easy addition: Let's ignore
	and/or die on the combination of this sort of "unsafe" directory and
	core.fsmonitor in particular. No?

That patch doesn't apply anymore (recent fsmonitor changes), but I still
think something like that would be a nice thing to have, e.g. being able
to configure in /etc/gitconfig that "this system is OK with not needing
safe.directory whitelisting, except maybe for core.fsmonitor".

Hopefully Johannes will chime in, but I think it's fair to say that
(this is just a summarizing from memory, I've surely missed some bits):

 * Yes, for the *known* issues we could go for a much more narrow
   solution (something like the above).

 * There are other bits of config that also point to executable things,
   e.g. core.editor, aliases etc, but nothing has been found yet that
   provides the "at a distance" effect that the core.fsmonitor vector
   does.

   I.e. a user is unlikely to go to /tmp/some-crap/here and run "git
   commit", but they (or their shell prompt) might run "git status", and
   if you have a /tmp/.git ...

 * Third-party software is also a wildcard here, i.e. we can know that
   for git itself we have such-and-such interaction with core.editor or
   whatever, but is the same true of the plethora of third-party git
   integrations?

 * Johannes et al were concerned that with the cat being out of the bag
   (as it were) other similar issues would be poked at/discovered.

 * Therefore a more thorough initial solution was preferred.

And maybe?:

 * Now that this is out, the people involved would be OK with discussing
   something more surgical, in particular to accommodate the
   core.sharedRepository case (after the current rc phase, preferably).

In any case, the core.sharedRepository case isn't personally my itch to
scratch anymore, so I'm not going to pursue this, but perhaps someone
else is interested...

> [1] the commit message for the change mentions "shared directories",=20
> but in some environments, it is quite common for each user to have
> read access to other uers's home directories. I'm mostly thinking about
> high performance computing clusters, which is the kind of systems I have=
=20
> experience with. This makes it really easy for local
> "git experts" to 'cd' into a colleague's repo and help them when they=20
> are facing a Git problem. The fact that it won't be possible to do that
> without manually invoking 'git config --add safe.directory $PWD' beforeha=
nd
> is a little sad... What were the arguments for specifically disabling
> 'git -c safe.directory' for this fix ?

I wasn't aware/hadn't noticed that aspect of it, but I don't think
that's "by design" or whatever, but just an "and by the way..." in
8959555cee7 (setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02).

I.e. for no particularly good reason other than historical codebase
growth we'll parse the command-line in git.c after we run the setup.c
bits, which I believe is the reason this isn't supported on the
command-line.

The same is true for the trace2.* config, which likewise is for no
particular reason other than nobody felt like refactoring that tricky
core bit of code to make it work.

I.e. if you go back and read the discussions when the trace2.* config
was added it was essentially a "yeah, -c would be nice, but this is good
enough", and not "we'd like to forbid -c by design".

I hope all of that helps.

P.s.: For anyone wanting to hoist the "-c" handling earlier this is
probably a good start:
https://lore.kernel.org/git/220128.8635l7d7y6.gmgdl@evledraar.gmail.com/
