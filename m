From: Jeff King <peff@peff.net>
Subject: Re: How to rebase and rename?
Date: Wed, 3 Feb 2010 04:48:06 -0500
Message-ID: <20100203094806.GB23956@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1002030958380.17444@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:48:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcbqM-0005Hx-AY
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397Ab0BCJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 04:48:10 -0500
Received: from peff.net ([208.65.91.99]:58320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932373Ab0BCJsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:48:08 -0500
Received: (qmail 25366 invoked by uid 107); 3 Feb 2010 09:48:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Feb 2010 04:48:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2010 04:48:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002030958380.17444@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138821>

On Wed, Feb 03, 2010 at 10:05:10AM +0100, Peter Krefting wrote:

> If I have a repository with a topic branch that is published, and
> that I want to rebase and republish under a new name, is there an
> easy way of doing that?
> [...]
> Currently, I do something along the lines of:
> 
>  git branch topic-2 topic-1
>  git rebase master topic-2
> 
> but that feels wrong as it creates the "topic-2" branch pointing the
> the wrong way first. Is there a way to eliminate that step?

No, I think that is the best way to do it. Since the creation of topic-2
is happening in your (presumably) private repo, it is not a big deal for
it to exist in an unintertesting state for a few seconds.

If you really cared, you could do the work on a detached HEAD and then
assign the result to a new branch, but that is even more typing:

  git checkout topic-1^0
  git rebase master
  git checkout -b topic-2

It also causes git to do slightly more work. In your example, the branch
creation is O(1), then rebase resets back to master and applies each
commit in topic-1 in turn. In mine, we actually reset the checkout to
topic-1, then reset it to master, and then apply the commits. Not that
it probably matters unless you have some enormous repository.

-Peff
