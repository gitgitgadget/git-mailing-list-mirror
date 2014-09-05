From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] use a hashmap to make remotes faster
Date: Fri, 5 Sep 2014 11:16:26 -0400
Message-ID: <20140905151626.GA1846@peff.net>
References: <25222.0938886865-sendEmail@debian>
 <5409887A.1000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Reynolds <patrick.reynolds@github.com>,
	Git <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 17:16:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPvFb-0006Ek-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 17:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbaIEPQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 11:16:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:44585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755117AbaIEPQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 11:16:29 -0400
Received: (qmail 12020 invoked by uid 102); 5 Sep 2014 15:16:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Sep 2014 10:16:29 -0500
Received: (qmail 6178 invoked by uid 107); 5 Sep 2014 15:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Sep 2014 11:16:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Sep 2014 11:16:26 -0400
Content-Disposition: inline
In-Reply-To: <5409887A.1000602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256509>

On Fri, Sep 05, 2014 at 11:55:06AM +0200, Stefan Beller wrote:

> >  struct remote {
> > +	struct hashmap_entry ent;  /* must be first */
> > +
> 
> I stumbled about this comment  "/* must be first */"
> when reading the changelog.
> 
> Why does it need to be first?
> Is it a common reason I'm just not aware of,
> or would it make sense to put the reason into the comment as well?

Yes, it's a requirement of the hashmap code. It stores arbitrary
structs, but uses the front of the type for its bookkeeping data (the
hash and a linked list pointer to the next item in the bucket). This is
documented in Documentation/technical/api-hashmap.txt.

-Peff
