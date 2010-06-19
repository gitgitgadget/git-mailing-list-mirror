From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Sat, 19 Jun 2010 15:15:25 +0200
Message-ID: <201006191515.25640.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006181140.16652.johan@herland.net> <20100619101736.GA3539@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jun 19 15:15:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPxtZ-0006f0-2k
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 15:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0FSNP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 09:15:29 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59538 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755678Ab0FSNP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 09:15:28 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L49002RMJHQJK60@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 19 Jun 2010 15:15:26 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 537F41EA5555_C1CC2EEB	for <git@vger.kernel.org>; Sat,
 19 Jun 2010 13:15:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3AEEA1EA2D2B_C1CC2EEF	for <git@vger.kernel.org>; Sat,
 19 Jun 2010 13:15:26 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4900CHXJHQAB20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 19 Jun 2010 15:15:26 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <20100619101736.GA3539@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149379>

On Saturday 19 June 2010, Heiko Voigt wrote:
> Hi,
> 
> On Fri, Jun 18, 2010 at 11:40:16AM +0200, Johan Herland wrote:
> > [1]: To put the search in general terms: Find all merge commits that
> > has _both_ (or in the case of octopus; _all_) of the candidate commits
> > (but none of the other merges) somewhere in its ancestry. You could
> > implement this by first intersecting the sets returned from these
> > commands (run in the
> > 
> > submodule):
> >   git rev-list --merges --ancestry-path --all ^B
> >   git rev-list --merges --ancestry-path --all ^F
> > 
> > to get the set of merges descending from both 'B' and 'F', and then
> > prune each member in the remaining set that has another set member in
> > its ancestry.
> 
> Is the --ancestry-path option already implemented? Because on my git
> 1.7.1 it does not seem to.

It was recently merged to 'next'.

> What does it do?

When given a commit range ("$from..$to", or "$to ^$from"), it shows commit 
that are in $to but not in $from (i.e. the usual), but additionally limits 
the list to those commits that descend from $from. Another use case for this 
functionality is, given a bug introduced in commit $foo, you can list the 
commit in the master branch that are potentially "contaminated" with the 
bug, with the following command:

  git log --ancestry-path $foo..master

See the --ancestry-path documentation in the jc/rev-list-ancestry-path 
series for more info.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
