From: Jeff King <peff@peff.net>
Subject: Re: Bug? file at the same time being deleted and not registered
Date: Mon, 24 May 2010 04:49:33 -0400
Message-ID: <20100524084932.GA21051@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop>
 <20100523234459.GA8285@coredump.intra.peff.net>
 <alpine.DEB.2.00.1005240932130.7107@tpo-laptop>
 <20100524082430.GA18755@coredump.intra.peff.net>
 <alpine.DEB.2.00.1005241027580.8425@tpo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tomas Pospisek <tpo@sourcepole.ch>
X-From: git-owner@vger.kernel.org Mon May 24 10:49:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGTMD-0003aQ-B3
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab0EXItk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 04:49:40 -0400
Received: from peff.net ([208.65.91.99]:59744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab0EXItj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 04:49:39 -0400
Received: (qmail 2559 invoked by uid 107); 24 May 2010 08:49:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 May 2010 04:49:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 May 2010 04:49:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005241027580.8425@tpo-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147611>

On Mon, May 24, 2010 at 10:29:02AM +0200, Tomas Pospisek wrote:

> >If it's empty or 32 bytes, then that explains what status is reporting
> >(but the question still remains how we got into that state).
> 
> There's no .git/index file there:
> 
>  $ ls -l .git/
>  total 36
>  drwxr-xr-x 2 tpo tpo 4096 2010-05-23 21:36 branches
>  -rw-r--r-- 1 tpo tpo    4 2010-05-23 21:36 COMMIT_EDITMSG
>  -rw-r--r-- 1 tpo tpo   73 2010-05-23 21:36 description
>  -rw-r--r-- 1 tpo tpo   23 2010-05-23 21:36 HEAD
>  drwxr-xr-x 2 tpo tpo 4096 2010-05-23 21:36 hooks
>  drwxr-xr-x 2 tpo tpo 4096 2010-05-23 21:36 info
>  drwxr-xr-x 3 tpo tpo 4096 2010-05-23 21:36 logs
>  drwxr-xr-x 7 tpo tpo 4096 2010-05-24 09:26 objects
>  drwxr-xr-x 4 tpo tpo 4096 2010-05-23 21:36 refs

Thanks. That means "git status" is at least reporting the right thing.
Now we just need to figure out why, when the strace of commit shows it
being written and renamed into place, the index file is missing.

I tried setting up a simple mhddfs mount to reproduce your problem, but
everything works fine for me. What version of mhddfs are you using? I'm
using version 0.1.28. I wonder if git is somehow triggering an mhddfs
bug. Looking through the svn logs for mhddfs, between 0.1.27 and 0.1.28,
there is a commit with message "fixed rename bug".

-Peff
