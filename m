Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678E5C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBXVGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXVGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 16:06:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB869ACC
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 13:06:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i34so2362692eda.7
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXBBlNtshVah6qGUH9F+UwkjvxQ2UY2lYK6u8P5YxRc=;
        b=Oue+/tDB/a5SUKjLr+rbynj1bM4HltTOmwBm/8uaPsqdC6E2vHWNKOzifbsalSTkum
         9DYVKwMlEETuHZTHaV8XrvNUHEPOmsHSGXyBani2sm5FdDX50wQSrIldisDNHQYkqsR9
         NXsQNmVOK5dP3QmP8z9HCU4RaIKfEVJo8nCfjkwxeugeKwQwJXlAF+cNLM2FjHcPVi68
         1n4AAcdCj7CFKVbNpJl8EDKJZ8OgDrzla2FKlrC6IRziQe13KrfDHsJ2Vr45K+mtAcDq
         8AkmuQmo3xGYzeT7guhVNh2sw2JRM0WQrXifaM6EGd6ENwdaR9Uzn91KPEiCI3EkWjWq
         ez4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXBBlNtshVah6qGUH9F+UwkjvxQ2UY2lYK6u8P5YxRc=;
        b=ZlTOORpwoz+BQSIJmu4n05FI8PJa7/oY532+eQ/0p9zijp2Vd8zTrbh6nvCn+Sa2kU
         HyyHFZVXvIQb3+BmZEVbYmOu1UrQFxzaTGuqcl6DuCRQ/u95vwxAWa5xaRioGvwP/mvK
         yrf5FjBcoJm6U/n83SvP7gdvmb2wVKbi81PrEk9leDsyZEMRIcVjzvGabsb5EHgXJnVv
         9uUwb2QKgmutvLUql+JR6Ud1zEFCegvZ9HvSrHM7aX1+dq1g7dCCDkCiuc3GgXOuYT/B
         qR6QM27QV7Ak2XPt0wGeo++pteCNxbUblHC9OpbapUOkQKT5ZabsDFVdoLaPqv6wXGNw
         O0dA==
X-Gm-Message-State: AO0yUKXBBYQ6YXCUDvhPPwqVaAHVXKIK5IKxLnK2vKJi11ypUa52v4vA
        UaFg0odI4+RUjOUH6bwLFpu2KqX2VN3o8iXYaxjtIQ==
X-Google-Smtp-Source: AK7set8hE3uZZdGCodwDrqfX4sxBEwZJfVgaTUqLE6znrCErwoUdzyG7NzI8fWwCoYN8HK8Cx/NcUU3zOjc6lw+mTWg=
X-Received: by 2002:a05:6402:3216:b0:4ad:7bb2:eefb with SMTP id
 g22-20020a056402321600b004ad7bb2eefbmr829895eda.3.1677272777103; Fri, 24 Feb
 2023 13:06:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <13e0737a-7d66-7122-9dab-f7659948cda3@github.com>
In-Reply-To: <13e0737a-7d66-7122-9dab-f7659948cda3@github.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Fri, 24 Feb 2023 13:06:05 -0800
Message-ID: <CAJoAoZ=aoqWWfjUXg2VOeTkiVPsccqpWAm-yw2QzURGh-m-bNQ@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 6:55 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/17/2023 4:12 PM, Emily Shaffer wrote:
>
> > This turned out pretty long-winded, so a quick summary before I dive in:
> >
> > - We want to compile parts of Git as independent libraries
> > - We want to do it by making incremental code quality improvements to Git
> > - Let's avoid promising stability of the interfaces of those libraries
> > - We think it'll let Git do cool stuff like unit tests and allowing
> > purpose-built plugins
> > - Hopefully by example we can convince the rest of the project to join
> > in the effort
>
> As I was thinking about this proposal, I realized that my biggest concern
> is that we are jumping to the "what" and "how" without fully exploring the
> "why"s, so I've reorganized some of your points along those lines, so I
> can respond to each in turn.

Thanks - and thanks for your patience in my replying, because there's
a lot here ;)

>
> ## Why: Modular code
>
> > - Having clear, modular libraries makes it easy to find the code
> > responsible for some behavior, or determine where to add something
> > new.
>
> > - An easy-to-understand modular codebase makes it easy for new
> > contributors to start hacking and understand the consequences of their
> > patch.
>
> Generally, having a modular codebase does not guarantee that things are
> easy to find or that consequences are understood. The correct abstractions
> are key in this, as well as developing boundaries that do not leak into
> each other.

Absolutely agreed. I do think we will want to be very careful about
how to abstract things - and very open to reworking the interface when
something isn't working. (See also, not guaranteeing ABI stability)

>
> Unless done correctly, we can have significant issues with how things are
> communicated through layers of abstraction. We already have that problem
> when we want to add a new option to a builtin and need to modify three or
> four method prototypes in order to communicate a change of behavior to the
> right layer.

Yes, that's true - and usually plumbing some new argument through and
coping with it appropriately in those 3-4 functions is because there's
not a way to silently provide the needed context to the bottom-most
function, if I'm thinking of the same scenario you are.

One thing we discussed internally was the need to pass around some
context struct to libraries, mostly to avoid reliance on globals. But
I wonder if that same schema means that we can reduce the amount of
argument plumbing needed when adding something to a low-level
dependency?

>
> I've also found that where we have abstractions, such as the refs code or
> the transport code, that the indirection created by the vtables is more
> confusing to discover by reading the code. I've needed the use of a
> debugger to even discover the call stack for certain operations.

This is a really good point, and part of why I'd like to hold off on
introducing vtables until we really painfully need them. I wonder when
that point will be - I guess if/when we start using runtime library
linking/selection it will be necessary.

>
> > - If we can swap out an entire library, or just a single function of
> > one, it's easy to experiment with the entire codebase without sweeping
> > changes.
>
> I don't understand this one too much. We already have this ability through
> forking the repository and mutating the code to do different things. Why
> do we need modules (with vtables and all the rest of the pain that goes
> into it) to make such swaps?
>
> This only really matters in the fullness of the libification effort: if
> everything is mocked, then subsystems can be replaced wholesale. That's a
> lot of work just to avoid experimenting with a fork.

Yeah, I see your point. Git has also experimented with two backends
selectable via config lots of times, and that's basically the same
functional role as experimenting by replacing a library. But I sure
would like it if our project's default suggestion for experimenting
with different implementations wasn't just "fork" - forks are
cumbersome to maintain and painful to reconvene with the mainline.

>
> ...
>
> You said this about how to achieve modular code:
>
> > - Removing references to global variables and instead piping them
> > through arguments
> > - Finding and fixing memory leaks, especially in widely-used low-level code
> > - Reducing or removing `die()` invocations in low-level code, and
> > instead reporting errors back to callers in a consistent way
> ...
> > - Making module interfaces more consistent and easier to understand,
> > including moving "private" functions out of headers and into source
> > files and improving in-header documentation
>
> I think these mechanisms should be universally welcomed. One thing that is
> tricky is how we can guarantee that an API can be marked as "done" and
> maintained that way in perpetuity. (Unit tests may help with that, so
> let's come back to this then.)

I'd really like to avoid that guarantee, actually! Even in the long
term, I think it's very likely that we'll want to continue extending
some APIs forever - for example, config learns new kinds of things
which might change the API quite frequently. Let's not reach for
"done, never touch the interface again" as a goal.

>
> > - Clarifying the scope and layering of existing modules, for example
> > by moving single-use helpers from the shared module's scope into the
> > single user's scope
>
> This one is a bit murky to me. It sounds like that if there is only one
> caller to a strbuf_*() method that it should be made 'static' inside the
> caller instead of global in strbuf.h for use by future callers. Making
> this a goal in itself is probably more likely to see methods moving around
> more frequently due to the frequency of their use, rather than natural
> groupings based on which data structures are being mutated.

Let me be a little more explicit about the strbuf example. strbuf
includes the purpose-built helper `strbuf_add_unique_abbrev()`, to
truncate the oid as much as possible to remain unique.
(https://github.com/git/git/blob/master/strbuf.h#L633) I'm proposing
that this helper doesn't belong in strbuf.a, but instead in oid.a or
similar. Still public, but since it relies on also having linked
oid.a, and it's in fact useless _without_ oid.a, it should live in
oid.a. (Reading my original phrasing back, I see how it didn't imply
this at all, so thanks for asking.)

>
> What measurement would we optimize for? How could we maintain such
> standards as we go? The Git codebase doesn't really have a firm
> "architecture" other than "builtin code calls libgit.a code, which calls
> other libgit.a code as necessary". There aren't really strong layers
> between things. Everything assumes it can look up an object or load
> config. Are there organizational things that we can do in this space that
> would help decoupling things before jumping to libification?

The example I cited above is a symptom of this weak layering you
describe, yeah. In practice so far, these symptoms show up in the
process of trying to isolate a single library, and require deciding
how to reorganize before we can build it as a library. But I think
part of the reason we don't have strong layering now is precisely
because we need it; I'm not sure that a soft reorganization will stick
without some kind of enforcement (for example, in the form of unit
tests operating on isolated components).

>
> ## Why: Submodules
>
> > - Operations recursing into submodules can be run in-process, and the
> > callsite makes it very clear which repository context is being used;
> > if we're not subprocessing to recurse, then we can lose the awkward
> > git-submodule.sh -> builtin/submodule__helper.c -> top-level Git
> > process codepath.
>
> Previously, there was an effort to replace dependencies on the_repository
> in favor of repository structs being passed through method parameters.
> This seems to have fallen off of the priority list, and prevous APIs that
> were converted have regressed in their dependencies.
>
> Should we consider restarting that effort as an early goal?

Yes, I think that effort is a good early goal, but I think the reason
it fell off is because there's not a lot of direct reward in moving
bits and pieces off of `the_repository`. It's hard (impossible?) to
guarantee with an integration test, and taken alone, it's too big of a
change for one person to complete in a single series. So I'm less
interested in saying "start by getting rid of the_repository in 100%
of the code!" and a lot more interested in saying "start by getting
rid of 100% of the globals in config.[ch]", if that makes sense.

> Should a
> repository struct be the "god object" that also includes the default
> implemenations of these modules until the modules can be teased apart and
> no longer care about the entire repository?

Hm, I'm not sure I follow this and the first impression I get is
pretty scary.  Could you explain a little more?

> ## Why: Unit testing
>
> > - Unit tests. We already have some in t/helper/, but if we can replace
> > all the dependencies of a certain library with simple stubs, it's
> > easier for us to write comprehensive unit tests, in addition to the
> > work we already do introducing edge cases in bash integration tests.
>
> Unit tests are very valuable in keeping the codebase stable and reducing
> the chance that code was mutated by accident. This is achieved by very
> rigid test infrastructure, requiring _replacing_ methods with mocks in
> careful ways in order to test that behavior matches expectation. The
> "simple stubs" are actually carefully crafted to verify their inputs and
> provide a carefully selected return value.
>
> The difficulty of writing unit tests (or mutating the code after writing
> unit tests) is balanced by the ability to more explicitly create error
> conditions that are unlikely to occur in real test cases. Cases such as
> connection errors, file I/O problems, or other unexpected responses from
> the mocked methods, are all relatively difficult to check via end-to-end
> tests.
>
> I've personally found that the hardest unit test to write is the _first_
> one, and after that the rest are simpler. The difficulty arises in making
> the code testable in the first place, as well as creating infrastructure
> for the most-common unit test scenarios. My expectation is that it will
> take significant changes to the Git codebase to make any non-trivial unit
> tests outside of these very isolated cases that are presented here: strbuf
> manipulation is easy to unit-test and config methods operating on
> config_set structs should be similar. However, config methods that
> interact with a repository and its config file(s) will be much harder to
> test unless we start mocking filesystem interactions. We could create
> test-tool helpers that load a full repository and check the config files
> present on the filesystem, but now we're talking about integration tests
> instead of unit tests.

Yeah, I see what you're saying. I think some of it depends on how we
build the interfaces; it's difficult to mock an entire filesystem for
an API that takes a path, but it's easy to give fake data to an API
that takes a string or bytestream. I suspect we'll want to be very
careful looking at how much work it is to build unit tests for a
certain library - overly complicated mocking setup seems like a code
smell to me.

>
> > - Being able to test libraries in isolation via unit tests or mocks
> > speeds up determining the root cause of bugs.
>
> I'm not sure I completely agree with this statement. Unit tests can help
> prevent introducing a new fault when mutating code to adjust for a bug,
> but unit tests only guarantee expected behavior on the expected
> preconditions. None of this necessarily helps finding a root cause,
> especially in the likely event that the root cause is due to combining
> units and thus not covered by unit tests.

Yeah, that's fair.

>
> ## Why: Correct use
>
> > The ability to use Git as a library also makes it easier for other
> > tooling to interact with a Git repository *correctly*.
>
> Is there is a correct way to interact with a Git repository? We definitely
> prefer that the repository is updated by executing Git processes, leaving
> all internals up to Git. Libification thus has a purpose for scenarios
> that do not have an appropriate Git builtin or where the process startup
> time is too expensive for that use.

There are certainly some incorrect ways! We get a lot of firsthand
experience with `repo` tool's poor interaction with Git repositories
:)

> However, would it not be preferrable to update Git to include these use
> cases in the form of new builtin operations? Even in the case where
> process startup is expensive, operations can be batched (as in 'git
> cat-file --batch').

In addition to expensive startup time, in some cases we've gotten
pushback about starting a subprocess at all, for security reasons.
Especially because Git loves to then start subprocesses itself.

>
> ## Why: Virtual Filesystem Support

In the initial email I CC'd a couple of the people working on our VFS,
so I'll leave this section alone and leave it to them to reply to you.

>
> ## How to achieve these goals
>
> > I'm also planning to send a proposal for a document full of "best
> > practices" for turning Git code into libraries (and have quite a lot
> > of discussion around that document, too). My hope is that we can use
> > that document to help us during implementation as well as during
> > review, and refine it over time as we learn more about what works and
> > what doesn't. Having this kind of documentation will make it easy for
> > others to join us in moving Git's codebase towards a clean set of
> > libraries. I hope that, as a project, we can settle on some tenets
> > that we all agree would make Git nicer.
>
> I like the idea of a "best practices" document, but I would hesitate to
> focus on the libification and instead aim for the high-value items such
> as lack of globals and reduced memory leaks. How do we write such code?
> How do we write (unit?) tests that guarantee those properties will be
> maintained into the future?
>
> > From the rest of my own team, we're planning on working first on some
> > limited scope, low-level libraries so that we can all see how the
> > process works. We're starting with strbuf.[ch] (as it's used
> > everywhere with few or no dependencies and helps us guarantee string
> > safety at API boundaries), config.[ch] (as many external tools are
> > probably interested in parsing Git config formatted files directly),
> > and a subset of operations related to the object store. These starting
> > points are intended to have a small impact on the codebase and teach
> > us a lot about logistics and best practices while doing these kinds of
> > conversions.
>
> I can see that making a library version of config.h could be helpful to
> third parties wanting to read Git config. In particular, I know that Git
> Credential Manager runs multiple 'git config' calls to get multiple values
> out. Perhaps time would be better spent creating a 'git config --batch'
> mode so these consumers could call one process, pass a list of config keys
> as input, and get a list of key-value pairs out? (Use a '-z' mode to allow
> newlines in the values.)
>
> However, I'm not seeing value to anyone else to have strbuf.h available
> externally. I'm also not seeing any value to the Git project by having
> either of these available as a library. I can only see increased developer
> friction due to the new restrictions on making changes in these areas.

The value in strbuf is simply this: a Git config library should
probably not be returning char*+int to its callers, or even worse, an
unwrapped linked list or map. It's too easy to make memory mistakes
dealing with raw C types, and I'd like for us to avoid that by using
the types we already have.

>
> If this first effort is instead swapped to say "we plan on introducing
> unit tests for these libraries" then I think that is an easier thing to
> support.
>
> It happens that these efforts will make it easier to make the jump to
> providing APIs as a library. Not only are unit tests _necessary_ to
> support libification, they also make a smaller lift. Unit tests will
> already create more friction when changing the API, since either new tests
> must be written or old tests must be modified.
>
>
> ### Summary
>
> Generally, making architectural change is difficult. In addition to the
> amount of code that needs to be moved, adjusted, and tested in new ways,
> there is a cultural element that needs to be adjusted. Expecting Git's
> code to be used as a library is a fundamentally different use case than we
> have supported in the past, and most of our developer guidelines reflect
> that. We don't hesitate to modify APIs. We prefer end-to-end tests over
> unit tests whenever possible.

Inherent in your summary I'm hearing a lot of concern about providing
API stability. But I agree with you there - I don't think that we
should provide API stability, especially at the beginning while we're
learning how to write good APIs. I hope we can wait as long as
possible to start promising backwards compatibility - maybe even never
- and I hope we can stand our ground if we do receive bug reports
about breaking API stability on an API still labeled as unstable. I'm
not sure how I can make this statement more strongly :)

It seems that the Linux kernel has also managed to get away with this
kind of purposeful instability
(https://www.kernel.org/doc/Documentation/process/stable-api-nonsense.rst)
and I'd be happy to try and follow their example. Another standard
library provided by Google (https://abseil.io/about/compatibility)
does the same. So I do think it's possible for us to guarantee
instability, as it were. (Thanks, Jonathan Nieder, for the links
here.)

>
> There are focused bits of your proposal that I think will be universally
> welcomed, and I think the best course of action in the short term is to
> demonstrate improvements in those areas:
>
>  * Reduced use of globals.
>  * Reduced memory leaks.
>  * Use error responses instead of die()s within low-level code.
>  * Update header files to have appropriate visibility and documentation.
>
> The things that we need to really focus on are how we can measure progress
> in these areas as well as how can we prevent regression in the future.
> Unit tests are one way to do this (especially with leak detection), but
> also documentation and coding guidelines need to be updated based on the
> new patterns discovered in this process.
>
> I mentioned the_repository earlier as a partially-complete architectural
> change. I think the_index compatibility macros are in a similar boat of
> being half-completed (though, the last time I tried to remove these macros
> I was told that it wasn't a goal to remove the macros from builtins). The
> sparse-index's command_requires_full_index checks are also in this boat,
> so I understand the difficulty of getting a big change 100% complete (and
> in this case, the plan is to do at least one more GSoC project in the area
> to see what progress can be made that way).
>
> We should be careful in committing to a very long-term direction without
> first delivering value on a shorter timeline.
>
> Thanks,
> -Stolee
