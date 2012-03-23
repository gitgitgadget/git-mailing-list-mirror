From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Fri, 23 Mar 2012 14:48:44 -0400
Message-ID: <20120323184823.GA14711@sigill.intra.peff.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <7vmx79zeui.fsf@alter.siamese.dyndns.org>
 <CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com>
 <7v8viswdho.fsf@alter.siamese.dyndns.org>
 <87pqc3ei08.fsf@thomas.inf.ethz.ch>
 <7v62dvus3f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	PJ Weisberg <pj@irregularexpressions.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:48:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9Xh-0003lS-U9
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab2CWSss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:48:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab2CWSsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:48:47 -0400
Received: (qmail 18077 invoked by uid 107); 23 Mar 2012 18:49:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 14:49:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 14:48:44 -0400
Content-Disposition: inline
In-Reply-To: <7v62dvus3f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193791>

On Fri, Mar 23, 2012 at 10:47:48AM -0700, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > How about trying to read "HEAD" as "head" instead when core.ignorecase
> > is true?  That would allow us to catch such misconfiguration (which I
> > imagine can also happen accidentally if you mv a repository across FS
> > boundaries) and tell the user about it.
> 
> Do you mean something like this?
> 
> I do not like it.  It essentially amounts to checking with the FS every
> time we run Git.

I think Thomas's suggestion is to piggy-back it onto an existing file
lookup ("head" instead of "HEAD"), so you aren't doing any extra work.
However, I'm not sure that would be sufficient. If I copy a repo from a
case-insensitive filesystem to a case-sensitive one, what will the case
of "HEAD" be on the new filesystem?

If the original filesystem was case-preserving, I would expect "HEAD".
But on a true caseless filesystem, it could be either. Of course,
current git would already blow up if the file was copied as "head",
which makes me think this is probably a rare case. So maybe that is not
worth worrying about.

I dunno. I think Thomas's idea is clever, but is this actually a problem
in practice? The current discussion seems more like a documentation bug,
and I don't remember seeing anybody reporting issues moving a repo
across filesystems (presumably most people use clone or push, which
handle this properly).

-Peff
