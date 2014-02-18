From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git-reviewed: linking commits to review discussion in git
Date: Tue, 18 Feb 2014 00:28:27 -0500
Message-ID: <20140218052827.GA25291@sigill.intra.peff.net>
References: <CANx4bCB5tTzKusbfcqQ=eoeOGJ-WxWvF3QNpfa5rTq7oOSG-5w@mail.gmail.com>
 <CANx4bCAWVoCQdYQQ5cGXF-Z6Evck=Oeb2Shghkcuf7PMvSZBOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Peter Rigby <peter.rigby@concordia.ca>
To: Murtuza Mukadam <murtuza.i.mukadam@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 06:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFdEQ-0005q8-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 06:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbaBRF2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 00:28:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:52422 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbaBRF23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 00:28:29 -0500
Received: (qmail 9119 invoked by uid 102); 18 Feb 2014 05:28:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Feb 2014 23:28:30 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 00:28:27 -0500
Content-Disposition: inline
In-Reply-To: <CANx4bCAWVoCQdYQQ5cGXF-Z6Evck=Oeb2Shghkcuf7PMvSZBOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242274>

On Mon, Feb 17, 2014 at 03:12:48PM -0500, Murtuza Mukadam wrote:

> We have linked peer review discussions on
> git@vger.kernel.org to their respective commits within the main
> git.git repository. You can view the linked reviews from 2012
> until present in the GitHub repo at:
> https://github.com/mmukadam/git/tree/review

Neat. We've experimented in the past with mapping commits back to
mailing list discussions.  Thomas (cc'd) has a script that creates
git-notes trees mapping commits to the relevant message-id, which can
then be found in the list archive.

To me, the interesting bits of such a project are:

  1. How do we decide which messages led to which commits? There is
     definitely some room for heuristics here, as patches are sometimes
     tweaked in transit, or come in multiple stages (e.g., the original
     patch, then somebody suggests a fixup on top). You might want to
     compare your work with the script from Thomas here:

       http://repo.or.cz/w/trackgit.git

  2. How do we store the mapping? I think git-notes are a natural fit
     here, but you don't seem to use them. Is there a reason?

  3. How do we present the emails to the user (including showing
     threads, letting them dig deeper, etc)?

     The existing solution has no support at all for 3. Personally, I
     keep my own git-list archive locally, so I can search it (by
     message-id or other features), dump the result into an mbox
     (optionally including the surrounding thread), and then view the
     result in mutt.

Having had this solution for a while, my experience has been that I
don't use it that often. It's not that I don't refer to the archive to
see more backstory on a commit; I probably do that once a week or so.
But since I have a decent searchable archive, I tend to just do it "by
hand", searching for keywords from the commit message, and limiting by
date if necessary.

Going straight to the message by id might be a little faster, but I
often pick up stray bits in my search that were not part of the original
thread. E.g., somebody reports a bug, then 3 days later, somebody else
posts a patch (but does not do it as a reply to the bug). There's
nothing in the message headers or the commit mapping to say that those
two messages are related. But because a search of the relevant terms
finds both, and because the result is date-sorted, they end up near each
other and it's easy for me to peruse.

It would be interesting to apply some kind of clustering algorithm that
automatically determines the messages related to a commit, including
both the patch but also any discussion leading up to it. I realize that
may be getting far afield of your original goals, but hey, you said you
wanted feedback. I can reach for the stars. :)

-Peff
