From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sat, 05 Feb 2011 14:55:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 05 20:55:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PloE1-0000TM-0W
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 20:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab1BETzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 14:55:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50105 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab1BETzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 14:55:07 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG500EUHTZ8PCB0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 05 Feb 2011 14:54:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110205193708.GA2192@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166117>

On Sat, 5 Feb 2011, Jeff King wrote:

> On Sat, Feb 05, 2011 at 01:39:57PM -0500, Nicolas Pitre wrote:
> 
> > So that's what has to be fixed.  If you get duplicated tag names then 
> > just warn the user and give priority to the local one, or error out with 
> > a "ambiguous tag specification" if no local but multiple remote tags 
> > with the same name are found (the user would have to be more precise in 
> > the tag scope in that case).
> 
> The latter seems like a regression for the common case of fetching from
> two upstreams. E.g., I usually pull from Junio, getting
> remotes/origin/v1.7.0.  One day Shawn is the interim maintainer, and I
> pull from him, getting remotes/spearce/v1.7.0, which he previously
> fetched from Junio. Under the current code, I can still do "git show
> v1.7.0"; under the scheme described above I now have to say
> "origin/v1.7.0" to disambiguate.

Let's suppose that both tags are identical, as in your scenario above 
they would be, then there is no need to call for any ambiguity in that 
case.

> The real issue, I think, is that we are claiming ambiguity even though
> those tags almost certainly point to the same sha1. When handling
> ambiguous tags, should we perhaps check to see if all of the ambiguities
> point to the same sha1, and in that case, just pick one at random?

If they're identical then there is no randomness.  If they refer to 
different tag objects, even if those tag objects do refer to the same 
commit object, then I'd say there is an ambiguity only if the tag object 
content matters i.e. when displaying the tag content.

> In the case of resolving a ref to a sha1, then by definition they are
> all equivalent to pick. For things that care (e.g., "git checkout") we
> should probably still complain (although many of those commands have
> their own disambiguation code to prefer refs/heads/ or whatever anyway).

We are probably more or less saying the same thing.


Nicolas
