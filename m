From: Junio C Hamano <junkio@cox.net>
Subject: Re: warning merge message
Date: Fri, 22 Dec 2006 13:12:00 -0800
Message-ID: <7vodpvy6sf.fsf@assigned-by-dhcp.cox.net>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com>
	<7vr6us92m2.fsf@assigned-by-dhcp.cox.net>
	<7v1wms79mg.fsf@assigned-by-dhcp.cox.net>
	<200612222142.15489.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:12:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrgV-0005la-Oc
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbWLVVME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbWLVVME
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:12:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62213 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbWLVVMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:12:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222211200.BXEP7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 16:12:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1xBJ1W0021kojtg0000000; Fri, 22 Dec 2006 16:11:18 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200612222142.15489.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Fri, 22 Dec 2006 21:42:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35220>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Friday 22 December 2006 07:00, Junio C Hamano wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>> > The above message was meant only for "git pull", but was leaked
>> > even when you did "git fetch"; it was a bug and was corrected
>> > already (hopefully).
>> 
>> Gaah... it turns out that it was not fixed properly.
>
> Sorry, I am missing something.

You are not missing anything -- I CC'ed you not because I meant
to point fingers at you but I hoped you had better ideas since
you touched the related logic recently.

> What is the exact problem that goes wrong here?

The problem is the same as on another thread where Merlyn got
his scripts broken.  It is not _issuing_ the warning that is
wrong anymore, but is about deciding how to decide that no merge
candidate should exist.

We used to always merge with the first set of branches (either
the first "Pull: " line in remotes/$origin or the first instance
of "remotes.$origin.fetch" configuration).  Santi then added
"branch.$current.merge" to override that depending on what
branch we are currently on, which was backward compatible --
without such a configuration, we still used the "first set of
branches" rule.

People for a long time observed "the first set of branches" rule
was often a wrong thing to do while on a branch other than
'master' (but we do not want to add hardcoded 'master'
unnecessarily), and I recently screwed up by changing the logic
in such a way that everything is marked as not-for-merge unless
branches.*.merge is not set when pulling from the default
remote, which was completely bogus and bitten Luben.
