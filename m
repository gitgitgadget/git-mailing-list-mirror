From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Mostly Evil
Date: Tue, 06 May 2014 15:06:49 -0700
Message-ID: <xmqqy4yed0jq.fsf@gitster.dls.corp.google.com>
References: <5363BB9F.40102@xiplink.com>
	<xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
	<5363edc954f8e_70ef0f30c24@nysa.notmuch>
	<20140502214817.GA10801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 00:09:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhnVr-0007UW-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbaEFWG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:06:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60490 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437AbaEFWGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:06:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 241C41599E;
	Tue,  6 May 2014 18:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHZVEIvUdD6DPNu3QrHInDIvO14=; b=ivBePO
	yZwwiZOVRFeB9Rp0vOIbu3+skD+rLdIdFFwdRgnYHopdY7w9OmjuRJXchj8XIxfY
	vOIFkWSBqx4Lh5q2d06waPyq0+vvPMD/+Fl3/Odoq6nAiYsRpxbmFEaGdYz7F+kW
	mY0wM4yljSPgt/1ufxmeKnok7GGLGl5lUpTIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBrqA61VooVIffSkWDOMmWZHKTmHoiUl
	HIS8VPtxSe0g70ugou3HenngC86oijwxSq1/eQlzOY5sdLu7r26ZJFSdqa2edqs0
	J5M/bmIbAlzvPtJ1rzRmvBJuR2O2ncuTmTmGj51DSnA8FyBnsl2CATi8lqd0jI8P
	MGZnYZft280=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A03F1599D;
	Tue,  6 May 2014 18:06:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E3C11599A;
	Tue,  6 May 2014 18:06:51 -0400 (EDT)
In-Reply-To: <20140502214817.GA10801@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 2 May 2014 17:48:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9D1BCBA-D56A-11E3-BD0E-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248258>

Jeff King <peff@peff.net> writes:

> I realize this has veered off into talking about an "update" command,
> and not necessarily "pull", but since there a lot of proposals floating
> around, I wanted to make one point: if we are going to do such a switch,
> let's please make it something the user explicitly turns on.

I mentioned "update" in an attempt to suggest some way to avoid
breaking "git pull" for people who do want to advane the history
with real work (i.e. not just following along with fast-forwarding).

A failed "git push" that suggests to pull first, which came from the
original "To emulate CVS workflow, you can pull, work, push, and if
the push fails, pull again and then push" in the early tutorial,
turns out to be very bad in the "trunk" centric worldview.
And I think the solution is to realize that we use "git pull" for
two fairly differnt workflows.

 - You know you own the tip of the "trunk" (in the global view).
   You merge from other people to advance the global world view in a
   way that makes sense in the "first-parent chain is the trunk"
   worldview.  That is what "git pull [--no-ff]" was designed to do,
   and it does it very well.

 - You have some work of yours (either you committed directly, you
   merged your own work done on a side branch, or you merged from
   other people using "git pull") on top of a commit that used to be
   at the tip of the global world.  You want to make sure that
   branch you are on is not missing what has happened while you are
   not communicating with the outside world.

The problematic case is the latter, and by introducing a new command
to do that well (which is *not* just about "swapping the order of
the parents", by the way), updating the "leaf developer" section of
"Everyday Git" document and tutorials, and suggesting to use that
upon failed "git push", I think users would get a more pleasant
experience.  And move "git pull" into "integrator" section, a
command that is not necessary for leaf developers.

I am not married to the name "update".  I think the ideal behaviour
of that "leaf-developer" command would be something along the lines
of the following:

 - If we can fast-forward, do so and we are done.

 - Otherwise, we have a history of this shape:

        ----O    
             \
    -----A----B----C
          \
           X---Y---Z

   where A was where we forked, B was a merge the user made, C was a
   commit the user directly made, and X, Y, and Z (some of them may
   be merges) are the "trunk" history  "git pull" would create a
   merge M whose parents are <C Z>, which is wrong from the
   "first-parent is the trunk" worldview.

   But recording the merge to have parents <Z C> does not give us
   "the first-parent is the trunk" worldview, in the presense of B.
   We would prefer to end up with a history more like this:

    -----A       ----O
          \           \
           X---Y---Z---B'--C'

   so that your work, your contribution with two commits of yours,
   was to merge the work done on a side branch and then made one
   commit directly on top of it.

   Hence, I think the ideal behaviour of the new command is to
   replay the first-parent history on top of the updated tip of your
   upstream (which by the way is different from how "rebase
   --preserve-merges" works; it is more like how J6t wanted to make
   "rebase --preserve-merges" work, IIRC).

After that, you can attempt to push, and it may fail again (because
somebody has grown the shared history to have a child W of Z at the
tip), in which case exactly the same "git update" would attempt to
recreate a history of this shape:

    -----A           ----O
          \               \
           X---Y---Z---W---B"--C"


During a long transition period (essentially, waiting for the
current crop of documents and tutorials to die out), we will need
extra safety to prevent people, who merely wanted to bring their
branch up to date, from running "git pull", and I think the command
needs to:

 - check which branch of what repository it is trying to pull;

 - check which branch of what repository it is going to update if
   "git push" is given;

 - if they are the same, then you are attempting to update from your
   upstream, so either warn or error out.  If we are going to warn
   but make a merge anyway, the warning message *must* come at the
   very end of the output (and tell the user the way to recover is
   to reset one away and run the other command).

Or something like that.
