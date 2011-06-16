From: Jeff King <peff@peff.net>
Subject: Re: rewrite history
Date: Thu, 16 Jun 2011 15:26:44 -0400
Message-ID: <20110616192644.GB13466@sigill.intra.peff.net>
References: <362053118.20110616231758@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 21:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIDM-0000lY-6R
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 21:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab1FPT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 15:26:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36953
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757522Ab1FPT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 15:26:46 -0400
Received: (qmail 16621 invoked by uid 107); 16 Jun 2011 19:26:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 15:26:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 15:26:44 -0400
Content-Disposition: inline
In-Reply-To: <362053118.20110616231758@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175918>

On Thu, Jun 16, 2011 at 11:17:58PM +0400, Ilya Basin wrote:

> Hi list. There were 2 branches. One's HEAD was modified to match a
> specific commit at another branch. Now, how to merge them according to
> this scheme?
> 
> A---B---X---E---F
>                      =>  C---D---X---E---F
> C---D---X'
> 
> X and X' have no difference. I tried to write a script to cherry-pick
> E and F, but some of commits are merges and cherry-pick fails.

I think you just want to rebase using the "-p" option to preserve
merges. Something like:

  $ git checkout -b rebased-branch F
  $ git rebase -p --onto D B

that will pick X, E, and F, and replay them on top of D, resulting in
the graph you showed above. You could also do:

  $ git rebase -p --onto X' X

if you wanted to keep X' instead of X.

The new history will be stored on "rebased-branch". You can make sure it
looks good to you, and then:

  $ git branch -f my_original_branch rebased-branch

to move the state over to your original branch. You could also just do
the rebase directly on the original A-B-X-E-F branch.

-Peff
