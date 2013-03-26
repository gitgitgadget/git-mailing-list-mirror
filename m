From: Jeff King <peff@peff.net>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 10:56:37 -0400
Message-ID: <20130326145637.GA3822@sigill.intra.peff.net>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <51519DA0.4090201@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Tue Mar 26 15:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKVJH-0006dF-7V
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 15:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933635Ab3CZO4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 10:56:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40270 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119Ab3CZO4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 10:56:41 -0400
Received: (qmail 2956 invoked by uid 107); 26 Mar 2013 14:58:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 10:58:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 10:56:37 -0400
Content-Disposition: inline
In-Reply-To: <51519DA0.4090201@nod.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219161>

On Tue, Mar 26, 2013 at 02:07:44PM +0100, Richard Weinberger wrote:

> >Should this important warning be part of the git(1) documentation on
> >the environment variables (and possibly other places) given the
> >consequences of this case? It wasn't something
> >I'd appreciated from a simple reading.
> 
> BTW: Can't we change git-clean such that it will not delete any files
> if GIT_DIR is set and GIT_WORK_TREE is "."?s

We could, but that would break the existing behavior for other people
(and I assume you mean "when GIT_WORK_TREE is not set at all", as I
would think GIT_WORK_TREE=. is explicit enough).

I am sympathetic to your data loss, but I wonder how common a problem it
is in practice. Git-clean already does a dry-run by default; you have to
give it `-f`. This is the first such report we've had. This seems more
akin to "oops, I accidentally ran `rm -rf` in the wrong directory". Yes,
it's catastrophic, but at some point you have to accept that deleting
files is what rm (and git-clean) does; you can only put so many safety
hoops in place.

I don't know. It's an uncommon enough case that we could deprecate
"GIT_WORK_TREE is implicitly `.`" entirely, but I think it would need a
deprecation period, and a way to get the same behavior (e.g., allowing
"GIT_WORK_TREE=.").

-Peff
