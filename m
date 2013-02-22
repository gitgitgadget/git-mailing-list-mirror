From: Jeff King <peff@peff.net>
Subject: Re: -B option of git log
Date: Thu, 21 Feb 2013 19:57:04 -0500
Message-ID: <20130222005704.GA24287@sigill.intra.peff.net>
References: <5126BF50.6020500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eckhard Maass <eckhard.maass@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 01:57:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8gxH-0008W3-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 01:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab3BVA5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 19:57:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56594 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810Ab3BVA5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 19:57:07 -0500
Received: (qmail 436 invoked by uid 107); 22 Feb 2013 00:58:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 19:58:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 19:57:04 -0500
Content-Disposition: inline
In-Reply-To: <5126BF50.6020500@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216814>

On Fri, Feb 22, 2013 at 01:44:00AM +0100, Eckhard Maass wrote:

> Let me get a setup:
> 
> $> git init .
> Initialized empty Git repository in /tmp/t2/.git/
> $> echo 'Lorem ipsum doler sed. Lorem ipsum doler sed. Lorem ipsum doler
> sed. Lorem ipsum doler sed.' > a
> $> git add a
> $> git commit -m 'Init.'
> [master (root-commit) b78205c] Init.
>  1 file changed, 1 insertion(+)
>  create mode 100644 a
> $> mv a b
> $> echo 'new' > a
> $> git add -A .
> $> git commit -m '2nd.'
> [master a30ca49] 2nd.
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  create mode 100644 b
> 
> Now, I get the following:
> 
> $> git log --oneline -B20%/80% -M20% --name-status
> a30ca49 2nd.
> M       a
> A       b
> b78205c Init.
> A       a
> 
> But I would expect that git-log shows me a rename from a to b and a new a.

I think the problem is that your test file is so tiny that it falls
afoul of git's MINIMUM_BREAK_SIZE heuristic of 400 bytes (which prevents
false positives on tiny files). Try replacing your "Lorem ipsum" echo
with something like "seq 1 150", and I think you will find the result
you are expecting.

-Peff
