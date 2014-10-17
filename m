From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 21/25] rev-list: add --index-objects option
Date: Thu, 16 Oct 2014 20:12:31 -0400
Message-ID: <20141017001230.GB7848@peff.net>
References: <20141015223244.GA25368@peff.net>
 <20141015224430.GU25630@peff.net>
 <xmqqiojjuaao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 02:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xev9z-0003yU-4q
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 02:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbaJQAMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 20:12:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:59454 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbaJQAMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 20:12:33 -0400
Received: (qmail 3528 invoked by uid 102); 17 Oct 2014 00:12:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 19:12:33 -0500
Received: (qmail 3929 invoked by uid 107); 17 Oct 2014 00:12:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 20:12:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 20:12:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiojjuaao.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 11:41:35AM -0700, Junio C Hamano wrote:

> I agree that "--index" is a bad name as it usually is used in a
> particular context: the command can work on various combination of
> working tree and the index, and I am asking it to work on both
> (e.g. "apply --index" as opposed to "apply --cached").

Thanks. I wasn't sure if I was just being paranoid or not, but now there
are at least two of us.

> > +--index-objects::
> 
> This risks "index" getting misunderstood as a verb, e.g. "please
> enumerate the objects and assign labels to later refer to them",
> doesn't it?
> 
> "--indexed-objects" (short for "--show-objects-in-the-index") or
> something?

That sounds reasonable. We could technically do `--indexed` as that is
different from `--index`, but maybe they are still confusingly close.

> > +	Pretend as if all objects used by the index (any blobs, and any
> > +	trees which are mentioned by the index's cache-tree extension)
> > +	ad listed on the command line. Note that you probably want to
> 
> s/ad/are/, probably?

Yeah, sorry, vi cruft I think (at least I didn't accidentally insert
"C-a C-k" ;) ).

> > +	use `--objects`, too, as there are by definition no commits in
> > +	the index.
> 
> For gitlinks/submodules, the index records names of the commit
> objects, they are not listed, and that is the right behaviour, but
> this description invites some confusion.

Good point. How about this:

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 03ab343..3301fde 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -172,12 +172,10 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
---index-objects::
-	Pretend as if all objects used by the index (any blobs, and any
-	trees which are mentioned by the index's cache-tree extension)
-	ad listed on the command line. Note that you probably want to
-	use `--objects`, too, as there are by definition no commits in
-	the index.
+--indexed-objects::
+	Pretend as if all trees and blobs used by the index are listed
+	on the command line.  Note that you probably want to use
+	`--objects`, too.
 
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if

I was tempted to not document this at all (nor to add documentation for
--reflog), as I think these are really only going to be used internally.
But it's nice to have documentation even for this internal stuff (if
anything, we should probably be making sure they are just limited to
rev-list plumbing, and not included in the log manpage).

-Peff
