From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Tue, 4 Jun 2013 17:22:55 -0400
Message-ID: <20130604212254.GC3271@sigill.intra.peff.net>
References: <1370369299-20744-1-git-send-email-me@ell.io>
 <1370369299-20744-2-git-send-email-me@ell.io>
 <7vip1t7koi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: elliottcable <me@ell.io>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyhH-00039m-9K
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3FDVXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:23:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:44297 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab3FDVW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:22:58 -0400
Received: (qmail 8867 invoked by uid 102); 4 Jun 2013 21:23:44 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 16:23:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 17:22:55 -0400
Content-Disposition: inline
In-Reply-To: <7vip1t7koi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226410>

On Tue, Jun 04, 2013 at 12:14:21PM -0700, Junio C Hamano wrote:

> > diff --git a/commit.h b/commit.h
> > index 67bd509..de07525 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -17,6 +17,7 @@ struct commit {
> >  	void *util;
> >  	unsigned int indegree;
> >  	unsigned long date;
> > +	unsigned long author_date;
> 
> While walking we keep many of them in-core, and 8-byte each for each
> commit objects add up.  We do not want to make "struct commit" any
> larger than it already is.

Yeah, I had the same thought. Maybe this is a good candidate to build on
top of the jk/commit-info slab experiment. The topo-sort could allocate
an extra slab for author-date (or even expand the indegree slab to hold
both indegree and author date), use it during the sort, and then free it
afterwards.

Elliott: you can see the relevant changes to the topo-sort in commit
96c4f4a (commit: allow associating auxiliary info on-demand,
2013-04-09).

-Peff
