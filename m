From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 18:47:23 -0700
Message-ID: <20150725014722.GA17830@peff.net>
References: <20150723012343.GA21000@peff.net>
 <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
 <20150724074028.GE2111@peff.net>
 <xmqq4mkto9lg.fsf@gitster.dls.corp.google.com>
 <20150725013634.GA7269@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 03:47:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIoYp-0002sE-OS
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 03:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbbGYBr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 21:47:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:34767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbbGYBr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 21:47:27 -0400
Received: (qmail 15044 invoked by uid 102); 25 Jul 2015 01:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 20:47:27 -0500
Received: (qmail 24399 invoked by uid 107); 25 Jul 2015 01:47:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 21:47:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 18:47:23 -0700
Content-Disposition: inline
In-Reply-To: <20150725013634.GA7269@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274608>

On Fri, Jul 24, 2015 at 06:36:34PM -0700, Jeff King wrote:

> > I think in the cycle we merged Couder's trailer stuff we updated the
> > helper functions to locate where the S-o-b should go in an existing
> > message and consolidated (or, at least "talked about consolidating")
> > them into a single helper.  I do not think we wrote any special case
> > for "a line with three-dashes and nothing else on it" when we did
> > so, but that function would be the logical place to do so.
> 
> Yeah, it nicely has the concept of "ignore this footer". But we would
> want it only to kick in when doing emails (where the "---" is
> syntactically significant), I would think. So something like the patch
> below (no commit message because I'm in an airport right now; I'll add
> tests and repost in the next day or two).

This works for "format-patch -s". But I guess that leaves open the
question of "commit --signoff". It should not matter when making a
commit new (after all, you have not yet had a chance to put the "---"
in). But something like "git commit --amend --signoff" might want to
handle it. Of course we have no idea if any "---" we find there is meant
to be an email notes-separator by the user, or if they happened to use
"---" for something else[1] (which is a bad idea if you have an emailed
patches workflow, but many people do not). So it's a bit riskier.

-Peff

[1] While reading the old "git commit --notes" thread recently, Johan
    Herland gave a plausible confusing example:

      What
      ----

      A commit message using markdown-like formatting conventions.

      Why
      ---

      To show that "---" can be part of a commit message. :)
