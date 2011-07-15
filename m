From: Jeff King <peff@peff.net>
Subject: Re: Generation numbers and replacement objects
Date: Fri, 15 Jul 2011 17:10:33 -0400
Message-ID: <20110715211033.GA1943@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <m3aacf9s4k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:10:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhpek-0002TG-9t
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab1GOVKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:10:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1GOVKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:10:36 -0400
Received: (qmail 27063 invoked by uid 107); 15 Jul 2011 21:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 17:11:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 17:10:33 -0400
Content-Disposition: inline
In-Reply-To: <m3aacf9s4k.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177233>

On Fri, Jul 15, 2011 at 02:01:36PM -0700, Jakub Narebski wrote:

> Peff, as Junio said somewhere else either in this thread, or the one
> started by Linus, we would want generation numbers both without taking
> into account replacement objects (e.g. for object traversal during
> push / fetch), and with taking it into account (e.g. when showing log
> or blame for end user).
> 
> So we would need two generation number caches: one with and one
> without replaces.

Right. And I already outlined a solution for that by indexing the caches
by the validity token (I haven't written the patches yet, but it's a
pretty trivial change).

> Nb. generation header stored in commit object can give only the one
> without replaces, i.e. speed up object enumeration (what happened to
> caching GSoC project code?) but not git-log.

Yes. It is a weakness of putting the generation number in the header. I
think Linus has already said he doesn't care about grafting. You are
welcome to argue with him about that.

> Also if replacement object has the same generation as the commit it
> replaces, and I think also if it has lower generation number, current
> generation numbers would still work (ne need to invalidate cache).

Yes, that is why I said elsewhere "you could be more clever about seeing
how the cache's validity constraints changed". But ultimately, it is not
that expensive to regenerate the cache under the new conditions, grafts
don't change very often, and the code to figure out exactly which parts
of the cache could be saved would be complex.

-Peff
