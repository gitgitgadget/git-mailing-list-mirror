From: Jeff King <peff@peff.net>
Subject: Re: I'd like to be able to know what git-push will do
Date: Mon, 22 Jun 2009 17:40:32 -0400
Message-ID: <20090622214032.GC19364@coredump.intra.peff.net>
References: <20090618212803.GA14486@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIrFv-0000cf-5N
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 23:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZFVVke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 17:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZFVVke
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 17:40:34 -0400
Received: from peff.net ([208.65.91.99]:41040 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbZFVVkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 17:40:33 -0400
Received: (qmail 9136 invoked by uid 107); 22 Jun 2009 21:42:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Jun 2009 17:42:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2009 17:40:32 -0400
Content-Disposition: inline
In-Reply-To: <20090618212803.GA14486@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122062>

On Thu, Jun 18, 2009 at 05:28:03PM -0400, Larry D'Anna wrote:

> I'd like to be able to call git-push --dry-run and process the result
> from a perl script, but there's a snag: what does "foobar -> foobar"
> mean?  foobar could be a tag or a branch.  In fact, it could be a
> branch on on side and a tag on the other!

Yeah, that output is really meant for human consumption.

> I've tried duplicating the refspec processing in the perl script, but
> this approach is highly sub-optimal because the refspec parsing and
> matching is so complicated.  I would wind up duplicating a lot of
> functionality, and every time it changed in git my script would become
> broken.

Agreed.

> Would you accept a patch that changes the behavior of git-push so that
> instead of
> 
>   $ git-push --dry-run  -v origin :
>   Pushing to ~/repos/bin
>   To ~/repos/bin
>    = [up to date]      master -> master
>   Everything up-to-date
>   
> It would print the full names like this (only if -v is used)
> 
>   $ git-push --dry-run  -v origin :
>   Pushing to ~/repos/bin
>   To ~/repos/bin
>    = [up to date]      refs/heads/master -> refs/heads/master
>   Everything up-to-date
> 
> Or, if you don't like changing the behavior of -v, would you accept a
> patch with a new option (perhaps --symbolic-full-name) that caused
> git-push to behave this way?

I think it would have to be a new option, as "-v" is really about
something orthogonal. However, I actually think you are better off
making a whole new output format for porcelain scripts to read. As I
said, the current output is for human consumption, and I wouldn't rule
out the possibility of it changing in the future (and it won't receive
the same sort of deprecation treatment that an interface created for
scripts would get).

In other words, something like:

  $ git push --dry-run --porcelain origin :
  =refs/heads/master:refs/heads/master

(the format is totally off the top of my head -- I haven't thought too
long about what you might want to have in it).

-Peff
