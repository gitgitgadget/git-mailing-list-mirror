From: Jeff King <peff@peff.net>
Subject: Re: Problems with stale .keep files on git server
Date: Thu, 31 Mar 2011 15:04:29 -0400
Message-ID: <20110331190429.GC16981@sigill.intra.peff.net>
References: <201103311246.25645.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:04:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5NAe-0003Zb-MV
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066Ab1CaTEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:04:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58979
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759141Ab1CaTEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:04:33 -0400
Received: (qmail 1666 invoked by uid 107); 31 Mar 2011 19:05:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 15:05:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 15:04:29 -0400
Content-Disposition: inline
In-Reply-To: <201103311246.25645.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170518>

On Thu, Mar 31, 2011 at 12:46:25PM +0200, Johan Herland wrote:

> Some questions:
> 
> 1. Why does the .keep file have 0600 permissions (preventing a local
>    clone by any other user)

The relevant code is in 6e180cd (Make sure objects/pack exists before
creating a new pack, 2009-02-24). I don't see anything particular about
the mode, so I suspect it was simply habit to make tempfiles restricted.

There is nothing secret in the contents, so I don't see any reason to
loosen it to the same permissions as the packfiles themselves.

> 2. Under which conditions will receive-pack leave stale .keep files
>    in the filesystem? Is this a bug?

I didn't look at the code, but I think we have to accept the possibility
that it may leave stale ones in the case of power failure or accidental
death by signal. So maybe there are places to fix, but we will still
have to deal with stale ones.

> 3. Do I need to scan for and remove stale .keep files in a cron job
>    in order to keep repos healthy and clonable?

If we fix (1), then hopefully it is not as much of an issue. But
probably "git gc" should clean up stale ones after a while.

-Peff
