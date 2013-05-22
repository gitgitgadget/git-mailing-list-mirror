From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Wed, 22 May 2013 11:55:00 -0700
Message-ID: <7vvc6aj14r.fsf@alter.siamese.dyndns.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
	<x2ip2b6udr.fsf@bacon.lysator.liu.se>
	<20130522134212.GB13731@poseidon.cudanet.local>
	<20130522144531.GB2777@thunk.org>
	<7v8v36kiau.fsf@alter.siamese.dyndns.org>
	<20130522180403.GB20848@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 20:55:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfEBt-0006Xv-3J
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 20:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801Ab3EVSzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 14:55:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab3EVSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 14:55:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5568121B10;
	Wed, 22 May 2013 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bh1CaM/xjeXqLwi7BIu1/p0SQj0=; b=YDbXOq
	CjZMe+gNUVDnjIvuwYKNSdchi5UiuubN2l69cviB3X6aeJlgRoCPR5kFzEbCePuf
	bZ3CTSkl51WSgGg9s9NIygaY0Du/S1nv4xU7ZFfp7PfWWekGhDH/jdpkvNCFdHhs
	Y1wl0cRMryWrpdBIpYxJLBAd+zAXDSD8GVOl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KG2+Z/JsFOTUAcOn5pFRJ5llnkee1a3T
	7lbtlC3K7HCeop2p5J8dp4WLoU2kCHO3wx/ujAydi1Y/Gj7rdMNKMtgzk+g37GDA
	lFaIVZtPiV9doxv0B2Ysz8RsPp37aQciS4KXY/PRO/UMElo9w0BK/T99YediOPk+
	soFgWcRCdBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4952121B0F;
	Wed, 22 May 2013 18:55:02 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BA3921B0E;
	Wed, 22 May 2013 18:55:01 +0000 (UTC)
In-Reply-To: <20130522180403.GB20848@thunk.org> (Theodore Ts'o's message of
	"Wed, 22 May 2013 14:04:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B57EAA8-C311-11E2-AC20-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225184>

Theodore Ts'o <tytso@mit.edu> writes:

> On Wed, May 22, 2013 at 10:58:49AM -0700, Junio C Hamano wrote:
>> Theodore Ts'o <tytso@mit.edu> writes:
>> 
>> > I was actually thinking that it might be interesting to have a
>> > branch.<branch>.rewindable, which would change the guilt defaults, and
>> > could also key changes in key git behavior which makes it less likely
>> > that a user shoots him or herself in the foot --- i.e., give warnings
>> > if he or she has modified the branch in such a way that
>> > remotes.origin.<branch> is no longer contained within the branch head.
>> 
>> At least "rebase" can pay attention to it and might make the world a
>> better place.
>
> Yeah, rebase was the primary command I was thinking about.  The other
> one would be "git commit --amend" after the branch had been pushed
> out.

It may or may not matter for the kernel folks, but let me pick your
brain while we are on this subject.

The "upstream" (your remotes.origin.<branch>) is that on top of
which you build your work.  You clone from there to bootstrap
yourself, you add your work (which may include integrating the work
of your contributors, if you are a mid-tier maintainer/integrator
aka a lieutenant) on top of it, and arrange the result to reach the
"upstream" in some way.

For the simplest (and still widely used) workflow that employs a
central shared repository, the way to make the result to reach the
"upstream" is by directly pushing into it yourself.  In that sense,
the word "upstream" and the traditional behaviour of "git push" that
pushes back to the 'origin' (or branch.<branch>.remote) to update
your "upstream" (or branch.<branch>.merge at 'origin') both make
perfect sense.

Also, if you are rebasing, @{u} refers to that place you integrate
with, i.e. your "upstream", in the central shared repository
workflow.

But in a triangular workflow, the way to make the result reach the
"upstream" is *not* by pushing there yourself.  For developers at
the leaf level, it is to push to their own repository (often on
GitHub), which is different from where they (initially) clone from
in order to bootstrap themselves, and (subsequently) pull from in
order to keep them up-to-date.  And then they request the published
work to be pulled by the "upstream".

Even in a triangular workflow, @{u} should still refer to the place
you integrate with, i.e. your "upstream", not to the place you push
to publish the result of your work.

This branch.<branch>.rewindable safety however cannot be tied to
@{u}.  The bottom boundary you want to be warned when you cross is
the change you pushed out to your publishing repository, and it may
not have reached remotes.origin.<branch> yet.

We will be introducing remote.pushdefault configuration in the
upcoming 1.8.3 release, so that you can say:

	[remote "origin"]
        	url = git://g.k.o/pub/scm/linux/kernel/git/torvalds/linux.git/
		fetch = +refs/heads/*:refs/remotes/origin/*

	[remote "ext4"]
        	url = g.k.o:/pub/scm/linux/kernel/git/tytso/ext4.git/
		fetch = +refs/heads/*:refs/remotes/ext4/*

	[remote]
        	pushdefault = ext4

and hopefully it would let you do this:

	git checkout master
        ... after working on it ...
        git push

As remote.pushdefault is set to ext4, without any extra arguments,
the result will pushed to the "ext4" remote.  If you are using the
traditional push.default=matching, it may also try to push out dev,
dev-next and other branches you may have in your local repository
and at k.org; if you are using push.default=simple or other "single
branch" modes like "current", "upstream", etc, it will only push out
your current branch (i.e. "master") to "ext4" remote.

You may however be using your local "master" branch for your
development, and pushing the result out to "dev".  With only the
remote.pushdefault setting to push to ext4 (instead of origin), you
still would have to say

	git push ext4 master:dev

There is another change discussed on the list recently to also let
you configure your local "master" branch to update "dev" in your
publishing repository.  It may go like this:

	[branch "master"]
        	push = refs/heads/dev

In any case, refs/remotes/ext4/dev would be the remote tracking
branch (not refs/remotes/origin/anything) that keeps track of what
you pushed out there the last time.  And that would be what your new
safety based on "branch.master.rewindable = no" needs to check
against, not "refs/remotes/origin/master" which is your master@{u}.
