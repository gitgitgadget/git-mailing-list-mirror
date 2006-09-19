From: Petr Baudis <pasky@suse.cz>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 23:18:44 +0200
Message-ID: <20060919211844.GB8259@pasky.or.cz>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 23:19:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPmzX-0000XI-5I
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWISVSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWISVSr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:18:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15800 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750975AbWISVSp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:18:45 -0400
Received: (qmail 20701 invoked by uid 2001); 19 Sep 2006 23:18:44 +0200
To: Joel Dice <dicej@mailsnare.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27287>

Dear diary, on Tue, Sep 19, 2006 at 11:07:45PM CEST, I got a letter
where Joel Dice <dicej@mailsnare.net> said that...
> Implementation:
> 
> A simple, efficient implementation of this feature would be based on a 
> single file, $GIT_DIR/history, which would contain a newline-delimited 
> list of SHA commit IDs in chronological order, oldest first.  The current 
> repository IRN would be calculated as the size of that file divided by the 
> SHA+newline length, and the commit ID of any IRN could be determined by 
> seeking to the correct offset in that file.  Every commit would cause a 
> new line to be appended to the history file with that commit's ID. 
> Finally, a history file could be generated for an existing repository by 
> serializing the commit history based on chronological order.

We already have support for recording something similar, it's called a
revlog. You would just need to modify it to aggregate all the branches
in a single file.

Also, multiple IRNs could refer to a single real commit if you do e.g.
cg-admin-uncommit, since revlog logs revision updates, not new revisions
created. This may or may not be considered a good thing. If you rather
want to just create a new IRN at commit object creation time, also note
that some tools _might_ validly create commit objects and then throw
them away, which would generate non-sensical (and after prune, invalid)
IRNs.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
