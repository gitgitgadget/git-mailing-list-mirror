From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sat, 10 Apr 2010 04:40:07 -0400
Message-ID: <20100410084007.GA16843@coredump.intra.peff.net>
References: <20100410040959.GA11977@coredump.intra.peff.net>
 <1270885256-31589-1-git-send-email-gitster@pobox.com>
 <20100410074430.GA12567@coredump.intra.peff.net>
 <7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Raymond <esr@snark.thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 10:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0WF5-0004Le-6n
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 10:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab0DJIkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 04:40:33 -0400
Received: from peff.net ([208.65.91.99]:56921 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab0DJIkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 04:40:32 -0400
Received: (qmail 17275 invoked by uid 107); 10 Apr 2010 08:40:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 04:40:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 04:40:07 -0400
Content-Disposition: inline
In-Reply-To: <7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144534>

On Sat, Apr 10, 2010 at 12:48:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	dir.flags |= DIR_COLLECT_IGNORED;
> 
> I thought about using collect-ignored so that fill_directory() does not
> have to be run twice, but IIRC it can short-circuit an entire directory
> using the "simplify" logic (as it was designed to be used for "git add"),
> no?

Hmm.  I didn't consider that. It may be sufficient to say "foo/ is
ignored" and let callers decide for themselves that "foo/bar" is
ignored, too (unless, of course, it appears as tracked earlier in the
list).

I just worry that your version will perform less well. I'm not that
worried about the double traversal (on any reasonable system everything
will be cached after the first traversal). But finding every file means
we have to traverse areas that git otherwise wouldn't look at, which
might mean going to disk to pull in all of the "foo/" directory
structure (which is less likely to be cached, since the rest of git
isn't touching it), even though it may not even be of interest to us.

-Peff
