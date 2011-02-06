From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 23:12:51 +0100
Message-ID: <201102062312.51655.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102061711.45460.johan@herland.net>
 <AANLkTi=gd5iu0i=ggqJC++N_rL+nU6RO9PNw=jMpT0NH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 23:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmCqx-0002bw-DM
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 23:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1BFWM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 17:12:59 -0500
Received: from smtp.getmail.no ([84.208.15.66]:48917 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab1BFWM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 17:12:58 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG700925V1HEH80@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 23:12:53 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9CE801EA57CA_D4F1CE5B	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 22:12:53 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 645F81EA33C9_D4F1CE5F	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 22:12:53 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG700LBOV1G0Y10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 23:12:53 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <AANLkTi=gd5iu0i=ggqJC++N_rL+nU6RO9PNw=jMpT0NH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166208>

On Sunday 06 February 2011, Dmitry Potapov wrote:
> On Sun, Feb 06, 2011 at 05:11:45PM +0100, Johan Herland wrote:
> > In practice, there is almost always one namespace (i.e. your repo
> > belongs to_ only one project with project-wide unique tags). However,
> > in any distributed_ system, the only-one-namespace is fundamentally a
> > myth.
> 
> By your logic git 1.7.4 is a myth, because I have not specified from
> what repository I pull it.

Yes, technically git 1.7.4 is a myth. However, by convention, we all agree 
what "v1.7.4" points to, and nobody seriously believe they can get away with 
pointing "v1.7.4" somewhere else.

The core of this discussion is where we want to place Git in the space 
between "technically correct" and "socially conventional", where the former 
means owning up to the fact that each repo really is its own namespace, and 
there's no way around that in a proper DVCS, and the latter means building 
social convention into our tools, thereby making it harder to deal with the 
few unconventional cases (like my two semi-related repos case).

AFAICS, my proposal does not harm the common case (unambiguous tags are 
still interpreted unambiguously, even if they may exist in multiple 
namespaces), while it _does_ help the uncommon case (by allowing ambiguous 
tags to co-exist in the same repo).

Granted, if we leave all tags in a single namespace, I can still work around 
this by manually futzing with the configured refspecs to create ad hoc 
namespaces. But I _really_ hate it when I'm forced to hack around the tool, 
because the tool thinks it "knows better".

> But, IMHO, it is a myth that having different
> namespaces solves the problem, because in _most_ cases, you really want
> to have a single namespace _semantically_, so you can communicate with
> other people using this tag name.

My proposal tries very hard to present a single namespace _semantically_ to 
the user in the common case (when tags are unambiguous). I'd even go as far 
as proposing that "git tag -l" should by default list only a single 
shortened tag name in the cases where there are multiple unambiguous 
alternatives.

Alternatively, I'd suggest a compromise (already mentioned elsewhere in this 
thread) where we add a config variable tags.preferredRemote (defaults to 
"origin") which allows you to directly select which namespace you consider 
official. You could even implement this as physically copying 
refs/remotes/${tag.preferredRemote}/tags/* into refs/tags/*.

> > In that case it would be wrong of gitk to display "v1.0". Instead it
> > should_ display a longer, unambiguous name, e.g. "origin/v1.0".
> 
> But it is still ambiguous because my "origin" may be different from
> yours origin. It is only unambiguous when it look at it _locally_ but
> that makes it completely useless for communication with other people.
> One project should have only one version with the same tag regardless
> where it came from.

Again, you are setting "technical correctness" up against "social 
convention". Technically, _any_ ref name whatsoever is repo-specific and 
"completely useless for communication with other people". The only thing we 
can communicate unambiguously is SHA-1 object names. However, social 
conventions compel us to name our refs unambiguously and to use common sense 
when communicating, so that - in practice - everybody in the project knows 
exactly what is meant by "v1.0".

It seems our opinions differ on whether Git should try to _force_ this 
social convention on you, or rather stick to technical correctness (with a 
bias towards conventional behavior as long as there no ambiguities).

> I agree in your use case of semi-related projects you need separate
> namespaces. But I don't think it is how most people use git. It may
> be nice to have an option that will make tag namespace separate, but
> I do not think it should be default. Not until, it is widely tested.

Well, this _is_ the thread for discussing things "we would have done 
differently if we were writing Git from scratch". ;)

Still, you have yet to convince me exactly _what_ will in practice be 
horribly and user-visibly broken by this proposal. AFAICS, all the common 
use cases today will still work well with this proposal.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
