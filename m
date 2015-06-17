From: Jeff King <peff@peff.net>
Subject: Re: 'git status -z' missing separators on OSX
Date: Tue, 16 Jun 2015 23:32:12 -0400
Message-ID: <20150617033211.GA24673@peff.net>
References: <5580AF94.6090801@platymuus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tad Hardesty <tad@platymuus.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 05:32:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z545S-0007tG-2V
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 05:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbbFQDcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 23:32:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:47186 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750722AbbFQDcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 23:32:14 -0400
Received: (qmail 8515 invoked by uid 102); 17 Jun 2015 03:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 22:32:14 -0500
Received: (qmail 21709 invoked by uid 107); 17 Jun 2015 03:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 23:32:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 23:32:12 -0400
Content-Disposition: inline
In-Reply-To: <5580AF94.6090801@platymuus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271809>

On Tue, Jun 16, 2015 at 06:21:56PM -0500, Tad Hardesty wrote:

> ~/test (master #)$ git status -z | hexdump -C
> 00000000  41 20 20 61 41 20 20 62                           |A  aA  b|
> 00000008

That's really weird. I don't have a Yosemite box available, but I can't
reproduce on the Mavericks box I have access to. Still, I'd suspect
something weird in your config (e.g., something that is inserting itself
on the output pipe of "git status").

You said you blanked your config, but can you do "git config --list"
to double-check? Also, try running with GIT_TRACE=1, which would show if
git is starting a pager between your processes which might be eating the
NUL.

Can you also double-check that you have no aliases for "git" (try "type
git"). We have sometimes seen weird behavior when people have aliased
"git" to "hub".

Is it only "git status" that is affected? Does "git log --oneline -1 -z"
end in a NUL (it should)?

-Peff
