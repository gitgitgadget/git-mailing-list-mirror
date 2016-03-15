From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 17/17] rebase-interactive: introduce interactive
 backend for builtin rebase
Date: Tue, 15 Mar 2016 08:57:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603150800420.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-18-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:58:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afjrp-0000BC-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 08:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbcCOH6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 03:58:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:55654 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbcCOH6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 03:58:06 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJFBe-1ahOpD0ZhK-002m9G; Tue, 15 Mar 2016 08:57:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457779597-6918-18-git-send-email-pyokagan@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:8vH52Jw6MRVWkTgoiU/vd9KjFfSSz25bEypYpmOBTOOUzf9qTfS
 G6GC0b0WVEJJ3nkqqEtILm6cdBJrs/U8PbP1Fvoh5uvk8fWEln6ph0rb4JoAaEIl953o0cG
 tJQfnlDzFONrWy1fYGW4WeQFWQvvHZOZo6mbVrZbaM2S0AUjQblilJliVNdECOv4QxDg1om
 mw7PlljVmo59NhsLaYa8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mv+YNNsM4XI=:8D9z+mTF5uSsMWaftFjK+E
 EHAnvGsbBD4JKl7b9lOnBCk7jiJSJ1s6uzrDid+IyjPpxTeddvHQ976aEh/VzHA/MchSbJ7Ob
 krTuEgpL5GaXIBsR2bI9nI3HIgIapib9Cun/fXZQmQJVXa6BGLjqX6RwKsGJkp7XXAGqrcaGW
 J5i/3a07e82hOvPXyhc6w1XY8OBCTnSZeJg1KFsSqWSeacH+JzY/SIdvWWFBilSADkd6ij05l
 +h8SgcSNdDwQKb5niX4setV22Pzkxly0pMX9XcZXxmSrnXTApD6MhbXUhFnq3ffLX5yX+plFI
 gK6X2oQ4DI3nxyoL7y+zObovJlEQ8ONekgQSaTpfvHboY+fDGAeXDPAUAbbnm+OPrBfXUUfMV
 ES/Es0SmYp8RbsTDAvNX1F8eUxXiNLI+v9NYj/p+bpYnaU7YXosMgkF+VrKa1nrLi2T0r5VeX
 1tF18O/QEgZfkdPE0cm+V0QI2dOcgbtP3rEiVYyCQPSaga35DkQFM3leTnqB2vr4m5B8wia/o
 w+bOtswcdlYqTMirz83qMcZm479h+jbI8SJQeDUbhpsMox9DAwo4vcg8UrSWbzFeJNj0fhiWD
 Q7q9V8q2MZsih8RcuVuVsgTMmoS8goCYPIY3RykywJku6Bk+riClXb5FPMPpPuyj8UwOipyNM
 vXnvNhoH7b//fRn25F5VZdsz9739Qhn8okWOCxU4IB6uAggCySnpwL7oQa6baHS2+NxEGCEjK
 LHmkwSrW4dphjEQ+eoE85Te7KLVs7Y5b5e3B8zZzSvGE4ECLnYo3XN/R2eoK3mUiqq/DS+Wx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288840>

Hi Paul,

On Sat, 12 Mar 2016, Paul Tan wrote:

> Since 1b1dce4 (Teach rebase an interactive mode, 2007-06-25), git-rebase
> supports an interactive mode when passed the -i switch.
> 
> In interactive mode, git-rebase allows users to edit the list of patches
> (using the user's GIT_SEQUENCE_EDITOR), so that the user can reorder,
> edit and delete patches.
> 
> Re-implement a skeletal version of the above feature by introducing a
> rebase-interactive backend for our builtin-rebase. This skeletal
> implementation is only able to pick and re-order commits.
> 
> Signed-off-by: Paul Tan <pyokagan@gmail.com>

It is a pity that both of us worked on overlapping projects in stealth
mode. Inevitably, some of the work is now wasted :-(

Not all is lost, though.

Much of the code can be salvaged, although I really want to reiterate
that an all-or-nothing conversion of the rebase command is not going to
fly.

For several reasons: it would be rather disruptive, huge and hard to
review. It would not let anybody else work on that huge task. And you're
prone to fall behind due to Git's source code being in constant flux
(including the rebase bits).

There is another, really important reason: if you package the conversion
into small, neat bundles, it is much easier to avoid too narrow a focus
that would tuck perfectly useful functions away in a location where it
cannot be reused and where it is likely to be missed by other developers
who need the same, or similar functionality (point in case:
has_uncommitted_changes()). And we know that this happened in the past,
and sometimes resulted in near-duplicated code, hence Karthik's Herculean,
still ongoing work.

Lastly, I need to point out that the conversion of rebase into a builtin
is not the end game, it is the game's opening.

I could imagine that other Git oldtimers are perfectly happy with the
state of the rebase family of commands. I am not. The user interface is
klunky, some parts are designed wrong (--preserve-merges, I am looking at
you!), the *name* is completely unintuitive, for crying out loud! Just to
name a *few* things, there is much more.

I worked around the limitations of the --preserve-merges feature (yeah,
blame me...) by inventing the "Garden Shears" [*1*] that can re-plant an
entire thicket of topic branches on top of a moving upstream branch. It is
similar in spirit to Junio's custom tools that recreate his 'pu' branch
over and over again, but uses the interactive rebase as work horse.

The shears can also be used to fix up commits in the middle of a thicket
of branches, which is why I wrote the shears script in the first place.

The fact that the interactive rebase does not do the job with which pretty
much every project maintainer is faced points out two things: interactive
rebase needs to learn new tricks, and we need plumbing to do interactive
rebase's bidding (so that we/others can build better UIs, hopefully with
much better names, too).

I already know pretty well how I want to implement the shears as a new
mode of the interactive rebase, once I finished teaching the sequencer how
to process rebase -i's edit scripts (which somebody decided to name
"instruction sheets" in the sequencer, to add confusion to poor naming).

All of this let's me think that there is just too much to do for a single
developer, and therefore whatever needs to be done must be done in a way
that allows more than a single person to complete the whole shebang, or
at least their part of it.

So you see, there was a much larger master plan behind my recommendation
to go the rebase--helper route.

As to my current state: Junio put me into quite a fix (without knowing it)
by releasing 2.7.3 just after I took off for an extended offline weekend,
and now I am scrambling because a change in MSYS2's runtime (actually,
probably more like: an update of the GCC that is used to compile the
runtime, that now causes a regression) is keeping me away from my work on
the interactive rebase. Even so, I am pretty far along; There are only
three major things left to do: 1) fix fixups/squashes with fast-forwarding
picks, 2) implement 'reword', 3) display the progress.  And of course 4)
clean up the fallout. ;-)

At this point, I'd rather finish this myself than falling prey to Brooks'
Law.

I also have to admit that I would love to give you a project over the
summer whose logical children are exciting enough to dabble with even
during the winter. And somehow I do not see that excitement in the boring
conversion from shell to C (even if its outcome is well-needed).

Ciao,
Dscho

Footnote *1*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
