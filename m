From: Jeff King <peff@peff.net>
Subject: Re: Best way to get number of insertions and deletions from a diff?
Date: Wed, 13 Oct 2010 15:37:50 -0400
Message-ID: <20101013193750.GC13155@sigill.intra.peff.net>
References: <AANLkTinJuuxOZ2DvCSc2Nb0DAjwmJEyJXeGLHsLkyM1B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P678o-0000NJ-QO
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab0JMTh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:37:29 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0JMTh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:37:28 -0400
Received: (qmail 1579 invoked by uid 111); 13 Oct 2010 19:37:27 -0000
Received: from 129-79-255-167.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.167)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 13 Oct 2010 19:37:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 15:37:50 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinJuuxOZ2DvCSc2Nb0DAjwmJEyJXeGLHsLkyM1B@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158972>

On Wed, Oct 13, 2010 at 01:21:27PM -0600, Pat Notz wrote:

> I'd like to probe various commits to see how many lines were added or
> removed.  For example,
> 
> $ git diff --shortstat HEAD HEAD^1
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> That's great but I'd like to do this from a script and parse out those
> numbers.  Is there a more plumbing-level way to do this that would be
> more robust?  Or, should I just parse this output?

The official plumbing way is --numstat, but you will have to sum the
totals for file yourself. You should also use "git diff-tree" over "git
diff". If you have a lot of commits, the simplest thing is something
like:

  git diff-tree --stdin --numstat <commits

which will automatically check each commit against its parent (though I
think diff-tree will not resolve refs for you, so you may need massage
the input).

-Peff
