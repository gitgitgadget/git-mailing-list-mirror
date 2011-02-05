From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sat, 05 Feb 2011 13:39:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pln3D-0005BJ-Fx
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab1BESj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:39:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44220 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab1BESj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:39:58 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG500H59QI8VRB0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 05 Feb 2011 13:39:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166108>

On Fri, 4 Feb 2011, Junio C Hamano wrote:

> For some reason, many people seem to be enthused about splitting the tag
> namespace, but I am not sure if that is a good thing in general.  Branches
> are moving pointers for people to flip around in their local repositories,
> and it makes sense to say "My master is a bit ahead of the public one",
> but what would we gain by making it _easier_ to add and exchange many tags
> with the same name (e.g. refs/remotes/*/tags/v1.7.4 vs refs/tags/v1.7.4),
> other than the extra confusion?

The extraordinary misfeature of the tag namespace at the moment comes 
from the fact that whenever you add a remote repo to fetch, and do fetch 
it, then your flat tag namespace gets polluted with all the tags the 
remote might have.  If you decide to delete some of those remote 
branches, the tags that came with it are still there and 
indistinguishable from other tags making it a real pain to sort out.

So that's what has to be fixed.  If you get duplicated tag names then 
just warn the user and give priority to the local one, or error out with 
a "ambiguous tag specification" if no local but multiple remote tags 
with the same name are found (the user would have to be more precise in 
the tag scope in that case).


Nicolas
