From: Jeff King <peff@peff.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
	a remote branch?
Date: Mon, 6 Apr 2009 17:25:16 -0400
Message-ID: <20090406212516.GA882@coredump.intra.peff.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com> <20090406043426.GC12341@coredump.intra.peff.net> <4d8e3fd30904060130l985b0a5x331d215ca6106fd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqwLV-0003qN-Vv
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 23:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbZDFVZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZDFVZh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 17:25:37 -0400
Received: from peff.net ([208.65.91.99]:48832 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbZDFVZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 17:25:36 -0400
Received: (qmail 27528 invoked by uid 107); 6 Apr 2009 21:25:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 17:25:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 17:25:16 -0400
Content-Disposition: inline
In-Reply-To: <4d8e3fd30904060130l985b0a5x331d215ca6106fd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115883>

On Mon, Apr 06, 2009 at 10:30:21AM +0200, Paolo Ciarrocchi wrote:

> I often act like a GIT "evangelist" trying to help friends and
> colleagues in starting using GIT and one of the "complaint" I'm
> getting is that people expect to get this information out of the
> branch command.
> 
> I mean something like:
> $ git branch
>  * foo <-> origin/foo
> 
> What do you think?

Ah. Well, if you just want it for human consumption, that is much
easier. :) That information is already shown by "git status":

  $ git status
  # On branch next
  # Your branch is ahead of 'origin/next' by 8 commits.
  ...

"git branch -v" is already looking at the information, but it
prints only the "ahead/behind" summary. E.g.,:

  $ git branch -v
    bar    1e0672d [behind 5] some commit
  * baz    dccc1cd [ahead 1, behind 3] other commit
    foo    787d5a8 [ahead 1] another commit
    master a0e632e actual upstream master

It would be pretty trivial to make it do something fancier. The
(extremely rough) patch below shows the tracking branch when
double-verbosity is given:

  $ git branch -vv
  * next 2d44318 [origin/next: ahead 9] branch -vv wip

So the questions are:

  - is this worth it? The verbose information is already available via
    git status, but only for the current branch.

  - should it be the default with "-v", or require "-vv"? It take up a
    bit of screen real estate, which is already in short supply for
    "branch -v"

  - in both the "status" and "branch" cases, we show nothing if they
    are equivalent. I guess you would want to see

      * next 2d44318 [origin/next] branch -vv wip

    or

      * next 2d44318 [origin/next: uptodate] branch -vv wip

-Peff
