Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E7C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E43220640
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 23:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H515V45m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLBXqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:46:15 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:43767 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBXqP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 18:46:15 -0500
Received: by mail-pf1-f176.google.com with SMTP id h14so669049pfe.10
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 15:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=poR1QbChCUxSy/njpi8gALydu/xSt1MlG5H0jVVEZ0U=;
        b=H515V45mtPhm8rXefYfIug68O4/R/B4R8LfQJtVze2LHAoUGS9+mk28QGWRcohWUxo
         ks6UtGM04QPfidc483oMUabdHUcKOfGP/1Oc8mfPSZxSUZeq7P7PSwvVQJXobkxO9Ltm
         Xb9lXwwyl1rxrsB6lBPuoJSpY8dy6f/5t9OpLjNUjy8xkWEgHU9xATiAkx6mPNBfqkjm
         LXexD6a7IQCBm98HXx1qNiRVhJqcBLFnkWMSw7f+9akZqh5+JSjQD0Uw4TF54cOrBkLl
         Et/uKj+0luP2zgk7MWYA9qzd2nE01dZiCn3GOgpasVsHNJZ9S5BcGgl2ETVA9LWODhFT
         7Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=poR1QbChCUxSy/njpi8gALydu/xSt1MlG5H0jVVEZ0U=;
        b=Jp4sFJYHiiyl6KmJ93IRftoAMOvYjjnlF7xj/ERHS5HP8Eqs7Af2ZVTbjlYIK+hDtd
         jag6omXXIX74PCFFK1V2gnsc16g153FGvlRklm7bN5cdnif8LajPRFgwBXN/R+8qWZwV
         i4rKP1XbZ2aUhdjF30gbh/i0N1Eip3m0mpxGaw1a81pvkVhdOYNj9BWwmhvUuqXq5z2Q
         BOgbOhEA99StfJ9Wb3PKdB4gxDqKDLYGvm9ryfg3LCL1GHYddPKip5xc6La+8IYv5zQZ
         e8GBhKRyVDMgOfSLGZkdvUkO6cgv7OsGFJJhAEJQ6LbEY5DfMwdltAYr6HV0uULvTUkW
         Jfqw==
X-Gm-Message-State: APjAAAUKg/oS9kEMxK7bG/qSMkPUsFPiGxcIHOCVWpYTSFQ42Xr0fPcL
        cuEuMRMS5Je6SeYr+hVkmnBMUw==
X-Google-Smtp-Source: APXvYqywpuQ3Hj6t2PTJjyI+QaHHQRF/YWbP8ZD8nV/sSwmkynwJP+jcv/0P3cd3QOX4JeUFLJJR7A==
X-Received: by 2002:a63:f702:: with SMTP id x2mr1811199pgh.300.1575330372072;
        Mon, 02 Dec 2019 15:46:12 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p21sm619182pfn.103.2019.12.02.15.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:46:11 -0800 (PST)
Date:   Mon, 2 Dec 2019 15:46:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191202234605.GA17687@google.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
 <20191123011924.GC101478@google.com>
 <20191125030445.GB2404748@camp.crustytoothpaste.net>
 <20191125222113.GA83137@google.com>
 <20191126002806.GD2404748@camp.crustytoothpaste.net>
 <20191126005614.GA251804@google.com>
 <20191126024147.GF2404748@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126024147.GF2404748@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for waiting as I took half of last week off to host family for
holiday. :)

On Tue, Nov 26, 2019 at 02:41:47AM +0000, brian m. carlson wrote:
> On 2019-11-26 at 00:56:14, Emily Shaffer wrote:
> > Hopefully I am not beating a dead horse here but I really want to
> > understand. Let me take another guess with examples at what you mean;
> > please correct me!
> > 
> > For our purposes, let's assume:
> > 
> > .git/hooks/
> >   update
> >   update.d/
> >     update-1
> >     update-2
> > 
> > update:
> >   #!/bin/bash
> > 
> >   ./git/hooks/update.d/update-1 &&
> >   ./git/hooks/update.d/update-2
> > 
> > The goal is to make sure update-1 and update-2 are run when other update
> > hooks happen.
> 
> 
> 
> > With my proposal as is, I see two options:
> > 
> > 1)
> > .git/config:
> >   hook.runHookDir = true
> > 
> > This will run whatever else is in hook.update, and then it will run
> > .git/hooks/update. This is not ideal because hookDir could change, and
> > then the content of update will be incorrect:
> > 
> >   git config --add core.hookdir=~/hooks/
> >   mv .git/hooks/update* ~/hooks/
> >   # call something which invokes update hooks
> >   # ~/hooks/update fails, .git/hooks/update-1 is gone :(
> > 
> 
> This is actually fine.  We assume the user knows where they want to
> store their hooks.  If they change that, then that's intentional.
> 
> > .git/config:
> >   hook.update = 001:/project/path/.git/hooks/update.d/update-1
> >   hook.update = 002:/project/path/.git/hooks/update.d/update-2
> > 
> > This will run each update hook individually and have no notion of
> > whether they're in a "hook dir" or not. It sees a path, it hands it to
> > 'sh' to run, it checks the return code.
> 
> Correct.  This is the logical porting of the above shell script to the
> config syntax if you use an absolute path.
> 
> > Now I run 'mv .git/hooks/update* ~/hooks/'. Next time I invoke something
> > which would run the 'update' hook, it fails, because the path in the
> > config isn't pointing to anything. But this way is unrelated to hookdir.
> 
> Yes, that's correct.
> 
> It sounds like you're thinking of the config approach as completely
> orthogonal to the hook directory.  However, I want to have multiple
> per-repository hooks that do not live within the repository but move
> with it.  The logical place to store those hooks is in the hook
> directory, even if it's not being invoked by Git explicitly.  To use
> that with the config approach so I can have multiple hooks in a useful
> way that's compatible with other tools, I need some way to refer to
> whatever the hook directory is at a given point in time.

This sounds like a use case we can expect other users to want to work.
It is very different from the way I think about and use hooks, so I'm
glad you explained it to me.

(For the record, the way I think of hooks is something like this: I want
all repositories to run git-secrets before I push; I want a handful of
repositories to run the Gerrit Change-Id hook after I commit; I want one
repo to run linter A, and three or four other repos to run linter B. So
I tend to think "how can I apply hooks I have downloaded a la carte to
my repositories?" You seem to be thinking "how can I write hooks for one
repository?" They are both totally valid, of course.)

> 
> > It sounds like you might be asking for something like:
> > 
> > .git/config:
> >   hook.update = 001:__HOOKDIR__/update.d/update-1
> > 
> > I'm not sure that I like the idea of this. My own dream is to eliminate
> > the need for a hookdir entirely, so it's logically easy for my Gerrit
> > hook to live in ~/gerrit-tools/ and my linter to live in ~/clang-tidy/
> > and so on.
> 
> Using the config syntax eliminates per-repository storage for hooks.  I,
> personally, want to store multiple one-off hooks in my hooks directory.
> I want to use tools that install one-off hooks into my repository
> without needing to depend on the location of those tools in the future.
> I don't want those hooks to live elsewhere on my file system, since that
> makes my repository no longer self contained.
> 
> I want to store those hooks in the hook directory, wherever I've
> configured that, and whatever that happens to be at this point in time.
> 
> I may additionally have tools that live in other locations as well and
> may use other syntaxes to invoke them.  For example, I may install a
> hook that's provided by a Debian package and refer to it using a bare
> program name.
> 
> If your goal is to eliminate the hook directory entirely, then I can't
> say that I'm in support of that.  A design which does that won't meet my
> needs, and it likely won't meet the needs of other users.

Internally, that is our goal, absolutely. However, you yourself are
proving it's not a reasonable goal for the entire world. That was
somewhat expected, which is why I hoped "hook.runHookDir" and
"hook.warnHookDir" would provide a path for users to decide by
themselves that they don't want to use the hook directory anymore. A
self-paced hook directoy phase out seems like a good fit to make us both
happy, where your pace can be "over my dead body" if you so choose ;)

> 
> The benefit of your proposed config syntax for me is that it provides a
> standard way to configure multiple hooks.  I still want many of those
> hooks to live in the hook directory, although others may live elsewhere.
> 
> > I could see option 1 being alleviated by writing it as something like:
> > 
> > update:
> >   $GIT_HOOKDIR/update.d/update-1 &&
> >   $GIT_HOOKDIR/update.d/update-2
> > 
> > or
> > update:
> >   $(git config core.hookdir)/update.d/update-1 &&
> >   $(git config core.hookdir)/update.d/update-2
> 
> This is similar to what I want, and why I want to pass it to the shell.
> I can write the following, and everything just works:
> 
> .git/config:
>   hook.update = 001:$(git config core.hookdir || echo .git/hooks)/update.d/update-1
>   hook.update = 002:$(git config core.hookdir || echo .git/hooks)/update.d/update-2
> 
> Wherever I have placed my hooks for this repository, I can refer to
> them with a shell script.  I can also add the following line as well:
> 
> .git/config:
>   hook.update = debian-package-hook update
> 
> …and everything just works.
> 
> > But, I think once you "buy in" to the idea of providing a full path to
> > the final target - not to a trampoline script - in your config, you
> > should forget about the idea of "core.hookdir" having anything to do
> > with it.
> 
> I have no intention of providing a full path to any hook, since that's
> quite brittle.  There are very few paths on my system which can be
> guaranteed not to change, and all of them are things like /bin/sh or
> /usr/bin/env.  If my hooks are in the hook directory (or even in the
> working tree) with a full path and I move that repository, they become
> broken.  If they're shipped by Debian and Debian decides to move the
> command, they're broken.

I think this is again stemming from the different ways you and I are
thinking about our hooks, and that's fine. I'm open to the idea of
relative-path hooks, and a blurb in the interactive "git hook edit" mode
(or whatever it ends up being) explaining where relative paths will be
relative to. Is that OK for you?

> I'm very interested in learning more about why you seem to want to
> specify full paths.  It seems very at odds with the way the rest of Git
> works.

I hope my description closer to the top of this mail helps to explain.

> If the goal is to support other syntaxes in the future, then
> let's use a prefix character (e.g. !) to denote commands vs.
> non-commands or something like that.  If the goal is security, then I'd
> like to hear more about the security model you're trying to achieve with
> this design.

As for the security model, I think Jonathan explained it quite well in
the link I posted at the top of this thread. The tl;dr is that Malicious
User can hand Victim Sysadmin a .zip with a repo that is "broken",
and when Victim Sysadmin starts to explore it, she inadvertently
triggers hooks which were packaged in that .zip and compromises her
workstation. Eliminating the use of .git/hooks/ alone doesn't protect
from this - .git/config is also a vector, as one can include an alias
there - but I believe it's heading towards the right direction.

> 
> > To quote you out-of-order now:
> > 
> > > If we want to allow people to have multiple hooks under something like
> > > .git/hooks/pre-push.d, then we need to have a way to wire them up in the
> > > configuration using the correct location of the hook directory instead
> > > of using a helper script like the one I linked above.
> > 
> > I think I may spot the misunderstanding. It sounds like you hope someone
> > can provide "hook.update=001:~/update.d/" and have all the contents of
> > update.d executed. I'll be clear and say that I didn't have the
> > intention to support that at all; instead I was hoping to support a case
> > like 2. above. Recursing through directories like that sounds scary to
> > order.
> 
> I don't need a particular way to do that, since I can do it already, but
> I do need a way to wire up multiple hooks that are per-repository and
> move with the repository but aren't in the repository.  In other words,
> I need a functional replacement for that approach if we're not going to
> use that approach itself.

It sounds like simply supporting relative paths in the config, with
adequate explanation to the user about where the paths are relative to,
will solve this for you. What do you think?

> 
> Hopefully I've done a better job at explaining myself here.

Yeah, I think I made a breakthrough understanding you from this mail.
Thanks :) :)

 - Emily

