From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Fri, 3 Jun 2011 10:26:12 -0700
Message-ID: <20110603172612.GC3839@leaf>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-2-git-send-email-jamey@minilop.net>
 <7vfwnrdfam.fsf@alter.siamese.dyndns.org>
 <20110602233619.GA1931@leaf>
 <7vvcwnbpat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:26:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSY8k-00006U-35
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 19:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1FCR0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 13:26:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56595 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab1FCR0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 13:26:23 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id E566E172067;
	Fri,  3 Jun 2011 19:26:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id ogNqs4j-jvBZ; Fri,  3 Jun 2011 19:26:20 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E72DF172077;
	Fri,  3 Jun 2011 19:26:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vvcwnbpat.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175018>

On Thu, Jun 02, 2011 at 07:51:22PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > ... I don't think it
> > makes sense to support passing in arbitrary namespaces when the callers
> > only use it to access the currently requested namespace.  If some
> > situation arises in later code that needs to handle arbitrary
> > namespaces, it seems easy enough to provide a more generalized function
> > at that point, but doing so now would just make the existing callers
> > more complex by forcing them to do the call to get_git_namespace()
> > rather than allowing for_each_namespaced_ref to do it.
> 
> If you do not pass the namespace around from day one, wouldn't it make it
> more cumbersome to later extend the API so that you can have more than one
> namespace active at the same time? For example, even with today's code,
> when responding to a push, the receiving repository issues a ls-remote
> request to its alternate repository to learn the tips of its refs, and at
> that point, the side of you who is responding to a push is using the
> namespace from the push client, while you acting as a fetch/ls-remote
> client would be in a different namespace. The different namespace happens
> to be "no funny namespace business" plain vanilla one, but I think you get
> the point. I do not mind seeing the very top-level caller of ref iterator
> calling get-namespace, but I would find it a bad taste if a function very
> deep in a callchain has to call get-namespace (meaning, you can only have
> one namespace active at a time) only because the caller does not pass it
> in.
> 
> But perhaps I am looking too far into the future and worried too much.

I do understand your concern, and in the future some tools might need to
support multiple namespaces, but for now all the users only need to use
GIT_NAMESPACE, and I'd prefer to tailor the API for the convenience of
the callers that exist now on the assumption that the API seems trivial
to change later if it turns out we need it.  I don't think it makes
sense to try to design that future API without specific callers in mind.

- Josh Triplett
