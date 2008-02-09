From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 22:55:20 -0500
Message-ID: <20080209035520.GA10709@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 04:56:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNgos-0004K0-0l
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 04:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYBIDzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 22:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbYBIDzY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 22:55:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1641 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbYBIDzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 22:55:23 -0500
Received: (qmail 7595 invoked by uid 111); 9 Feb 2008 03:55:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 08 Feb 2008 22:55:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2008 22:55:20 -0500
Content-Disposition: inline
In-Reply-To: <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73189>

On Fri, Feb 08, 2008 at 07:24:06PM -0800, Junio C Hamano wrote:

> Yeah, -f using "matching refs" is dangerous, but on the other
> hand, that would be how you correct that mistake in one shot,
> after you fixed the mistake locally.

Not necessarily; you might not even have the refs that you just rewound.

> Is there anything wrong with "git push $there $branch_name"?  I

I think only that:

  - it's more typing, so if there is a class of users who want to use
    "git push origin HEAD" as their workflow, it might make sense to
    support them with a config option

  - I have seen less experienced users expecting "git push" to do a
    single branch (i.e., users whose workflow is "git pull; hack hack
    hack; git push").
    With one branch it is not a problem, but as soon as you introduce
    them to other branches, then the push behavior is yet another thing
    that you have to explain. And I know "clueless users" is not a good
    reason to change defaults if it makes clueful users less happy, but
    it might be reason for a config option.

> thought we discussed this last time and there was even a patch
> that does "git push $there HEAD" to push out the current branch,

Ah, I forgot about that. Yes, that does work in 1.5.4.

> I do not know if this was part of the last round of patches, but
> I suspect it is not a problem to allow
> 
> 	$ git push HEAD
> 
> if it is unambiguous.  That is, "HEAD?  Do we have such a remote
> nickname?  No.  Then can we default to 'origin' and use it as
> the ref to push?  Yeah, we can, so the user meant 'git push
> origin HEAD'".

I have often wanted that, since I typically only _ever_ push to an
origin, but the DWIM made me paranoid that it could be unsafe. If you
had a remote and a branch name that were similar, then a typo could end
up pushing to the wrong place.

-Peff
