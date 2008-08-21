From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: do not remove trash_directory if called with
	--debug
Date: Thu, 21 Aug 2008 08:55:17 -0400
Message-ID: <20080821125516.GA22453@coredump.intra.peff.net>
References: <7vabf7mcpz.fsf@gitster.siamese.dyndns.org> <20080821011811.GA13915@coredump.intra.peff.net> <alpine.DEB.1.00.0808210946280.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72qiwc0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW9iG-0000xP-FB
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 14:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbYHUMzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 08:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754731AbYHUMzV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 08:55:21 -0400
Received: from peff.net ([208.65.91.99]:4389 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbYHUMzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 08:55:20 -0400
Received: (qmail 4960 invoked by uid 111); 21 Aug 2008 12:55:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 08:55:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 08:55:17 -0400
Content-Disposition: inline
In-Reply-To: <7vy72qiwc0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93145>

On Thu, Aug 21, 2008 at 01:52:31AM -0700, Junio C Hamano wrote:

> Yeah, I think hooking this with --debug is makes actual sense.  Much saner
> than changing the behaviour magically with "make -j".
> 
> Even though I personally do not particularly like having an _easy_ way to
> leave the cruft around, I'll apply it if Jeff and other people like this
> behaviour.

I think the workflow you described is probably a better one for adding a
test, and I'll try to adjust to that. However, I do think Dscho's patch
makes sense for any time you simply want to look at the output of a
successful test (e.g., even if you aren't editing it).

My only concern with the patch is that it conditionally sets
$remove_trash; if debug is set, that variable is not set at all. Yet
later we look at it and "rm -rf" it. Obviously the chances of somebody
accidentally passing in such a variable are quite low, but style-wise
(and given that we are calling rm -rf!), I think I would prefer:

  if ! test -z "$debug"; then
    remove_trash="$TEST_DIRECTORY/$test"
  else
    remove_trash=
  fi

And a final comment on leaving cruft around: this is something that
developers have to deal with _anyway_, when tests fail or when we break
out of the test scripts with ^C. It eventually gets cleaned when the
test runs successfully (or one runs "git clean -xd").

-Peff
