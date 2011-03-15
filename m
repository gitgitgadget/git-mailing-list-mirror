From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] tests: scrub environment of GIT_* variables
Date: Tue, 15 Mar 2011 03:37:18 -0400
Message-ID: <20110315073718.GB11754@sigill.intra.peff.net>
References: <20110315064909.GA25738@elie>
 <20110315070445.GC29530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:37:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzOox-0002Gs-Cn
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 08:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab1COHhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 03:37:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38775
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab1COHhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 03:37:20 -0400
Received: (qmail 19729 invoked by uid 107); 15 Mar 2011 07:37:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Mar 2011 03:37:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2011 03:37:18 -0400
Content-Disposition: inline
In-Reply-To: <20110315070445.GC29530@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169050>

On Tue, Mar 15, 2011 at 02:04:45AM -0500, Jonathan Nieder wrote:

> Variables from the inherited environment that are meaningful to git
> can break tests in undesirable ways.  For example,
> 
>  GIT_PAGER=more sh t5400-send-pack.sh -v -i
> 
> hangs.  So unset them in test-lib.
> 
> The variables to unset were found with 'git grep -F -e '"GIT_'.

Thanks. I fixed a few of these in a1231de recently, but was too lazy to
do an exhaustive search. Your list and your method look sane to me.

> Exception: leave the GIT_USE_LOOKUP variable from v1.5.6-rc0~134^2~1
> (sha1-lookup: more memory efficient search in sorted list of SHA-1,
> 2007-12-29) alone, since it is about trying an alternate
> implementation strategy rather than changing semantics and it can be
> useful to compare performance with and without it set.

Makes sense to me.

> Longer term, it would be nice to just unset all GIT_* variables (with
> exceptions like GIT_TRACE and GIT_USE_LOOKUP) with some magic using
> the "env" command.  That is less straightforward than one might hope
> because the values of environment variables can contain embedded
> newlines and equal signs and "env -0" is not portable.

According to posix, just running "set" provides an unambiguous,
parseable output. The problem is that it's actual shell, so it's a
little tricky to parse (it's single-quoted, and you have to follow
values across embedded newlines). So it's probably not worth the
headache.

Having a big list of "clear these variables" is probably not the end of
the world.  If it breaks somebody's test run, they'll probably report it
and we'll fix it. We don't add variables like this all that often.

-Peff
