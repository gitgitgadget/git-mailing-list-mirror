From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] commit: only strip diff from message in verbose
	mode
Date: Wed, 12 Nov 2008 03:29:47 -0500
Message-ID: <20081112082947.GA3817@coredump.intra.peff.net>
References: <20081112081609.GA3720@coredump.intra.peff.net> <20081112082552.GE3751@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:31:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0B7x-00029H-KR
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYKLI3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYKLI3u
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:29:50 -0500
Received: from peff.net ([208.65.91.99]:1462 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbYKLI3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:29:50 -0500
Received: (qmail 17766 invoked by uid 111); 12 Nov 2008 08:29:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:29:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:29:47 -0500
Content-Disposition: inline
In-Reply-To: <20081112082552.GE3751@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100728>

On Wed, Nov 12, 2008 at 03:25:52AM -0500, Jeff King wrote:

> +test_expect_success 'diff in message is retained without -v' '
> +	git commit --amend -F diff &&
> +	check_message diff
> +'
> +
> +test_expect_failure 'diff in message is retained with -v' '
> +	git commit --amend -F diff -v &&
> +	check_message diff
> +'

I put in this expect_failure to remind us that we could be doing better.
The solution you proposed would fix this test. Another idea I had was to
use a bogus diff header, and match on that. Something like:

  diff --git --verbose-commit a/file b/file

and searching for "diff --git --verbose-commit", which would not trigger
on any diffs (unless, of course, you were trying to explain how the
verbose mode worked in your commit message :) ).

But that doesn't cover any other special input (i.e., lines beginning
with '#'), and would probably require an ugly hack to the diff machinery
(some diff option for "add these bogus diff command line options").

-Peff
