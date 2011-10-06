From: Jeff King <peff@peff.net>
Subject: Re: git-cherry-pick and author field in version 1.7.6.4
Date: Thu, 6 Oct 2011 07:27:42 -0400
Message-ID: <20111006112742.GA4445@sigill.intra.peff.net>
References: <4E8C6F0E.7000508@6wind.com>
 <20111005174138.GA22962@sigill.intra.peff.net>
 <4E8D5DEA.9010500@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 13:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBm7C-0001Rk-QO
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 13:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935791Ab1JFL1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 07:27:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54310
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935288Ab1JFL1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 07:27:45 -0400
Received: (qmail 6448 invoked by uid 107); 6 Oct 2011 11:27:45 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 07:27:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 07:27:42 -0400
Content-Disposition: inline
In-Reply-To: <4E8D5DEA.9010500@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182939>

On Thu, Oct 06, 2011 at 09:51:06AM +0200, Nicolas Dichtel wrote:

> Here is my sequence. I'm in a linux tree with a remote that point to
> linus tree and I want to cherry-pick a patch from this remote:
> 
> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> [dev 87ce387] drivers/net/usb/asix.c: Fix unaligned accesses
>  1 files changed, 33 insertions(+), 1 deletions(-)
> # git log -1 --format='%an<%ae>'
> Nicolas Dichtel<nicolas.dichtel@6wind.com>
> # git log -1 --format='%an<%ae>' 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> Neil Jones<NeilJay@gmail.com>
> #

Hmph. Odd:

  $ cd linux-2.6
  $ git checkout -b dev 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9^
  Switched to a new branch 'dev'
  $ git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
  [dev 78929c2] drivers/net/usb/asix.c: Fix unaligned accesses
   Author: Neil Jones <NeilJay@gmail.com>
   1 files changed, 33 insertions(+), 1 deletions(-)
  $ git log -1 --format='%an <%ae>'
  Neil Jones <NeilJay@gmail.com>

> Maybe it is related to the problem I've reported in another thread:
> http://comments.gmane.org/gmane.comp.version-control.git/182853

Possibly. That issue is about the commit that comes _after_ the
cherry-pick, and in this instance, things are already wrong for you by
the time the cherry-pick has completed.

However, the problem has to do with leaving a stale state file in .git,
so perhaps a previous partially-completed cherry-pick has left cruft in
.git that is confusing this cherry-pick (i.e., I can't reproduce because
it is being affected by something that happened before the commands
above). So let's see what Jay comes up with for solving the other
problem, and I suspect it may just fix this issue, too.

You might also repeating the commands above. If it still fails, maybe
try removing ".git/CHERRY_PICK_HEAD" if it exists and see if that helps.

-Peff
