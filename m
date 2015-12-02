From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Wed, 2 Dec 2015 17:31:14 -0500
Message-ID: <20151202223114.GA20542@sigill.intra.peff.net>
References: <20151202002450.GA27994@sigill.intra.peff.net>
 <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Fvm-0000na-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 23:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbbLBWbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 17:31:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:36558 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754635AbbLBWbR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 17:31:17 -0500
Received: (qmail 15792 invoked by uid 102); 2 Dec 2015 22:31:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 16:31:17 -0600
Received: (qmail 4187 invoked by uid 107); 2 Dec 2015 22:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 17:31:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2015 17:31:14 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281918>

On Wed, Dec 02, 2015 at 02:11:32PM -0800, Junio C Hamano wrote:

> I think I managed to get my working area (together with a handful of
> new entries in the rerere database and a few merge-fix/ entries) in
> sync with what you pushed out well enough that my automated
> procedure would recreate the status of various branches you pushed
> out exactly.
> 
> I haven't caught up with the changes in the component branches,
> though, so it may take a few days until I start picking up new
> topics from the list traffic.

My whole workspace is at https://github.com/peff/git, if fetching that
directly is easier. I just noticed that my refspecs were not configured
to push up refs/merge-fix. I've just fixed that and pushed again.

I'll leave it that way for a few more days, but then will probably take
it back to my usual contributor setup (i.e., just my topics and personal
integration branches).

Let me know if there's anything else I can do to help with the handoff.

> > * bc/object-id (2015-11-20) 12 commits
> [...]
> 
> Aside from niggles on titles of a handful of changes in this topic,
> I have a bit of concern with this one and dt/refs-backend-pre-vtable
> topic (marked as "Will merge to 'master' two cycles from now.",
> which I am reading as "two cycles" means 2 x (8-10 week release
> cycle), not "two integration cycles by the maintainer, aka two
> issues of What's cooking report", which is typically less than a
> week).

My "two cycles from now" meant "two integration cycles". I seemed to do
only about two per week. You can take those all with a grain of salt. It
was meant only as a note to myself that the topic seemed risky enough to
allow extra cooking time in next.

Since your "Meta/cook -w" output shows dates of merges, I imagine you
are in the habit of simply looking at those dates and saying "eh, this
has been in next for 2 weeks and nobody has complained; that's enough
cooking time".

> The merge resolution in 'pu' discards what this topic did to refs.c
> because much of the original goes away from there, but does it mean
> (remember, I haven't caught up with the contents of the topics yet)
> that the merge reverts part of what this topic did, and in an ideal
> world, if the other one were more mature when this topic got
> started, more use of "unsigned char[40]" would have been migrated to
> "struct object_id" in new files the other one introduced?  Or
> perhaps we would want to go the other way around, i.e. as this topic
> conceptually is fairly straight-forward, merge this to 'next' and
> then down to 'master' (which would not take two release cycles) and
> then redo the other topic on top?

I took the resolution proposed by brian, which was that the refs.c code
went away. There was some evil-merge required to make the new
refs/files-backend.c compile (in my refs/merge-fix/bc/object-id) for
code that moved. I was surprised there wasn't more, but I think it's
right. We dropped the _users_ of some sha1/object_id transition code
(which is why it doesn't need more fixup to compile). We did not drop
any actual function conversions (which might have been wrong but still
compiled, if both the function signature and its callers all moved).

As it's all part of an incremental conversion anyway, my feeling was
that it was OK to move forward as long as it wasn't disturbing topics in
flight (assuming we're agreed on the overall direction, which I think is
the case).

> > * mr/ff-refs (2015-11-28) 6 commits
> [...]
> 
> This is another one that needs some evil-merge interaction with
> bc/object-id, but I have a feeling that this is not such a good
> addition to our workflow elements, so I am not worried too much
> about it.  I'm inclined to eject this topic (and will welcome if
> people come up with an alternative, perhaps based on the "let fetch
> do so instead" approach discussed there).

Right. There's another merge-fix for this.

I explicitly put this after bc/object-id (requiring another merge-fix,
rather than rolling it into the bc/object-id merge fix), because I
expected bc/object-id to graduate, and this one to languish in pu or get
re-rolled.

I agree that ejecting is fine here.

> > * ps/rebase-keep-empty (2015-11-24) 2 commits
> >  - rebase: fix preserving commits with --keep-empty
> >  - rebase: test broken behavior with --keep-empty
> >
> >  Keep duplicate commits via rebase --keep-empty.
> >
> >  I'm not sure if I agree with this interpretation of the "rebase
> >  --keep-empty" documentation, but I haven't thought too hard about it.
> >  Comments welcome.
> 
> "--keep-empty" has always been about keeping an originally empty
> commit, not a commit that becomes empty because of rebasing
> (i.e. what has already been applied to the updated base).  The
> documentation, if it leads to any other interpretation, needs to be
> fixed.
> 
> Besides, if "--keep-empty" were to mean "keep redundant ones that
> are already in the updated base", the patch must do a lot more,
> e.g. stop filtering with git-cherry patch equivalence.
> 
> I'm inclined to eject this topic.

That was my thinking too (and I notice it didn't get any review from
anybody else).

> > * ls/test-must-fail-sigpipe (2015-11-28) 2 commits
> >   (merged to 'next' on 2015-12-01 at d374686)
> >  + add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
> >  + implement test_might_fail using a refactored test_must_fail
> >
> >  Fix some racy client/server tests by treating SIGPIPE the same as a
> >  normal non-zero exit.
> >
> >  Will merge to 'master' two cycles from now.
> 
> Hmm, perhaps I misread what you meant by "two cycles", as this is
> only the test suite and I cannot imagine we would want to be
> ultra-safe to cook that for two release cycles, and you did mean two
> issues of "What's cooking" report?

Yes, the latter. Even though it is "only" the test suite, it gave us
enough trouble that I did not want to go to next and then immediately to
master in the next cycle (i.e., I wanted to give people time enough to
complain if it breaks their "make test" in next).

> > * dt/refs-backend-pre-vtable (2015-11-20) 10 commits
> >   (merged to 'next' on 2015-11-24 at 8fd7293)
> >  + refs: break out ref conflict checks
> >  + files_log_ref_write: new function
> >  + initdb: make safe_create_dir public
> >  + refs: split filesystem-based refs code into a new file
> >  + refs/refs-internal.h: new header file
> >  + refname_is_safe(): improve docstring
> >  + pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
> >  + copy_msg(): rename to copy_reflog_msg()
> >  + verify_refname_available(): new function
> >  + verify_refname_available(): rename function
> >
> >  Code preparation for pluggable ref backends.
> >
> >  Will merge to 'master' two cycles from now.
> 
> ... that is, I'd very much prefer bc/object-id redone on top of an
> updated codebase that already has dt/refs-backend-pre-vtable in it.

I think that is OK to do, though I'm not sure the end result will be
all that different.

-Peff
