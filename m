From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 02:17:55 -0700
Message-ID: <7vps70qpx8.fsf@assigned-by-dhcp.cox.net>
References: <382665.13897.qm@web31804.mail.mud.yahoo.com>
	<7v7it8s7c4.fsf@assigned-by-dhcp.cox.net>
	<20070323090213.GA7186@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ltuikov@yahoo.com, git@vger.kernel.org
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Mar 23 10:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUfuK-0004mF-77
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 10:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbXCWJR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934273AbXCWJR5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 05:17:57 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44187 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbXCWJR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 05:17:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323091756.KONO18070.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Mar 2007 05:17:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e9Hv1W0021kojtg0000000; Fri, 23 Mar 2007 05:17:55 -0400
In-Reply-To: <20070323090213.GA7186@fiberbit.xs4all.nl> (Marco Roeland's
	message of "Fri, 23 Mar 2007 10:02:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42915>

Marco Roeland <marco.roeland@xs4all.nl> writes:

>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>> > BTW, git has always said to me "Pushing version ... to the masses"
>> > whenever I'd do "git-push --tags web".
>> 
>> Sorry, I must be blind, and git-grep is too.
>> 
>> $ git grep -e 'to the masses' -e 'Pushing v'
>> 
>> returns absolutely empty.
>
> The line comes from an older version of templates/hooks--update. The
> line was removed in commit 829a686f1b50ba96cac2d88494fa339efe0c0862 .
>
> So Luben does seem to have a hook installed, perhaps this is the
> culprit.

Thanks for spotting this.  I do not use this hook (well, I only
use commit-msg, pre-commit, and pre-rebase patches) and it was
totally outside of my radar.

It runs describe to find the previous tag, but the parser is a
bit old fashioned.  It says:

	prev=$(git describe "$3^" | sed 's/-g.*//')

but modern way to say the same is:

	prev=$(git describe --abbrev=0 "$3^")

Luben, sorry for the trouble.

I do not know how much better the recent hooks--update is
compared to the version you use.  It is supposed to be backward
compatible, so you _might_ want to simply update it with the one
from 'master' after checking if it suits your needs.  Otherwise,
I think the above one-liner should work the problem around.
