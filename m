From: Jeff King <peff@peff.net>
Subject: Re: git-log combining different detail levels
Date: Wed, 22 Aug 2012 16:04:44 -0400
Message-ID: <20120822200444.GA27462@sigill.intra.peff.net>
References: <50353212.7060109@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4HAh-0001Lx-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 22:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190Ab2HVUEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 16:04:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45416 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756295Ab2HVUEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 16:04:52 -0400
Received: (qmail 12258 invoked by uid 107); 22 Aug 2012 20:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Aug 2012 16:05:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2012 16:04:44 -0400
Content-Disposition: inline
In-Reply-To: <50353212.7060109@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204090>

On Wed, Aug 22, 2012 at 09:25:06PM +0200, Maaartin-1 wrote:

> Quite often I need to see some changes in more detail and others only
> briefly, so I get some idea about the context. For example I'd like
> something like merging the outputs of
> 
> git log -p -S Bandersnatch
> and
> git log --name-status --oneline
> 
> together, so I know better what happened.
> 
> A simpler (and maybe more important) example is merging
> 
> git log -p some/dir
> and
> git log --name-status
> 
> so I could see all the changes, and the chosen ones with all details.

No, I don't think this is possible. We have "--full-diff", which
disconnects the path-limiting from the diff generation, so that:

  git log --full-diff --name-status some/dir

would choose only commits for some/dir, but show the full diff of each
commit.

However, what you are asking is to disconnect the two diff options: one
verbose option only for interesting parts of the diff, and then a
more sparse option for the rest. I'm pretty sure the diff machinery does
not currently understand such an option.

It would not be impossible to implement, I think, but I suspect it would
involve refactoring the format selection in the diff code quite a bit.
In the meantime, one thing you can do is generate the full diff output
and then post-process it to collapse the uninteresting bits.  I haven't
tried, but you can probably do something like this using "folds" in your
editor (e.g., shrink all of the diff content for a file to a single
line, but then expand it on demand).

-Peff
