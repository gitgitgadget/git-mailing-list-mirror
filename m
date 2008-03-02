From: Jeff King <peff@peff.net>
Subject: Re: bug in git-revert
Date: Sun, 2 Mar 2008 02:02:21 -0500
Message-ID: <20080302070221.GA10629@coredump.intra.peff.net>
References: <20080302064449.GA6334@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JViDs-0005Lr-1t
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYCBHCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbYCBHCY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:02:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2347 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbYCBHCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:02:23 -0500
Received: (qmail 2574 invoked by uid 111); 2 Mar 2008 07:02:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 02:02:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 02:02:21 -0500
Content-Disposition: inline
In-Reply-To: <20080302064449.GA6334@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75733>

On Sun, Mar 02, 2008 at 01:44:49AM -0500, Jeff King wrote:

> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -279,6 +279,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>  		if (get_sha1("HEAD", head))
>  			die ("You do not have a valid HEAD");
>  		wt_status_prepare(&s);
> +		s.fp = NULL;
> +		wt_status_print_updated(&s);
>  		if (s.commitable)
>  			die ("Dirty index: cannot %s", me);
>  		discard_cache();

Actually, this isn't right. It needs to call wt_status_print(&s), since
it does some magic that wt_status_print_updated() requires to run
correctly.

-Peff
