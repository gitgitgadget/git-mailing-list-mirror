From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option
 "--ignore-submodules"
Date: Tue, 8 Jun 2010 23:02:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006082247390.1732@bonsai2>
References: <4C0E7037.8080403@web.de> <7vhbldtow3.fsf@alter.siamese.dyndns.org> <4C0EAAE8.3060300@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:03:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5wt-0000A9-IL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab0FHVC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 17:02:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:47326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756466Ab0FHVC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 17:02:57 -0400
Received: (qmail invoked by alias); 08 Jun 2010 21:02:42 -0000
Received: from pD9EB2098.dip0.t-ipconnect.de (EHLO noname) [217.235.32.152]
  by mail.gmx.net (mp011) with SMTP; 08 Jun 2010 23:02:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Gd4sw+UXGH99jhOjERuNu9JQ+0qHQcJBkWx0vMw
	JF505Bc3b3tgpd
X-X-Sender: gene099@bonsai2
In-Reply-To: <4C0EAAE8.3060300@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148717>

Hi,

On Tue, 8 Jun 2010, Jens Lehmann wrote:

> Am 08.06.2010 19:28, schrieb Junio C Hamano:
> > The above outline (I haven't looked at the code) sounds sane.  We might
> > even want to make untracked (or dirty) the default, if nothing is given
> > from the command line nor configuration.
> 
> Hm, as far as I interpreted the postings here, "none" should be a
> reasonable default for most users because it protects them from errors
> that are easy to make and hard to detect.
> 
> IIRC there are two main exceptions which want a different setting:
> 
>  - Huge submodules which take a substantial portion of time to scan may 
>    want "dirty" to avoid spending the extra time (at least until we have 
>    an inotfiy daemon ;-).

Not only huge submodules. Thrashing the disk cache (e.g. by the sheer 
number of submodules) is another reason. In my main project, the time for 
a simple "git status" went up from unnoticable (<0.1 seconds AFAICT) to 45 
seconds.

Let me repeat that. Fourty-five seconds. For a simple "git status".

According to me, the fact that nobody noticed can only be explained by the 
lack of real submodule users. In particular, the people who invented the 
submodules, and pushed them into "official" Git, never used it, but 
precluded more appropriate solutions. I am not complaining, I am just 
stating observations.

It comes back to my argument that developers should not have beefy 
machines, lest they lose touch with the users and uses, and develop things 
that closely skirt reality just so.

>  - Submodules where the provider doesn't care or is not able to provide 
>    a proper .gitignore for other reasons want "untracked" to avoid the 
>    noise.

While this is a valid scenario, I do not think that any user was hurt 
by that case.

> And these seem to fall into the category: If you are unlucky enough to 
> have one of these included in your superproject, configure these to use 
> "dirty" or "untracked" as appropriate. And AFAICT they are more the 
> exception than the rule so I came up with this proposal of a per 
> submodule configuration, so people won't have to turn off submodule 
> checking for all submodules because of a single special one.

I agree that the basic reason for the default to check for dirty and 
untracked files is sound.

It is not your (Jens') fault that this does not integrate well into the 
Git context, and that users of the submodule feature were punished that 
heavily (just to reiterate, if anybody missed that number, the time on 
"git status" -- or for that matter, "git diff" -- went up by >4500%. In 
English words, that is four-thousand five hundred percent, and that is 
just a lower bound).

So I would actually argue (being a real submodule user, not just an 
imaginary one) that the default for dirty checking in the submodules 
should stay.

> > I don't see a reason for patch 1/2, though.
> 
> Ok, I will drop that from the next round.

If I had not stopped caring about consistency in Git, I would strongly 
contest this dropping.

Ciao,
Dscho
