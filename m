From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and u-boot broken.
Date: Fri, 13 Oct 2006 23:28:12 -0700
Message-ID: <20061014062812.GC29149@localdomain>
References: <86slhsgg3f.fsf@blue.stonehenge.com> <00e301c6ef2f$16993ac0$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Randal L. Schwartz'" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 08:28:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYd0T-0007sc-5u
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 08:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWJNG2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 02:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWJNG2P
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 02:28:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40340 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752107AbWJNG2O (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 02:28:14 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BBB9D7DC08E;
	Fri, 13 Oct 2006 23:28:12 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 13 Oct 2006 23:28:12 -0700
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Disposition: inline
In-Reply-To: <00e301c6ef2f$16993ac0$1267a8c0@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28869>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>  
> 
> > -----Original Message-----
> > From: Randal L. Schwartz [mailto:merlyn@stonehenge.com] 
> > Sent: den 13 oktober 2006 21:40
> > To: Joakim Tjernlund
> > Cc: git@vger.kernel.org
> > Subject: Re: git-svn and u-boot broken.
> > 
> > >>>>> "Joakim" == Joakim Tjernlund 
> > <joakim.tjernlund@transmode.se> writes:
> > 
> > Joakim> First, I had to change this (from memory) in git-svn:
> > Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > $self->{pool});
> > Joakim> to
> > Joakim>   my $got;
> > Joakim>   if ( $got ) {
> > Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > $self->{pool});
> > Joakim>   } else {
> > Joakim>     $got = $exp
> > Joakim>   }
> > Joakim> I am no perl programmer so please change as you se fit.

With your correction following merlyn's comments, it could work[1].  I'm
curious as to what change git-svn printed right before hitting an error
here, and would like to see the files (before and after) that were
printed by git-svn.

I'm not sure what change would show up in git but cause apply_textdelta
to return undef...

[1] - I am tempted to apply a change based on yours, but this could just
be working around another bug somewhere else (either in git-svn or
subversion).

> > That doesn't make any sense.  You'll never run the if-true 
> > branch there.
> > The value of $got immediately following "my $got;" is always undef.
> 
> git-pull --squash seems to do what I want but know I get this when
> committing to svn: 
> git-svn commit remotes/git-svn..svn-branch
> ...
>         A       cpu/mpc824x/drivers/i2c_export.h
>         A       cpu/mpc824x/drivers/i2o.h
>         A       cpu/mpc824x/drivers/i2o/Makefile
>         A       cpu/mpc824x/drivers/i2o/Makefile_pc
> Cannot allocate memory at /usr/bin/git-svn line 1462
> 3072 at /usr/bin/git-svn line 547
>         main::commit_lib('2ff9bcb7908d2752f643695ab3a28f9ababfafab') called at /usr/bin/git-svn line 457
>         main::commit('remotes/git-svn..svn-branch') called at /usr/bin/git-svn line 149

How large is the changeset you're committing?
(git show --stat 2ff9bcb7908d2752f643695ab3a28f9ababfafab)

I actually have a fair amount of fork() hacks in git-svn to workaround
leaks in the SVN:: libraries (hard to avoid otherwise in Perl).
I haven't noticed (or looked for) file-descriptor leakage very heard,
though.

Also, which version of git-svn are you running?  Also, which version of
Subversion (client library, and server (if possible) are you running?

There seems to be a lot of new bugreports to git-svn lately and very
little has changed in git-svn the past few months...

-- 
Eric Wong
