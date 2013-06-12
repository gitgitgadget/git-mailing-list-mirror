From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] refs: do not invalidate the packed-refs cache
 unnecessarily
Date: Wed, 12 Jun 2013 08:39:31 -0400
Message-ID: <20130612123931.GD20461@sigill.intra.peff.net>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
 <1370987312-6761-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:39:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmkL3-0007Fv-9U
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab3FLMjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 08:39:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:36525 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab3FLMjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:39:35 -0400
Received: (qmail 20932 invoked by uid 102); 12 Jun 2013 12:40:27 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 07:40:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 08:39:31 -0400
Content-Disposition: inline
In-Reply-To: <1370987312-6761-13-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227608>

On Tue, Jun 11, 2013 at 11:48:32PM +0200, Michael Haggerty wrote:

> Now that we keep track of the packed-refs file metadata, we can detect
> when the packed-refs file has been modified since we last read it, and
> we do so automatically every time that get_packed_ref_cache() is
> called.  So there is no need to invalidate the cache automatically
> when lock_packed_refs() is called; usually the old copy will still be
> valid.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> This patch is optional.  It makes the assumption that the metadata
> stored in stat_validity are adequate to reliably detect when the
> packed-refs file has changed.  Given that we are about to rewrite the
> file, it is perhaps even more crucial not to make a mistake in this
> codepath than in others.  So if the stat_validity check is not
> considered safe enough, it might be prudent to omit this patch and
> continue to reload the packed-refs data here unconditionally.

I doubt that the risk is very high, but I'd also doubt that this
provides any useful performance improvement, because it is mostly
happening during a `git pack-refs` call. The exception is packing for a
ref deletion, and it could potentially speed up a receive-pack that was
deleting many refs.

I don't have a strong opinion either way.

-Peff
