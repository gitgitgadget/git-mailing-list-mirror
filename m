From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 23:50:39 -0400
Message-ID: <20130410035039.GA795@sigill.intra.peff.net>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 05:50:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPm3e-0000Xv-RO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 05:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab3DJDuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 23:50:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37054 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab3DJDup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 23:50:45 -0400
Received: (qmail 31879 invoked by uid 107); 10 Apr 2013 03:52:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 23:52:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 23:50:39 -0400
Content-Disposition: inline
In-Reply-To: <20130409231332.GZ30308@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220657>

On Tue, Apr 09, 2013 at 04:13:32PM -0700, Jonathan Nieder wrote:

> Random idea: today you can do
> 
> 	git push origin master; # push branch master to remote origin
> 	git push --multiple origin korg; # push default refspec to 2 remotes

Can we do "git push --multiple" today? My git does not seem to know
about that (and I don't remember any patches in the area). Am I missing
something?

> How about:
> 
> 	git push origin korg -- master; # push master to 2 remotes
> 	git push -- master next; # push two refs to default remote
> 	git push origin -- master; # push master to origin, more explicitly
> 	git push origin korg --; # push default refspec to 2 remotes, again

I like that _way_ better than the "-" proposal. Rather than introducing
a magic token for "the default ref", it fixes the actual syntax problem
(that we have two lists of arguments to the command, and we do not know
where one begins and the other ends). And it does it the same way as
other parts of git.

> 	git push host:some/path; # ambiguous argument. Please disambiguate.

This is a regression.  I thought the point of this exercise was to leave
that working. We could just as easily switch to:

  git push --remote=host:some/path

if we are willing to break the existing syntax. Though your proposal
does have the benefit of breaking only one particular syntax which is
(I'm guessing) less frequently used. But we'd still need the usual
deprecation period, I think.

> 	git push host:some/path --; # push default refspec over SSH
> 	git push -- host:some/path; # push specified refspec to default remote

I like this.

> 	git push origin; # is a remote name and not a refname. Good.
> 	git push master; # is a ref name and not a remote name. Good.

And this is sensible, too.

-Peff
