Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A0C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 19:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07F120732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFnGhjRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbgDMTPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387844AbgDMTPW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 15:15:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF54C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 12:15:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o1so3359918pjs.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yMdmeSw68zj8gfYz8DR2Dn2c2aIvNiRHzjct0AzRTko=;
        b=WFnGhjRhAiaZsVFejMdUg2TIIZWU/tTYqPNFziiSPgfHBKnBknJ0qqOkqHQOjaDqaF
         gJ+SI80CDnoX9iYqnUBKbSS9QH6xn4dA7Cdqb4tul0KvOu6lBrto+XzKyQ2FcNxdqG45
         jWCRbyub6ku4DYUK/qAuoYLBqMRv8IjVbqB7a27J28oFSCVVJz0eofZoMiDw3Ym4oeub
         cqr2CcKcohOaZiKzjNC7glEhppjgnzpTG5cKvv+aTEEEILju9LbaLlAdUj6E+5HX9NQt
         rb2suRgjTjASPVxDsvyB9A9GDf4MS2dFTVq4iV0Rz7SisDkGem43ORtrAO5CJ4KfnQgF
         QCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yMdmeSw68zj8gfYz8DR2Dn2c2aIvNiRHzjct0AzRTko=;
        b=ZKpCWGmfvNCVs5PZEIVevjzu+qLucL9YVKACW98TIhNcqIyOs9BC1AT5biluLMPOXm
         dTLiL4yK+b5Z9ty2OG2ap+mwLQQkaxR8t0hsZbZwO2CV7DHUVfASi81TPjw1KZlOGtUs
         hOXvd4SqAnytqQJvGxTB/6uY7Yr4+Nmj7y2XQ/IBCPeTemB5l8bQi3PzKZCydGU8hQZ4
         14o8v4wmTlJI0wZ2Eu0BBfBHgxOs2tRgmh+MIxB64awVvBqyeUpiRaEeeQ5OreUjoX5+
         jNzCBoNCbABiTZFGxvYjkBRDboQy7C3XtyC3iCSwQ50SvNjDNxwMg5sEHyLJ/c+Yjleg
         ci3g==
X-Gm-Message-State: AGi0PubwVy8vLL1LtY2VztpvncQJedNvzJTK4xn8Mr9H2kfO9PAfWqPw
        78GNlrwypqHLjXgM56xuZVKs/pABCUE=
X-Google-Smtp-Source: APiQypJHp3mFdPi9Q5nW010B+2iCp328KyJcr9SLuxC853wQKDrJHKuy4K6Aav9iTb+PJLceGgacUQ==
X-Received: by 2002:a17:902:bf41:: with SMTP id u1mr18233577pls.331.1586805321621;
        Mon, 13 Apr 2020 12:15:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w196sm509596pfc.121.2020.04.13.12.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:15:20 -0700 (PDT)
Date:   Mon, 13 Apr 2020 12:15:15 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200413191515.GA5478@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410213146.GA2075494@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 05:31:46PM -0400, Jeff King wrote:
> On Tue, Apr 07, 2020 at 04:51:16PM -0700, Emily Shaffer wrote:
> 
> > On Tue, Apr 07, 2020 at 04:01:32PM -0700, Emily Shaffer wrote:
> > > Thoughts?
> > 
> > Jonathan Nieder and I discussed this a little bit offline, and he
> > suggested another thought:
> > 
> > [hook "unique-name"]
> >   pre-commit = ~/path-to-hook.sh args-for-precommit
> >   pre-push = ~/path-to-hook.sh
> >   order = 001
> 
> Yeah, giving each block a unique name lets you give them each an order.
> It seems kind of weird to me that you'd define multiple hook types for a
> given name.

Not so odd - git-secrets configures itself for pre-commit,
prepare-commit-msg, and commit-msg-hook. The invocation is slightly
different ('git-secrets pre-commit', 'git-secrets prepare-commit-msg',
etc) but to me it still makes some sense to treat it as a single logical
unit.

> And it doesn't leave a lot of room for defining
> per-hook-type options; you have to make new keys like pre-push-order
> (though that does work because the hook names are a finite set that
> conforms to our config key names).

Oh, interesting. I think you're saying "what if option 'frotz' only
makes sense for prepare-commit-msg; then there's no reason to allow
'frotz' and 'prepare-commit-msg-frotz' and 'post-commit-frotz' and so
on? I think I didn't do a great job explaining myself in that mail, but
my idea was to let an unqualified option name in a hook block set the
default, and then allow it to be overridden by qualifying it with the
name of the hook in question:

[hook "unique-name"]
  option = "some default"
  post-commit-option = "post-commit specific version"
  pre-push = ~/foo.sh pre-push
  post-commit = ~/foo.sh post-commit

Then when post-commit is invoked, option = "post-commit specific
version"; when pre-push is invoked, option = "some default". My
intention was to generate the hook-specific option key on the fly during
setup.

> 
> What if we added a layer of indirection: have a section for each type of
> hook, defining keys for that type. And then for each hook command we
> define there, it can have its own section, too. Maybe better explained
> with an example:
> 
>   [hook "pre-receive"]
>   # put any pre-receive related options here; e.g., a rule for what to
>   # do with hook exit codes (e.g., stop running, run all but return exit
>   # code, ignore failures, etc)
>   fail = stop

Interesting - so this is a default for all pre-receive hooks, that I can
set at whichever scope I wish.

> 
>   # And we can define actual hook commands. This one refers to the
>   # hookcmd block below.
>   command = foo
> 
>   # But if there's no such hookcmd block, we could just do something
>   # sensible, like defaulting hookcmd.X.command to "X"
>   command = /path/to/some-hook.sh

I like this idea a lot!

> 
>   [hookcmd "foo"]
>   # the actual hook command to run
>   command = /path/to/another-hook
>   # other hook options, like order priority
>   order = 123

Looks familiar enough. Now I worry - what if I specify 'fail' here too?

It seems like I may be saying "let's set a default per hookcmd" and you
may be saying "let's set a default per hook". Maybe you're saying "some
options are hook-specific and some options are command-specific." You
might be saying "we shouldn't need to set multiple option values for a
single command," and I think I disagree with that based on the
git-secrets value alone; if I'm getting ready to commit, I want
git-secrets to run last so it can look at changes other hooks made to my
commit, but if I'm getting ready to push, I want git-secrets to run
first so I don't wait around for a test suite just to find that my
commit is invalid anyways. Although, I guess with your schema the former
would be in [hookcmd "git-secrets-committing"] and the latter
would be in [hookcmd "git-secrets-pushing"], so I can set the ordering
how I wish.

(This might be an OK problem to punt on. I don't think there are any
options we have in mind just yet - even "order", we aren't sure whether
to prefer config order or an explicit number. I think if we make no
decision on how to treat per-hook options today, it doesn't stop us from
deciding on some schema tomorrow. Once we do decide, then we put it in
documentation and need to stick to it, but for now I think it's OK to
leave it undefined. We might not even need it.)

This schema also means it's easy to reorder or remove hooks later on,
which I like. A single line in my worktree config is clear:

  hookcmd.git-secrets-committing.skip = true
  hookcmd.git-secrets-pushing.order = 001
> 
> I think both this schema and the one you wrote above can express the
> same set of things. But you don't _have_ to pick a unique name if you
> don't want to. Just doing:
> 
>   [hook "pre-receive"]
>   command = /some/script
> 
> would be valid and useful (and that's as far as 99% of use cases would
> need to go).

Yeah, I see what you mean, and again I really like that. That lets us
run multiples in config order easily:

[hook "pre-receive"]
  command = /some/script
  command = /some/other-script
  command = some-hookcmd-header

If we add a little repeated-name detection then we can also reorder
easily this way if that's the direction we want for ordering:

{global}
hook.pre-receive.command = a.sh
hook.pre-receive.command = b.sh

{local}
hook.pre-receive.command = c.sh
hook.pre-receive.command = a.sh

for a final order of {b.sh, c.sh, a.sh}.

Very nice, IMO.

I wonder - I think even something like this would work:

{global}
[hook "pre-receive"]
  command = no-hookcmd-entry.sh

{local for repo "zork"}
[hookcmd "no-hookcmd-entry.sh"]
  skip = true

For most repos, now I simply invoke no-hookcmd-entry.sh on pre-receive,
but when I'm parsing the config in "zork", now I see a populated hookcmd
entry, and when I look it up with the key I found in the global config,
I see that it's supposed to be skipped.

Although I might need to do something hacky if I have multiple hooks
pointing to the same simple invocation:

{global}
[hook "pre-receive"]
  command = no-hookcmd-entry.sh

[hook "post-commit"]
  command = no-hookcmd-entry.sh

{local}
hookcmd.no-hookcmd-entry.sh.skip = true

[hook "pre-receive"]
  command = modified-no-hookcmd.sh

[hookcmd "modified-no-hookcmd-entry"]
  command = no-hookcmd-entry.sh

That is, I think this makes it kind of tricky to shut off one invocation
for only one hook.  Maybe it makes sense to honor something like:

hookcmd.foo.skip-pre-receive = true

?

I wonder if I'm getting buried in the weeds of stuff we won't ever have
to worry about ;)

 - Emily
