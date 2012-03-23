From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Fri, 23 Mar 2012 14:57:43 -0400
Message-ID: <20120323185743.GA15063@sigill.intra.peff.net>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <7vmx79zeui.fsf@alter.siamese.dyndns.org>
 <CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com>
 <7v8viswdho.fsf@alter.siamese.dyndns.org>
 <87pqc3ei08.fsf@thomas.inf.ethz.ch>
 <7v62dvus3f.fsf@alter.siamese.dyndns.org>
 <20120323184823.GA14711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	PJ Weisberg <pj@irregularexpressions.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9gN-0002hB-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab2CWS5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:57:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57666
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab2CWS5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:57:46 -0400
Received: (qmail 18172 invoked by uid 107); 23 Mar 2012 18:58:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 14:58:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 14:57:43 -0400
Content-Disposition: inline
In-Reply-To: <20120323184823.GA14711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193793>

On Fri, Mar 23, 2012 at 02:48:44PM -0400, Jeff King wrote:

> I think Thomas's suggestion is to piggy-back it onto an existing file
> lookup ("head" instead of "HEAD"), so you aren't doing any extra work.
> However, I'm not sure that would be sufficient. If I copy a repo from a
> case-insensitive filesystem to a case-sensitive one, what will the case
> of "HEAD" be on the new filesystem?
> 
> If the original filesystem was case-preserving, I would expect "HEAD".
> But on a true caseless filesystem, it could be either. Of course,
> current git would already blow up if the file was copied as "head",
> which makes me think this is probably a rare case. So maybe that is not
> worth worrying about.

As soon as I sent this, I had two additional thoughts:

  1. You could probably just use "HeAd", which is unlikely to work
     anywhere except on a case-insensitive filesystem, and gets around
     my objection above.

  2. This still isn't a good test, because it is checking case
     sensitivity of the repo directory, not the working tree, and
     core.ignorecase is about the latter. It's possible to have the two
     on different filesystems with different capabilities.

     Though I think the initial test in "git init" suffers from the same
     problem (it checks that "config" is accessible as "CoNfIg"), and I
     have no heard anybody complaining about that.

-Peff
