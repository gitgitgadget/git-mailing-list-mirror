From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu, 8 Apr 2010 00:45:52 -0400
Message-ID: <20100408044552.GA30473@coredump.intra.peff.net>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 06:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzjdM-0007X4-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 06:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab0DHEqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 00:46:14 -0400
Received: from peff.net ([208.65.91.99]:33085 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab0DHEqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 00:46:12 -0400
Received: (qmail 16155 invoked by uid 107); 8 Apr 2010 04:46:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 00:46:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 00:45:52 -0400
Content-Disposition: inline
In-Reply-To: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144312>

On Thu, Apr 08, 2010 at 11:58:03AM +0800, Tay Ray Chuan wrote:

> Instead of breaking execution when no remote (as specified in the
> variable dest) is specified when git-ls-remote is invoked, continue on
> and let remote_get() handle it.
> 
> That way, we are able to use the default remote (by default, "origin"),
> as git-fetch, git-push, and others, do.
> 
> While we're at it, die with a more interesting message ("Where do you
> want to..."), as git-fetch does, instead of the plain usage help.

I don't really see a problem with this. The current behavior produces an
error, so it is not as if we are breaking somebody's workflow, and the
only sensible default is the same one used by the other commands.

> +	if (!remote)
> +		die("Where do you want to list from today?");

Heh.

> +test_expect_success 'dies with message when no remote specified and no default remote found' '
> +
> +	!(git ls-remote >actual 2>&1) &&
> +	test_cmp exp actual

Use test_must_fail?

> +cat >exp <<EOF
> +fatal: 'refs*master' does not appear to be a git repository
> +fatal: The remote end hung up unexpectedly
> +EOF
> +test_expect_success 'confuses pattern as remote when no remote specified' '
> +	#
> +	# Although ugly, this behaviour is akin to the confusion of refspecs for
> +	# remotes by git-fetch and git-push, eg:
> +	#
> +	#   $ git fetch branch
> +	#
> +
> +	# We could just as easily have used "master"; the "*" emphasizes its
> +	# role as a pattern.
> +	!(git ls-remote refs*master >actual 2>&1) &&
> +	test_cmp exp actual
> +
> +'

This seems like a very odd thing to be testing. Should you not instead
test that "git ls-remote $foo" still treats $foo as a remote and lists
it, which is what we really care about?

-Peff
