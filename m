From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 16:29:17 -0400
Message-ID: <20130917202917.GA20020@sigill.intra.peff.net>
References: <20130917190659.GA15588@pengutronix.de>
 <xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
 <20130917201259.GB16860@sigill.intra.peff.net>
 <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:29:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1to-0000kU-W0
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab3IQU3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:29:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:47679 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab3IQU3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:29:24 -0400
Received: (qmail 21508 invoked by uid 102); 17 Sep 2013 20:29:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Sep 2013 15:29:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Sep 2013 16:29:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234921>

On Tue, Sep 17, 2013 at 01:27:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Sep 17, 2013 at 12:58:07PM -0700, Junio C Hamano wrote:
> >
> >> I could argue that the above intended behaviour is suboptimal and it
> >> should have been "the resulting paths in the index and the work tree
> >> that match the given pathspec must be identical to that of the
> >> tree-ish".  In the resulting index or working tree, paths that match
> >> "subdir" pathspec in the above result is subdir/a and subdir/b, and
> >> that is different from what exists in the given tree-ish (which has
> >> only subdir/a and not subdir/b), and under that modified definition,
> >> what the current one does is not correct.
> >
> > Our emails just crossed, but I basically ended up saying a similar
> > thing.  Could we simply replace the "update_some" in builtin/checkout.c
> > with a two-way merge via unpack-trees?
> 
> Would it work to resolve a conflicted index by checking out from a
> known tree?

Hrm. Probably not. It is almost a one-way merge going to the named tree
(but limited by the pathspec), except that I think the current
git-checkout code may provide some safety checks related to where we are
coming from (e.g., do we unconditionally overwrite entries that are not
uptodate?).

-Peff
