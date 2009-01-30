From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Thu, 29 Jan 2009 21:55:46 -0500
Message-ID: <20090130025546.GA18257@coredump.intra.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 03:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSjZD-00026E-Nq
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 03:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZA3Czv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 21:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbZA3Czu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 21:55:50 -0500
Received: from peff.net ([208.65.91.99]:43261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbZA3Czu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 21:55:50 -0500
Received: (qmail 26290 invoked by uid 107); 30 Jan 2009 02:55:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 21:55:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 21:55:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107766>

On Fri, Jan 30, 2009 at 01:34:28AM +0100, Johannes Schindelin wrote:

> 	Let's be honest here, I have not much respect for users who fail 
> 	to read up enough to understand what they are doing.
> 
> 	But hearing from those users constantly is really unnerving.  And 
> 	it would be a one-time cost to old-timers.

I am not personally opposed to changing this default. I seem to
recall some opposition when this was brought up initially, but I don't
recall any specific reason besides "change is bad". Maybe those who
oppose want to summarize their arguments here.

I was hoping that introducing the warning would cause new users to "get
it". But since this warning was put in place, I think we have still
gotten a few questions on the list about this. I don't know if it simply
because they are on older versions, or if the warning is insufficient.
If the former, then perhaps that argues for leaving it a little longer.

>  	case DENY_REFUSE:
> -		if (!is_ref_checked_out(name))
> +		if (is_bare_repository() || !is_ref_checked_out(name))

Now what is this change about?

> --- a/t/t5701-clone-local.sh
> +++ b/t/t5701-clone-local.sh
> @@ -119,7 +119,7 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
>  test_expect_success 'clone empty repository' '
>  	cd "$D" &&
>  	mkdir empty &&
> -	(cd empty && git init) &&
> +	(cd empty && git init && git config receive.denyCurrentBranch false) &&
>  	git clone empty empty-clone &&
>  	test_tick &&
>  	(cd empty-clone

Perhaps some of these tests would do better to actually just use a bare
repository. That would better match the expected workflow for cloning
empty, anyway.

-Peff
