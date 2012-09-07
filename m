From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Prevent git-config from storing section keys that are too long
Date: Thu, 06 Sep 2012 22:34:21 -0400
Message-ID: <1346984829-sup-4477@pinkfloyd.chass.utoronto.ca>
References: <1346978829-4486-1-git-send-email-bwalton@artsci.utoronto.ca> <7vpq5yzkf3.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 04:34:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9oOv-0008Az-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 04:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457Ab2IGCe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 22:34:26 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:44867 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757638Ab2IGCeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 22:34:25 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51435 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1T9oOj-0002lq-Om; Thu, 06 Sep 2012 22:34:21 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1T9oOj-0001mo-Nl; Thu, 06 Sep 2012 22:34:21 -0400
In-reply-to: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204944>

Excerpts from Junio C Hamano's message of Thu Sep 06 21:33:20 -0400 2012:

Hi Junio,

> > identifiers generated from keys like:
> >
> > url./some/really/long/path.insteadOf
> >
> > could overrun the current limit.  It's not a common case, of course,
> > or this issue would have been found sooner.  Would doubling the
> > current limit be out of the question?
> 
> Is there a reason to have _any_ limitation?  It is not like we store
> configuration data by allocating one file per item (in which case we
> may be limited by the filesystem limit for direntry size), so if it
> is not too much trouble, I think the right thing to do is to lift
> the limitation altogether, possibly using strbuf instead of a
> statically sized array of characters.

I thought it made sense to impose some sort of bound here but removing
the limit wouldn't encourage the use of ridiculously long names so
lifting it entirely shouldn't hurt.

Any chosen limit would always be somewhat arbitrary.  I had considered
extending it to (PATHMAX + x) where x would also be arbitrary as
that would allow any valid url./path/max.insteadOf type setting but
that didn't seem like a good approach.

Removing the limit is a much better choice...

> Of course, once you write a very long entry using a newer version of
> Git, the resulting configuration file may end up unusable by older
> version of Git, so a patch to implement such a change may need to be
> based on older maintenance release (say maint-1.7.9) and then merged
> upwards, but otherwise I do not offhand see a compatibility downside
> of such a change.

I'm ok with this approach and will put an altered patch together
shortly.  I think it's fairly unlikely, but not impossible, that
anyone creating a config file with long key names would be in a
situation where someone else couldn't read that same config file.
I'll still base the change on maint-1.7.9 as suggested though.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
