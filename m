From: Jeff King <peff@peff.net>
Subject: Re: git diff
Date: Mon, 17 Jan 2011 17:30:21 -0500
Message-ID: <20110117223021.GA31045@sigill.intra.peff.net>
References: <AANLkTi=ASvicFGaaDfqxjOxJELWPLKsQwvk7rEeT36Fh@mail.gmail.com>
 <AANLkTik7cfu_DS=GS5gz_Tu94NC=ZGi-eA8YXztyd9Ra@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carter Lamb <carter.lamb@livetext.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 23:30:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pexaq-0000uJ-LB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 23:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab1AQWaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 17:30:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56385 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab1AQWaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 17:30:23 -0500
Received: (qmail 26295 invoked by uid 111); 17 Jan 2011 22:30:23 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 17 Jan 2011 22:30:23 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Jan 2011 17:30:21 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik7cfu_DS=GS5gz_Tu94NC=ZGi-eA8YXztyd9Ra@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165188>

On Thu, Jan 13, 2011 at 04:46:16PM -0600, Carter Lamb wrote:

> I use git diff --summary --numstat <commit> to report the files
> modified, created, and deleted between the current commit and some
> prior commit. The --stat and --numstat options count the lines added
> and deleted for each file. Is there a way to report the lines modified
> for each file. For example:

Not really, because it's not well defined. Consider your example:

> Given content below for commit 1:
> aaaaa
> ccccc
> 
> Given content below for commit 2:
> aaaaa
> bbbbb
> ccccc
> 
> Given content below for commit 3:
> Aaaaa
> Bbbbb
> ccccc
> ddddd

How do we know that "Aaaaa" is a modification of line "aaaaa", and not
simply the deletion of the old line and the addition of a new one? It's
easy to come up with a case where that is more obvious:

  -aaaaa
  +ddddd

but there are many shades of gray in between. Is:

  -aaaaa
  +Aaada

the deletion of an old line and the introduction of a new one, or the
modification of an existing line?  So fundamentally the diff format just
deals with added and removed lines, and modifications are represented as
a delete followed by an add.

Which isn't to say you couldn't think of many clever algorithms for
heuristically determining a modification, but git doesn't do that itself
in numstat.

-Peff
