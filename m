From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: Heads up: rebase -i -p will be made sane again
Date: Tue, 27 Jan 2009 08:54:18 -0600
Organization: Exigence
Message-ID: <20090127085418.e113ad5a.stephen@exigencecorp.com>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 16:14:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRpde-0001a1-My
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZA0PMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbZA0PMm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:12:42 -0500
Received: from sat6.emailsrvr.com ([64.49.219.6]:46447 "EHLO
	smtp112.sat.emailsrvr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751727AbZA0PMl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 10:12:41 -0500
X-Greylist: delayed 1096 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jan 2009 10:12:41 EST
Received: from relay31.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay31.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 702971B4027;
	Tue, 27 Jan 2009 09:54:22 -0500 (EST)
Received: by relay31.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTPSA id 383881B401C;
	Tue, 27 Jan 2009 09:54:22 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901271012550.14855@racer>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107350>


> Dear list,

Thanks for keeping me on the cc list--several of the later stages of
cruft are my fault, so I don't know that I'll be able to help any more
than commentary on the use cases I was trying to fulfill.

> As for the design bug I want to fix: imagine this history:
> 
>   ------A
>  /     /
> /     /
> ---- B
> \     \
>  \     \
>   C-----D-----E = HEAD
> 
> A, C and D touch the same file, and A and D agree on the contents.
> 
> Now, rebase -p A does the following at the moment:
> 
>   ------A-----E' = HEAD
>  /     /
> /     /
> ---- B
> 
> In other words, C is truly forgotten, and it is pretended that D never 
> happened, either.  That is exactly what test case 2 in t3410 tests for 
> [*1*].
> 
> This is insane.

Agreed.

Does this mean you're just getting rid of the code that calls "rev list
--cherry-pick"?

If so, I'd be all for that--I did not introduce it, nor fully understand
its nuances, and t3410 was just a hack to get the behavior of a rebase
with a dropped/cherry picked commit from the previous behavior of being
a no-op to instead do "something".

A few times I've pondered just removing the --cherry-pick/drop commit
part of rebase-p, but assumed it was there for a reason.

Also, yeah, don't treat the test cases in t3410 as "the result should be
this exact DAG" but "the result should be something that is not a
noop/sane".

> [*1*] The code in t3410 was not really easy to read, even if there was an 
> explanation what it tried to do, but the test code was inconsitent, 
> sometimes tagging, sometimes not, sometimes committing with -a, sometimes 
> "git add"ing first, yet almost repetitive.
> 
> In my endeavor not only to understand it, and either fix my code or the 
> code in t3410, I refactored it so that others should have a much easier 
> time to understand what it actually does.

Thanks for cleaning it up.

I recently saw a test of yours use a `test_commit` bash function that I
really like. My last patch submission debacle had a patch cleaning up
t3411 by introducing `test_commit`--I can brave `git send-email` again
if you have any interest in me resending it.

Thanks,
Stephen
