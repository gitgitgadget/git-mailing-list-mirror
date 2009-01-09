From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 9 Jan 2009 05:47:18 -0500
Message-ID: <20090109104718.GA11033@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net> <49672244.80200@viscovery.net> <20090109101335.GA4346@coredump.intra.peff.net> <496728B9.7090200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLEv1-0002jI-Q9
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 11:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZAIKrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 05:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZAIKrW
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:47:22 -0500
Received: from peff.net ([208.65.91.99]:34895 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbZAIKrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 05:47:21 -0500
Received: (qmail 18099 invoked by uid 107); 9 Jan 2009 10:47:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 05:47:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 05:47:18 -0500
Content-Disposition: inline
In-Reply-To: <496728B9.7090200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105003>

On Fri, Jan 09, 2009 at 11:36:41AM +0100, Johannes Sixt wrote:

> Ah, no, it would not survive.
> 
> But there's a more serious problem why we cannot use start_async() in its
> current form: It expects that there is a *function* that produces the
> output; but here we don't have a function - output is produced by
> *returning* (from setup_pager).

Good point.

> I'll test your other patch (that replaces the execvp in git.c by run_command).

Note that it only covers the case of external commands. Hitting ctrl-c
to interrupt git will still cause funniness. For that we need to
intercept signals to call wait_for_pager(). But there is a slight snag:
we also intercept signals elsewhere (e.g., for tempfile cleanup). So we
need to start remembering the old signal handlers everywhere and
chaining to them.

-Peff
