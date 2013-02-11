From: Jeff King <peff@peff.net>
Subject: Re: Pushing a git repository to a new server
Date: Mon, 11 Feb 2013 11:27:14 -0500
Message-ID: <20130211162714.GB16402@sigill.intra.peff.net>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
 <20130211075040.GJ5210@localhost.localdomain>
 <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	git <git@vger.kernel.org>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:28:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wFR-0007uJ-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999Ab3BKQ2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:28:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44321 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757575Ab3BKQ1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:27:17 -0500
Received: (qmail 23509 invoked by uid 107); 11 Feb 2013 16:28:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 11:28:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 11:27:14 -0500
Content-Disposition: inline
In-Reply-To: <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216046>

On Mon, Feb 11, 2013 at 02:57:51AM -0500, Ethan Reesor wrote:

> On Mon, Feb 11, 2013 at 2:50 AM, Konstantin Khomoutov
> <kostix+git@007spb.ru> wrote:
> > What's wrong with
> > $ ssh myuser@remotehost 'mkdir /path/to/MyRepo.git; cd $_; git init --bare'
> > $ git push --all git@remotehost:MyOtherRepo.git
> > ?
> 
> Nothing, I just wanted to make myself a command to do that for me.

We talked about this a long time ago. One problem is that it's
inherently unportable, as the procedure to make a repo is potentially
different on every server (and certainly that is the case between a
regular user running stock git and something like GitHub or Google Code;
I imagine even gitolite has some special procedures for creating repos,
too).

One proposal made in the previous discussion was to define a microformat
for repository administration commands. So that you could connect and
say "git admin-create-repo /path/to/MyRepo.git", and the server-provided
admin-create-repo command would take care of the details. Then stock git
could forward it to "git init --bare", GitHub could do the same and
create the necessary database records, etc.

And once that standardized method was in place, it would be easy to add
a "--create" option to "git push" to request an "admin-create-repo"
before pushing.

I still think that's a reasonable way forward, but nobody was interested
enough to start writing code for it.

-Peff
