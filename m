From: Len Brown <len.brown@intel.com>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 22:25:27 -0400
Organization: Intel Open Source Technology Center
Message-ID: <1124850327.27033.6.camel@firebird.lenb.worldpath.net>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	 <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net><1124836282.14730.4.camel@toshiba>
	 <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
	 <7vek8kmb2a.fsf@assigned-by-dhcp.cox.net>
	 <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tony.luck@intel.com, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 04:17:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7koc-0000Ui-EM
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 04:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVHXCPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 22:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHXCPb
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 22:15:31 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:22489 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S1750909AbVHXCPa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 22:15:30 -0400
Received: from firebird (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	by unix.worldpath.net (8.12.9/8.12.9) with ESMTP id j7O2F5rQ026070;
	Tue, 23 Aug 2005 22:15:05 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7697>

On Tue, 2005-08-23 at 21:07 -0400, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Probably the ideal way would be to give merge-base an option to
> > spit out all the candidates, and have the script try to see
> > which ones yield the least number of non-trivial merges.
> 
> I first checked out your 702c7e.. commit, and slurped Linus tip
> (back then, 81065e2f415af6c028eac13f481fb9e60a0b487b).  Then I
> ran git resolve with the attached patch (against the tip of
> git.git "master" branch).  Here is what happened, which seems to
> work a little bit better, at least to me.
> 
>     prompt$ git checkout -f
>     prompt$ git status
>     nothing to commit
>     prompt$ ls -l .git/HEAD
>     lrwxrwxrwx  1 junio src 26 Aug 23 15:43 .git/HEAD ->
> refs/heads/lenb
>     prompt$ git resolve HEAD origin 'Merge Linus into Lenb'
>     Trying to find the optimum merge base
>     Trying to merge 81065e2f415af6c028eac13f481fb9e60a0b487b into
> 702c7e7626deeabb057b6f529167b65ec2eefbdb using
> 3edea4833a1efcd43e1dff082bc8001fdfe74b34

Looking at gitk, it certainly chose the right ancestor in this case.

>     Simple merge failed, trying Automatic merge
>     Auto-merging Documentation/acpi-hotkey.txt.
>     merge: warning: conflicts during merge
>     ERROR: Merge conflict in Documentation/acpi-hotkey.txt.
>     Auto-merging drivers/acpi/osl.c.
>     fatal: merge program failed
>     Automatic merge failed, fix up by hand
> 
> Only lightly tested, in the sense that I did only this one case
> and nothing else.  For a large repository and with complex
> merges, "merge-base -a" _might_ end up reporting many
> candidates, in which case the pre-merge step to figure out the
> best merge base may turn out to be disastrously slow.  I dunno.

It ran a heck of a lot faster than the alternative -- which
would have been to export 85 patches and re-commit them
to a new tree.

Perhaps Tony's recent merge mystery had the same cause and he can also
benefit from this patch?

thanks!

-Len
