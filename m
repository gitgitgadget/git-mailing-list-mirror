From: Jeff King <peff@peff.net>
Subject: Re: git add -p doesn't respect diff.context
Date: Thu, 4 Feb 2016 03:02:40 -0500
Message-ID: <20160204080239.GC21161@sigill.intra.peff.net>
References: <20160120063523.GA26490@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:02:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aREsI-00071V-L8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 09:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbcBDICn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 03:02:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:37262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753166AbcBDICm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 03:02:42 -0500
Received: (qmail 15664 invoked by uid 102); 4 Feb 2016 08:02:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 03:02:42 -0500
Received: (qmail 32632 invoked by uid 107); 4 Feb 2016 08:02:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 03:02:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 03:02:40 -0500
Content-Disposition: inline
In-Reply-To: <20160120063523.GA26490@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285408>

On Wed, Jan 20, 2016 at 03:35:23PM +0900, Mike Hommey wrote:

> When doing git add -p, the default of 3 context lines is used, ignoring
> the diff.context.
> 
> git add -p is using git-diff-files, and diff.context is being read in
> git_diff_ui_config, so the comment above that function applies:
> /*
>  * These are to give UI layer defaults.
>  * The core-level commands such as git-diff-files should
>  * never be affected by the setting of diff.renames
>  * the user happens to have in the configuration file.
>  */
> 
> I guess the question is whether it's diff-files or add -p that should
> honor diff.context. Or should it have its own separate config?

I think it must be "add -p", as otherwise we risk breaking scripts which
try to build on diff-tree but can't handle extra context (though I have
to admit that unlike something like diff.color, it would be a pretty
poor consumer of a diff that couldn't handle varying context).

We already do something similar with diff.algorithm. I think you could
probably just cargo-cult the handling of $diff_algorithm in
git-add--interactive.perl.

It might also make a nice GSoC microproject.

-Peff
