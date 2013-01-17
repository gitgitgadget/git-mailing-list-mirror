From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 19:11:00 -0800
Message-ID: <20130117031100.GA7264@sigill.intra.peff.net>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <20130116160131.GB22400@sigill.intra.peff.net>
 <7vfw21xde5.fsf@alter.siamese.dyndns.org>
 <20130116174325.GA27525@sigill.intra.peff.net>
 <CAEUsAPY8T9TYCrZLWB-0Mwae_NtnqqVvGwY+4jGfqh5Lh3=Dgw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Jan 17 04:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvft6-0001Hb-9T
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 04:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825Ab3AQDLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 22:11:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35927 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758267Ab3AQDLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 22:11:05 -0500
Received: (qmail 17419 invoked by uid 107); 17 Jan 2013 03:12:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 22:12:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 19:11:00 -0800
Content-Disposition: inline
In-Reply-To: <CAEUsAPY8T9TYCrZLWB-0Mwae_NtnqqVvGwY+4jGfqh5Lh3=Dgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213839>

On Wed, Jan 16, 2013 at 08:19:28PM -0600, Chris Rorvick wrote:

> On Wed, Jan 16, 2013 at 11:43 AM, Jeff King <peff@peff.net> wrote:
> > I think that is a reasonable rule that could be applied across all parts
> > of the namespace hierarchy. And it could be applied by the client,
> > because all you need to know is whether ref->old_sha1 is reachable from
> > ref->new_sha1.
> 
> is_forwardable() did solve a UI issue.  Previously all instances where
> old is not reachable by new were assumed to be addressable with a
> merge.  is_forwardable() attempted to determine if the concept of
> forwarding made sense given the inputs.  For example, if old is a blob
> it is useless to suggest merging it.

I think it makes sense to mark such a case as different from a regular
non-fast-forward (because "git pull" is not the right advice), but:

  1. is_forwardable should assume a missing object is a commit not to
     regress the common case; otherwise we do not show the pull advice
     when we probably should, and most of the time it is going to be a
     commit

  2. When we know that we are not working with commits, I am not sure
     that "already exists" is the right advice to give for such a case.
     It is neither "this tag already exists, so we do not update it",
     nor is it strictly "cannot fast forward this commit", but rather
     something else.

     The expanded definition of "what is a fast forward" that I
     suggested would let this fall naturally between the two.

-Peff
