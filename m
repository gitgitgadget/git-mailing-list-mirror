From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] add a stat_validity struct
Date: Wed, 15 May 2013 23:51:58 -0400
Message-ID: <20130516035158.GE13296@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
 <20130507023942.GB22940@sigill.intra.peff.net>
 <5190500E.8060907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 16 05:52:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcpEc-0003K0-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3EPDwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:52:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:44925 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3EPDwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:52:01 -0400
Received: (qmail 21532 invoked by uid 102); 16 May 2013 03:52:29 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 May 2013 22:52:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2013 23:51:58 -0400
Content-Disposition: inline
In-Reply-To: <5190500E.8060907@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224477>

On Mon, May 13, 2013 at 04:29:34AM +0200, Michael Haggerty wrote:

> > This patch introduces a "stat_validity" struct which
> > encapsulates the concept of checking the stat-freshness of a
> > file. It is implemented on top of "struct cache_entry" to
> > reuse the logic about which stat entries to trust for a
> > particular platform, but hides the complexity behind two
> > simple functions: check and update.
> 
> Given that "struct cache_entry" holds a lot of information that is
> irrelevant to stat-freshness and that ce_match_stat_basic() has a lot of
> logic that is geared towards cache_entries, it seems like there should
> be some kind of "struct stat_data" that holds the portion of the stat
> information that we use for checking whether a file might have been
> changed between two accesses.  cache_entry would contain a stat_data as
> a member, and the functionality for checking that part of a cache_entry
> validity would be moved to a separate function.
> 
> Then your "struct validity_info" could hold a pointer to a stat_data
> rather than to a cache_entry, and it wouldn't have to contain the
> unrelated cache_entry stuff.

Yes, I had the exact same thought, and came up with the exact same
solution. I was just hesitant to do it because it meant touching all of
the cache_entry users to adjust their struct accesses.

But from your patches, it doesn't look too bad (and we can be sure we
updated every spot, because it's easy for the compiler to enforce).

I'm sorry to be so slow lately; I'm on vacation (and will be for a bit
yet). I'm happy to rebuild my series on top of yours, and it looks like
it is still only in pu (I haven't yet read "What's Cooking" to see the
plans for it). I don't think there's a rush, as it is post-1.8.3 anyway
(I _do_ think it's a serious bug, in that it can cause data loss, but in
practice I doubt most people would hit it).

-Peff
