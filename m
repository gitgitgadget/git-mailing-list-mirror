From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/12] refs: implement simple transactions for the
 packed-refs file
Date: Wed, 12 Jun 2013 08:01:56 -0400
Message-ID: <20130612120156.GB20461@sigill.intra.peff.net>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
 <1370987312-6761-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umjka-00051I-UB
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab3FLMCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 08:02:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:36272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab3FLMB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:01:59 -0400
Received: (qmail 19223 invoked by uid 102); 12 Jun 2013 12:02:51 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 07:02:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 08:01:56 -0400
Content-Disposition: inline
In-Reply-To: <1370987312-6761-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227603>

On Tue, Jun 11, 2013 at 11:48:24PM +0200, Michael Haggerty wrote:

> The API docs are not clear about whether it is kosher to read
> lock_file::fd directly.  It is only done in one file outside of
> lockfile.c.  So this patch stores the fd of the lockfile separately in
> struct packed_ref_cache, even though the same struct also has a
> pointer to the struct lock_file.
> 
> So please let me know if it is OK to read lock_file::fd directly.  If
> so, then I will drop the fd member of struct packed_ref_cache, as well
> as the local variable "fd" in lock_packed_refs().

I think it's fine; the fact that you have such an fd is a public part of
the interface, so you are only relying on the struct member being there.
And since the lock_file must hold the fd itself somewhere, I don't think
that's unreasonable.

I'm not sure how you got your "in one file" list, but it appears to
happen in credential-store.c, bundle.c, fast-import.c, and read-cache.c.

-Peff
