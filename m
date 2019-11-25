Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567CFC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 22:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1039D2071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dd4CJ+o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKYWVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:21:21 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:38288 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 17:21:21 -0500
Received: by mail-pj1-f52.google.com with SMTP id f7so7271641pjw.5
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 14:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a45iaeLiqRI0Ue+mgEVjba8tOdjTBZzcIcj6U4hihdo=;
        b=Dd4CJ+o3UuO32ONbVZ2zJ04eUSqV34YloVKaAAG5m5tQnLXWptiSEZsCYUHhtwaDqH
         57Ennrvd5qfTUz93x6Qwj5lz7NIM9JdcadQ62Cu7fzwQu+nbpBg58WZYqm5FsIFDHNI6
         EX5i1Kmzt1TCOFQjc7sSpPIXnMNTl83upL42cP18I0sS53nCcad0q9gU/FpjCz+YoZk9
         opWvFUokyK5S7Rajn8kYVppY+PwmZemIuo+iBc0vATtJpHgWlxhQmFLUvJc9LvI5+4kD
         wSbkdsCrwc/RFGDFSo7BG1bHZfA4stMnmW6WFMiSkKYRW8vURH0He+o57UNbZbE0shtJ
         lP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a45iaeLiqRI0Ue+mgEVjba8tOdjTBZzcIcj6U4hihdo=;
        b=CmS3Nfd/9SVog8ac4MPqROsW7Y5JKjOtWPg+T0a0Zc2XPJ5ypNUWiuNXqOd/ScqitA
         kQOtfzuzDBKzdygFTawcWxQD6RFBJPQUxupOBcEKvTylmOnVtIsGLgw1qF+aZPTrZXjK
         N4YW9HgO+7hDxIs2v9p9p/+ZP3Rg8hvJglP9+TStN7jwdPeR2IJ1spMDvTNUeycYm8g0
         KFqhdxHdigDgkvQtGOz/Ai3zbgDIQMWl+I24aoRh0ivE6jbnaWh8Ce+8OeTnIY1ZsJ0I
         zO5PKFdcNRNTXzjc9zAEWkL9l13MJQ2XfsRgaisDjIWow1uy2l3J253dUJxBFns2ZJ67
         nRhw==
X-Gm-Message-State: APjAAAWMkmMPrF0i0nEK/rbmxi21Q4SYdw/3p/rv429/i0W5P8xERYZ5
        jp8eC0fgiZOHEneV4GL/HLXI4A==
X-Google-Smtp-Source: APXvYqz0TJRad/LUYhZH8GW89uGtuTuRU1G/bs8Ddmf1taWbcFmGnoD8dX1YmngSSpjZpmOHf0tWJQ==
X-Received: by 2002:a17:90a:a00d:: with SMTP id q13mr1827842pjp.106.1574720479469;
        Mon, 25 Nov 2019 14:21:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id j23sm9534712pfe.95.2019.11.25.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:21:18 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:21:13 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191125222113.GA83137@google.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
 <20191123011924.GC101478@google.com>
 <20191125030445.GB2404748@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125030445.GB2404748@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 03:04:45AM +0000, brian m. carlson wrote:
> On 2019-11-23 at 01:19:24, Emily Shaffer wrote:
> > Ah, I think I see what you mean.
> > 
> > hook.update = security-heuristic-runner
> > 
> > where "security-heuristic-runner" is some compiled binary your employer
> > purchased from some vendor and distributed directly to your `/bin/`.
> > 
> > No, I had imagined users would achieve that by writing:
> > 
> > hook.update = /bin/security-heuristic-runner
> 
> Yeah, that's what I'm looking for.  The problem is that, for example,
> Debian does not guarantee where in PATH a file is.  Having a newer Git
> on RHEL or CentOS systems often involves hacking PATH and
> LD_LIBRARY_PATH.
> 
> > Hm. Do you mean:
> > 
> > hook.update = git grep "something"
> > 
> > Or do you mean:
> > 
> > hook.update = ~/grephook.sh
> > 
> > grephook.sh:
> >   #!/bin/bash
> > 
> >   git grep "something" >output
> >   ... do something with output ...
> 
> I had intended to include the latter case, but also allow valid hooks
> with multiple argument support.  For example, you could invoke "git lfs
> pre-push" directly in your hook, and that is a fully functioning
> pre-push hook, and would require a suitable PATH lookup to find your Git
> binary.  It accepts the additional arguments that pre-push hooks accept;
> right now we basically do the following instead:
> 
> ----
> #!/bin/sh
> 
> exec git lfs pre-push "$@"
> ----
> 
> > I suppose I need to understand better how $PATH works with the latter
> > scenario, but my gut says "if you didn't worry about where to find the
> > Git binary from your script before, why are you going to start caring
> > now".
> > 
> > This led me to wonder: "Should we allow someone to pass arguments via
> > the hook config?" Or to put it another way, "Should we allow 'hook.update
> > = grep -Rin blahblah >audit.log'?" I think the answer is no - some hooks
> > do expect to be given arguments, for example
> > sequencer.c:run_prepare_commit_msg_hook().
> 
> I think what we want to do in this case is just invoke things in the
> shell with extra arguments, like we do with editors.  This means we
> don't have to handle PATH or anything else; we just invoke the shell and
> let it handle it.  That lets people provide multi-call binaries (like
> git lfs) that include hooks inside them.

I think that you are saying we should do the nice equivalent of:

  system("git lfs pre-push");

and tack the args onto the end. (I suppose that's run-command.h, but I'm
trying to use a shorthand that is easy to understand.)

It seems like this would solve the PATH issue, yes. However, I feel
tentative because of pushback on that approach in the bugreport review.
Hmmm. I think this is different, because the user understands that the
hook they configure themselves will be invoked on the shell of their
choosing. That is, I think run-command.h with "C:\myhook.exe" would
still work, no?

Will this approach "just work" for Windows, et al.?

> I do, however, think we should require folks to have a suitable hook
> that accepts the right arguments.  So "git grep blahblah" isn't a valid
> hook in most cases, because it doesn't take the right arguments and read
> the right data from stdin if necessary.

I'm not sure how we would guarantee that. Are you suggesting we should
try dry running a hook somehow when it's added with 'git hook add'? Even
doing that won't stop someone from popping open ~/.gitconfig with nano
and adding their hook that doesn't take the right args that way.

> 
> > > I suppose if we continue to keep the existing behavior of changing the
> > > directory and we pass the config options to the shell, then we could
> > > just write "$(git config core.hooksPath || echo
> > > .git/hooks)/pre-push.d/hook1" instead, which, while ugly, gets the job
> > > done.  Then we wouldn't need such a command.
> > 
> > Yeah, I am wondering about when you want to run a hook generically (i.e.
> > from a noninteractive script) but outside of the context of something in
> > the Git binary invoking a hook. Are you thinking of Git commands
> > implemented as scripts?
> 
> I'm just thinking about existing hook wrappers that invoke multiple
> scripts at the moment, something like how
> https://gist.github.com/mjackson/7e602a7aa357cfe37dadcc016710931b works
> at the moment and how we'd replace that with a config-based model.
> 
> I think using the shell avoids the entire proposal, because it then
> becomes trivial to script that in the command and port it over, since we
> can use my ugly hack above.

Still not sure I understand what the issue was before. Is it that the
trampoline script needs to know $PATH to be able to invoke the child
hooks in hookname.d? Or it's because the current working directory
isn't clear, so a relative path in the trampoline script may not be
resolved well?

> I think I like that better than "git hook
> execute" because it's a little more flexible.
> 
> > > One of the benefits to using numbered files in a .d directory is that
> > > you can explicitly control ordering of operations.  For example, maybe I
> > > have a per-repo pre-push hook that performs some checks and rejects a
> > > push if something is off.  I also have a pre-push hook for Git LFS that
> > > pushes the Git LFS objects to the remote server if Git LFS is in use.
> > > 
> > > In this case, I'd always want my sanity-check hook to run first, and so
> > > I'd number it first.  This is fine if both are per-repo, but if the LFS
> > > hook is global, then it's in the wrong order and my LFS objects are
> > > pushed even though my sanity check failed.
> > 
> > Yeah, this is really compelling, and also removes the somewhat wonky ^
> > proposed just below here. I like this idea quite a lot:
> > 
> > hook.pre-push = 001:/path/to/sanity-checker
> 
> I think a colon is actually better than my proposal for a space in this
> regard, but I'm not picky: anything unambiguous is fine.

Yeah, same. I'm a little worried about a colon because there was some
conversation about being able to pick a hook in a repo from a specific
ref (i.e. I want to run 'update' hook from 'master' all the time even
when I'm examining 'third-party-topic' branch or bisecting
'nasty-bug-branch') and the colon seems to be used handily for ref +
path, but I think these details will work themselves out during
implementation, so I'm not so very worried.
> 
> > I'll have to ponder on the UX of a 'git hook'-facilitated interactive
> > edit of the hook numbering, though. UX is not my strong point :)
> 
> I also find I'm not great at UX, so I can't be of much help.

We're in luck on my end as it seems we have a UX team with open office
hours who can give us an opinion. I'll try to meet with them next week
Thursday; thanks Jonathan Nieder for the pointer.


This sounds like we both are pretty close on the same page, so I think I
will get started in the coming weeks and see if we can get a mockup to
pick at with the implementation details in front of us.

 - Emily
