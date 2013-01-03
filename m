From: Jeff King <peff@peff.net>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Thu, 3 Jan 2013 15:36:07 -0500
Message-ID: <20130103203606.GA8188@sigill.intra.peff.net>
References: <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
 <20130103083712.GC32377@sigill.intra.peff.net>
 <7vehi2xote.fsf@alter.siamese.dyndns.org>
 <20130103202343.GA4632@sigill.intra.peff.net>
 <7vip7evwdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:36:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqrWh-000481-6u
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab3ACUgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:36:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42293 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915Ab3ACUgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:36:09 -0500
Received: (qmail 10401 invoked by uid 107); 3 Jan 2013 20:37:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 15:37:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 15:36:07 -0500
Content-Disposition: inline
In-Reply-To: <7vip7evwdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212608>

On Thu, Jan 03, 2013 at 12:34:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Or are you suggesting that the three-way case should always be protected
> > by checking that there are no unmerged entries before we start it? That
> > seems sane to me, but I haven't confirmed that that is the case.
> 
> I think the normal (and hopefully only) "-m -u O A B" use case of
> threeway is the bog-standard "git merge", which requires even more:
> your index must exactly match HEAD, even though you are allowed to
> have local changes in the working tree.
> 
> That requirement is not likely to change, as cleanly merged paths
> are automatically added to the index, so "diff --cached" should show
> only the changes from cleanly merged part, while "diff" should show
> paths that still needs user's help.
> 
> If we allowed local modification to the index (let alone conflicted
> entries in it) before the merge begins, the users would not be able
> to tell which paths are in what state after a half-merge stops and
> asks for help.  Updated paths may not have anything to do with the
> merge (i.e. earlier "git add" before the merge started), conflicting
> paths may not have anything to do with the merge (i.e. leftover
> conflicts before the merge started).

Oh, I agree it's insane to try to carry through unmerged entries. I'm
just concerned that not all code paths are careful enough to check. They
probably are, though, as a null sha1 in your index would be the least of
your worries, and somebody would have noticed in the last 7 years.

-Peff
