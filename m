From: "Ollie Wild" <aaw@google.com>
Subject: Re: git-svn fetch failure: index.lock file exists
Date: Sun, 25 Nov 2007 23:59:46 -0800
Message-ID: <65dd6fd50711252359y301aa775mc60cadbc59b682d0@mail.gmail.com>
References: <65dd6fd50711151607x50639232w6d79322129c3d82@mail.gmail.com>
	 <20071117211549.GC31598@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwYt4-0004AM-TZ
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbXKZH7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 02:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbXKZH7z
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 02:59:55 -0500
Received: from smtp-out.google.com ([216.239.33.17]:21649 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbXKZH7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 02:59:54 -0500
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id lAQ7xlsH028168
	for <git@vger.kernel.org>; Mon, 26 Nov 2007 07:59:48 GMT
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=JpT8/rmA9ZQoQTbO/6iwLcOOXMazZp6Y6iakXD1IpWi0NNmX9WmbtzD177GRcN7PK
	wMRDfB+7tY/XhUtPRjV/A==
Received: from py-out-1112.google.com (pyia29.prod.google.com [10.34.253.29])
	by zps37.corp.google.com with ESMTP id lAQ7xA1I006879
	for <git@vger.kernel.org>; Sun, 25 Nov 2007 23:59:46 -0800
Received: by py-out-1112.google.com with SMTP id a29so1431277pyi
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 23:59:46 -0800 (PST)
Received: by 10.35.91.1 with SMTP id t1mr3016346pyl.1196063986532;
        Sun, 25 Nov 2007 23:59:46 -0800 (PST)
Received: by 10.35.106.4 with HTTP; Sun, 25 Nov 2007 23:59:46 -0800 (PST)
In-Reply-To: <20071117211549.GC31598@mayonaise>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66051>

Thanks, Eric.  I managed to get things working before your response
which means that (a) I'm a bit fuzzy on what I did and (b) I didn't
record all the various messages that might be useful for debugging.

I ended up having to delete the entire .git/svn/libbid-last-merge
directory, as the fetch failed even with the lockfile removed.  After
that, git-svn fetch retrieved a lot of old changes which had already
been synched before but seems to have gotten itself back into a
consistent state.

As for whether or not I interrupted  a previous fetch, it's possible,
but I don't remember doing so.  I'd been doing mostly rebases against
the trunk, though, so any corruption could have occurred some time
back.

If I run into any more problems, I'll let you know and provide more
detailed feedback about the types of errors I'm seeing and the steps
required to correct it.  Otherwise, I'll chalk this up to a one-off
failure due to a poorly timed interrupt.

Ollie

On Nov 17, 2007 1:15 PM, Eric Wong <normalperson@yhbt.net> wrote:
>
> Ollie Wild <aaw@google.com> wrote:
> > Hi,
> >
> > I've been using git-svn for a while now to work on gcc.  Last night, I did a
> >
> >   git svn fetch
> >
> > and got the following failure:
> >
> >   Found possible branch point: svn+ssh://aaw@gcc.gnu.org/svn/gcc/trunk =>
> >       svn+ssh://aaw@gcc.gnu.org/svn/gcc/tags/libbid-last-merge, 128810
> >   Found branch parent: (tags/libbid-last-merge)
> >       789aa951bbc6a49f791bf5109136335fc33222c5
> >   fatal: unable to create
> > '.git/svn/tags/libbid-last-merge/index.lock': File exists
> >   read-tree 789aa951bbc6a49f791bf5109136335fc33222c5:
> >       command returned error: 128
> >
> > Naively, it looks to me like I've just got a stale lock file from a
> > previous run.  However, I have no idea what the correct recovery
> > strategy is.  Can I just delete the lock file?  Do I need to do some
> > sort of data validation?
> >
> > I'm using git version 1.5.2.5 with subversion version 1.4.5 (r25188).
>
> Did you interrupt git-svn in a previous run?  But you should be able to
> just remove it; git-svn should verify that the index is in a consistent
> state before it attempts to fetch again.
>
> --
> Eric Wong
>
