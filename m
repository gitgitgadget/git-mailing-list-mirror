From: Jeff King <peff@peff.net>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 18:54:34 -0400
Message-ID: <20140324225434.GB17080@sigill.intra.peff.net>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:54:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSDlS-0000BW-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaCXWyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:54:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:46230 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750816AbaCXWyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:54:36 -0400
Received: (qmail 13358 invoked by uid 102); 24 Mar 2014 22:54:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 17:54:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 18:54:34 -0400
Content-Disposition: inline
In-Reply-To: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244895>

On Mon, Mar 24, 2014 at 03:18:14PM -0400, Scott Sandler wrote:

> I've noticed that a few times in the past several weeks, we've had
> events where pushes have been lost when two people pushed at just
> about the same time. The scenario is that two users both have commits
> based on commit A, call them B and B'. The user with commit B pushes
> at about the same time as the user who pushes B'. Both pushes are
> determined to be fast-forwards and both succeed, but B' overwrites B
> and B is no longer on origin/master. The server does have B in its
> .git directory but the commit isn't on any branch.

What version of git are you running on the server? Is it possible that
there is a simultaneous process running `git pack-refs` (e.g., a `git
gc` run by a cron job or similar)?

There were some race conditions fixed last year wherein git could see
stale values of refs, but I do not think they could impact writing to a
ref like this.  When we take the lock on the ref, we always go straight
to the filesystem, so the value we see is up-to-date.

-Peff
