From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 17:24:56 +0200
Message-ID: <87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:25:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIc8-0007ZN-Te
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab3DVPZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:25:01 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:5994 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab3DVPZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:25:00 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 17:24:56 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 17:24:56 +0200
In-Reply-To: <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 22 Apr 2013 20:00:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222025>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Thomas Rast wrote:
>> [...]
>
> I think you've misunderstood the whole thing.  The histories of M^1
> and M^2 are completely unrelated: they're from different projects
> altogether.  Considering the /ichi in M^2 a "rename" of the /ichi in
> M^1 is completely wrong.  They have nothing to do with each other.  I
> intentionally named it "ichi" in my orphan branch just to drive my
> point.  I suspect you've got confused because I used an orphan branch
> to emulate a different project's history.  If you want an end-user
> understanding of the problem, use git subtree:
>
>     $ cd /tmp
>     $ git clone gh:artagnon/varlog
>     $ cd varlog
>     $ git subtree add --prefix=clayoven \
>        gh:artagnon/clayoven master
>     $ cd clayoven
>     $ git log README.md
>
> What do you expect?  The same output you would get if you cloned
> gh:artagnon/clayoven separately and executed 'git log README.md' on
> it.

No, I don't.  But that's probably because I know a few things about how
git-log works that your hypothetical $USER doesn't.

At the risk of restating what everyone agrees on: It's a design
principle of git that it only stores tree states, and anything about
diffs, files, renames, etc. is purely in the imagination of the user.

We support that imagination by having analysis tools with which some
things can be found out, but others can't.

So (I think?) in the above you claim that $USER interprets

  git log -- README.md

as

  Show me the history of README.md.

But there's no such thing as the history of a file!  The command instead
says

  If I filter all history for only changes affecting a path 'README.md'
  in the root of the repository[1], then what does it look like?


So please don't write tests that go contrary to that definition, because
they're *wrong*.  The current implementation precisely matches the
current definition of pathspec filtering.

You can try arguing for changing the definition, but unless you find one
that can be implemented fast enough to be generally usable, I will
oppose that change.


The only thing that's broken in any of this is that I think, as
explained on IRC, that a hypothetical fixed --follow -C should be able
to figure out this case.  By spending extra cycles on analysis,
naturally.


[1]  and also skipping lines of history that seem uninteresting at this
point already, compare --simplify-merges

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
