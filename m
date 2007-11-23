From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Thu, 22 Nov 2007 23:23:37 -0200
Message-ID: <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
	 <fi5743$32p$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711230050270.27959@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 02:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvNGv-0007IR-NI
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 02:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbXKWBXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 20:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbXKWBXk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 20:23:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:63495 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbXKWBXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 20:23:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3336215wah
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Z+F2BHxSzc3OJ+xXC/KWh4YAvHl9WvSXWQQu6FReP/I=;
        b=CVoGxIBUJlxjMmjvjbnKEHhboETEE2mPA9EK4qyHPEUCv6M0mOfeIC0RwgLQMRvwB2Kqkd0qEuXqhN/CS+2wph2thKp1fOzpS33qutj54rOq1wndl7akCgtAE8P4M6Ud6BXLTyeNSWlo9N9nlWiwN/ZZMypX9Ki+bhFzk5f3xAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cDiGyk0zbzXGVFDWC5SmRSDSHnrXrE5VN+QG+H2x5km2BhNzUB+EkTC4HJ04gqEXsbMTrWcsatB5ZZxS9TNxed5/LmA8P1b1IaHZAdwprww5LUfKY8DlQCSNT1mSzs6zspOZ93/Qj7zrBc+37pT5tl3uQAVKbJlwPb3nlqUle5E=
Received: by 10.114.88.1 with SMTP id l1mr596208wab.1195781017272;
        Thu, 22 Nov 2007 17:23:37 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Thu, 22 Nov 2007 17:23:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711230050270.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65867>

2007/11/22, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > The cool thing about git-fast-import is that it reads from stdin, has a
> > very easy to use programmatic interface, and does not impose any order
> > on how you enter the information.
> >
> > This doesn't seem to be mirrored by this script?
>
> Umm.  What exactly do you want to reorder?  I mean, this program is meant
> to dump the complete contents to stdout (whether you redirect it to a file
> or edit it with sed does not concern this program).  It does that.

fast-import does not need to take a complete repository as input, but
can also update lots of branches incrementally, all from one process.
Likewise, it would be nice to have a program  that can also dump small
bits of information.

Maybe I'm misunderstanding you, but fast-export just does not seem a
mirror of fast-import; perhaps you can name it 'dump-all' or
something?

> Maybe you want to specify if all blobs should be output first, and then
> the commits?  Or files should be used?  But all of these things seem to be
> useless to me.

No, I want the program to wait for me to tell it what
blobs/commits/trees I want. The commit I want to see secondly may
depend on the output I read in the first request blob. Right now, for
each data dependency I have to start a new git process.

> > Besides being a nuisance, I actually run git on NFS, and every git
> > process has to go to NFS a couple times to retrieve the same
> > information. This has a noticeable performance impact.
>
> Why don't you just work on a local clone?  If it is really performance
> critical, and I/O is an issue, you are better off working in a tmpfs.

In a company setting, NFS is the easiest way to share information with
colleagues without breaking access control and making our security
staff nervous.  It's also snapshotted and backed up automatically.

> > It would make my life a lot easier if I could simply open a pipe to a
> > single process for the duration of the script, and do all my queries to
> > this one process.  Of course, if the repository is changed by another
> > process, I would have to restart it, but that's manageable.  I could
> > even write a nice Python class that runs both fast-import and
> > fast-export. I could then have an efficient Python interface to a
> > git-repository, without needing any library wrapping.
>
> There is a minimal python wrapper to libgit-thin, which was one of our
> GSoC projects.  You might want to look at this if you are really that
> unhappy with the existing framework.

What's the status of this?  I prefer not to diverge from mainline too much.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
