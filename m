From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Thu, 17 Jan 2013 17:06:38 -0800
Message-ID: <20130118010638.GA29453@sigill.intra.peff.net>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
 <7vobgpxeel.fsf@alter.siamese.dyndns.org>
 <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
 <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 02:07:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw0QE-0001Ya-G8
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 02:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3ARBGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 20:06:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36770 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784Ab3ARBGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 20:06:42 -0500
Received: (qmail 26351 invoked by uid 107); 18 Jan 2013 01:08:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (207.86.76.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Jan 2013 20:08:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2013 17:06:38 -0800
Content-Disposition: inline
In-Reply-To: <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213896>

On Thu, Jan 17, 2013 at 07:09:16AM -0600, Chris Rorvick wrote:

> I was referring to your concern about rejecting based on type.  A push
> causing a reference to move (for example) from a commit to a blob is
> rejected as "already exists" with this patch.  You emphatically state
> this is not OK and your solution is to revert back to behavior that
> advises a merge.
> 
> Clearly the bug regarding an 'old' unknown to the client should be
> fixed.  This is a obvious test case I should have covered and it's
> unfortunate it made it into master.  But I don't understand why
> is_forwardable() was misguided (maybe poorly named) nor why
> ref_newer() is a better place to solve the issues it was addressing.

I think that a type-based rule that relies on knowing the type of the
other side will always have to guess in some cases, because we do not
necessarily have that information. However, if instead of the rule being
"blobs on the remote side cannot be replaced", if it becomes "the old
value on the remote side must be referenced by what we replace it with",
that _is_ something we can calculate reliably on the sending side. And
that is logically an extension of the fast-forward rule, which is why I
suggested placing it with ref_newer (but the latter should probably be
extended to not suggest merging if we _know_ it is a non-commit object).

-Peff
