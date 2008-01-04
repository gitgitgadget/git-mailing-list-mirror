From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 04:25:05 -0500
Message-ID: <20080104092505.GA2320@coredump.intra.peff.net>
References: <20080104081429.GA30635@coredump.intra.peff.net> <7vabnmm1ww.fsf@gitster.siamese.dyndns.org> <20080104083252.GB3300@coredump.intra.peff.net> <7vsl1ekmg5.fsf@gitster.siamese.dyndns.org> <20080104085934.GA3706@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAio5-0003pS-0E
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbYADJZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbYADJZK
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:25:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1318 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbYADJZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:25:09 -0500
Received: (qmail 16299 invoked by uid 111); 4 Jan 2008 09:25:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 04:25:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 04:25:05 -0500
Content-Disposition: inline
In-Reply-To: <20080104085934.GA3706@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69572>

On Fri, Jan 04, 2008 at 03:59:34AM -0500, Jeff King wrote:

> OK. In that case, we need a way for the plumbing to tell the diff
> machinery "don't ever try loading the ui config."

> >  * funcname-pattern can go either way; that affects what appears
> >    at the end of @@ context @@ lines, and would not have risk to
> >    corrupt the patch for plumbing.

I just sent a patch to put the funcname pattern in the "basic" config,
and to get rid of the lazy config loading. So that fixes one call by the
plumbing to read_config_if_needed.

And it looks like the second call is already OK. We don't try parsing
the config to get the external diff command unless ALLOW_EXTERNAL is
set, which the plumbing already disallows (though I am still confused
why it would need to be loaded lazily in the first place -- I wonder if
read_config_if_needed is needed at all).

-Peff
