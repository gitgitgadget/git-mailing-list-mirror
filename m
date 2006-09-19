From: Joel Dice <dicej@mailsnare.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 15:42:20 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <20060919211844.GB8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 23:42:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnMI-0005d3-7T
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWISVmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWISVmX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:42:23 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:11142 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1751220AbWISVmW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 17:42:22 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id E4E4B2BFD0;
	Tue, 19 Sep 2006 21:42:20 +0000 (UTC)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919211844.GB8259@pasky.or.cz>
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27290>

On Tue, 19 Sep 2006, Petr Baudis wrote:

> Dear diary, on Tue, Sep 19, 2006 at 11:07:45PM CEST, I got a letter
> where Joel Dice <dicej@mailsnare.net> said that...
>> Implementation:
>>
>> A simple, efficient implementation of this feature would be based on a
>> single file, $GIT_DIR/history, which would contain a newline-delimited
>> list of SHA commit IDs in chronological order, oldest first.  The current
>> repository IRN would be calculated as the size of that file divided by the
>> SHA+newline length, and the commit ID of any IRN could be determined by
>> seeking to the correct offset in that file.  Every commit would cause a
>> new line to be appended to the history file with that commit's ID.
>> Finally, a history file could be generated for an existing repository by
>> serializing the commit history based on chronological order.
>
> We already have support for recording something similar, it's called a
> revlog. You would just need to modify it to aggregate all the branches
> in a single file.

Thanks - I'll look at that.

> Also, multiple IRNs could refer to a single real commit if you do e.g.
> cg-admin-uncommit, since revlog logs revision updates, not new revisions
> created. This may or may not be considered a good thing. If you rather
> want to just create a new IRN at commit object creation time, also note
> that some tools _might_ validly create commit objects and then throw
> them away, which would generate non-sensical (and after prune, invalid)
> IRNs.

I'm not too worried about cg-admin-uncommit or git-reset, since the IRN 
feature is intended mainly for shared repositories.  I would suggest that 
such commands simply be disallowed for such repositories.

The problem of temporary commits certainly needs to be addressed.  In this 
case, may I assume nothing under $GIT_DIR/refs is ever modified?  If so, 
perhaps I could somehow hook into the git-update-ref step.  Is that what 
the revlog code does?

  - Joel
