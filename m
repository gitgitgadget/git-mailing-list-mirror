From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 10:27:55 -0400
Message-ID: <20130820142755.GA839@sigill.intra.peff.net>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
 <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
 <52137A63.3010609@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:28:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmuo-0007WC-6H
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198Ab3HTO2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:28:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:37751 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab3HTO17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:27:59 -0400
Received: (qmail 21933 invoked by uid 102); 20 Aug 2013 14:27:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 09:27:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 10:27:55 -0400
Content-Disposition: inline
In-Reply-To: <52137A63.3010609@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232604>

On Tue, Aug 20, 2013 at 04:17:07PM +0200, Stefan Beller wrote:

> Stepping two steps back, I am trying to figure out, what this repo_abrev
> thing is doing, as I could find no documentation.

It's meant to abbreviate long pathnames in subject lines. As you noted,
the kernel .mailmap has:

  # repo-abbrev: /pub/scm/linux/kernel/git/

Try "git shortlog" in the kernel and grep for "..." to see its effect.

It is IMHO a misfeature to have it as part of .mailmap, but it is there
for historical reasons. And I think it is not really needed these days
anyway, as the messages created by git-merge are nicer to read in the
first place (and people tend to use nice readable URLs for accessing
one-off git pulls, too).

> So we're passing there an address, which was just set to zero.
> This is the only occurence of passing a value at all and the value
> being passed is 0, so the free in the original patch doesn't need
> that check either.

Right. I think the intent was to free a previously found repo-abbrev
line to avoid leaking memory (although arguably, it would make sense to
keep a list and abbreviate all that we find, I don't think anybody cares
anymore for the reasons I stated above).

-Peff
