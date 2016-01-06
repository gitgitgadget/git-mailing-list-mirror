From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Wed, 6 Jan 2016 15:49:10 +0000
Message-ID: <20160106154910.GA8375@salo>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <5643107B.20501@alum.mit.edu>
 <20151201205527.GF18255@google.com>
 <CAD0k6qQ98ED4xLynRZdnnPX_HDHhEq5SQhNov-5cwG82pqMFGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 16:49:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGqKt-0002q3-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 16:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbcAFPtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 10:49:16 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36388 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbcAFPtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 10:49:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id ABA5646082F;
	Wed,  6 Jan 2016 15:49:12 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4WHm5ya0fEz; Wed,  6 Jan 2016 15:49:06 +0000 (GMT)
Received: from salo (salo.dyn.ducie.codethink.co.uk [10.24.2.138])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 3850D4609E8;
	Wed,  6 Jan 2016 15:49:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAD0k6qQ98ED4xLynRZdnnPX_HDHhEq5SQhNov-5cwG82pqMFGw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283448>

On Tue, Dec 01, 2015 at 04:00:52PM -0500, Dave Borowitz wrote:
> On Tue, Dec 1, 2015 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Cc-ing dborowitz, who has been working on storing Gerrit's code review
> > information in Git instead of a separate database (e.g., see [1]).
> 
> Thanks, we actually already had a thread going that I realize only in
> retrospect did not include the git mailing list.

Thanks, we did indeed have a thread going,
that probably should have been on-list.
I'm also working on a little library[1] that should eventually allow other
tools to use gerrit's notedb in the hope that this might
eventually lead to the development/adoption of a common format for such tools.

One thing that concerns me about notedb with respect to distributed review
is the storage format for comments. Within a distributed review system comments
may be made in any order, yet the format is designed around the kind of
linearisation that can be assumed by a centralised system.

The problem is that multiple comments in notedb may be stored within
the same blob/note, specifically all comments on a particular commit will
be stored in the same blob. In a distributed system storing multiple comments
in the same blob like this will inevitably lead to merge conflicts.

This problem isn't unsolvable, someone already suggested to me the idea
of writing a custom merge driver for merging different notes stored in notedb.
It would obviously be preferable to have a format that avoided creating
conflicts in the first place, but a custom merge driver doesn't seem like
an unreasonable solution.

If anyone has any thoughts on how else this problem might be solved,
I'd be very interested to hear them.

Thanks again,
Richard Ipsum

[1]: https://bitbucket.org/richardipsum/perl-notedb
