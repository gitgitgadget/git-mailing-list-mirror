From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 15:37:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102071517070.14920@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
 <7vvd0xvsjc.fsf@alter.siamese.dyndns.org> <4D501983.5060508@xiplink.com>
 <7v62svvdjo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marc Branchaud <marcnarc@xiplink.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmXqI-0004Hj-6r
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358Ab1BGUhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:37:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8238 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab1BGUhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:37:39 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG9009FTL902J70@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 07 Feb 2011 15:36:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v62svvdjo.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166280>

On Mon, 7 Feb 2011, Junio C Hamano wrote:

> As I said in my message, it feels awkward to use refs/private-tags for
> tags everybody uses for his or her own purpose, so by swapping the roles
> of namespaces around, we would be able to use refs/tags for private ones,
> and refs/remotes/origin/tags for the ones that came from upstream.  But
> then if you fetch/pull from a third party (including the "interim
> maintainer"), it feels wasteful to get full set of tags that you have in
> the origin namespace anyway replicated in refs/remotes/interim/tags.

Why so?  At least you get to know if that particular remote has a 
particular tag that may also exist elsewhere.  And if you decide to drop 
one remote source with all its tags from your local repository, then the 
remaining one(s) still have relevant tags available.

> And that is what bothers me---not the waste itself, but I have this
> nagging feeling that the wasteful duplication is an indication of
> something else designed wrong.

We do have "wasteful" duplicated references all over the place, such as 
when two directories (tree objects) contain the same file content (refer 
to the same blob object).  But no one feels like this is wasted 
duplication as those two directories end up using the same single blob 
object even if in the working directory you get twice the content.

Here this is the same thing.  You have multiple handles to the same tag 
which are distributed across different remote repositoryes you are 
tracking.  The name on the tag may be found in many places, and even 
under different names.  But there is still only one actual tag object.

If you have 3 remotes sharing the same tag then you know that the tag 
cannot be garbage collected until all three remotes have been removed 
from your repository.

Simply storing snapshots of the tag state per remote repository is 
simple and allow for smarter processing on top, which is in agreement 
with the design philosophy for the rest of Git.


Nicolas
