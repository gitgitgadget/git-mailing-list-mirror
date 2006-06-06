From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Tue, 6 Jun 2006 11:13:34 -0400
Message-ID: <9e4733910606060813r41037467u74235f7a9386c1e0@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
	 <46a038f90606052255s62cda81bt62d7442beb26658a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 17:13:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FndFS-00011J-S1
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 17:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWFFPNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWFFPNg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 11:13:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:47642 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932218AbWFFPNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 11:13:35 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1602369nze
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 08:13:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WpYVvMDB/iWahScCqAz/c48t4B87xnxsXdsf2JZa/X8TRmB/tAikblJFPbte2Q6MoFQ1ch7wEETauHbo+XI96hga7I+S8VFgiuqJvV3BQLoBGFUweCmSX3SGyr8iujNPagbC6X7143aTm1hvoKf8xxEm8mbDJn4l10uSBGEQx4Q=
Received: by 10.36.43.12 with SMTP id q12mr4803385nzq;
        Tue, 06 Jun 2006 08:13:34 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Tue, 6 Jun 2006 08:13:34 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606052255s62cda81bt62d7442beb26658a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21379>

On 6/6/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 6/3/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 6/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > With the attached patch you can parse the entire Mozilla tree. The
> > > tree has over 100,000 files in it and about 300 branches.
> >
> > I was a little low with these counts, more like 110,000 files and some
> > parts of the tree have 1,000 branches. Total tree size is 3GB.
>
> I don't think it really has that many branches. If I am to believe
> cvsps (which took 3GB to walk the history), it has some branches with
> recursive loops in their ancestry (MANG_MATH_BRANCH and
> SpiderMonkey140_BRANCH have eachother as ancestors!?), 197969 commits
> and 796 branches.

It probably is 796 and not a 1,000. The branch names were scrolling
across my screen and I just estimated.

> This repository has been mangled quite badly. Don't know what you guys
> did with it, but it sure isn't pretty. I'm working on getting
> git-cvsimport to get through a complete import.

The repository is close to 10 years old and it has gone through a
number of corporate reorgs. Who knows what has happened to it over
that length of time.

Have you looked at the SVN CVS import tool? It imported Mozilla on the
first try. If you download the source they have built about 40 test
repositories with various errors. Those would make a good test suite
for cvsps.  http://cvs2svn.tigris.org

I have been working on converting the svn tool to do git commands but
my git knowledge is limited so it has been slow going. The last stage,
pass 8, is very similar to what the git tools do. The svn commands
just need to be swapped for git ones.

If you get git-cvsimport working I'll use it instead. Will the cvsps
process stay small enough to run on a 32b machine? The svn tools are
very RAM efficient since they use an external db. Can cvsps read from
a local copy of the repository without using a CVS server?

We are going to have to develop some kind of incremental mechanism for
updating the new git tree. It can take up to two days to convert the
repository, Mozilla development can't be shut down that long for a
transition. Git will also need to mirror the CVS repository (check-in
still going to CVS) for a long time while we convince everyone on the
merits of switching.

My imported svn version of Mozilla has a lot of performance problems.
One of the directories has over 200,000 files in it slowing downing
the filesystem. The repository went from 3GB CVS to 8GB svn, probably
due to svn using 1000s of tiny files. I'll look around and see if svn
has a pack feature like git.

-- 
Jon Smirl
jonsmirl@gmail.com
