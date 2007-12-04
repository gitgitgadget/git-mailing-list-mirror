From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Pulling tags no longer works in 1.5.3.4...
Date: Mon, 3 Dec 2007 21:33:40 -0500
Message-ID: <20071204023340.GA22320@coredump.intra.peff.net>
References: <4754B4AF.8070408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNbo-0006si-4D
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbXLDCdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbXLDCdn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:33:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2334 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXLDCdm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:33:42 -0500
Received: (qmail 1993 invoked by uid 111); 4 Dec 2007 02:33:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 21:33:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 21:33:40 -0500
Content-Disposition: inline
In-Reply-To: <4754B4AF.8070408@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66999>

On Mon, Dec 03, 2007 at 09:00:15PM -0500, Jeff Garzik wrote:

> Using package git-core-1.5.3.3-3.fc7, I can do the following with kernel git 
> trees:
>
> 1) git-clone --reference linux-2.6 linux-2.6 tmp-2.6
>
> 2) time passes (days or weeks)
>
> 3)	cd tmp-2.6
> 	git pull ../linux-2.6
> 	git pull --tags ../linux-2.6
>
> Result:  works as expected.

Hrm, when I try to reproduce using v1.5.3.3, I get the "Warning: No
merge candidate found..." message. Between 1.5.3.3 and 1.5.3.4, this
message got a bit longer and the exit code was fixed to indicate an
error. Were you perhaps just missing the warning message, since no error
was signaled?

At any rate, I think what you really want in step 3 is

  git fetch --tags ../linux-2.6

since you just want to grab the tags, and not merge anything (remember
that pull is fetch+merge -- you are only interesting in the fetching
side effect). You could also do this:

  git pull --tags ../linux-2.6 master

In general, "git pull --tags" without a branch to pull doesn't make much
sense. What happens is that the "--tags" tells the fetch part of the
pull operation to just grab the tags. Then the merge part of the pull
operation looks in what has just been fetched for something merge-able.
And of course there isn't anything, since all you fetched were tags.

-Peff
