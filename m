From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/20] [GIT PULL][v3.2] tracing: queued updates
Date: Wed, 12 Oct 2011 10:19:39 -0400
Message-ID: <20111012141939.GA25085@sigill.intra.peff.net>
References: <20111010133852.829771373@goodmis.org>
 <20111011055017.GA32616@elte.hu>
 <20002.1318367320@turing-police.cc.vt.edu>
 <20111012080711.GM18618@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Valdis.Kletnieks@vt.edu, git@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:19:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDzes-0008BB-8P
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 16:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab1JLOTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 10:19:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58441
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab1JLOTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 10:19:41 -0400
Received: (qmail 11220 invoked by uid 107); 12 Oct 2011 14:19:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 10:19:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 10:19:39 -0400
Content-Disposition: inline
In-Reply-To: <20111012080711.GM18618@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183369>

On Wed, Oct 12, 2011 at 10:07:14AM +0200, Ingo Molnar wrote:

> > On Tue, 11 Oct 2011 07:50:17 +0200, Ingo Molnar said:
> > 
> > >  $ git pull git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git tip/perf/core
> > >  fatal: The remote end hung up unexpectedly
> > 
> > Is it possible to get 'git' to say something more informative than 
> > "hung up unexpectedly"? "Tree not found, check URL" or similar 
> > would be nice...

It's not possible for the client to say anything more. The server sees
that the request isn't valid and hangs up without saying anything. So
the server needs to be changed to output better responses.

> Firstly, arguably, typoing something is not 'fatal' really - it's 
> just a resource that was not found on the server.
> 
> Secondly, and more importantly, the reason for the failed pull is 
> indeed important to know, if you want to resolve the problem with a 
> minimum fuss:
> 
>  - Was it the tree that didnt exist?
>  - Or the branch?
>  - Or was there some other problem [such as a truly unexpectedly 
>                                     closed transport socket]?
> 
> It's really useful for a painless UI flow to disambiguate failure 
> messages into clearly actionable variants.

I agree. I think some people are concerned with leaking information
about which repos exist and how they are configured. That is probably
not a big problem for a public site like kernel.org, though.

You might find this thread interesting:

  http://thread.gmane.org/gmane.comp.version-control.git/182529/focus=182642

It seems to have resulted in a patch that will at least say "access
denied" for every error. Which is a step up from "the remote end hung up
unexpectedly", but I do think most users would appreciate it being more
specific.

Perhaps we just need a config option to turn on more verbose messages,
if the site decides that there's no security implications to doing so.

-Peff
