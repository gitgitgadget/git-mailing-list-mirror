From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 10:19:37 +0100
Message-ID: <1kc5qsi.v9kcpd1vui7adM%lists@haller-berlin.de>
References: <20111212082526.GC16511@sigill.intra.peff.net>
Cc: h.b.furuseth@usit.uio.no (Hallvard B Furuseth),
	gelonida@gmail.com (Gelonida N), git@vger.kernel.org
To: peff@peff.net (Jeff King)
X-From: git-owner@vger.kernel.org Mon Dec 12 10:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra22w-0006hI-N3
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 10:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab1LLJTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 04:19:38 -0500
Received: from server90.greatnet.de ([83.133.96.186]:40062 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1LLJTh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 04:19:37 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 1C9FF2A01F3;
	Mon, 12 Dec 2011 10:18:02 +0100 (CET)
In-Reply-To: <20111212082526.GC16511@sigill.intra.peff.net>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186899>

Jeff King <peff@peff.net> wrote:

> On Mon, Dec 12, 2011 at 08:33:15AM +0100, Stefan Haller wrote:
> 
> > > Local branches can track each other.  So the script needs to toposort
> > > the branches, or to loop until either nothing was done or an error
> > > happened.  (The latter to prevent an eternal loop on error.)
> > 
> > Is this just theoretical, or are there real use cases for this? What
> > would be a workflow with such a local tracking branch?
> 
> I use this all the time.
> 
> In git.git, we use a topic branch workflow (i.e., every feature gets its
> own topic branch, and topics graduate independently to master as they
> are deemed stable). And we use a patch-submission workflow, which means
> it's OK for me to rebase my topics locally, because the end-product is a
> series of patches sent to the list.
> 
> Typically I branch off of "origin/master", so the topic is independent
> of anything else. For example, the "jk/credentials" branch in my git
> repo is branched from "origin/master" (Junio's master).  But sometimes
> there is a topic that depends on another topic, but should not be part
> of the same series (because the the first topic can graduate to master,
> but the second one may still need more time for discussion and cooking).
> In that case, I'll set the upstream to the other local topic branch. An
> example of this is the "jk/prompt" series, which depends on
> "jk/credentials" for infrastructure, but is really a separate issue.
> 
> Having the upstream set is convenient, because I can get _just_ the
> commits in jk/prompt with "git log @{u}..". Or I can rebase _just_ the
> commits in that topic with "git rebase -i". If my upstream were set to
> origin, I would accidentally also rebase all of the commits pulled in
> from jk/credentials, too.

I see, thanks.  For my script, I'm wondering then if the most sensible
thing to do is to just skip any branch whose upstream doesn't start with
refs/remotes/.

For a future "git pull --all" feature, it would probably only work on
those branches whose upstream is on the remote being pulled from,
anyway.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
