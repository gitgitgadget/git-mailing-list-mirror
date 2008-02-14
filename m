From: Jeff King <peff@peff.net>
Subject: Re: git-status producing incorrect results
Date: Thu, 14 Feb 2008 12:02:50 -0500
Message-ID: <20080214170250.GB28059@coredump.intra.peff.net>
References: <20080214164505.GA21932@coredump.intra.peff.net> <alpine.LSU.1.00.0802141650080.30505@racer.site> <20080214165432.GA28059@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhUe-0003Yz-VM
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYBNRCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYBNRCy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:02:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1268 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbYBNRCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:02:53 -0500
Received: (qmail 8902 invoked by uid 111); 14 Feb 2008 17:02:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 12:02:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 12:02:50 -0500
Content-Disposition: inline
In-Reply-To: <20080214165432.GA28059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73892>

On Thu, Feb 14, 2008 at 11:54:32AM -0500, Jeff King wrote:

> diff --git a/t/t7502-status.sh b/t/t7502-status.sh
> index b64ce30..11e5655 100755
> --- a/t/t7502-status.sh
> +++ b/t/t7502-status.sh
> @@ -128,4 +128,8 @@ test_expect_success 'status without relative paths' '
>  
>  '
>  
> +test_expect_success 'status of partial commit excluding new file in index' '
> +	git status modified
> +'
> +
>  test_done

Actually, this only finds the problem in the current 'next', where
git-status barfs with an error, and not in the first commit that
exhibits the problem, where only the results are incorrect.

I tried making a "git commit" test, but it seems that the commit
actually happens correctly (although if you do not specify -m, it does a
run_status, and ends up barfing). So the problem really is that the
index is screwed up after we decide what to commit but before we do the
status.

-Peff
