From: Jeff King <peff@peff.net>
Subject: Re: Beginner question on "Pull is mostly evil"
Date: Wed, 7 May 2014 13:04:05 -0400
Message-ID: <20140507170405.GA6224@sigill.intra.peff.net>
References: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Wed May 07 19:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi5GS-0006Oo-7x
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbaEGREL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:04:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:46812 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751068AbaEGREH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:04:07 -0400
Received: (qmail 7243 invoked by uid 102); 7 May 2014 17:04:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 May 2014 12:04:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 May 2014 13:04:05 -0400
Content-Disposition: inline
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248331>

On Wed, May 07, 2014 at 03:40:28PM +0000, Jim Garrison wrote:

> During my initial self-education I came across the maxim "don't pull,
> fetch+merge instead" and have been doing that.  I think I followed
> most of the "pull is (mostly) evil" discussion but one facet still
> puzzles me: the idea that pull will do a merge "in the wrong
> direction" sometimes.
> 
> Do I understand correctly that this occurs only in the presence of
> multiple remotes?

No, it does not have to do with multiple remotes. It is about "X merged
into Y" versus "Y merged into X". The ordering of parents in a merge
doesn't matter for the merge result, but git must choose some order, and
it always uses your current HEAD first, and then the commit you are
merging second (and so on, in an octopus merge).

As a result, you can use "git log --first-parent" to follow the line of
development that always got merged into. In a strict topic-branch
workflow like git.git, this will show you just what happened on master:
a linear sequence of merges of topic branches, with occasional
direct-to-master commits like version bumps.

For an integrator who is pulling from other people, "git pull bob topic"
from "master" does the right thing: master is the first parent, and
topic is the second parent.

For somebody with a centralized repo who follows the "push was a
non-fastforward, so pull then push" advice, the merge between their work
and master will be "backwards". The merge commit will have upstream's
work (i.e., "master") merged into their topic. Following --first-parent
will walk down their work instead of the merge commits on master.

Does that explain it?

-Peff
