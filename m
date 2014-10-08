From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] object_array: factor out slopbuf-freeing logic
Date: Wed, 8 Oct 2014 03:36:58 -0400
Message-ID: <20141008073658.GC25250@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202222.GC16293@peff.net>
 <5433CDC2.6000908@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:37:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xblo3-00065h-ST
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 09:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbaJHHhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 03:37:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:56103 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753489AbaJHHhA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 03:37:00 -0400
Received: (qmail 1414 invoked by uid 102); 8 Oct 2014 07:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 02:37:00 -0500
Received: (qmail 12819 invoked by uid 107); 8 Oct 2014 07:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 03:37:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 03:36:58 -0400
Content-Disposition: inline
In-Reply-To: <5433CDC2.6000908@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 07, 2014 at 01:25:54PM +0200, Michael Haggerty wrote:

> > +static void object_array_release_entry(struct object_array_entry *ent)
> > +{
> > +	if (ent->name != object_array_slopbuf)
> > +		free(ent->name);
> > +}
> > +
> 
> Would it be a little safer to set ent->name to NULL or to
> object_array_slopbuf after freeing the memory, to prevent accidents?

I considered that, but what about the other parts of object_array_entry?
Should we NULL the object context pointers, too?

The intent of this function is freeing memory, not clearing it for sane
reuse.  I think I'd be more in favor of a comment clarifying that. It is
a static function used only internally by the object-array code.

-Peff
