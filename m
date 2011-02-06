From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 01:04:36 +0100
Message-ID: <201102060104.37146.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102050218.44325.johan@herland.net>
 <20110205214045.GA15668@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 01:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pls7b-0004pW-DY
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 01:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab1BFAEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 19:04:43 -0500
Received: from smtp.getmail.no ([84.208.15.66]:49595 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab1BFAEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 19:04:42 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG600LUJ5JSOT40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 01:04:40 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 661811EA57B6_D4DE598B	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 00:04:40 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 425B41EA321C_D4DE598F	for <git@vger.kernel.org>; Sun,
 06 Feb 2011 00:04:40 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG6004RH5JQQJ10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 06 Feb 2011 01:04:40 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <20110205214045.GA15668@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166131>

On Saturday 05 February 2011, Dmitry Potapov wrote:
> On Sat, Feb 05, 2011 at 02:18:44AM +0100, Johan Herland wrote:
> > Having said that, there are real situations where users encounter
> > collisions in the shared tag namespace. A rare (but plausible)
> > scenario arise when two developers create (and publish) conflicting
> > tags in their repos. A more common scenario that I have encountered at
> > $dayjob, is where two parallel (semi-related) projects are developed
> > in separate repos (with different versioning because of separate
> > release schedules), and I need to interface with both repos from a
> > single local repo. Each of the remote repos have their own "v1.0" tag,
> > but my repo can only hold one such tag. Which of those tags end up
> > "winning" in my local repo depends on my fetch order.
> 
> Well, I agree that this situation requires a better diagnostic, but I
> don't think that having separate namespaces is the right solution in
> general. For your case, where you work on semi-related projects, it is
> could be the right thing to do, but if you work on the same project and
> have more than one source to fetch, then having multiple namespaces can
> lead only to confusion, because tag names must be unique globally to
> make sense to everyone. Actually, even if you have two semi-related
> projects in the same repository, but you have more than one URL per
> project, you want to group tags based on their relation to the project
> and not based on the URL.

I'm not sure what problem you're describing here. Let's assume that my repo 
has multiple remotes (URLs), but they're all fundamentally part of the same 
project. If there is a tag "foo" in one remote/namespace, and a tag "foo" in 
a different remote/namespace, they (in the common case) point to the same 
object, since they - as you say - "must be unique globally to make sense to 
everyone".

As long as they point to the same object, there's no ambiguity, and when you 
simply refer to tag "foo" (without specifying namespace) it all works, like 
today. (Read footnote [2] of my proposal for more details on handling 
ambiguity in tag names.)

However, when the remote tags point to different objects (i.e. the uncommon 
case), there is an ambiguity, and we should deal with that ambiguity 
properly, instead of silently adopting one of them arbitrarily.

I don't see how the separate namespaces cause problems here. Also, I don't 
know what you're proposing instead, or indeed what other organization of 
tags would lead to less confusion.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
