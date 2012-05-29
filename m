From: Jeff King <peff@peff.net>
Subject: Re: Alphabetize git config --list
Date: Tue, 29 May 2012 04:49:40 -0400
Message-ID: <20120529084940.GA15145@sigill.intra.peff.net>
References: <CAFus=5=cp62hpLM_Odog--Q0vER8kkT5Doqo28i-yZQyfvv4gQ@mail.gmail.com>
 <20120528212309.GA4220@sigill.intra.peff.net>
 <4FC45CEB.4070808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zach <zach@letmesearchthat.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 29 10:49:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZI7r-0000OS-DO
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 10:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab2E2Itw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 04:49:52 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:34863
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab2E2Itu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 04:49:50 -0400
Received: (qmail 21289 invoked by uid 107); 29 May 2012 08:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 May 2012 04:49:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2012 04:49:40 -0400
Content-Disposition: inline
In-Reply-To: <4FC45CEB.4070808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198732>

On Tue, May 29, 2012 at 07:21:47AM +0200, Michael Haggerty wrote:

> >>Essentially this
> >>$ git config --list | sort
> >
> >No, it's not a good idea; the order of keys is important. For example,
> >[...]
> 
> Is the order of *keys* important, or only the order of *values* for a
> given key?  I believe that one could sort the output by key as long
> as the values for each key are kept in their original order (i.e.,
> sort stably by key).  This would indeed make it easier to read the
> output.

Good question. I was thinking of the order of values, but you're right
that a stable key-only sort would handle that.

In general, keys are independent, but there are two exceptions I can
think of:

  1. We sometimes have aliased keys that get parsed to the same memory
     location (usually this is to maintain backwards compatibility when
     a key is renamed, or wants to grow incompatible features). For
     example, "diff.color" and "color.diff" override each other, and
     their order is important. Also, "diff.funcname" and "diff.xfuncname".
     There may also be others.

  2. Keys which involve pattern matching. The url.*.insteadOf keys seem
     to be order-independent, as they the longest match is used, not the
     first. The credential context-matching code takes all matches
     (though technically, things like the order in which helpers are
     called would be changed by a sort). I can't think of any others
     offhand.

So yes, I think the key order does matter, though only in a few corner
cases.

-Peff
