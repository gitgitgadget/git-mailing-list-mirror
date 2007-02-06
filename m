From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 11:20:40 +0100
Message-ID: <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	 <eq6tj6$80m$2@sea.gmane.org>
	 <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
	 <20070205194508.GD8409@spearce.org>
	 <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
	 <20070205225505.GA9222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 11:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HENRU-0002fe-GA
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 11:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbXBFKUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 05:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXBFKUn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 05:20:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:11410 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbXBFKUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 05:20:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1561650uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 02:20:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YP77AbqYpsaUajlHqAByXMYP5XAcKsSvYSTnqY/nC+SeqpOveh+9hkcwOhR19Q69LgBYkmAU7mbAzIRfSGyEA/u2vDxzP8kF//xPNArPi1P7AtPzrlOdjz1UYxW5M2/a5vL1Ozj0plqdlGZiuwS5aUPmFe7xGAZD5ENHAgHEwrQ=
Received: by 10.78.203.13 with SMTP id a13mr1564780hug.1170757240563;
        Tue, 06 Feb 2007 02:20:40 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 02:20:40 -0800 (PST)
In-Reply-To: <20070205225505.GA9222@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38831>

On 2/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 2/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > >I use it daily.  Mainly `git log origin/master@{1}..origin/master`
> > >to see what has come in from Junio since my last fetch.  The @{n}
> > >syntax has (for me) been one of its best features.  (Thanks Junio!)
> >
> > It looks and smells like a useful feature. I just haven't found
> > any use for it yet. Besides all the good, it's another part of a repo
> > needing maintenance (constantly growing thing, like /var/log).
>
> `git gc` is your friend.  It automatically trims the reflogs, keeping
> only the last 90 days worth of entries.  You can tune this with the
> `gc.reflogexpire` configuration parameter.

git gc (repack -d of it) is too dangerous in a shared repo: it breaks
the repos which depend on the master repository, have sent (by some
means) some objects over to the master, and accidentally removed
the reference, and were pruned afterwards.
I'm not saying git gc is bad, I'm just saying you can't use it
whenever and wherever you want. Sometimes you'd prefer
to only expire logs, only pack refs or only repack. And if I
have no logs, I can't forget to trim them.

> So its not a constantly growing thing; you can at least bound it
> by time.

No, I can't. git gc and reflog --expire can. I have to call them.
And I don't think trimming the logs automatically is a good
idea: 90 days of commits can be a very long file on a busy repository.
Add to that slow disks and stupid OS (the worst case, which matters),
and you get a very annoyed user (if he was just angry before, having
to use the drive and OS, he'll definitely go berserk now).

> > >If the reflog code did fail to record something, and you needed it,
> > >and you hadn't git-prune'd yet, git-fsck would list the dangling
> > >commit.  And a copy-n-paste session with `git-log -p D --not --all`
> > >in another xterm would help you navigate what the dangling commits
> > >were.
> >
> > Yes, of course. I somehow missed it. Shows how often one does
> > git-fsck in cygwin, doesn't it?
>
> :-)
>
> Actually I have need for git-fsck too often on Cygwin; one of
> my coworkers looses objects all of the time in his repository.
> I think his harddrive is failed.  The zlib CRC checking we put into
> pack-objects saved his bacon when it failed to repack his repository
> with corrupt objects.

Never had that, can be hardware problem.

What I meant is that it takes too long and I just avoid running
fsck unless I am forced to.
