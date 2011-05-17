From: Stephen Bash <bash@genarts.com>
Subject: Re: Maint-only commits
Date: Tue, 17 May 2011 10:20:38 -0400 (EDT)
Message-ID: <32603283.31527.1305642038158.JavaMail.root@mail.hq.genarts.com>
References: <7vliy6jo8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 16:20:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QML8m-0002Lv-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 16:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab1EQOUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 10:20:47 -0400
Received: from hq.genarts.com ([173.9.65.1]:50085 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754788Ab1EQOUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 10:20:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 0E36AEA2324;
	Tue, 17 May 2011 10:20:45 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wG0rSgox4Gga; Tue, 17 May 2011 10:20:38 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5D2B4EA231F;
	Tue, 17 May 2011 10:20:38 -0400 (EDT)
In-Reply-To: <7vliy6jo8c.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173801>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Monday, May 16, 2011 6:05:07 PM
> Subject: Re: Maint-only commits
> 
> > In my office we've recently run into three separate fixes required
> > on our maintenance branch that should not be included in master (our
> > normal workflow is to make changes on maint, tag, release, and then merge
> > to master). Normally these "maint only" fixes are interspersed with
> > commits that should go back into master. In the past the "maint
> > only" commits were rare, so I'd carefully use "merge -s ours" to avoid
> > including the "maint only" changes in master. But now I'm wondering
> > if there's a better process/workflow?
> 
> I wonder what these "maint only" changes are, and the most importantly, if
> you know if a change you are about to commit is "maint only" material
> at the time you make it, or if it is something you would notice
> retroactively only when it is time to prepare merging maint back to master.

The three recent cases have all been fixes that, due to refactoring on master, require different changes on the two branches (these specific changes have been non-conflicting in a merge sense, but incorrect in a code sense).  All three cases were known ahead of time as "maint only", but unfortunately the first one still snuck through the merge process and had to be reverted on master.

> Assuming the former, you can use exactly the same discipline you already
> use to keep your 'maint' free of commits you make on 'master' to add
> new features that shouldn't be in the maintenance track.

... <snip> ...

> - You would keep for-both-maint-and-master, maint, and master
> branches.
> 
> - You treat the for-both-maint-and-master branch the way maint branch
> in projects like git itself is treated, i.e. everything can go to
> master. Commit changes that are meant for both maint and master on
> this branch, either by committing directly on it, or forking a topic from a
> commit on that branch and committing on top of it.
> 
> - You merge for-both-maint-and-master into maint and master at
> appropriate times.
> 
> - You never merge maint to master, nor merge master to maint.
> 
> - You commit changes that should only go to master on master, either
> by committing directly on it, or forking a topic from a commit on that
> branch and committing on top of it.
> 
> - You commit changes that should only go to maint on maint, either by
> committing directly on it, or forking a topic from a commit on that
> branch and committing on top of it.

That's certainly a valid approach.  I discussed it around the office and got push back on adding additional complexity to our branching model.  So I'll document the "our" merge approach and perhaps revisit the branching model at the beginning of the next development cycle.

Thanks,
Stephen
