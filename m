From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Fri, 30 Dec 2011 08:54:23 -0500
Message-ID: <20111230135423.GA1684@sigill.intra.peff.net>
References: <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
 <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org>
 <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
 <4EFB8E78.4090205@tu-clausthal.de>
 <7vlipwz5xs.fsf@alter.siamese.dyndns.org>
 <4EFD40CF.8000801@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Dec 30 14:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgcum-0001wQ-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 14:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab1L3Ny2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 08:54:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54323
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab1L3Ny1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 08:54:27 -0500
Received: (qmail 16767 invoked by uid 107); 30 Dec 2011 14:01:15 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Dec 2011 09:01:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Dec 2011 08:54:23 -0500
Content-Disposition: inline
In-Reply-To: <4EFD40CF.8000801@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187803>

On Fri, Dec 30, 2011 at 05:40:47AM +0100, Sven Strickroth wrote:

> >> git-core also asks for username using *_ASKPASS, this is the reason why
> >> I implemented it this way. I noticed it when I tried to push to google
> >> code (using https).
> > 
> > I thought that was updated with Peff's series recently?
> 
> So, was this changed? git-core doesn't ask for a username using
> *_ASKPASS helpers anymore?

No, it will. It's only that we will echo characters when using the
terminal prompt. In theory we could have an ASKPASS-style interface that
would would echo characters, but there's no such interface in common
use (i.e., we would have to invent it).

> I talked off-list with Junio and he proposed to use another environment
> variable (e.g. GIT_DIALOG for a different tool) to solve these issues.
> 
> A good way could be to define the GIT_DIALOG-tools to have two
> parameters. First (pass|text|filename|...) with fallback to text, this
> way one can implement a password field, a text field, a file chooser (on
> type filename) and it is still extendable for e.g. directory choosers
> (if we might need that)...

Yes, like that. I think some windowing toolkits already have programs to
provide dialogs from shell scripts. You might look at them for
inspiration on the interface.

For credentials, it would be nice to be able to create a multi-field
dialog, like:

  Username: <text input>
  Password: <text input>
  Remember password? [checkbox]

I was planning to do something custom for credentials as an extension to
the credential helper protocol, but this could also fall under the
heading of a general prompt helper.

-Peff
