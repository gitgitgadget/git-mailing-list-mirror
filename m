From: Jeff King <peff@peff.net>
Subject: Re: got myself into trouble; now what? - how to revert once you've
 pushed
Date: Tue, 1 Mar 2011 14:50:28 -0500
Message-ID: <20110301195027.GE10082@sigill.intra.peff.net>
References: <AANLkTi=RGhGMcoDEL4q2pnnZ97tdswYG7OkjNS3wF7jn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVaT-0007d2-Rm
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176Ab1CATuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:50:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1CATuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:50:18 -0500
Received: (qmail 9657 invoked by uid 111); 1 Mar 2011 19:50:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 19:50:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 14:50:28 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=RGhGMcoDEL4q2pnnZ97tdswYG7OkjNS3wF7jn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168247>

On Tue, Mar 01, 2011 at 02:37:19PM -0500, Robert Buck wrote:

> We have two branches: master, feature/wixinstall
> 
> Apparently a merge happened from the branch to master (and I am pretty
> sure I never typed `git merge...`). But alas, a merge somehow happened
> and got pushed.

Did you run "git pull", which is basically fetch+merge?

> Then I followed the Git Pro documentation, which said to do this...
> 
>     git revert -m 1 [sha_of_C8]
> 
> Now I am left with a bigger mess. When I merge master to the branch,
> all the newly added files on the branch got deleted (not what I
> wanted). Somehow git is interpreting the revert literally as a
> sequence of deletes which it incorrectly then applies to the work on
> the branch.

Yeah. That reverts the merge, in essence creating a new tree built on
top of the merge without the results of the merge. But when you try to
re-merge between those two branches, it sees that history has already
combined, and then afterwards eliminated the result. Which is not what
you wanted.

Read the section "reverting the revert" directly below the advice you
followed:

  http://progit.org/2010/03/02/undoing-merges.html

> What I really wanted the revert to do is restore the history of the
> world immediately prior to the merge. But now I have a branch I can't
> merge into at all without losing a weeks work.
> 
> How can I get out of this mess?

If you can accept that history will be rewritten (which is a problem if
people have built on top of your bogus merge), then what you want is:

  git checkout master
  git reset --hard $SHA1_OF_MERGE^

and then re-push.

-Peff
