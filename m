From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Fri, 29 Jan 2016 00:38:16 +0000
Message-ID: <20160129003816.GA26200@dcvr.yhbt.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <20160128235339.GB10308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 01:38:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOx5F-0006ba-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 01:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbcA2AiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 19:38:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52968 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbcA2AiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 19:38:17 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507421F736;
	Fri, 29 Jan 2016 00:38:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160128235339.GB10308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285050>

Jeff King <peff@peff.net> wrote:
> On Thu, Jan 28, 2016 at 10:51:23PM +0000, Eric Wong wrote:
> > -static int connect_setup(struct transport *transport, int for_push, int verbose)
> > +static int connect_setup(struct transport *transport, int for_push)
> >  {
> >  	struct git_transport_data *data = transport->data;
> > +	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
> 
> Do we want to trigger this only for "transport->verbose > 1"?
> 
> Right now, "git fetch -v" gives us a verbose status table (i.e.,
> includes up-to-date refs), but no more debugging than that. Should we
> reserve more debug-ish information like for "git fetch -vv"?

I'm not sure, I've never used "-v" at all in the past with fetch.

On one hand, I suspect someone who looks up "-v" and uses it is likely
wondering: "why is it so slow?"  At least, that's what I did before
resorting to strace :)

On the other hand, I'm not sure if there's anything parsing the stderr
out of "git fetch -v" right now.  In that case, perhaps only changing
"-vv" (and documenting it) is a better idea.  I've always been of the
opinion stderr is for humans and test suites, only; and not considered
an interface somebody should be parsing.

For reference, "curl -v" includes connection info which I rely on
all the time.

Junio:

  I'm leaning towards putting the test into t/t5570-git-daemon.sh
  to avoid potential port conflicts if that's OK with you.
  It doesn't seem like we have a lot of fetch tests on the git://
  at all.
