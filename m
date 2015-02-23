From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: --to requires directory
Date: Mon, 23 Feb 2015 09:42:15 -0500
Message-ID: <20150223144214.GA31624@peff.net>
References: <768eecca8711467b43fcc45403ce9ce91bb1550e.1424700971.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 15:42:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPuDG-0002mZ-9P
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 15:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbbBWOmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 09:42:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:52261 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751898AbbBWOmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 09:42:17 -0500
Received: (qmail 9078 invoked by uid 102); 23 Feb 2015 14:42:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 08:42:17 -0600
Received: (qmail 24389 invoked by uid 107); 23 Feb 2015 14:42:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 09:42:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2015 09:42:15 -0500
Content-Disposition: inline
In-Reply-To: <768eecca8711467b43fcc45403ce9ce91bb1550e.1424700971.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264261>

On Mon, Feb 23, 2015 at 03:16:59PM +0100, Michael J Gruber wrote:

> --to requires a directory, not a file. Say so in the usage string.

Sounds like a good goal, but...

> -		OPT_FILENAME(0, "to", &opts.new_worktree,
> +		OPT_STRING(0, "to", &opts.new_worktree, N_("dir"),
>  			   N_("check a branch out in a separate working directory")),

OPT_FILENAME also calls fix_filename(), which munges the filename so
that relative paths given by the user will work, even though git has
chdir'd to the root of the working tree.

So you need to handle that somewhere. I think it might be less painful
to teach OPT_FILENAME to be more flexible in the usage message it
prints.

-Peff
