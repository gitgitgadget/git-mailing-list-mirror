Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD390C2BB54
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884262075E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PwhHZwvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDGWYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:24:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:51503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgDGWYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586298225;
        bh=iFWoSy9h+LOCXAr9Wq7NQLeLLZKQej8QXhZUe0oeSQM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PwhHZwvO11Hv3cAGg8HEutCQ7dmIeg4a22JeRymn4xzridw6q5vVIXoCeG8N0xt66
         ZPHle/nF4U24BZfibnn2IWL6rr0CYRI7Ma6ObXUoyj8a74CGPMgk34mMP8sHD0KAcv
         UCvPlxlWJae3/iB+MrZwkix+OB7zcgXm9rzMif5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MOREc-1jf62p0rle-00PsK5; Wed, 08 Apr 2020 00:23:45 +0200
Date:   Wed, 8 Apr 2020 00:23:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
In-Reply-To: <20200407014829.GL6369@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com> <xmqqv9mgxn7u.fsf@gitster.c.googlers.com> <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com> <20200407014829.GL6369@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YZcRSmRMBxIfdgJRjbngdpiwaCr1nH0RwWHGgQqr4X+cZEiGeoN
 poK4VhMJbQos30IfdSiubqgTU1Dryl1rlqeVVx4Q3R0xkoLa1fnKn/Tk1JDY4G+tRLufPDR
 QyB2lmE7OVN6A/XLVyU3a9ZzVY9qlzwKaRXCN0Gz7DFhUlfbiitMTVDWo2WhZPIa96q/pWO
 UcnZy7AHqzCkOYTUDP8Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xMhyPvOn/E0=:Mxh42WWrVKgcoc4y8no3qi
 exBiOQ6I/of90m8Armr+yqHM9BGVhLXA5RQLDKvzkr+58BCFtwnRCUKpaWMTnRz5xMUePYh4k
 DQHpr03hhfuJ6HbN9iry0mnUoX1za6oG9EpBA+sl3vJPUPmGwHGO7uWVmfjF2O3ZkFBX65kyr
 Rg3yIveMLeUXQCAw1+8AGuVDMF8lP9QFUF9hTfQLzBTqf7jOGcZlCKwAZtBTIjgqDuBFUu/mK
 0yvI9bD1aUOMEpTUaVDqAZmxy9mv6rXKmCGs8yVFNtwTRVIe+RrUEs3QqZSuhANoDSCpVx8Zl
 MytVkY5bPmIQSm3PEqnRJjVN+Doo4JpNDnclxVgwXNOgDvst7bQQnyKR/NCPZpal0wyTY57mc
 gIC566vrPwonqN/h2JR5q+msAFhfO301KPJW2wZ89ICje86/1lJRvOrS/G9aDlFVEfDbrwSfd
 DRlxGEFd2CaVcCHltBHFkxp2yzw73wssQotmx03GbOIbSxJ07z/5ehAAaXZ7IyzJVGPBVVkNo
 FC9qPEAaidQAXJJeLeXectw43anVCoqptUYYNPBVG7svHH5HAtzsgP6RYkK7HX6px5KJqTK9g
 BD13Ypk2OwVxO6Hqdqz1KQD6aSpw3IswukHR3bK2hioYTJ92NV4EeQDlaqZo23lrPgNmGS9De
 TeGUsVriFu721HxEBOI/3AUGOw0QEyBlzXnvaYlgHvStIHKkkRHeL2IrDpjNXLeo7CgYVtlcq
 nLBlFmJq1922x3zhbjq4ahK5AkeQ+ADbCkz62d27JMQHGCNuMuomwi4VTZ49c35Q/XBvk+mwm
 UCpBctfqOtNG2NGSciGEx+81+qBHBLAgUMqg8Byb1d/ZkWkOcRILrFyJ/2IBkCLjc1zzcQeaS
 iGwyDRty38JnwHxw9RtUoqxA9IzvKf7isrMFiL+HSoCwyGHk2P+PZuPeuNA2NzTPXW2/eOKpA
 WPgfjO+WrLfYVblOl7bwE7yHJvG7UBNUJ2MJHKMoWEDN0AIiSLwmCVZnEQ/Q89kN+P76VoCBk
 PURZ+M3RJh9ZPTUG0UBYzl4PkvWcKIxC89Ye7fdFtkOrUtDEkiOHuf9xrKD8tveMnJor6LR8d
 WPlaRkw2jyWAwQgGVQQbp8E0hVwP+pshaxTJhOI25QITI40KwtyoudzyIEZJfYVhzj+cNWawj
 2V2dXXR2atwXhFt11oMvwSd6MHbwMEACZrUzUJl6HxNs4Kni6zAKNBysrXqi1XfqAk6wxHmBy
 Fp1qHgBnFo0QkWBP7dfVj90i7tKVODfizO4HABw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Tue, 7 Apr 2020, brian m. carlson wrote:

> On 2020-04-04 at 00:16:21, Derrick Stolee wrote:
> > On 4/3/2020 5:40 PM, Junio C Hamano wrote:
> > > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > >>  * git run-job <job-name>: This builtin will run a single instance =
of a
> > >>    maintenance job.
> > >>
> > >>  * git job-runner [--repo=3D<path>]: This builtin will run an infin=
ite loop
> > >>    that executes git run-job as a subcommand.
> > >
> > > What does this have to do with "git", though?  IOW, why does this
> > > have to be part of Git, so that those who would benefit from having
> > > a mechanism that makes it easy to run regular maintenance tasks but
> > > are not Git users (or those that want to do such maintenance tasks
> > > that are not necessarily tied to "git") must use "git" to do so?
> > >
> > > I'll find out later why it is so after reading thru 15 patches
> > > myself, so no need to give a quick answer to the above; it was just
> > > my knee-jerk reaction.
> >
> > That's a reasonable reaction. The short version of my reasoning is tha=
t
> > many many people _use_ Git but are not Git experts. While a Git expert
> > could find the right set of commands to run and at what frequency to
> > keep their repo clean, most users do not want to spend time learning
> > these commands. It's also worth our time as contributors to select wha=
t
> > a good set of non-intrusive maintenance tasks could be, and make them
> > easily accessible to users.
> >
> > This series gets us half of the way there: a user interested in doing
> > background maintenance could figure out how to launch "git run-job" on
> > a schedule for their platform, or to launch "git job-runner" at start-
> > up. That's a lot simpler than learning how the commit-graph,
> > multi-pack-index, prune-packed, pack-objects, and fetch builtins work
> > with the complicated sets of arguments.
>
> If there are periodic tasks that should be done, even if only on large
> repos, then let's have a git gc --periodic that does them.  I'm not sure
> that fetch should be in that set, but nothing prevents users from doing
> "git fetch origin && git gc --periodic".

Hmm. Who says that maintenance tasks are essentially only `gc`? With
_maaaaaybe_ a `fetch` thrown in?

And about "nothing prevents users from doing ...": while that is true,
_even less_ is preventing those same users from _forgetting_ to run them,
or _not even knowing_ about the need to run them.

I vividly remember how `git gc --auto` was introduced. A Linux developer
too many was complaining about their Git operations becoming slower and
slower over the course of some months.

That is a very illustrative example of what we're trying to accomplish
here: we are dealing with people whose job it is not to become Git
experts, but whose job is to develop software, and it just so happens that
they use Git as version control system. For the most part, they are not
even all that interested in the internals of Git. Strange, I know.

The solution then, and now, is to teach Git to do these things for the
users, without the need to know a specific command and when to run it.

I am not saying that the current state of the design is perfect. What I am
saying is that the goal is very clear, and important, and we must try to
get there: to teach Git to run maintenance for the user, without much in
the way of the user asking for it, but Git knowing when to do what, and
trying mostly to stay out of the users' way.

> Let's make it as simple and straightforward as possible.

I fear that we're running the danger of confusing _two_ meanings of "as
simple and straightforward as possible" here.

=46rom my perspective, Stolee's patches aim to make using Git as simple an=
d
straightforward as possible, and the historical record shows that Scalar
(after which they are modeled) does a pretty good job at that, or is at
least heading in the right direction.

I get the impression, however, that many reviewers here seem to favor the
goal of making the _patches_ as simple and straightforward as possible,
however, at the expense of the original goal. Like, totally sacrificing
the ease of use in return for "just use a shell script" advice.

> As for handling multiple repositories, the tool to do that could be as
> simple as a shell script which reads from ~/.config/git/repo-maintenance
> (or whatever) and runs the same command on all of the repos it finds
> there, possibly with a subcommand to add and remove repos.

Sure, that is flexible.

And it requires a ton of Git expertise to know what to put into those
scripts. And Git updates cannot deliver more value to those scripts.

Which taps right into the above-mentioned focus on _the patches'_
simplicity, as opposed to the original goal of making _using Git_ simpler
and less painful with big repositories.

> > The second half would be to create a command such as
> >
> > 	git please-run-maintenance-on-this-repo
> >
> > that initializes the background jobs and enables them on the repo they
> > are using. This allows the most casual of Git user to work efficiently
> > on very large repositories.
>
> I'm not opposed to seeing a tool that can schedule periodic maintenance
> jobs, perhaps in contrib, depending on whether other people think it
> should go.  However, I think running periodic jobs is best handled on
> Unix with cron or anacron and not a custom tool or a command in Git.

Okay, here is a challenge for you: design this such that the Windows
experience does _not_ feel like a 3rd-class citizen. Go ahead. Yes, there
is a scheduler. Yep, it does not do cron-like things. Precisely: you have
to feed it an XML to make use of the "advanced" features. Yeah, I also
cannot remember what the semantics are regarding missed jobs due to
shutdown cycles. Nope, you cannot rely on the XML being an option, that
would require Windows 10. The list goes on.

Do you see where I am getting at?

It's really asking the user to take on _all_ the burden of the complexity.
The complexity has to live _somewhere_, after all, and if you want to
prevent Git from taking care of it, there are only the users left to hold
the candle.

I'd rather Git take up that responsibility, and lift that burden from the
users' shoulders. It's not like we have a stellar record of usability, so
we might just as well welcome Stolee's effort to improve Git in that
respect.

> I've dealt with systems that implemented periodic tasks without using
> the existing tools for doing that, and I've found that usually that's a
> mistake.  Despite seeming straightforward, there are a lot of tricky
> edge cases to deal with and it's easy to get wrong.

That might be true for general-purpose periodic taks managers.

But that's not what we need in Git, do we? The scope is a _lot_ more
reduced.

But maybe you found one of those issues in Stolee's patches? If so, please
do contribute your experience there to point out those issues, so that
they can be addressed.

> We also don't have to reimplement all the features in the system
> scheduler and can let expert users use a different tool of their choice
> instead if cron (or the Windows equivalent) is not to their liking.

Do we really want to start relying on `cron`, when the major platform used
by the target audience (enterprise software engineers who deal with rather
larger repositories than git.git or linux.git) quite obviously _lacks_
support for that?

That would be a decision that would not make sense to me. I mean, why go
to all the lengths of making it easier and less involved to manage large
repositories, and then just slam the door shut into the faces of all of
those developers working on Windows, an operating system with a rather
large market share?

Ciao,
Dscho
