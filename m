From: Jeff King <peff@peff.net>
Subject: Re: Confused about push/pull of a branch
Date: Tue, 25 Aug 2009 14:32:30 -0400
Message-ID: <20090825183230.GB23731@coredump.intra.peff.net>
References: <BA2E0DDB-3DE0-4D49-BFA6-72CFEDEBA5AE@uchicago.edu>
 <8E2E19AE-DFA6-4000-AD73-35739F1E6642@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fritz Anderson <fritza@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:33:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg0pI-0001L9-PC
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 20:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbZHYScb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 14:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbZHYSca
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 14:32:30 -0400
Received: from peff.net ([208.65.91.99]:38219 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650AbZHYSca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 14:32:30 -0400
Received: (qmail 18208 invoked by uid 107); 25 Aug 2009 18:32:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 14:32:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 14:32:30 -0400
Content-Disposition: inline
In-Reply-To: <8E2E19AE-DFA6-4000-AD73-35739F1E6642@uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127038>

On Tue, Aug 25, 2009 at 12:58:25PM -0500, Fritz Anderson wrote:

> >I can't get a second machine to pull in a branch that's in my
> >remote repository. I'm confused.
> 
> And just from half-wittedly fooling around, I tried:
> 
> machine_2$ git pull origin webservices

That will merge the 'webservices' branch from your origin with your
current branch (which looks like 'master' in this case).

Remember that "pull" in git is really just "fetch" and "merge". What you
want is "fetch" and "create a new local branch":

  $ git fetch
  $ git checkout -b webservices origin/webservices

except that the "fetch" step has probably already been done as a
side-effect of the pull you did earlier.

> This seems to mean that master on machine_2 is now congruent to
> webservices on machine_1. That's not what I meant. Is there a way to
> undo this? git-pull origin-master doesn't seem to do anything.

Sort of. It contains all the changes of 'master' _and_ all the changes
of 'webservices'. However in this case there were no changes in 'master'
that were not already in 'webservices', so we were able to "fast
forward" to where webservices is. If the two branches had diverged at
all, you would have had a merge (potentially with conflicts).

To undo it, you probably want:

  $ git checkout master ;# make sure we are on master branch
  $ git reset --hard origin/master ;# go back to where remote master is

-Peff
