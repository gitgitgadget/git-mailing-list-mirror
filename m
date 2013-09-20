From: Jeff King <peff@peff.net>
Subject: Re: breakage in revision traversal with pathspec
Date: Thu, 19 Sep 2013 23:35:41 -0400
Message-ID: <20130920033541.GC15101@sigill.intra.peff.net>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
 <522F8ED2.9000408@bracey.fi>
 <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
 <5230AD23.2050009@bracey.fi>
 <20130911182444.GD4326@google.com>
 <5230C6E3.3080406@bracey.fi>
 <xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
 <xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Bracey <kevin@bracey.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 05:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMrVp-0005i0-M0
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 05:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab3ITDfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 23:35:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:41007 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab3ITDfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 23:35:51 -0400
Received: (qmail 23084 invoked by uid 102); 20 Sep 2013 03:35:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 22:35:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 23:35:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235054>

On Thu, Sep 19, 2013 at 02:35:40PM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: revision: do not peel tags used in range notation
> 
> A range notation "A..B" means exactly the same thing as what "^A B"
> means, i.e. the set of commits that are reachable from B but not
> from A.  But the internal representation after the revision parser
> parsed these two notations are subtly different.
> [...]

Thanks for a very clear explanation. This definitely seems like an
improvement, and the patch looks good to me.

One question, though. With your patch, if I do "tag1..tag2", I get both
the tags and the peeled commits in the pending object list. Whereas with
"^tag1 tag2", we put only the tags into the list, and we expect the
traversal machinery to peel them later. I cannot off-hand think of a
reason this difference should be a problem, but I am wondering if there
is some code path that does not traverse, but just looks at pending
objects, that might care.

-Peff
