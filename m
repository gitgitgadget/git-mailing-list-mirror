From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 00:49:00 -0400
Message-ID: <20081012044900.GA27845@coredump.intra.peff.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 06:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KosyI-0001M2-Ou
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 06:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYJLEtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 00:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbYJLEtF
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 00:49:05 -0400
Received: from peff.net ([208.65.91.99]:2205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbYJLEtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 00:49:04 -0400
Received: (qmail 12684 invoked by uid 111); 12 Oct 2008 04:49:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 12 Oct 2008 00:49:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 00:49:00 -0400
Content-Disposition: inline
In-Reply-To: <48EE1F58.2060707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98000>

On Thu, Oct 09, 2008 at 05:12:24PM +0200, Michael J Gruber wrote:

> - people are used to "svn status [-v]" like output which can include
> untracked as well as tracked unmodified files; there are other valid
> reasons why you would want that info
> 
> - porc can't do it: git status can't show ignored files, doesn't use
> status letters, can't show files with specific status; git diff
> --name-status can't show ignored nor untracked files
> [In fact, the description of "git diff" says "files which you could
> add", which should include untracked files, but doesn't.]
> 
> - plumb uses conflicting letters: git ls-files output conflicts with git
> diff --name-status output
> 
> So I guess it's time for a usability effort in this area. A few
> questions before going about that:

A week or two ago I came across yet another git-status annoyance: it
needs write access to the repository to run (I was helping somebody with
a task on a shared box, and I wanted to run status in their repository
using my account).

I considered submitting a patch to fix this, but I think it is really
more fundamental. I use status to get an overview of what's going on in
a repo, but it is intimately related to a potential commit.

And this bleeds into other areas, too. Why should the "what's going on
in this repo" command prefix all lines with "#"? We would have more
freedom to change the format if it weren't required to be a comment
line in a commit message.

So I think it is probably reasonable to think about a new command (which
would not be called status) that shows this information. What do people
want to see? And in what format? Some things I would want or have seen
requested are:

 - staged and unstaged changes in --name-status format

 - files without changes (with a -v flag).

 - untracked files

 - current branch / detached HEAD (with relationship to tracked branch,
   if any)

And maybe after hashing it out, it turns out it's not that different
from "git status" and we should just stick with that. But I would be
curious to hear proposals.

> - I think change of existing behaviour is unavoidable (make ls-files and
> diff --name-status consistent). Is that something to do now or rather
> before 1.7? Is porc (diff) supposed to be changed or plumb (ls-files)?

I don't think you would want to just change the default; you would
probably add a new option to ls-files to use the --name-status letters,
and then use that in your new porcelain.

> - How strong should the tie between git status and git commit be?
> Current git status is basically git commit -n, with the usual meaning of
> "-n" (such as for prune etc."), not with the current meaning of git
> commit -n, sigh...

I think the theoretical tool I mentioned would benefit from breaking
this connection. But I don't know whether it is prudent to take the
"status" name in doing so. Even if we decided to do so, it would
probably happen something like:

  1. Introduce git-wtf, a new status-like tool. Deprecate git-status in
     its current form.

  2. Wait a really long time.

  3. Rename git-wtf to git-status.

So either way, the first step is an alternative replacement command.

-Peff
