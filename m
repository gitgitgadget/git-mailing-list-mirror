From: David Kastrup <dak@gnu.org>
Subject: Re: Consistency question
Date: Wed, 15 Jan 2014 12:40:29 +0100
Message-ID: <871u098ocy.fsf@fencepost.gnu.org>
References: <8761pl8raj.fsf@fencepost.gnu.org>
	<20140115111330.GH14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 12:40:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Oq1-0001vA-B8
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbaAOLkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:40:46 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56722 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbaAOLko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 06:40:44 -0500
Received: from localhost ([127.0.0.1]:55764 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W3Opv-0006B4-TS; Wed, 15 Jan 2014 06:40:44 -0500
Received: by lola (Postfix, from userid 1000)
	id B041CDF673; Wed, 15 Jan 2014 12:40:29 +0100 (CET)
In-Reply-To: <20140115111330.GH14335@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2014 06:13:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240464>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 15, 2014 at 11:37:08AM +0100, David Kastrup wrote:
>
>> The question is what guarantees I have with regard to the commit date of
>> a commit in relation to that of its parent commits:
>> 
>> a) none
>> b) commitdate(child) >= commitdate(parent)
>> c) commitdate(child) > commitdate(parent)
>
> a) none
>
>> Obviously, I can rely on c) being true "almost always":
>
> Actually, b) is quite often the case in automated processes (e.g., "git
> am" or "git rebase"). The author dates are different, but the committer
> dates may be in the same second.

Ok, thanks.  Assuming that rebases don't happen 1000/s, I should likely
not worry too much about O(n^2) for this case (and frankly, clearly
nobody worried about O(n^2) in the current blame.c anyway).  It's also
not really relevant for linear parts of the history like that of "git
rebase" since in that case the parent enters my priority queue when its
child is getting processed: nothing to be confused about here.  This is
more about sibling rivalries calling a parent to the queue before the
sibling had a chance to leave.  So it comes into play for my use case
basically only when dealing with merge commits.

> I suspect there are other algorithms that could be sped up, too, if we
> had trustworthy generation numbers (I implemented and timed the
> "--contains" algorithm, but haven't done so for other algorithms).

With a single root, "depth" helps a lot.  When looking for a common
parent of a number of commits, you first shorten all ancestries to the
same size and then you can look for the point of convergence in
lockstep.

But didn't git forego the "single root" requirement in its commit DAG at
some point of time?

Thanks for the speedy reply!  I think I'm good with what I need to know
to go ahead.  The rest is just idle curiosity.

-- 
David Kastrup
