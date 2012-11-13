From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 12:14:46 -0500
Message-ID: <20121113171445.GG20361@sigill.intra.peff.net>
References: <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
 <20121113074720.GA18746@sigill.intra.peff.net>
 <7vpq3hfpm7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYK4p-0003Fd-85
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab2KMROx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:14:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47623 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201Ab2KMROv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:14:51 -0500
Received: (qmail 26894 invoked by uid 107); 13 Nov 2012 17:15:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 12:15:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 12:14:46 -0500
Content-Disposition: inline
In-Reply-To: <7vpq3hfpm7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209642>

On Tue, Nov 13, 2012 at 08:13:04AM -0800, Junio C Hamano wrote:

> >> That's right, AUTHOR_IDENT would fall back to the default email and full name.
> >
> > Yeah, I find that somewhat questionable in the current behavior, and I'd
> > consider it a bug. Typically we prefer the committer ident when given a
> > choice (e.g., for writing reflog entries).
> 
> Just to make sure I follow the discussion correctly, do you mean
> that the bug is that we pick a fuzzy AUTHOR when COMMITTER is
> specified more concretely and we usually use COMMIITTER for this
> kind of thing in the first place but send-email does not in this
> case (I do not see "git var GIT_AUTHOR_IDENT" returning value from
> the implicit logic as a bug in this case---just making sure).

Having discussed more, I think there are two questionable things:

  1. Preferring author over committer

  2. Failing to fall back to committer when author is implicit or bogus
     (because "git var" dies).

I think (1) may fall into the "this is not how I would do it today, but
it is not worth a possible regression" category.

I think (2) might be worth fixing, though. Certainly when the author is
bogus (by IDENT_STRICT rules), which I think was the original intent of
the "$repoauthor || $repocommitter" code. Probably when the author ident
is implicit, though that is more hazy to me.

> For a change with low benefit/cost ratio like this, the best course
> of action often is to stop paying attention to the thread that has
> become unproductive and venomous, and resurrect the topic after
> people forgot about it and doing it right yourself ;-).

I came to the same conclusion, but decided to simply do it right now
while it was in my head. Hopefully we can progress by reviewing the
series I just posted.

-Peff
