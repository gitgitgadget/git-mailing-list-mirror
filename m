From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 16:21:05 -0400
Message-ID: <20130410202105.GE24177@sigill.intra.peff.net>
References: <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <20130410195256.GA24177@sigill.intra.peff.net>
 <CALkWK0nAMVKuDg4wmwujkpNxAF9zxQEdsZXyUzr+w4zVpWDCzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:21:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1W8-0003n0-RY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936318Ab3DJUVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:21:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39127 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935153Ab3DJUVM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:21:12 -0400
Received: (qmail 6598 invoked by uid 107); 10 Apr 2013 20:23:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 16:23:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 16:21:05 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nAMVKuDg4wmwujkpNxAF9zxQEdsZXyUzr+w4zVpWDCzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220752>

On Thu, Apr 11, 2013 at 01:35:34AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > Maybe. But no more so than the current:
> >
> >   git push
> >
> > which may also push master and next to the same remote.
> 
> I would argue that this was not really a problem in practice, until I
> introduced branch.<name>.pushremote.
> 
> Let us imagine that I was working on artagnon/git.git (remote: ram), a
> fork of git/git.git (remote: origin) earlier.  My fork contains the
> link and implicit-push branches in addition to the master, next and pu
> branches, which are present on both.  When I push from my
> implicit-push branch with push.default = matching, I'm updating all
> the matching refs on the remote ram (since branch.implicit-push.remote
> is set to ram), which is fine.  Now, I git push while on branch
> master.  My push is simply rejected, as I don't have write access to
> the remote origin.
> 
> This is designed exactly for the read-only upstream, read-write fork
> scenario.  If I had write access to upstream (where we're essentially
> regression to a centralized model), we'd have some major confusion.

I don't see how pushremote changes that. It was already a problem with
branch.*.remote, no?

I have a similar remote setup in my git.git repository. But all of my
branch.*.remote variables point to origin, because my branches are based
off of Junio's master. A matching push goes to the wrong place (and I
have screwed it up many times; it is nice that I do not have write
access to Junio's repository). The is broken without having pushremote
at all (and the proper fix is your remote.pushdefault).

> > As I said in an
> > earlier message, I would be OK with allowing both or neither, but
> > allowing one but not the other is even more confusing.
> 
> What is the point of allowing something internally consistent, but
> nonsensical?  You should complain.

If I were designing it today, I definitely think complaining is the
right thing to do. My only hesitation is the backwards compatibility.

If we are not going to break the existing behavior, I think it can be
argued that consistency and simplicity of the rules is important, so the
user can predict what will happen. But the more we discuss, the more I
think we should simply change the current behavior (to stop respecting
branch.* config with "matching"), which just seems wrong to me. Then we
can be simple and consistent, and do what the user probably intended.

-Peff
