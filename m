From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 29 Oct 2008 12:42:53 -0400
Message-ID: <20081029164253.GA3172@sigill.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 17:44:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvE9V-0006Qm-ID
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 17:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbYJ2Qm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 12:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYJ2Qm7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:42:59 -0400
Received: from peff.net ([208.65.91.99]:2976 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbYJ2Qm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 12:42:58 -0400
Received: (qmail 29302 invoked by uid 111); 29 Oct 2008 16:42:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 12:42:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2008 12:42:53 -0400
Content-Disposition: inline
In-Reply-To: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99379>

On Wed, Oct 29, 2008 at 09:15:36AM -0700, David Symonds wrote:

>  Consider this as a replacement to the previous git-staged series.

I think this is a much more sensible (actual) approach.

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index c53eba5..a2f192f 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -33,6 +33,7 @@ forced by --no-index.
>  	commit relative to the named <commit>.  Typically you
>  	would want comparison with the latest commit, so if you
>  	do not give <commit>, it defaults to HEAD.
> +	--staged is a synonym of --cached.

Hmm. I wonder if it would make it more sense to make the "official" name
--staged, and leave --cached forever as a synonym. If the goal is giving
sane names to end users, then we should probably advertise the sane
ones.

OTOH, maybe it is better to start slow, let people who are doing
training materials mention --staged, and see how that works.

> @@ -118,7 +118,7 @@ static int builtin_diff_index(struct rev_info *revs,
>  	int cached = 0;
>  	while (1 < argc) {
>  		const char *arg = argv[1];
> -		if (!strcmp(arg, "--cached"))
> +		if (!strcmp(arg, "--cached") || !strcmp(arg, "--staged"))
>  			cached = 1;
>  		else
>  			usage(builtin_diff_usage);

I had to investigate this hunk closely, as it really looks at first
glance (from the function name, and the fact that there are two hunks,
one here and one for cmd_diff) that this is impacting diff-index
--cached, but it's not. We just checked --cached in two different places
inside git-diff (but at least one of them is prefixed by a comment that
includes the world "Eek.").

-Peff
