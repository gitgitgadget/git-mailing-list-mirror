From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: About -X<option>
Date: Sun, 6 Jul 2008 13:28:00 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061315310.32725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness> <20080705133245.GH4729@genesis.frugalware.org> <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl> <7v63rktekf.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807060342550.3557@eeepc-johanness>
 <7vmykvpq2n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <frimmirf@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 13:29:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFSQS-0001fm-BX
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 13:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbYGFL2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 07:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYGFL2F
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 07:28:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:47182 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752917AbYGFL2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 07:28:03 -0400
Received: (qmail invoked by alias); 06 Jul 2008 11:28:01 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp043) with SMTP; 06 Jul 2008 13:28:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qTLN71K3qONvhZm/L/yvRtkD1N0luTvX2U6KuKa
	1tLQJunWAdugAz
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmykvpq2n.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87518>

Hi,

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Isn't that obvious?  -X looks like a short option, but the rest of 
> > that string does not consist of aggregated short options.
> 
> Ah, I see.  Then the issue is not about "not easy to code" but about "not
> being consistent".

I never meant to say "easy to code".  I always meant "not possible with 
parseopt, without major -- and ugly -- surgery".

> We can change it to "--X<option>[=<value>]" and "-X option[=<value>]"; 
> the topic is still young, not even documented properly IIRC, and is not 
> scheduled for 'master' any time soon yet.

I feel that this is too limiting.  You really do not want to allow passing 
"theirs" to git-merge, when you only ask for stratgey "resolve", right?  
Because the "resolve" strategy never heard about "theirs".

To be frank, the semantics of "theirs" _wants_ to treat it as a strategy; 
just think of

	$ git merge -s ours -Xtheirs

Besides, I sincerely doubt that anybody will find the naming of "-X" 
intuitive.

But let's step back a little: "theirs" is most likely something we do not 
want to announce, since a careful review in case of merge conflicts should 
be performed in that case.

So we do not want official support for it.

And there comes in an aspect of the broader plan for the second half of 
Miklos' project: user-defined merge backends.

By allowing users to put a script in their PATH (possibly resorting to "." 
just for that script), named "git-merge-<mybackend>", the following 
becomes possible:

	$ echo 'git merge-recursive --theirs "$@"' > ~/bin/git-merge-X
	$ chmod a+x ~/bin/git-merge-X
	$ git merge -s X

This would be even more flexible than the "-X" option, and it would 
properly keep "--theirs" out of our officially supported features.

If we feel like it, we could even accept a "git-merge-partially-theirs" 
into contrib/.

Ciao,
Dscho
