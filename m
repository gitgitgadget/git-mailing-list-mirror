From: Junio C Hamano <junkio@cox.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 11:47:42 -0700
Message-ID: <7v4pmb9tip.fsf@assigned-by-dhcp.cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
	<11793556371774-git-send-email-junkio@cox.net>
	<200705170539.11402.andyparkins@gmail.com>
	<7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
	<20070517110225.GA3334@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 20:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hol16-0006UG-02
	for gcvg-git@gmane.org; Thu, 17 May 2007 20:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759501AbXEQSrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 14:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759149AbXEQSrq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 14:47:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54760 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbXEQSro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 14:47:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517184742.PHTU19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 14:47:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0Jnj1X0041kojtg0000000; Thu, 17 May 2007 14:47:43 -0400
In-Reply-To: <20070517110225.GA3334@steel.home> (Alex Riesen's message of
	"Thu, 17 May 2007 13:02:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47548>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Thu, May 17, 2007 07:21:40 +0200:
>> What I was "handwaving" (or "envisioning") was to have something
>> like this in .gitmodules:
>> 
>> 	[subproject "kernel/"]
>>         	URL = git://git.kernel.org/pub/linux-2.4.git
>
> So, assuming .gitmodules is versioned (afaics, it is), it would mean
> that after a some unlucky git-pull, where someone changed the upstream
> .gitmodules ("linux-2.4" for whatever reason is changed to just
> "linux"). And suddenly all such local configuration is useless:

See below.

>> (or 2.6, depending on the revision of the superproject) and per
>> repository configuration would maps this with these two entries:
>> 
>> 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
>>         	URL = http://www.kernel.org/pub/linux-2.4.git
>>
>> 	[subproject "git://git.kernel.org/pub/linux-2.6.git"]
>
> isn't there a typo somewhere around "2.6"?
>
>>         	URL = http://www.kernel.org/pub/linux-2.6.git
>
> because there is no URL to map from.

The basic idea is that you keep mappings for all the URLs that
appear in versions of .gitmodules in the history you are
interested in checking out.  If the upstream switches from 2.4
based one to 2.6 based one, .gitmodules would contain a new URL,
which is not yet known to your configuration.  Then either the
UI would ask, with the default hint in the .gitmodules you just
pulled, refuse and have you manually add it to your config after
confirming, or just take the default (iow "trust the upstream").

So, no, it is not a reason to drop older mappings when your tip
was updated by a pull.  It should still be possible to checkout
older version that depend on the older 2.4 based subproject.

> why can't I just have _repo_ configuration:
>
>  	[subproject "kernel/"]
>          	URL = http://www.kernel.org/pub/linux-2.6.git
> ?
> It can be first-time cloned from the upstream, but it stays after
> people change it to suit their systems. They can depend on it not to
> be broken by upstream.

But that is a wrong thing to do when you are forking from the
release #1 of the appliance project, which wanted to have 2.4
based on at that path.
