From: Jeff King <peff@peff.net>
Subject: Re: Elegant subdirectory checkout of remote-tracking branch?
Date: Sat, 2 Mar 2013 03:04:25 -0500
Message-ID: <20130302080425.GA22861@sigill.intra.peff.net>
References: <20130301152253.GA9312@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Mar 02 09:05:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBhRI-0006jk-48
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 09:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab3CBIE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 03:04:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39841 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab3CBIE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 03:04:28 -0500
Received: (qmail 8327 invoked by uid 107); 2 Mar 2013 08:06:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Mar 2013 03:06:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Mar 2013 03:04:25 -0500
Content-Disposition: inline
In-Reply-To: <20130301152253.GA9312@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217321>

On Fri, Mar 01, 2013 at 10:22:53AM -0500, W. Trevor King wrote:

> These fail because I can't use a remote tracking branch as a
> source for the clone.  It should be possible to do:
> 
>   $ git clone --reference . --single-branch --branch todo git://git.kernel.org/pub/scm/git/git.git Meta
> 
> but that will require (I think) network access during a fetch.

Yes, it will. Junio mentioned already that for him, "Meta" is really a
separate repository, and I think the simplest thing is to just treat it
that way (that's how I handle my personal "meta" branch).

But if you really want to save the extra network round trip during a
fetch, you can either:

  1. Just fetch from the surrounding repository using a custom refspec,
     like:

       git init Meta
       cd Meta
       git config add remote.origin.url ..
       git config add remote.origin.fetch \
         refs/remotes/origin/todo:refs/remotes/origin/todo
       git fetch
       git checkout todo

or

  2. Look into the git-new-workdir script in contrib/workdir, which lets
     you check out an alternate branch in a separate directory.

The latter would probably be the most seamless, but it's also the most
likely to have bugs. :)

-Peff
