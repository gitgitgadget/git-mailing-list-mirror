Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B844C433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556E160724
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347587AbhIBWDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347569AbhIBWDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:03:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CBC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 15:02:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q3so2072335plx.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7WZ08Wds6AVmeoq0uza24k8FCDqD4dS6q2z+j9CZ+Jk=;
        b=TvK0q65qBGGddjc+EWZjVVkQte5KyJAQZ76HMbacLeGG+TX0U4EaWOsXDqlujfUyqB
         So7+9zEc2+3YrryIwQoG8S/JDvzkj9gZFe54+rNH5HtaeNMO2GTK+7Oh/GXUbKz4Ibpi
         OvwzXn0oUs594i056oVsunm0PhuNiQdF5AQUsT0GlEuTNy3cC4KFEzn/RMD8AocyH5Xx
         0EZ7IZhlVKZpt0qwGNoFlghJZ1Tc273feESKjlacXEjkXPWbRGzbHkjT2R6wM1LKjJru
         1OvZupPqcPym1so83E7VPib/z08rQRFYyQ+LfAdleGL0hgMHtWTH2C9gHOUtbDTimL/r
         NSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7WZ08Wds6AVmeoq0uza24k8FCDqD4dS6q2z+j9CZ+Jk=;
        b=ImoSu3usLUrkUKveD91Mor3eHbhak0Ftzo+Tn5qLVR9vdGGcdFJUaMyL5RDfc70Tto
         BFe0B3sek5XlgB31uTYikFXUlYWp8+JcZ+2283XFwxUkgkzoGOx3rVig2GPYKyefUR7Z
         AsB5b4zPIflAalZmuNjCvRyVhofeQLst5szchPlGl/1lbVcfOud2T9JNKjwRIHi/iRuX
         D3lZH4kEtvmJZNmGPf9XIFW3FIzIYa5C4PkTKZMaV9/myfoPRvDawoFZDIquk3MgWE9U
         XjykQHNxRjS66gPog3FtZFpvFGjGHaTKps5zToRU+QWGpkcDp2RC15HoR2t0m8hDrIWx
         XGPQ==
X-Gm-Message-State: AOAM531Y0cbF+tffnID7zbjm1t1UwVmYtDwUvgELK54hSlY1lD7yLQKH
        5dUPgAUIyuAXcMrfmBR7UwlY/Pfila6wPw==
X-Google-Smtp-Source: ABdhPJyEbuOcmnNCOXLEsWF6aPn4v/agEFDgRytbHxFYQtyjuAaqSyQNltU/vfdbTd5Ye5xd/BalPA==
X-Received: by 2002:a17:902:82c6:b0:136:59b0:ed17 with SMTP id u6-20020a17090282c600b0013659b0ed17mr426606plz.61.1630620122863;
        Thu, 02 Sep 2021 15:02:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:40d2:503e:1c2a:5c81])
        by smtp.gmail.com with ESMTPSA id r13sm3889472pgl.90.2021.09.02.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 15:02:02 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:01:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/6] config-based hooks restarted
Message-ID: <YTFAqvBlILJwwNyi@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210819033450.3382652-1-emilyshaffer@google.com>
 <87fsuyeds6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsuyeds6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 10:29:33PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 0)
> 
> I think this is in much much better shape vis-as-vis the simplified
> config schema that's now being proposed re our discussion starting
> around https://lore.kernel.org/git/87bl6ttmlv.fsf@evledraar.gmail.com/
> 
> I.e. the main complexity of the "skip" mechanism is gone, and also the
> conflation of hook names with hook commands (the "rm -rf /" as a
> <name-or-cmd> discussed in the above).
> 
> So before going any further, I'll just say that I wouldn't object much
> to this design going in as-is. What I'm about to mention here below is
> much closer to bikeshedding in my mind than "this is really to complex
> to go in-tree", which was my opinion of the config schema before.
> 
> 1)
> 
> On the current config design: First, before going into any detail on
> that, I think whatever anyone's opinion is on that that the
> design-focused patches as they stand could really use more a more
> extended discussion of the design.
> 
> I.e. talk about the previously considered config schema, why it evolved
> into its current form. The trade-offs involved, and why the patch
> proposed to implement the schema it's implementing over another earlier
> or alternate design.
> 
> I.e. https://lore.kernel.org/git/20210819033450.3382652-6-emilyshaffer@google.com
> is two very short paragraphs. We won't be able to summarize all our
> month-long discussion on the config design in one commit message, but I
> think at least discussing it somewhat / linking to relevant on-list
> discussions would make future source spelunking easier.

Hum. I don't think that it's necessary to summarize the whole discussion
in the commit message, but I think it's worth it to describe the
rationale ("we like this design because it makes x good practice easy
and y bug hard") and link out to the discussion for parties who are
interested in reading more.

> 
> 2)
> 
> So that out of the way, a comment on the current config design, which
> should be read in the context of what I noted in #0. I.e. I'm *much*
> happier with this version.
> 
> That being said I'm still not convinced that the simple 1=1 mapping of
> "hook.<name>.command" and its "value" should be followed by the 1=many
> mapping of "hook.<name>.event" and its "value".
> 
> I.e. we're making the trade-off of saving the user from typing out or
> specifying:
>     
>     [hook "my-pre-commit"]
>     command = ~/hooks/pre-commit-or-push
>     event = pre-commit
>     [hook "my-pre-push"]
>     command = ~/hooks/pre-commit-or-push
>     event = pre-push
> 
> And instead being able to do:
> 
>     [hook "my-pre-commit-or-push"]
>     command = ~/hooks/pre-commit-or-push
>     event = pre-commit
>     event = pre-push
> 
> So for the very common case, saving two config lines. "Two" because as
> we discussed[1] as there's currently no GIT_HOOK_TYPE env var. So this
> form will work pretty much only for that case.
> 
> I.e. unlike with .git/hook/<name> the hook run via config can't
> determine what <hook-type> it's being run at, so as it stands this is
> only useful for those hooks listed in githooks(5) where someone would
> want to do the exact same thing for one or more <hook-name> names. You
> can't use it as a general routing mechanism for any hook type as it
> stands.
> 
> I *think* that's only these two, perhaps "update" and "pre-receive",
> with the hook seeing if it consume stdin/has arguments to disambiguate
> the two.
> 
> But even with a GIT_HOOK_TYPE passed the trade-off, as discussed in [1],
> and downthread in [2], is that by having it 1=many we're closing the
> door on any future hook.<name>.<whatever>. I.e. config that would change
> the behavior of that hook, but you'd want to change it in another way
> for at least one of the N event types.

I'm not really sure that's the case, to be honest. Even with the config
scheme as is in this iteration, you can still define it the way you're
describing with no problem, and in fact it makes it easier for users to
apply some special config to all-but-one invocation.

Let's say for example the "git-secrets" hook, which we do have defined
for at least 3 different events at Google today, and a hypothetical
"parallelize me" config; for the sake of argument let's presume that
this is the far future and we've added a GIT_HOOK_TYPE envvar:

[hook "git-secrets"]
  command = /bin/git-secrets
  event = pre-commit
  event = pre-merge-commit
  parallelizable = true

[hook "git-secrets-mutexed"]
  command = /bin/git-secrets
  event = prepare-commit-msg
  event = commit-msg
  parallelizable = false

If we don't allow "hook.myhookname.event" to be multiply configurable,
then the user gets this really tedious task of defining every single
"hook.git-secrets-$hookevent.parallelizable" config.

> 
> Well, "closing the door" as in if you'd want that you'd have to split up
> the section from the "my-pre-commit-or-push" example above to the
> "my-pre-commit" and "my-pre-push" example.
> 
> But again, on the "is the complexity worth it" we're then having to
> explain to users that they can do it one way if the want no config other
> than hook.<name>.{command,event*}, but another if they have another key
> in that namespace.

I am not so worried about "this will be hard to explain, so we should
not do it" - I think we can make the documentation useful with enough
effort and expertise. (And yes, I'm feeling optimistic because I have an
actual technical writer taking a look at the manpage right now.)

> 
> You've said that you wanted to add something like a GIT_HOOK_TYPE
> environment variable. Fair enough, and I guess we could add it in a
> re-roll of this series. I'm mainly commenting on the end-state of *this*
> series in particular. I.e. I think it leaves the user & implementation
> with a config schema that still seems to be needlessly complex for the
> very limited benefits that complexity brings us in what you're able to
> do with it now.

I think that limiting ourselves in the way you're describing will make
it more difficult to bring additional benefits later. It is certainly
possible and valid to write your configuration the way you are
describing, without changing this schema.

> 
> But some of that goes back to the comments I had on 5/6[3], i.e. I'm
> willing to be convinced, but I think that the current commit message &
> added docs aren't really selling the idea of why it's worth it.

Ok. I think your point is not "the schema is still wrong" as much as it
is "the documentation could be much better", and I agree.

> 
> 3) 
> 
> As an extension to my comments on 5/6[3], I think this whole notion of
> "git hook run <name>" as invoked by a user of git is just more confusing
> the more I think about it.
> 
> I.e. 5/6[4] is apparently seeking to implement a way to just make that
> facility a general way for users to run some command on their system to
> do whatever, instead of say using /usr/bin/parallel or a shell alias.
> 
> But then we also use that command as our own dispatch mechanism for our
> own known hooks, except mostly not, since we mostly use the C API
> ourselves directly.
> 
> It's particularly confusing that if you say run "git hook run
> pre-auto-gc" as a user to test your hook you'll have that hook run in
> the same way that git-gc(1) would run it. So someone developing a hook
> might think they can use "git hook run" for testing it.
> 
> But if you do the same with say "git hook run pre-receive" or anything
> else that feeds arguments or stdin (e.g. "update", or "pre-receive"),
> you'll have your hook happily being run by git, but in a way that's not
> at all how such a hook will be run when it's run by git "for real".
> 
> So I wonder if we shouldn't just have the thing die() if you try to run
> any hook that's in githooks(5) itself, except for sendemail-validate and
> the p4 hooks, since we need to run those ourselves.

I think this again falls to a documentation issue. I would love to have
a tighter loop when developing a hook that takes weird mid-merge
arguments or whatever; making it easier to test the hook in isolation
with known inputs sounds like a good thing to me.

Personally, "I ran 'git hook run pre-receive' without being in the
middle of a receive operation and it didn't behave like it was in the
middle of a receive operation!" doesn't sound all that surprising to me.

> 
> Or have those use an internal-only "git hook--helper", and start out
> with "git hook" just supporting "git hook list", and then later on have
> "git hook run" (or perhaps "git hook run-configured"?) be an entry point
> for this facility of running some arbitrary script that's not a "real"
> hook.
> 
> I don't know, maybe I'm the only one that finds this confusing...
> 
> 1. https://lore.kernel.org/git/87bl6ttmlv.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/877dh0n1b3.fsf@evledraar.gmail.com/
> 3. https://lore.kernel.org/git/87lf4qeh86.fsf@evledraar.gmail.com/
> 4. https://lore.kernel.org/git/20210819033450.3382652-6-emilyshaffer@google.com/

Besides "make the docs more obvious", I don't think there is anything in
this mail that I want to act on. I am very happy with the config schema
as it is, as well as the behavior of 'git hook run'.


As I mentioned here and somewhere else in the review, I am in the
process of getting feedback on the manpage from a tech writer this week,
so do not expect a reroll from me until at least next week. I saw your
reroll today and I'll try and look at it (or at least the interdiff)
tomorrow or Monday.

 - Emily
