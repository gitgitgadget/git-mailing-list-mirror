From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 2 May 2013 11:46:18 -0400
Message-ID: <20130502154618.GA18462@sigill.intra.peff.net>
References: <20130501203449.GA12535@sigill.intra.peff.net>
 <51820B37.8010503@viscovery.net>
 <20130502064630.GA15208@sigill.intra.peff.net>
 <5182101D.4050807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 02 17:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXviE-00026N-PO
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743Ab3EBPqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:46:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:58246 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab3EBPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:46:21 -0400
Received: (qmail 28094 invoked by uid 102); 2 May 2013 15:46:38 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 May 2013 10:46:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2013 11:46:18 -0400
Content-Disposition: inline
In-Reply-To: <5182101D.4050807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223216>

On Thu, May 02, 2013 at 09:05:01AM +0200, Johannes Sixt wrote:

> > I figured the lengthy description in the commit message would be
> > sufficient,
> 
> It's absolutely sufficient *if* one reads the commit message. In this
> case, though it goes more like "this function should be trivial, and it is
> -- up to this if statement; what the heck is it good for?" and the reader
> is forced to dig the history.

What I really didn't want to do was to rewrite the whole rationale
again. I think something like:

  /*
   * Move the found object to the front of the collision chain;
   * this is a pure optimization that can make future lookups cheaper,
   * assuming there is some time-locality to which objects are looked
   * up.
   */

would be enough, and interested parties can go to the commit history (I
tend to go there pretty rapidly if there is a chunk of code that sticks
out, but I guess not everybody does).

> BTW, do you notice that the function is now modifying an object (the hash
> table) even though this is rather unexpected from a "lookup" function?

I think this is fine. The function is conceptually constant from the
outside; callers don't even know about the hash table. They just know
that there is some mapping. It's similar to the way that lookup_commit
will lazily allocate the "struct commit". The callers do not care
whether it exists already or not; they care that at the end of the
function, they have a pointer to the commit. Everything else is an
implementation detail.

-Peff
