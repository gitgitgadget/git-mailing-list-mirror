From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] better "remote add --mirror" semantics
Date: Wed, 30 Mar 2011 15:51:39 -0400
Message-ID: <20110330195139.GA814@sigill.intra.peff.net>
References: <loom.20110330T040437-823@post.gmane.org>
 <20110330145908.GA812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:51:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51Qg-0007hP-NI
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153Ab1C3Tvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:51:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44324
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979Ab1C3Tvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:51:41 -0400
Received: (qmail 20971 invoked by uid 107); 30 Mar 2011 19:52:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 15:52:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 15:51:39 -0400
Content-Disposition: inline
In-Reply-To: <20110330145908.GA812@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170416>

On Wed, Mar 30, 2011 at 10:59:08AM -0400, Jeff King wrote:

> All of that being said, I'm not sure your config makes sense:
> 
> > [remote "origin"]
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> >         url = ssh://myserver.com/srv/git/myproject.git
> > [remote "mirror"]
> >         url = ssh://chris@myserver.com/srv/git/mirrors/chris/myproject.git
> >         fetch = +refs/*:refs/*
> >         mirror = true
> 
> Your mirror is configured to overwrite everything in refs/ if you fetch
> from it. Meaning it will throw away anything you fetched from "origin",
> as well as any local work. So this config is probably not what you want.
> 
> I'm guessing what you really wanted is a remote only for pushing to, and
> created it with:
> 
>   git remote add --mirror mirror ssh://...
> 
> The --mirror option has problems with that case. See this thread:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/161653

Here is a patch series which I think improves the situation. +cc Jan
Hudec from the mentioned thread.

  [1/3]: remote: disallow some nonsensical option combinations
  [2/3]: remote: separate the concept of push and fetch mirrors
  [3/3]: remote: deprecate --mirror

-Peff
