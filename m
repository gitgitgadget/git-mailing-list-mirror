Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454341F464
	for <e@80x24.org>; Mon, 30 Sep 2019 08:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfI3IzP (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 04:55:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45020 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730185AbfI3IzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 04:55:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AC0961F463;
        Mon, 30 Sep 2019 08:55:12 +0000 (UTC)
Date:   Mon, 30 Sep 2019 08:55:12 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190930085512.GA21522@dcvr>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190924005529.GA8354@dcvr>
 <nycvar.QRO.7.76.6.1909261343590.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909261343590.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 24 Sep 2019, Eric Wong wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Mon, 16 Sep 2019, Emily Shaffer wrote:
> > > >  - try and make progress towards running many tests from a single test
> > > >    file in parallel - maybe this is too big, I'm not sure if we know how
> > > >    many of our tests are order-dependent within a file for now...
> > >
> > > Another, potentially more rewarding, project would be to modernize our
> > > test suite framework, so that it is not based on Unix shell scripting,
> > > but on C instead.
> >
> > I worry more C would reduce the amount of contributors (some of
> > the C rewrites already scared me off hacking years ago).  I
> > figure more users are familiar with sh than C.
> 
> Seeing as most of the patches/patch series require contributors not only
> to write test cases in Unix shell script, but also to patch or implement
> code in C, I fail to be concerned about that.

My point was that it was easier to experiment using a less
tedious and verbose language than C.  git already has a lot of
commands and options, but they're mostly documented.  Having to
learn our internal C APIs on top of that is a lot of cognitive
overhead (and I'm still learning our APIs, myself).

> > It would also increase the disparity between tests and use of
> > actual users from the command-line.
> 
> I find it really endearing whenever I hear anybody talking about Git
> users as if every single one of them crafted extensive shell scripts
> around Git. In my experience, most of the people who do that gather on
> this here mailing list, or on a nearby one, and that is but a tiny
> fraction of Git users.

I only mean stuff like: "git add foo && git commit -m ..."
in tests, which is standard command-line usage and using
our documented UI.

Fwiw, I don't have extensive scripts or customizations
around git or any of the tools I use, either.

> Besides, it was my understanding that Git's test suite tries to prevent
> regressions in Git's code, whether it is called in scripts or not. As
> such, it would not matter _how_ that functionality is tested. Does that
> not match your understanding?

That matches my understanding.  My concern that most of our
functionality is exposed to users as commands; so new developers
would feel more comfortable recreating tests off failures
they encounter under normal use, instead of having to learn
C API internals.

> > > The fact that it is based on Unix shell scripting not only costs a lot
> > > of speed, especially on Windows, it also limits us quite a bit, and I am
> > > talking about a lot more than just the awkwardness of having to think
> > > about options of BSD vs GNU variants of common command-line tools.
> >
> > I agree that it costs a lot of time, and I'm even on Linux using
> > dash as /bin/sh + eatmydata (but ancient laptop)
> 
> One thing that I meant to play with (but which is hampered by too many
> parts of Git being implemented in Unix shell/Perl, still, therefore
> making code coverage analysis hard) is Test Impact Analysis
> (https://docs.microsoft.com/en-us/azure/devops/pipelines/test/test-impact-analysis).
> In short, a way to avoid running tests the code touched by them was
> already tested before. Example: if I change the `README.md`, no
> regression test needs to be run at all. If I change `git-p4.py`, the
> majority of test scripts can be skipped, only t98*.sh need to be run
> (and maybe not even all of them).

Cool.  I wonder how much effort it would take to do with gcov +
Devel::Cover.

> There is a lot of work to be done on the built-in'ification, still,
> before that becomes feasible, of course.
> 
> > > For example, many, many, if not all, test cases, spend the majority of
> > > their code on setting up specific scenarios. I don't know about you,
> > > but personally I have to dive into many of them when things fail (and I
> > > _dread_ the numbers 0021, 0025 and 3070, let me tell you) and I really
> > > have to say that most of that code is hard to follow and does not make
> > > it easy to form a mental model of what the code tries to accomplish.
> > >
> > > To address this, a while ago Thomas Rast started to use `fast-export`ed
> > > commit histories in test scripts (see e.g. `t/t3206/history.export`). I
> > > still find that this fails to make it easier for occasional readers to
> > > understand the ideas underlying the test cases.
> > >
> > > Another approach is to document heavily the ideas first, then use code
> > > to implement them. For example, t3430 starts with this:
> > >
> > > 	[...]
> > >
> > > 	Initial setup:
> > >
> > > 	    -- B --                   (first)
> > > 	   /       \
> > > 	 A - C - D - E - H            (master)
> > > 	   \    \       /
> > > 	    \    F - G                (second)
> > > 	     \
> > > 	      Conflicting-G
> > >
> > > 	[...]
> > >
> > > 	test_commit A &&
> > > 	git checkout -b first &&
> > > 	test_commit B &&
> > > 	git checkout master &&
> > > 	test_commit C &&
> > > 	test_commit D &&
> > > 	git merge --no-commit B &&
> > > 	test_tick &&
> > > 	git commit -m E &&
> > > 	git tag -m E E &&
> > > 	git checkout -b second C &&
> > > 	test_commit F &&
> > > 	test_commit G &&
> > > 	git checkout master &&
> > > 	git merge --no-commit G &&
> > > 	test_tick &&
> > > 	git commit -m H &&
> > > 	git tag -m H H &&
> > > 	git checkout A &&
> > > 	test_commit conflicting-G G.t
> > >
> > > 	[...]
> > >
> > > While this is _somewhat_ better than having only the code, I am still
> > > unhappy about it: this wall of `test_commit` lines interspersed with
> > > other commands is very hard to follow.
> >
> > Agreed.  More on the readability part below...
> >
> > As far as speeding that up, I think moving some parts
> > of test setup to Makefiles + fast-import/fast-export would give
> > us a nice balance of speed + maintainability:
> >
> > 1. initial setup is done using normal commands (or graph drawing tool)
> > 2. the result of setup is "built" with fast-export
> > 3. test uses fast-import
> 
> I actually talked about this in my mail. If you find it easy to deduce
> the intent behind a commit history that was exported via fast-export,
> more power to you. (Was the committer name crucial? The file name? Or
> the temporal order of the commits?)
> 
> In contrast, I find it very challenging, myself. And please keep in mind
> that the first thing any contributor needs to do who sees a failing
> regression test (where the failure is most likely caused by the patch
> they plan on contributing): understand what the heck the regression test
> case is trying to ensure. The harder the code makes that, the worse it
> does its primary job: to (help) prevent regressions.
> 
> So no, I am not at all on board with moving to fast-imported commit
> histories in Git's test suite. They provide some convenience to the
> authors of those regression tests, which is not the audience you need to
> cater for in this case: instead, regression tests should make it not
> only easy to catch, but _especially_ easy to fix, regressions. And that
> audience would pay dearly for that erstwhile convenience.

Sorry I wasn't clear.  I only want fast-export/import to be used
as a local cache mechanism for tests.  I don't want to be
writing or maintaining fast-import histories by hand, either :>

> > Makefile rules would prevent subsequent test runs from repeating
> > 1. and 2.
> 
> That is a cute idea, until you realize that the number of developers
> fluent in `make` is even smaller than the number of developers fluent in
> `C`. In other words, you would again _increase_ the the number of
> prerequisites instead of reducing it.

Wouldn't any C developer need to know SOME build system?

We already use make, and make uses sh.  I'm not especially
fluent in make or sh, either; but I can hack my way through
them.

> > > If we were to (slowly) convert our test suite framework to C, we could
> > > change that.
> > >
> > > One idea would be to allow recreating commit history from something that
> > > looks like the output of `git log`, or even `git log --graph --oneline`,
> > > much like `git mktree` (which really should have been a test helper
> > > instead of a Git command, but I digress) takes something that looks like
> > > the output of `git ls-tree` and creates a tree object from it.
> >
> > I've been playing with Graph::Easy (Perl5 module) in other
> > projects, and I also think the setup could be more easily
> > expressed with a declarative language (e.g. GNU make)
> 
> I am dubious. But hey, if you show me something that looks _dead_ easy
> to understand, and even easier to write for new contributors, who am I
> to object?
> 
> But mind, I am not fluent in Perl. I can probably hack my way through
> `git-svn`, but that's a far cry from knowing what I am doing there.
> 
> And wouldn't that _again_ increase the number of prerequisites on
> contributors? I mean, you sounded genuinely concerned about that at the
> beginning of the mail. And I share that concern.

I'm not saying we use Graph::Easy, but we could probably take
inspiration from it for creating something that makes creating
histories easy and maintainable.

But it could also be writing better comments, using "git commit"
as normal, and letting fast-export cache to speed up subsequent
runs.

> > > Another thing that would be much easier if we moved more and more parts
> > > of the test suite framework to C: we could implement more powerful
> > > assertions, a lot more easily. For example, the trace output of a failed
> > > `test_i18ngrep` (or `mingw_test_cmp`!!!) could be made a lot more
> > > focused on what is going wrong than on cluttering the terminal window
> > > with almost useless lines which are tedious to sift through.
> >
> > I fail to see how language choice here matters.
> 
> In Unix shell script, we either trace (everything) or we don't. In C,
> you can be a lot more fine-grained with log messages. A *lot*.
> 
> We even already have such a fine-grained log machinery in place, see
> `trace.h`.
> 
> Also, because of the ability to perform more sophisticated locking, lazy
> prerequisites can easily be cached in C, whereas that is not so easy in
> Unix shell (and hence it is not done).

`make` seems good at driving stuff to cache.

> > > Likewise, having a framework in C would make it a lot easier to improve
> > > debugging, e.g. by making test scripts "resumable" (guarded by an
> > > option, it could store a complete state, including a copy of the trash
> > > directory, before executing commands, which would allow "going back in
> > > time" and calling a failing command with a debugger, or with valgrind, or
> > > just seeing whether the command would still fail, i.e. whether the test
> > > case is flaky).
> >
> > Resumability sounds like a perfect job for GNU make.
> 
> Umm.
> 
> So let me give you an example of something I had to debug recently. A
> `git stash apply` marked files outside the sparse checkout as deleted,
> when they actually had staged changes during the `git stash` call.
> 
> If this had been a regression test case, it would have looked like this:
> 
> test_expect_success 'stash handles skip-worktree entries nicely' '
>         test_commit A &&
> 	echo changed >A.t &&
> 	git add A.t &&
> 	git update-index --skip-worktree A.t &&
> 	rm A.t &&
> 	git stash &&
> 
> 	: this should not mark A.t as deleted &&
> 	git stash apply &&
> 	test -n "$(git ls-files A.t)"
> '
> 
> Now, the problem would have occurred in the very last command: `A.t`
> would have been missing from the index.
> 
> In order to debug this, you would have had to put in "breakpoints"
> (inserting `false &&` at strategic places), or prefix commands with
> `debug` to start them in GDB, then re-run the test case.
> 
> Lather, rinse and repeat, until you figured out that `git stash` was
> failing to record `A.t` properly.
> 
> Then dig into that, recreating the same worktree situation every time
> you run `git stash`, until you find out that there is a call to `git
> update-index -z --add --remove --stdin` that removes that file.
> 
> Further investigation would show you that this command pretty much does
> what it is told to, because it is fed `A.t` in its `stdin`.
> 
> The next step would probably be to go back even one more step and see
> that `diff_index()` reported this file as modified between the index and
> `HEAD`.
> 
> Slowly, you would form an understanding of what is going wrong, and you
> would have to go back and forth between blaming `diff_index()` and
> `update-index`, or the options `git stash` passes to them.
> 
> You would have to recreate the worktree many, many times, in order to
> dig in deep, and of course you would need to understand the intention
> not only of the regression test, but also of the code it calls.
> 
> In this instance, it is merely tedious, but possible. I know, because I
> did it. For flaky tests, not so much.
> 
> *That* is the scenario I tried to get at.
> 
> Writing the test cases in `make` would not help that. Not one bit. It
> would actually make things a lot worse.

I agree debugging can be tedious, but I'm not sure how to get
around that besides making test cases smaller, more isolated
(which can also lead to missing coverage), and better
documented.

How would your ideal test framework approach it?

Was using git tracing in the above scenarios not enough?

I've never cared much about project-specific tracers; but
instead prefer to rely on project-agnostic (but OS-specific)
facilities such as truss/strace since I can reuse that knowledge
across languages/projects.

> > (that said, I don't know if you use make or something else to build
> > gfw)
> 
> We are talking about the test suite, yes?
> 
> Not about building Git? Because it does not matter whether we use `make`
> or not (we do by default, although we also have an option to build in
> Visual Studio and/or via MSBuild).
> 
> On Windows, just like on Linux, we use a Unix shell interpreter (Bash).
> Sure, to run the entire test suite, we use `make` (sometimes in
> conjunction with `prove`), but the tests themselves are written in Unix
> shell script, so I have a hard time imagining a different method to run
> them -- whether on Windows or not -- than to use a Unix shell
> interpreter such as Bash.
> 
> > > In many ways, our current test suite seems to test Git's
> > > functionality as much as (core) contributors' abilities to implement
> > > test cases in Unix shell script, _correctly_, and maybe also
> > > contributors' patience.  You could say that it tests for the wrong
> > > thing at least half of the time, by design.
> >
> > Basic (not advanced) sh is already a prerequisite for using git.
> 
> Well, if you are happy with that prerequisite to be set in stone, I am
> not. Why should any Git user *need* to know sh?

For chaining commands together, why not?

I expect anybody who's learned C to also be able to figure out
some basic scripting to tie a series of commands together in the
same way you can poke around in Perl without being fluent.

And there's plenty of overlap between C and sh when it comes to
with control flow (if/else/while/&&/for).

> > Writing correct code and tests in ANY language is still a
> > challenge for me; but I'm least convinced a low-level language
> > such as C is the right language for writing integration tests in.
> 
> I would be delighted to go for a proper, well-maintained test framework
> such as Jest. But of course, that would not be accepted in this project.
> So I won't even think about it.
> 
> > C is fine for unit tests, and maybe we can use more unit tests and
> > less integration tests.
> 
> We don't have integration tests.
> 
> Unless your concept of what constitutes an "integration test" is very
> different from mine. For me, an integration test would set up an
> environment that involves multiple points of failure, e.g. setting up an
> SSH server on Linux and accessing that via Git from Ubuntu. Or setting
> up a web server with a self-signed certificate, import the public key
> into the Windows Certificate Store and then accessing the server both
> using OpenSSL and Secure Channel (the native Windows way to communicate
> via TLS).

I think of integration tests as anything which covers
real-world use cases (e.g. running documented commands as
a normal user would).

Unit tests would be t/helper/*.c in my mind...

But maybe my terminology is all wrong *shrug*

> There is nothing even close to that in Git's test suite.
> 
> > > It might look like a somewhat less important project, but given that we
> > > exercise almost 150,000 test cases with every CI build, I think it does
> > > make sense to grind our axe for a while, so to say.
> >
> > Something that would benefit both users and regular contributors
> > is the use and adoption of more batch and eval-friendly interfaces.
> > e.g. fast-import/export, cat-file --batch, for-each-ref --perl...
> 
> Given how hard it is to deduce the intention behind such invocations, I
> am rather doubtful that this would improve our test suite.
> 
> > I haven't used hg since 2005, but I know "hg server" exists
> > nowadays to get rid of a lot of startup overhead in Mercurial,
> > and maybe git could steal that idea, too...
> 
> I have no idea what `hg server` does. Care to enlighten me?

Sorry, "hg serve" (no 'r').  It starts a long-lived server to
expose the API over a pipe or socket:
https://www.mercurial-scm.org/wiki/CommandServer
Closest we have is fast-import and "cat-file --batch*"
