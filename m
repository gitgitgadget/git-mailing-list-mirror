From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the
 tracked branch
Date: Thu, 10 Sep 2009 10:16:18 -0400
Message-ID: <20090910141618.GB4942@coredump.intra.peff.net>
References: <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net>
 <7vzl93cncn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 16:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlkRq-0005y4-JO
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 16:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbZIJOQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZIJOQV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 10:16:21 -0400
Received: from peff.net ([208.65.91.99]:32945 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbZIJOQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 10:16:20 -0400
Received: (qmail 1514 invoked by uid 107); 10 Sep 2009 14:16:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Sep 2009 10:16:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Sep 2009 10:16:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128115>

On Thu, Sep 10, 2009 at 11:36:42AM +0200, Johannes Schindelin wrote:

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 82045a2..09a2145 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -231,6 +231,10 @@ when you run 'git-merge'.
>  * The special construct '@\{-<n>\}' means the <n>th branch checked out
>    before the current one.
>  
> +* The suffix '@{tracked}' to a ref (short form 'blabla@{t}') refers to
> +  the branch tracked by that ref.  If no ref was specified, it means the
> +  branch tracked by the current branch.
> +

It looks like the code dereferences symbolic refs when doing the lookup
(so HEAD@{t} will find the upstream of the current branch), which I
think is the best thing to do. However, that does make it behave
slightly differently than HEAD@{2.minutes.ago}, so it may be worth
adding a sentence to this paragraph like:

  If the ref is a symbolic ref, it is dereferenced before searching
  for the upstream ref.

And we may want to add a test for HEAD, as well.

Also, I seem to be able to stimulate a segfault on a detached HEAD, but
I haven't investigated it yet.

-Peff
