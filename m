From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 09:58:11 +0100
Message-ID: <201102070958.11551.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070451.37370.johan@herland.net>
 <20110207051123.GA4748@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 09:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmMvM-0007le-70
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 09:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1BGI6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 03:58:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:37878 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab1BGI6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 03:58:14 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG800IUHOX1YL90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 09:58:13 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 0BC621EA55E2_D4FB425B	for <git@vger.kernel.org>; Mon,
 07 Feb 2011 08:58:13 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 831721EA2A49_D4FB424F	for <git@vger.kernel.org>; Mon,
 07 Feb 2011 08:58:12 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG800FRCOX0Y510@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 09:58:12 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <20110207051123.GA4748@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166242>

On Monday 07 February 2011, Jeff King wrote:
> On Mon, Feb 07, 2011 at 04:51:37AM +0100, Johan Herland wrote:
> > > Take the example of the interim maintainer cited somewhere else in
> > > this thread. If Shawn fetches from Junio, he'll get a junio/v1.7.4
> > > tag, and on my side, I do not want to end up having
> > > shawn/junio/v1.7.4, especially if this means that people fetching
> > > from me would end up with a me/shawn/junio/v1.7.4 ...
> > 
> > You won't end up with "shawn/junio/v1.7.4". When Shawn fetches from
> > Junio, what he actually gets is "refs/remotes/junio/tags/v1.7.4"
> > ("junio/v1.7.4" is a shorthand; "v1.7.4" is an even better shorthand).
> 
> But keep in mind that this proposal will have to live alongside repos
> that are using older versions of git. So Shawn might very well have
> refs/tags/v1.7.4 from Junio if he is using (or has ever used) pre-1.8.0
> git.

Yes, but since they point to the same object, there's no ambiguity.

I'm also starting to wonder whether we should, in existing repos with 
existing remotes, keep using the old-style refspecs by default, thereby 
making new-style refspecs the default only for _new_ repos. It seems mixing 
the two styles in one repo would cause confusion. Another alternative would 
be to transform old-style remotes into new-style remotes, but I believe that 
was shot down elsewhere in this thread.

> No, that won't give you me/shawn/junio/v1.7.4, but it does mean we have
> to gracefully handle the case of ambiguous duplicate tags (that happen
> to point to the same thing).

Whoa, we use the "ambiguous" term differently here. In this whole thread I 
have used "ambiguous" exclusively about when the same (shorthand) tag name 
point to _different_ things. As long as they point to the same thing, there 
is no ambiguity, IMHO.

> Which I think you are implying here:
> > Next, you should never pull from Shawn's work repo, but rather from the
> > repo he has published. In that repo he will typically have pushed the
> > "v1.7.4" tag (as described above). When you pull from Shawn's public
> > repo, you will get the "v1.7.4" tag at
> > "refs/remotes/shawn/tags/v1.7.4" (but "v1.7.4" is an unambigious
> > shorthand).
> 
> But I wanted to point it out explicitly.

Yes, over its lifetime a tag name ("v1.7.4") might appear in several 
namespaces (refs/tags, refs/remotes/*/tags), but it's always identifiable 
with the shorthand "v1.7.4" name (assuming no other "v1.7.4" name point to a 
different object).

This is the same technique we use when talking about branch names: On this 
mailing list, nobody is confused when I refer to 'maint', 'master', 'next' 
and 'pu'. Still, in our own work repos (at least in mine), these branches 
are actually called "refs/remotes/origin/<name>" (commonly referred to by 
their shorthands "origin/<name>"). Here we are, juggling the same kind of 
namespaces that I propose for tags, and it seems to work well without 
causing much confusion.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
