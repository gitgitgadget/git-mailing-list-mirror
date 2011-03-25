From: Jeff King <peff@peff.net>
Subject: Re: merge recursive and code movement
Date: Fri, 25 Mar 2011 12:00:13 -0400
Message-ID: <20110325160013.GA25851@sigill.intra.peff.net>
References: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
 <20110325093758.GA9047@sigill.intra.peff.net>
 <20110325101204.GB9047@sigill.intra.peff.net>
 <20110325111225.GC9047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:00:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q39R0-00009I-NQ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1CYQAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 12:00:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56696
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab1CYQAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 12:00:15 -0400
Received: (qmail 14772 invoked by uid 107); 25 Mar 2011 16:00:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 12:00:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 12:00:13 -0400
Content-Disposition: inline
In-Reply-To: <20110325111225.GC9047@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169992>

On Fri, Mar 25, 2011 at 07:12:25AM -0400, Jeff King wrote:

> It passes my test, and it doesn't break anything in t/. Yay.
> 
> There's one other call to remove_file in process_renames. It's for the
> case that both sides renamed the same file to the same destination.  I
> think there we need to actually compare the two sides. If only one side
> still has something at the source path, then we can take that side
> (since the other side renamed away the file). But if they both have it
> (i.e., they both installed a replacement), then we need to do the usual
> 3-way merge on that replacement. I'm not sure if we'd have to do that
> ourselves, or if we can just punt and the rest of the merge machinery
> will handle the entry. I'll have to write some tests, I think.

OK, I figured it out. I was thrown off by test failures in t3030, but I
think that test is actually wrong; it documents what happens, but not
really what we _want_ to have happen.

So this is the patch series I ended up with:

  [1/3]: t3030: fix accidental success in symlink rename
  [2/3]: merge: handle renames with replacement content
  [3/3]: merge: turn on rewrite detection

-Peff
