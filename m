From: Jeff King <peff@peff.net>
Subject: Re: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Tue, 7 Aug 2012 02:16:16 -0400
Message-ID: <20120807061616.GC13222@sigill.intra.peff.net>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <501E3F04.4050902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:16:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syd5h-0002kH-Lz
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 08:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab2HGGQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 02:16:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54201 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2HGGQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 02:16:22 -0400
Received: (qmail 25169 invoked by uid 107); 7 Aug 2012 06:16:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 02:16:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 02:16:16 -0400
Content-Disposition: inline
In-Reply-To: <501E3F04.4050902@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203020>

On Sun, Aug 05, 2012 at 11:38:12AM +0200, Michael Haggerty wrote:

> I have some other crazy ideas for making the concept even more powerful:
> 
> * Support remote alternate repositories.  Local repository obtains
> missing objects from the remote as needed.  This would probably be
> insanely inefficient without also supporting...
> 
> * Lazy copying of "borrowed" objects to the local repository.  Any
> object fetched from the alternate object store is copied to the local
> object store.
> 
> Together, I think that these two features would give fully-functional
> shallow clones.

You might be interested in looking at my rough (_very_ rough) experiment
with object db "hooks":

  https://github.com/peff/git/commits/jk/external-odb

The basic idea is to have helper programs that basically have two
commands: give a list of sha1s you can provide, and fetch a specific
object by sha1. That's enough for the low levels of git to fall-back to
a helper on an object lookup failure, and copy the object to a local
cache. Managing the cache could be done externally by helper-specific
code.

Sorry, there's no documentation on the format or behavior, and most of
the changes are in one big patch. If you're interested and find it
unreadable, I can try to clean it up.

-Peff
