From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
	branch-name
Date: Sun, 12 Apr 2009 03:20:57 -0400
Message-ID: <20090412072056.GA25837@coredump.intra.peff.net>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> <200904092119.10520.mlevedahl@gmail.com> <7vbpr519jq.fsf@gitster.siamese.dyndns.org> <200904111301.31250.mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 09:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsu33-00089U-Th
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 09:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbZDLHVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 03:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbZDLHVA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 03:21:00 -0400
Received: from peff.net ([208.65.91.99]:44197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbZDLHU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 03:20:59 -0400
Received: (qmail 12754 invoked by uid 107); 12 Apr 2009 07:21:01 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 12 Apr 2009 03:21:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Apr 2009 03:20:57 -0400
Content-Disposition: inline
In-Reply-To: <200904111301.31250.mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116370>

On Sat, Apr 11, 2009 at 01:01:30PM -0400, Mark Levedahl wrote:

>    $ git checkout -b refs/heads/master refs/heads/master
>              creates a new branch, refname = refs/heads/refs/heads/master
> 
> The last command is the one that I find most curious. The exact same string 
> has two entirely different meanings to the same command. I can explain why 
> this happens, but I cannot explain why this is a good thing. 

A command like "grep foo foo" has the same property (one string with
different meanings based on argument position). The problem is that you
are thinking of it as:

  git checkout -b <branch> <branch>

And I can see why you might think of it that way, because that is what
the synopsis in git-checkout(1) says. :) But it is really:

  git checkout -b <branch> <commit>

I'm not sure if changing that synopsis would really help, or if it is
a bit too subtle.

> A model I could explain without mental gymnastics would be "branch names are 
> simply refnames without the leading refs/heads or refs/remotes, and a refname 
> may be used wherever a branch name is requested. While branch names are 
> potentially ambiguous, refnames never are."  Of course, this would mean that 

So the current model is: "branch names are simply refnames without the
leading refs/heads or refs/remotes. A <commit> can be referenced by the
usual names (see git rev-parse, "specifying revisions" for details)".

The thing that I think is more confusing about that is not the
final example you pointed out, but the difference between

  git checkout master

and

  git checkout refs/heads/master

Which is explained by the fact that the usage for checkout is not

  git checkout <branch>

but actually

  git checkout <branch|commit>

If a branch, then we checkout the branch. If a commit, then we detach on
that commit.

I'm not sure if that explanation helps you at all, but that is how I
think of it (and it makes sense to me).

-Peff
