From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Mon, 29 Feb 2016 17:10:25 -0500
Message-ID: <20160229221024.GE25342@sigill.intra.peff.net>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
 <20160227035634.GA10829@sigill.intra.peff.net>
 <1456783062.18017.65.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:11:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaW1m-0003Wq-J1
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbcB2WKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:10:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:51820 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754670AbcB2WKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:10:52 -0500
Received: (qmail 12082 invoked by uid 102); 29 Feb 2016 22:10:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 17:10:51 -0500
Received: (qmail 31824 invoked by uid 107); 29 Feb 2016 22:10:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 17:10:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 17:10:25 -0500
Content-Disposition: inline
In-Reply-To: <1456783062.18017.65.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287921>

On Mon, Feb 29, 2016 at 04:57:42PM -0500, David Turner wrote:

> > So I think this setup probably should be in
> > check_repository_format_gently(), and should be able to trigger off
> > of
> > the existing ref_storage_backend string we've already saved (and we
> > should bail immediately there if we don't know about the backend, as
> > it
> > means we _don't_ match the repo's extensions and cannot proceed).
> 
> We apparently don't always call check_repo_format before calling
> git_config_early -- or, more to the point, before doing ref operations.
> So I think we need this in git_config_early.

That seems horribly broken, though. If a program is accessing refs
without calling check_repository_format, isn't it bypassing all of our
regular version and extension checks?

I think we should be smoking out such cases (e.g., by setting
a null refs-backend, as I mentioned earlier) and fixing them, rather
than working around them by putting the backend setup in the wrong
place.

-Peff
