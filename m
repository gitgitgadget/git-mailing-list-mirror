From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 13:23:57 +0530
Message-ID: <CALkWK0noVfRoXAH75r4yBijXSHD5yusLcKgGC=8bjOW6=qCMng@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
 <87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr>
 <7vmwsqns4p.fsf@alter.siamese.dyndns.org> <CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
 <7vehe2m88a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 09:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUY3m-0004oe-RM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 09:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab3DWHyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 03:54:38 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:37829 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab3DWHyi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 03:54:38 -0400
Received: by mail-ia0-f172.google.com with SMTP id i20so280251ian.17
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=M3fM2sCyd/dikjRJ9ooD9Cpz6gPguJsRv9BKpWhwD7Y=;
        b=gdPUfMyUldSU2GobEmz32XKyjGboBT6E1SmLX2OUSw344zt/RJM3gIgkacGxY3rlAg
         u+Q/EA5iBGTLopKoJmx5DLcSrENnr2xrnZuf8sdnU/KvfOLHSUbpZv9K9XDtNuYtAi1v
         YpnbeBXQoZ9x3E2iiUZT5SslnOvT01XKPIHTtZ6v0JahvYUbQ9NEW5Q3MPlCTIlxfmuH
         qIG/TRO8nNSyIH0m8NI/rAbmp2OsSt+I5bRiXcEY5iQk0kbMPu4u54cSxK6eD5kS/Mxc
         winHZ74Llu/6o+q2gh3RJe101J3NHfFGefQ06iNpqpaoPAnU74aE3zAadfGKwIvlwzj+
         bNZA==
X-Received: by 10.50.117.3 with SMTP id ka3mr22449941igb.107.1366703677591;
 Tue, 23 Apr 2013 00:54:37 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 00:53:57 -0700 (PDT)
In-Reply-To: <7vehe2m88a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222137>

Junio C Hamano wrote:
> It sounds like you are repeating the same old "let's record renames
> in the commit", and in a system (not Git) where recording renames
> may make sense, you may be making sense.
>
> But we will not record renames in the commit.  Time to re-read
> $gmane/217, perhaps?

Yeah, you're right.  It makes no sense to record renames, although I
have a different argument against it: any implementation that records
renames will depend on the path that was taken to get to the final
state, and this is completely wrong.  Subversion made this mistake,
and users pay a very heavy price: if the user didn't explicitly rename
a node (~= tree) and just did a delete + add, the repository is
more-or-less screwed wrt merging.

Forget everything that I said, and let's start over.

In the common usecase of subtrees, it might make sense to record some
additional submodule-like parameters in the subtree's tree object.
This additional information is entirely optional, and doesn't change
the way merges happen: we can have it as merely a heuristic-helper
(for git merge -s subtree).  Initially, let's just think of putting a
ref field in the tree, so that I can have the following setup:

- remote origin referring to my superproject.
- remote git/origin referring to the fetchdefault of my subproject git.
- remote git/ram referring to the pushdefault of my subproject.
- the tree object corresponding to quux/baz/git is additionally filled
in with the ref refs/remotes/git/origin/master.

Then, I can just say git pull quux/baz/git, and it will automatically
fetch changes from the ref and merge it into the subtree.  It's not to
say that I can't merge any other ref; just that I merge this ref most
of the time, and I want a DWIM for this case.

Further, this can speed up tree-rename detection greatly (in fact, I'm
thinking the first implementation will depend on this information
being present).  I inspect M^{tree} and I want to know how it's
composed from M^1^{tree} and M^2^{tree}.  Simple.  In M^{tree}, look
for trees that have this additional data filled in: then we can just
short-circuit the rename detection to matching the similarity of this
tree with M^1^{tree} and M^2^{tree}.

When this aux data is present in the tree, we can do one more thing:
have a symref tracking the commit-line corresponding to M^2. This
means that we can DWIM for things like 'git commit' inside the subtree
very easily.  When the aux information is not present, 'git commit'
will obviously commit to HEAD, essentially making the superproject own
those changes in the subtree (as it does now).

This might be the route to implementing narrow clones sensibly.  A
narrow clone does not mean that any directory in the entire repository
can be cloned separately: it just means that a tree with this aux data
need not be fetched in the initial clone.  For this to work, instead
of refs/remotes/git/origin/master, the aux data will need a
combination of upstream URL and ref: we can then automatically figure
out the name from the URL and deposit the fetched data in
refs/remotes/<name>/origin/<ref>.

Initializing nested submodules without the container is also easy: in
the superproject, you need to have aux-trees corresponding to
quux/baz/git and quux/baz/git/moo/clayoven.  It might additionally be
a good idea to track these aux-trees: but even if we don't go down
that route, we can always deposit a "template" file from the
superproject that won't interfere with the subtree merging process.

Now, I'm not sure what the value of splitting the object stores at
this point is.  The aux-tree can have a statthrough field to block
stat() calls from going through, so there's really no performance
issue.  If you want to separate one tree out of the superproject and
work on it separately, all you have to do is fetch the corresponding
ref.

On the issue of floating submodules.  It might make sense to zero out
the hex of the tree, as seen by the superproject.  The limitation is
that we can't introduce any changes to the submodule from the
superproject: it's basically a dummy entry sitting in the
superproject's tree.  It's a bit of a hack, but I think it's workable.

So, what do you think?
