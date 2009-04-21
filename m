From: Jeff King <peff@peff.net>
Subject: Re: Bug(let): status reports 'can fast-forward' when not true
Date: Tue, 21 Apr 2009 17:02:33 -0400
Message-ID: <20090421210233.GB13151@coredump.intra.peff.net>
References: <20090421205352.GA29125@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Kjetil Barvik <barvik@broadpark.no>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwN8t-0003a0-3J
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 23:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbZDUVCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 17:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbZDUVCh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 17:02:37 -0400
Received: from peff.net ([208.65.91.99]:48811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbZDUVCg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 17:02:36 -0400
Received: (qmail 11607 invoked by uid 107); 21 Apr 2009 21:02:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Apr 2009 17:02:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2009 17:02:33 -0400
Content-Disposition: inline
In-Reply-To: <20090421205352.GA29125@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117157>

[cc'ing Kjetil, as this is a fallout of 19de5d6]

On Tue, Apr 21, 2009 at 09:53:52PM +0100, Charles Bailey wrote:

> I was not really thinking when I get fetched, and ran git status on my
> pu branch. I was told that pu was behind origin/pu by 104 commits and
> could be fast-forwarded, so I git merged origin/pu and was mildly
> surprised when git merge made a commit for me.
> 
> A quick investigation revealed that pu had (of course) been rewound,
> but the only commits that it had that the new pu didn't, were merge
> commits.

I think this is an unintended consequence of 19de5d6
(stat_tracking_info(): only count real commits, 2009-03-04). It is
perhaps more useful when seeing the actual numbers to see only the count
of real commits, but it makes statements like "can be fast-forwarded" no
longer true.

So I think we need to either:

  1. reword the "can be fast-forwarded" text to something else

  2. revert 19de5d6, since merge commits _can_ be interesting

  3. refactor stat_tracking_info to return "real" and "merge" counts,
     and change the text for the case of "real == 0 && merge > 0".

-Peff
