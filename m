From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] When nothing to git-commit, honor the git-status color
	setting.
Date: Mon, 27 Aug 2007 04:25:50 -0400
Message-ID: <20070827082550.GC17373@coredump.intra.peff.net>
References: <20070826183526.GA16359@ruiner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPZvO-0002I8-PP
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbXH0IZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbXH0IZx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:25:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1537 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbXH0IZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:25:53 -0400
Received: (qmail 29173 invoked by uid 111); 27 Aug 2007 08:25:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 04:25:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 04:25:50 -0400
Content-Disposition: inline
In-Reply-To: <20070826183526.GA16359@ruiner>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56778>

On Sun, Aug 26, 2007 at 02:35:26PM -0400, Brian Hetro wrote:

> Instead of disabling color all of the time during a git-commit, allow
> the user's config preference in the situation where there is nothing
> to commit.  In this situation, the status is printed to the terminal
> and not sent to COMMIT_EDITMSG, so honoring the status color setting
> is expected.

Thanks, this had been annoying me for a while. For some reason, I was
thinking that it was not going to be trivial to fix, because I thought
for efficiency reasons we only ran run_status once and used the output
for either the commit template or for dumping to the user. But I can't
seem to find any revision where that is the case, so obviously somebody
spiked my drink. For a month.

A minor nit on the implementation:

> +	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
> +		color=
> +	else
> +		color=--nocolor
> +	fi

This variable doesn't really say "use color"; it says "don't explicitly
turn off color". So perhaps there is a better name (respect_color or
similar)?

-Peff
