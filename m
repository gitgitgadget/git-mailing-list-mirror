From: Jeff King <peff@peff.net>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 23:41:38 -0500
Message-ID: <20101112044137.GA24915@sigill.intra.peff.net>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
 <20101112043229.GB10765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 05:41:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGlSR-0003Wa-Fh
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 05:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab0KLElq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 23:41:46 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47584 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516Ab0KLElq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 23:41:46 -0500
Received: (qmail 1256 invoked by uid 111); 12 Nov 2010 04:41:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 12 Nov 2010 04:41:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Nov 2010 23:41:38 -0500
Content-Disposition: inline
In-Reply-To: <20101112043229.GB10765@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161323>

On Thu, Nov 11, 2010 at 10:32:30PM -0600, Jonathan Nieder wrote:

> Subject: SIGPIPE and other fatal signals should default to SIG_DFL
> 
> The intuitive behavior when a git command receives a fatal
> signal is for it to die.
> 
> Indeed, that is the default handling.  However, POSIX semantics
> allow the parent of a process to override that default by
> ignoring a signal, since ignored signals are preserved by fork() and
> exec().  For example, Python 2.6 and 2.7's os.popen() runs a shell
> with SIGPIPE ignored (Python issue 1736483).
>
> [...]
>
>  check-racy.c   |    1 +
>  daemon.c       |    1 +
>  fast-import.c  |    1 +
>  git.c          |    2 ++
>  http-backend.c |    1 +
>  http-fetch.c   |    1 +
>  http-push.c    |    1 +
>  imap-send.c    |    1 +
>  remote-curl.c  |    1 +
>  shell.c        |    2 ++
>  show-index.c   |    2 ++
>  upload-pack.c  |    1 +
>  12 files changed, 15 insertions(+), 0 deletions(-)

Do we need to have it in every command? Is calling git-foo deprecated
enough that we can just put it in git.c?

I guess there are still a few commands that get installed explicitly in
.../bin (upload-pack, for example). They would need a separate one.
Perhaps it doesn't hurt to just put it in all of the non-builtins as you
did. It's not that big a maintenance issue.

-Peff
