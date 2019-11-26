Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A3DC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B01520674
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GA2dHSUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfKZA4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:56:20 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35236 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 19:56:20 -0500
Received: by mail-pf1-f181.google.com with SMTP id q13so8282904pff.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8D1ZvWPgEIQXFK6ceKbJskoH3tEmKsSlFWVi1JACplk=;
        b=GA2dHSUC3ZclM0TbvYZTzzrJHcW29rHgssXqAk4L1agoA0TgqUXFw2IBl20lpK1ZJx
         0yo0JJ2dAP7J8OG8YLIBWQ7UFmStLrMgr8BUtumcK3dg6C9OhugCA2VLMVHUM7uq7CxH
         sIEvOULJxi9zpE+ADUsS5ryUg7oCHFhqGTNLTjH+AXXemkRXQRcdiEduCKIc0TVSc0rY
         KxZqLRWAhGlls3oz3C3s6PAYY/s6KipMcj1wc3a/e61l2q5A4bgY+2RDrj1/trRV5ogx
         OXMxzGlSfUsc5spBpFdQVh6nslcftgbfFUnK4fXqb24WarJDy7Ewww5qWwKway5DaSP3
         qTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8D1ZvWPgEIQXFK6ceKbJskoH3tEmKsSlFWVi1JACplk=;
        b=uVUhfNkYZGNp1nbP+32bNeaFAetSeUO+Fu5zxpHkBd3KLSeLM5EJHg30DGI1v0U8TQ
         Cwi2SNXBhva/huPa8P1Mt1uXnr7DcpZ9MzSA0NlkAwwADnbs80qOdpOJimG2+dC8ZbKZ
         MCaipJKyVOswmXiIUIJlmVmHIG2z7nuU8HH4XaXDaFiDzdVRizJQvMEtURBXOIzpw1md
         COYNrSWQQdRJU22Ha3PxlkpNsFwXcv2hfDHaz1LNH3xd2O9Ki1aTzJZ+KzFFJg4q3JP8
         dqPMKsCI1Ob5rg5OxyjafKfweyOufTHvBz9Rh0JKBrflSBFJyWtTmnBqEEoYqFcDGXF3
         vRlQ==
X-Gm-Message-State: APjAAAVTVGvX0L5x7kiizbWkDrskoYZWCjStdZWnRRRUR9Fp5UF/wVZQ
        mPAoohEnpX6YoBnNwhtUeFNhfw==
X-Google-Smtp-Source: APXvYqzvP/jxCAxO7VDzI6gg7OOkRwoydsIMeTRHJ1wKmDg4JJMsqhGuGQ3woIM2AaGaF+aOZPgTWQ==
X-Received: by 2002:a62:154:: with SMTP id 81mr14895228pfb.126.1574729779070;
        Mon, 25 Nov 2019 16:56:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w15sm9420889pfi.168.2019.11.25.16.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:56:18 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:56:14 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191126005614.GA251804@google.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
 <20191123011924.GC101478@google.com>
 <20191125030445.GB2404748@camp.crustytoothpaste.net>
 <20191125222113.GA83137@google.com>
 <20191126002806.GD2404748@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126002806.GD2404748@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 12:28:06AM +0000, brian m. carlson wrote:
> On 2019-11-25 at 22:21:13, Emily Shaffer wrote:
> > I think that you are saying we should do the nice equivalent of:
> > 
> >   system("git lfs pre-push");
> > 
> > and tack the args onto the end. (I suppose that's run-command.h, but I'm
> > trying to use a shorthand that is easy to understand.)
> 
> Yeah, I'm proposing we run the command using run-command.c with the
> use_shell flag, which does something very much like that, except a
> little bit saner.
> 
> > It seems like this would solve the PATH issue, yes. However, I feel
> > tentative because of pushback on that approach in the bugreport review.
> > Hmmm. I think this is different, because the user understands that the
> > hook they configure themselves will be invoked on the shell of their
> > choosing. That is, I think run-command.h with "C:\myhook.exe" would
> > still work, no?
> 
> This will always use /bin/sh, as we do for editors.
> 
> bash on Windows does understand the Windows paths and works correctly in
> this case, AIUI, so that should be fine.
> 
> > Will this approach "just work" for Windows, et al.?
> 
> Yes.  Windows ships with bash (or in Portable Git, busybox sh), which is
> not only required to run the testsuite, but required to invoke editors.
> 
> > > I do, however, think we should require folks to have a suitable hook
> > > that accepts the right arguments.  So "git grep blahblah" isn't a valid
> > > hook in most cases, because it doesn't take the right arguments and read
> > > the right data from stdin if necessary.
> > 
> > I'm not sure how we would guarantee that. Are you suggesting we should
> > try dry running a hook somehow when it's added with 'git hook add'? Even
> > doing that won't stop someone from popping open ~/.gitconfig with nano
> > and adding their hook that doesn't take the right args that way.
> 
> We don't need to guarantee that.  We just need to document it, so that
> (a) people write hooks in the expected way and (b) if people don't, we
> can point them to the documentation and explain why their hooks don't
> work.  I can see people thinking of this as a set of commands that just
> checks exit statuses, and there's likely to be confusion.
> 
> > > I'm just thinking about existing hook wrappers that invoke multiple
> > > scripts at the moment, something like how
> > > https://gist.github.com/mjackson/7e602a7aa357cfe37dadcc016710931b works
> > > at the moment and how we'd replace that with a config-based model.
> > > 
> > > I think using the shell avoids the entire proposal, because it then
> > > becomes trivial to script that in the command and port it over, since we
> > > can use my ugly hack above.
> > 
> > Still not sure I understand what the issue was before. Is it that the
> > trampoline script needs to know $PATH to be able to invoke the child
> > hooks in hookname.d? Or it's because the current working directory
> > isn't clear, so a relative path in the trampoline script may not be
> > resolved well?
> 
> I think we need to have either (a) a way to explicitly invoke hooks
> underneath the hook directory or (b) a shell invocation to allow looking
> up the hook directory.  People want to have per-repository hooks that
> are not a part of the project, and they need a place to store them,
> which is logically the hook directory.
> 
> If we want to allow people to have multiple hooks under something like
> .git/hooks/pre-push.d, then we need to have a way to wire them up in the
> configuration using the correct location of the hook directory instead
> of using a helper script like the one I linked above.
> 
> We don't know that the hook directory will necessarily be under
> .git/hooks, so if the user has moved it elsewhere, we'd want to follow
> that.  A relative path would be wrong if the user changed the hook
> directory to a different location.

Hopefully I am not beating a dead horse here but I really want to
understand. Let me take another guess with examples at what you mean;
please correct me!

For our purposes, let's assume:

.git/hooks/
  update
  update.d/
    update-1
    update-2

update:
  #!/bin/bash

  ./git/hooks/update.d/update-1 &&
  ./git/hooks/update.d/update-2

The goal is to make sure update-1 and update-2 are run when other update
hooks happen.

With my proposal as is, I see two options:

1)
.git/config:
  hook.runHookDir = true

This will run whatever else is in hook.update, and then it will run
.git/hooks/update. This is not ideal because hookDir could change, and
then the content of update will be incorrect:

  git config --add core.hookdir=~/hooks/
  mv .git/hooks/update* ~/hooks/
  # call something which invokes update hooks
  # ~/hooks/update fails, .git/hooks/update-1 is gone :(

2)
.git/config:
  hook.update = 001:/project/path/.git/hooks/update.d/update-1
  hook.update = 002:/project/path/.git/hooks/update.d/update-2

This will run each update hook individually and have no notion of
whether they're in a "hook dir" or not. It sees a path, it hands it to
'sh' to run, it checks the return code.

Now I run 'mv .git/hooks/update* ~/hooks/'. Next time I invoke something
which would run the 'update' hook, it fails, because the path in the
config isn't pointing to anything. But this way is unrelated to hookdir.

It sounds like you might be asking for something like:

.git/config:
  hook.update = 001:__HOOKDIR__/update.d/update-1

I'm not sure that I like the idea of this. My own dream is to eliminate
the need for a hookdir entirely, so it's logically easy for my Gerrit
hook to live in ~/gerrit-tools/ and my linter to live in ~/clang-tidy/
and so on.

I could see option 1 being alleviated by writing it as something like:

update:
  $GIT_HOOKDIR/update.d/update-1 &&
  $GIT_HOOKDIR/update.d/update-2

or
update:
  $(git config core.hookdir)/update.d/update-1 &&
  $(git config core.hookdir)/update.d/update-2

But, I think once you "buy in" to the idea of providing a full path to
the final target - not to a trampoline script - in your config, you
should forget about the idea of "core.hookdir" having anything to do
with it.

To quote you out-of-order now:

> If we want to allow people to have multiple hooks under something like
> .git/hooks/pre-push.d, then we need to have a way to wire them up in the
> configuration using the correct location of the hook directory instead
> of using a helper script like the one I linked above.

I think I may spot the misunderstanding. It sounds like you hope someone
can provide "hook.update=001:~/update.d/" and have all the contents of
update.d executed. I'll be clear and say that I didn't have the
intention to support that at all; instead I was hoping to support a case
like 2. above. Recursing through directories like that sounds scary to
order.

Hmm. Maybe it makes slightly more sense to support something like 'git
hook add update ~/update.d', which provides an editor where you can add
ordering numbers and config scope to each, but resolves to a config
which looks like option 2. above.

Are you pushing hard for this update.d case in the hopes that someone
can 'set and forget' a hook directory like that, and be able to add new
hooks there without changing the configuration? It sounds tricky to me,
as we then get to deal with more questions like:

 - how do we order hooks in that directory?
 - how should 'git hook list' display those hooks?
 - how would you use 'git hook' to reorder those hooks?
 - do we really want a user to 'git pull' and be running an entirely new script
   they didn't mean to, without any additional interaction? (and maybe
   we do - 'git pull' in a repo where you have asked to run hooks from,
   and then hook behavior changes, might not actually be surprising.)

 - Emily
