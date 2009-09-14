From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Mon, 14 Sep 2009 07:14:32 -0400
Message-ID: <20090914111432.GA15893@sigill.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 13:14:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn9W3-0004Y2-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 13:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbZINLOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZINLOa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 07:14:30 -0400
Received: from peff.net ([208.65.91.99]:37505 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbZINLOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 07:14:30 -0400
Received: (qmail 24002 invoked by uid 107); 14 Sep 2009 11:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Sep 2009 07:14:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 07:14:32 -0400
Content-Disposition: inline
In-Reply-To: <7v1vmar353.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128445>

On Sun, Sep 13, 2009 at 01:38:48PM -0700, Junio C Hamano wrote:

> I saw some discussion on improving the wording.  Here is what I plan to
> commit.
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index 0bbd5bf..2c2fa79 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -89,6 +89,8 @@ error_on_no_merge_candidates () {
>  	done
>  
>  	curr_branch=${curr_branch#refs/heads/}
> +	upstream=$(git config "branch.$curr_branch.merge" ||
> +			git config "branch.$curr_branch.rebase")

Argh, I made a mistake in my original patch which was retained in your
version. For some reason I was thinking that "branch.*.rebase" was an
_alternative_ to branch.*.merge, but it is in fact a bool that modifies
how we interpret branch.*.merge (I think when the feature was originally
discussed, that was one such proposal, and as I am not a user of the
feature, I proceeded with a totally bogus mental model since then).

So this really should read simply:

  upstream=$(git config "branch.$curr_branch.merge")

-Peff
