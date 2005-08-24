From: Len Brown <len.brown@intel.com>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 20:31:09 -0400
Message-ID: <1124843469.14730.13.camel@toshiba>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	 <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net><1124836282.14730.4.camel@toshiba>
	 <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 02:26:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7j4o-0008QE-W4
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVHXAZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVHXAZH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:25:07 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:60855 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S932475AbVHXAZG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 20:25:06 -0400
Received: from toshiba (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	by unix.worldpath.net (8.12.9/8.12.9) with ESMTP id j7O0OtrQ012194;
	Tue, 23 Aug 2005 20:24:56 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1 
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7691>

On Tue, 2005-08-23 at 19:58 -0400, Junio C Hamano wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> >> I could get to 81065e2f415af6... commit (Linus tip at this
> >> moment), so if you can tell me where to snarf the other commit
> >> (702c7e76....) that would help me diagnose the problem a lot.
> >
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-akpm.git
> 
> Thanks.
> 
> I think merge-base, even though we attempted to fix it recently,
> is still confused and that is one of the reasons why you are
> getting this.
> 
>     prompt$  git-rev-parse origin test-lenb-merge
>     81065e2f415af6c028eac13f481fb9e60a0b487b
>     702c7e7626deeabb057b6f529167b65ec2eefbdb
>     prompt$  git-merge-base origin test-lenb-merge
>     30e332f3307e9f7718490a706e5ce99f0d3a7b26
>     prompt$  git show-branch origin test-lenb-merge
>     ! [origin] zd1201 kmalloc size fix
>      * [test-lenb-merge] [ACPI] fix ia64 build issues resulting from
> L...
>     --
>     +  [origin] zd1201 kmalloc size fix
>     +  [origin~1] md: make sure resync gets started when array starts.
>     +  [origin~2] preempt race in getppid
>     +  [origin~3] Merge master.kernel.org:/pub/scm/linux/kernel/git/da
>     -- >8 -- snip -- >8 --
>     +  Merge ../to-linus-stable/
>     ++ [ACPI] re-enable platform-specific hotkey drivers by default
>     +  ARM: 2851/1: Fix NWFPE extended precision exception handling
>     ++ [origin~34] intelfb/fbdev: Save info->flags in a local variable
>     prompt$  git-rev-parse origin~34
>     3edea4833a1efcd43e1dff082bc8001fdfe74b34
> 
> Notice that show-branch, which walks the commit ancestry chain
> pretty much the same way merge-base does, notices and stops at
> origin~34 (that's 34th generation first parent commit from Linus
> tip) that is the common commit between the two heads being
> merged?  And that commit, 3edea48... is different from what
> merge-base is reporting.
> 
> If I maually run merge-cache using origin~34 as the merge base,
> only the following two files needs to result in non-simple merge:
> 
>     Documentation/acpi-hotkey.txt
>     drivers/acpi/osl.c
> 
> Do these two files match your expectation?

No, I don't think so.

Unless I missed something, to-akpm should be a proper super-set
of from-linus, so I wouldn't expect a merge on these two.

> I'll take a look at merge-base.c next, but just in case I CC:ed
> this to Linus, who is more familiar with that code.

thanks,
-Len
