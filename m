From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Fri, 14 Nov 2008 01:47:56 -0500
Message-ID: <20081114064756.GB11907@coredump.intra.peff.net>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>, Theodore Ts'o <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 07:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0sUa-0005s4-FD
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 07:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbYKNGr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 01:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbYKNGr7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 01:47:59 -0500
Received: from peff.net ([208.65.91.99]:2017 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYKNGr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 01:47:58 -0500
Received: (qmail 31772 invoked by uid 111); 14 Nov 2008 06:47:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Nov 2008 01:47:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2008 01:47:56 -0500
Content-Disposition: inline
In-Reply-To: <1226580075-29289-4-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100955>

On Thu, Nov 13, 2008 at 12:41:15PM +0000, Charles Bailey wrote:

> This option stops git mergetool from aborting at the first failed merge.
> This allows some additional use patterns. Merge conflicts can now be
> previewed one at time and merges can also be skipped so that they can be
> performed in a later pass.
> 
> There is also a mergetool.keepGoing configuration variable covering the
> same behaviour.

I think this series addresses the questions I remember from the first
posting, and it looks sane overall to me. My only two complaints are:

>  Documentation/config.txt        |    4 +++
>  Documentation/git-mergetool.txt |   12 +++++++++-
>  git-mergetool.sh                |   46 ++++++++++++++++++++++++++++++--------
>  3 files changed, 51 insertions(+), 11 deletions(-)

This patch in particular changes some of the innards of mergetool, and
while the changes look good to me via reading, I would feel even more
comfortable if there were some tests (it looks like your previous t7610
gives at least a basic sanity check, but it might be nice to test to
make sure we detect merge failures, too).

> -		return
> +		return 0
> [...]
> -		return
> +		return 0
> [...]
> -		exit 1
> +		return 1
> [...]
> -	exit 1
> +	return 1
> [...]
> -	exit 1
> +	cleanup_temp_files
> +	return 1

One of these is not like the others. Is there a reason to add a
cleanup_temp_files here (and if so, should it be noted in the commit
message, and/or be in a separate commit?).

-Peff
