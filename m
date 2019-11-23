Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7973DC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3E320707
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8zdtlxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfKWBTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 20:19:31 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33616 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWBTb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 20:19:31 -0500
Received: by mail-pg1-f172.google.com with SMTP id h27so4207319pgn.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 17:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p3hwja00mliEqjp85CNUPirjaDhJjlyg8HgEFiDu+U4=;
        b=F8zdtlxtMQNPNwX8YY1qzzQQ+dZckYTtoxhhKUHpmXVoOFf8FURqidN7Fw2CH2p3OR
         8QOhYn1CFEjjH8/ZtlrL1hSUUbHi71hGYyacS9Rvu/QWOeas/16h/e5p/QFHxtvErvMn
         SoE7ddn9ghkmf6Y7thUNra/15ZgaAbnJJaSf/KOkyvs5JC5dl+d6Tj60hQpf2I9+cPP6
         2izjiAB6iyxJb2JXiK8dGWY/3/1QQZ38y9xDPaDh+GEWhTv551cfJl0KX3l+SHF/iPw5
         PyE7a3slAPKVgsbO1U04rX8GNq1H8hHqwTV+0Ny7tWyfJWrOnn02leZMu1bs+u66JIPB
         tUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p3hwja00mliEqjp85CNUPirjaDhJjlyg8HgEFiDu+U4=;
        b=ZC3ABXvBK/ShLVI0XPaZSwcb99Hm4DuytMhvwNI8t0ZWehzYmZwzS6rwDkM0mwxMg7
         JboO+9vlgASqtHHqfNu2uzQ7F4AMixTA9ZG0gVxqUMe7oet8TcAaeORfmqJkw2XRXUyO
         rlyK5RKuNCcEFNfMCTQg2ibTlgQE+GRrUwBQ35ZwdMl4qrly1l9gWciRauZPMe78oYOp
         9gIGLDzg9WYo0Jt0r9tuFd97UECa2PoFtCwgVC6cvIm4s96rKxThjFJy5XQ85WE+C5y2
         mqDExa6iA8cXAKE0URBYs4u4Y1r6GH+M9b49nuStrzxMM3YeyvGTe5oV24l5T3ugG6/H
         Y2uQ==
X-Gm-Message-State: APjAAAVIy81WMrz4gFvHpawNXBcT29KCM4Q1837jurSh7Wwwmd1/eMvC
        +vwrmX/cz2KqDS3i4djUU/mlwQ==
X-Google-Smtp-Source: APXvYqxEbLsivSCeajTgmqdBlxKxtoherfD3xw2Jp/rdZTaFsEkIdM0UY7T54shWrgkZ26pX4R8A6g==
X-Received: by 2002:a63:c802:: with SMTP id z2mr11777092pgg.158.1574471969324;
        Fri, 22 Nov 2019 17:19:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w4sm116219pjt.21.2019.11.22.17.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 17:19:28 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:19:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191123011924.GC101478@google.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
 <20191118223819.GI22855@google.com>
 <20191119005136.GA6430@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119005136.GA6430@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 12:51:36AM +0000, brian m. carlson wrote:
> On 2019-11-18 at 22:38:19, Emily Shaffer wrote:
> > On Sat, Nov 16, 2019 at 05:45:01AM +0000, brian m. carlson wrote:
> > > On 2019-11-16 at 01:11:25, Emily Shaffer wrote:
> > > > Here's my suggestion.
> > > > 
> > > >  - Let configs handle the hook list and ordering, via 'hook.{hookname}' which
> > > >    can be specified more than once.
> > > >    - global config: hook.update = /path/to/firsthook
> > > >      user config: hook.update = /path/to/secondhook
> > > >      worktree config: hook.update = -/path/to/firsthook #eliminate the firsthook
> > > >       call
> > > >    - global config: hook.update = /path/to/firsthook
> > > >      repo config: hook.update = /path/to/secondhook
> > > >      repo config: hook.update = ^/path/to/firsthook #move firsthook execution
> > > >        after secondhook for this project
> > > 
> > > I'd like to hear more about how we handle multiple hooks that are
> > > repo-specific and don't live in the PATH.  This is a common situation
> > > for existing tools that handle multiple hooks, and it's one I think we
> > > should support.
> > 
> > I guess I'm confused about where PATH comes into play. Do you mean that
> > the hook being run relies on PATH to be set appropriately? I had
> > envisioned absolute paths in the config.
> 
> In past discussions, there's been an assumption that hooks in the config
> will be found in PATH if they're not specified explicitly, and I assumed
> (apparently incorrectly) that the same would be true here.

Ah, I think I see what you mean.

hook.update = security-heuristic-runner

where "security-heuristic-runner" is some compiled binary your employer
purchased from some vendor and distributed directly to your `/bin/`.

No, I had imagined users would achieve that by writing:

hook.update = /bin/security-heuristic-runner


> I do expect folks are going to want to use non-absolute paths, though.
> If I'm invoking the git binary in a hook, I don't care whether it exists
> in /usr/bin, /usr/local/bin, ~/bin, or somewhere else entirely.  That's
> my shell's problem to figure out.

Hm. Do you mean:

hook.update = git grep "something"

Or do you mean:

hook.update = ~/grephook.sh

grephook.sh:
  #!/bin/bash

  git grep "something" >output
  ... do something with output ...

I suppose I need to understand better how $PATH works with the latter
scenario, but my gut says "if you didn't worry about where to find the
Git binary from your script before, why are you going to start caring
now".

This led me to wonder: "Should we allow someone to pass arguments via
the hook config?" Or to put it another way, "Should we allow 'hook.update
= grep -Rin blahblah >audit.log'?" I think the answer is no - some hooks
do expect to be given arguments, for example
sequencer.c:run_prepare_commit_msg_hook().

> 
> It's also common for folks to use something like "bundle exec" in a hook
> to run a linter that's installed by the local package manager, and in
> order to do that, you have to honor PATH to find the package manager's
> binary.  That could be in a variety of places, and it could end up
> changing dynamically in a session due to a tool like RVM.

I imagine I'm missing something crucial here about why this isn't an
issue in today's hook implementation, but it would be an issue with a
config-based hook lookup. I don't think I see why the invocation would
be any different, except today find_hook() says "is it in
$GITDIR/hooks/" and tomorrow find_hook() would say "is it in config".

> 
> > > Perhaps we add a "git hook execute" subcommand that executes scripts
> > > from the hook directory.
> > 
> > Can you give an example of when you'd use it? I'm not understanding your
> > concern and I think an example use case would help me see what you mean.
> 
> Sure.  Currently, if I have pre-push hook, it lives in
> .git/hooks/pre-push.  Now, I want to have multiple hooks for that which
> are specific to my repo.  Maybe I've stuffed them into
> .git/hooks/pre-push.d/hook1 and .git/hooks/pre-push.d/hook2, since
> that's where my previous hook management system put them, but I now want
> to use those same hooks with the config style and drop the old tool.
> 
> I'd like to use "git hook execute pre-push.d/hook1" and "git hook
> execute pre-push.d/hook2" to automatically find the right hooks and
> invoke them.  Similarly, I could use "git hook execute pre-push" to
> execute the old pre-push hook.

Hmmm. I think you're describing a scenario like this:

1. I make .git/hooks/pre-push.d/hook1, .git/hooks/pre-push.d/hook2, and
   .git/hooks/pre-push.
2. Hook magic happens upstream, and now instead of living in
   .git/hooks/, my hooks live in ~/.githooks/<reponame>/.
3. I just want to run my hooks now, but where are they?

I don't envision a Git-facilitated "mv .git/hooks/
~/.githooks/<reponame>/" (or whatever). In fact, I think it could break
your scenario, because maybe you write "pre-push" to reference hook1 and
hook2 by absolute path, or by relative path to the repo directory. I
don't like the idea of doing that very much at all, which is why I
proposed hook.warnHookDir (or whatever it is I called it), which we can
later turn on by default if/when we want to chase people off using
.git/hooks/.

To your point, though. The most hands-off way to keep your previous
setup would be to add:

  hook.pre-push = /path/to/myrepo/.git/hooks/pre-push

which would invoke your springboard script and let you do whatever you
want with the contents of .git/hooks/pre-push.d/. The second most
hands-off (but more correct) way would be to add:

  hook.pre-push = /path/to/myrepo/.git/hooks/pre-push.d/hook1
  hook.pre-push = /path/to/myrepo/.git/hooks/pre-push.d/hook2

I think we may be talking past each other, because when I hear you
describe what you want from 'git hook execute <...>', it sounds like you
are asking for 'git hook' to just do:

  $ $(git config core.hookdir)/$3

and that confuses me because I'm having trouble figuring out why you
couldn't just do that yourself. So I'm sure I'm still not understanding
something correctly.

This is kind of the use case I was hoping to account for by providing
'hook.runHookDir' - hooks in .git/hooks/ still "just work", by taking
the contents of that dir into account while composing the list of hooks
to run.

> 
> I suppose if we continue to keep the existing behavior of changing the
> directory and we pass the config options to the shell, then we could
> just write "$(git config core.hooksPath || echo
> .git/hooks)/pre-push.d/hook1" instead, which, while ugly, gets the job
> done.  Then we wouldn't need such a command.

Yeah, I am wondering about when you want to run a hook generically (i.e.
from a noninteractive script) but outside of the context of something in
the Git binary invoking a hook. Are you thinking of Git commands
implemented as scripts?

I wonder if the script use case is better served by something like 'git
hook list pre-push --porcelain' which could compose the full list of
hooks to run, taking into account hook.runHookDir and provide them in a
script-readable way. Or, a simplification on your suggestion: 'git hook
execute pre-push" which does the same thing, but runs them all for you
too.

> > > I think this addresses most of the concerns that I had about ordering.
> > > It is still a little suboptimal that we're relying on the ordering of
> > > the config file, since it makes things equivalent to numbered files in
> > > .d directories hard.
> > 
> > Hm, I suppose I don't see why, if the final ordering is determined by
> > the .git/config (or future replacement for that). Can you explain what
> > you mean? I want to understand where you're coming from.
> 
> One of the benefits to using numbered files in a .d directory is that
> you can explicitly control ordering of operations.  For example, maybe I
> have a per-repo pre-push hook that performs some checks and rejects a
> push if something is off.  I also have a pre-push hook for Git LFS that
> pushes the Git LFS objects to the remote server if Git LFS is in use.
> 
> In this case, I'd always want my sanity-check hook to run first, and so
> I'd number it first.  This is fine if both are per-repo, but if the LFS
> hook is global, then it's in the wrong order and my LFS objects are
> pushed even though my sanity check failed.

Yeah, this is really compelling, and also removes the somewhat wonky ^
proposed just below here. I like this idea quite a lot:

hook.pre-push = 001:/path/to/sanity-checker

I'll have to ponder on the UX of a 'git hook'-facilitated interactive
edit of the hook numbering, though. UX is not my strong point :)

> 
> > > Possibly as an alternative to the ^ syntax, we could make the hook value
> > > be of the form "key program", where key is a sort key (e.g., a number)
> > > and program is the program to run.  We pick normal config file ordering
> > > if the keys are identical.  Then if the system config wants to have a
> > > hook that always runs at the end, it can do so easily.
> > 
> > Interesting. This way if you decide after you've set up all your configs
> > just so that you really want something to run at the end of the update
> > event, you can change one place, not n=number of Git repos. (I do still
> > want to be able to say "don't run that global hook in this project"
> > though.)
> 
> Exactly.  A global or per-user commit-msg hook may want to see the final
> message before approving or rejecting it, and that wouldn't be possible
> without some sort of ordering.
> 
> I strongly agree that we should still allow removing higher-level hooks.
> 
> > > In addition, we should be sure that attempting to remove a hook which
> > > doesn't exist isn't an error, since a user might want to set their
> > > ~/.gitconfig file to always unset a global hook that may or may not
> > > exist.
> > 
> > I'd be comfortable with a warning when exiting 'git hook edit' mode and
> > silence when actually running the hook list.
> 
> Yeah, that's what I'm going for.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

Thanks for being patient as I wrapped my head around this enough to
reply.

 - Emily
