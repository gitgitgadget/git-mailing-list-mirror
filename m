From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Tue, 6 Jun 2006 20:40:50 -0400
Message-ID: <9e4733910606061740v797886baif6b1edd969dfab2a@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <9e4733910606022128h23ff94fbg3fcb4fa191254b5a@mail.gmail.com>
	 <46a038f90606052255s62cda81bt62d7442beb26658a@mail.gmail.com>
	 <9e4733910606060813r41037467u74235f7a9386c1e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 02:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnm6Q-0001Tl-Ew
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 02:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWFGAkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 20:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWFGAkv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 20:40:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:2364 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750736AbWFGAkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 20:40:51 -0400
Received: by nz-out-0102.google.com with SMTP id s18so61782nze
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 17:40:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IUKQ9AydQ69Ky47+ChidzI0e/EXxJWA1ACvdIHxVAL+N69QoHdhh98kv2XQVpgeklUpyZWAVaWp22R0QM3QjdbFNrc7kCUc07JigOrXBup9FAbz7mTh9xRsa42Nn4F7UDm96QT/tb+nkzRIIBXBO5+ws3Juw5MgmOjjX6H9VGWI=
Received: by 10.36.39.9 with SMTP id m9mr156242nzm;
        Tue, 06 Jun 2006 17:40:50 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Tue, 6 Jun 2006 17:40:50 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <9e4733910606060813r41037467u74235f7a9386c1e0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21423>

On 6/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/6/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > On 6/3/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > On 6/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > With the attached patch you can parse the entire Mozilla tree. The
> > > > tree has over 100,000 files in it and about 300 branches.
> > >
> > > I was a little low with these counts, more like 110,000 files and some
> > > parts of the tree have 1,000 branches. Total tree size is 3GB.
> >
> > I don't think it really has that many branches. If I am to believe
> > cvsps (which took 3GB to walk the history), it has some branches with
> > recursive loops in their ancestry (MANG_MATH_BRANCH and
> > SpiderMonkey140_BRANCH have eachother as ancestors!?), 197969 commits
> > and 796 branches.

My full import to svn just finished after a day and a half.
Here are the stats:

cvs2svn Statistics:
------------------
Total CVS Files:             99851
Total CVS Revisions:        948580
Total Unique Tags:            1505
Total Unique Branches:        1577
CVS Repos Size in KB:      2725843
Total SVN Commits:          205787
First Revision Date:    Fri Mar 27 21:13:08 1998
Last Revision Date:     Tue May 30 19:28:10 2006
------------------
Timings:
------------------
pass 1:  3602 seconds
pass 2:   227 seconds
pass 3:    66 seconds
pass 4:  1070 seconds
pass 8:124650 seconds
total: 124650 seconds
[jonsmirl@jonsmirl ~]$

[jonsmirl@jonsmirl svn]$ du -h
4.0K    ./svntest/dav
12K     ./svntest/locks
40K     ./svntest/hooks
16K     ./svntest/conf
7.4G    ./svntest/db/revs
808M    ./svntest/db/revprops
4.0K    ./svntest/db/transactions
8.2G    ./svntest/db
8.2G    ./svntest
8.2G    .

[jonsmirl@jonsmirl svn]$ find | wc
 411607  411607 10891057

There are two directories that each contain about 205k files. 205K
files in a single directory is causing svn problems on Ext3.

Bottom line, cvs2svn import tool works quite well. Highest memory
consumption I saw was 100MB and it used 6GB of extra disk while
running plus space need by svn.

I don't know quite enough about git yet to replace the svn commands it
uses with git equivalents but if that were done I think most of the
cvs import problems would be solved. Obviously the svn team has put a
great deal of work into this program.

I don't think replacing the svn commands is very hard, I just haven't
figured out the right way to build branches with low-level git yet and
I don't know Python. I'll bet someone already familiar with git and
cvs import could convert it in a couple of hours.

-- 
Jon Smirl
jonsmirl@gmail.com
