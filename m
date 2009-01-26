From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 22:18:20 -0500
Message-ID: <20090126031820.GC14277@sigill.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <7v1vuqdcjp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@cs.ucla.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 04:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRI0q-0006SK-82
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 04:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbZAZDSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 22:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZAZDSX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 22:18:23 -0500
Received: from peff.net ([208.65.91.99]:51254 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbZAZDSW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 22:18:22 -0500
Received: (qmail 32424 invoked by uid 107); 26 Jan 2009 03:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 25 Jan 2009 22:18:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 22:18:20 -0500
Content-Disposition: inline
In-Reply-To: <7v1vuqdcjp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107164>

On Sun, Jan 25, 2009 at 06:30:18PM -0800, Junio C Hamano wrote:

> It would be a good addition to our toolset if scripts like gitk can
> declare which options and features are safe to accept from the end user to
> pass down to the plumbing tools.  "git rev-parse", which lets the script
> sift between options that are meant to affect ancestry traversal and the
> ones that are for other (primarily diff family) commands, does not do
> anything fancy like that, but it would be a logical place to do this sort
> of thing.

I'm not sure there is a good way of doing this at a less fine-grained
level than "each option". That is, how can git-core, without knowing how
the script will use the output, classify options in groups according to
how the script will react to them?

It seems like "--since" is innocent enough for gitk. It just limits the
commits shown. So maybe it goes into the "ancestry traversal" list. But
is that whole list safe? "--reverse" isn't, but I would have put it in
the same list.

So I think what you will end up with is a list in gitk of "these
particular options are known good for passing through". And that doesn't
really need tool support from git-core. It's up to each script how much
it wants to protect the user.

But if you are proposing that some config options can be "enabled" by
scripts selectively, then I think that does need tool support. Keith's
"primer" example will be parsed by git, not by whatever script is
calling it. So we would need to feed it some list of "these are the OK
options".

-Peff
