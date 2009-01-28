From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Heads up: rebase -i -p will be made sane again
Date: Tue, 27 Jan 2009 21:39:50 -0600
Organization: Exigence
Message-ID: <20090127213950.3596ecf9.stephen@exigencecorp.com>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
	<20090127085418.e113ad5a.stephen@exigencecorp.com>
	<alpine.DEB.1.00.0901280225240.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 04:41:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1Iq-0002TK-Pi
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZA1Dj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZA1Dj6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:39:58 -0500
Received: from smtp112.sat.emailsrvr.com ([66.216.121.112]:59148 "EHLO
	smtp112.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZA1Dj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:39:57 -0500
Received: from relay1.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 2E884CD56F;
	Tue, 27 Jan 2009 22:39:57 -0500 (EST)
Received: by relay1.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id EA124CD569;
	Tue, 27 Jan 2009 22:39:56 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901280225240.3586@pacific.mpi-cbg.de>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107464>


> Actually, I misread t3410 a great deal.  The situation is as follows:
> 
>     ... UPSTREAM
>            \
> ... A - B - C -D
> 
> A is a patch the upstream does not have, B is a patch UPSTREAM has,
> and "git diff C^!" (i.e. the diff of C to its first parent) is _also_ 
> identical to a diff of a merge that is in UPSTREAM.
> 
> Basically, t3410 tests that after "git rebase -i -p UPSTREAM" and leaving 
> the rebase script as-is, essentially, A and D are cherry-picked on top of 
> UPSTREAM.

Cool--I "knew" that, but could not have articulated the case as
succinctly.

> > Does this mean you're just getting rid of the code that calls "rev list 
> > --cherry-pick"?
> 
> Only now do I understand.
> 
> I misread the code for --cherry-pick.  For merges, it adds the diff to the 
> first parent!

Ah, so that is how --cherry-pick works--I'd never looked into the
patch-id stuff before. Makes sense, both of how it is leveraged by
rev-list --cherry-pick and also that it doesn't make sense to only be
against the first parent of merges.

> So I adapted my code to find the "dropped" merges in
> git-rebase--interactive, too, for now, but I guess the proper fix is
> something like this:

So, if C, as a merge commit, doesn't get a patch id anymore (right?),
does that mean that C is included with A and D in the cherry-picking
on top of UPSTREAM (because with no patch id it cannot be recognized
as a duplicate)? So then C' is an empty-commit? This would be fine, I
think, or can you detect that C is a noop somehow without patch ids?

Thanks,
Stephen
