From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 23:08:43 +0100
Message-ID: <20060119220843.GA3601@steel.home>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <81b0412b0601190242m4792e73bg181172e478b6e0c2@mail.gmail.com> <20060119183143.GB27888@trixie.casa.cgf.cx>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 23:09:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezhxx-0001Ab-Kk
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 23:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161452AbWASWI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161457AbWASWI7
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 17:08:59 -0500
Received: from devrace.com ([198.63.210.113]:25101 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1161455AbWASWI6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 17:08:58 -0500
Received: from tigra.home (p54A05B54.dip.t-dialin.net [84.160.91.84])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0JM8kUu018465;
	Thu, 19 Jan 2006 16:08:47 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EzhxU-00041A-00; Thu, 19 Jan 2006 23:08:44 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EzhxT-0001jX-R7; Thu, 19 Jan 2006 23:08:43 +0100
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060119183143.GB27888@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14938>

Christopher Faylor, Thu, Jan 19, 2006 19:31:43 +0100:
> >>"They" probably don't like it when people treat an open source project
> >>as if it was some unresponsive proprietary enterprise which does not
> >>listen to or accept patches.
> >Please, accept my appologies for the sarcasm in the original post.
> >Sometimes I get an impression of cygwin being not maintained at all,
> >and that, if not justifies my behavior, but at least is an attempt to
> >explain it.
> 
> Hmm.  I thought we'd already dispelled the myth that cygwin is
> unsupported in this very mailing list.  That is an odd impression given
> the fact that you were complaining about behavior in a version of cygwin
> which was released on Monday but, apology accepted.

It was my first update since a long time (which BTW broke some
programs like cp: they missed symbols in cygwin1.dll).

> If you want to see evidence of continual cygwin development, you can always
> visit this page:  http://cygwin.com/snapshots/ .  This page has snapshots
> of cygwin built from cvs.  We make these available so that people will check
> things out prior to an actual release.

Thanks.

> >>>And on top of that, they removed dirent->d_ino (or probably replaced it
> >>>by __ino32, if at all).  BTW, can we somehow avoid using d_ino?  It is
> >>>referenced only in fsck-objects.c Anyway, to workaround this I put
> >>>
> >>>COMPAT_CFLAGS += -Dd_ino=__ino32
> >>>
> >>>It helps, but surely is not the solution.
> >>
> >>I don't see how it could help since __ino32 is not actually filled in
> >>with anything.  In fact, I'll rename the field to __invalid_ino32 to
> >>make that clear.
> >
> >But why keep the DT_-macros?! And why there is two fields hinting at
> >d_ino, and why there is 3 (!)
> 
> The default entry (i.e., the one you get without defining
> __INSIDE_CYGWIN__ or __CYGWIN_USE_BIG_TYPES__) in dirent.h is the
> correct one.

Maybe it'd be a good idea just to remove the definitions? Or, as
__INSIDE_CYGWIN__ implies, move them into cygwin internal sources.
Would be less confusion and no chance of someone defining one of the
macros and getting a binary-incompatible object?

> >"struct dirent" definitions in dirent.h (sys/dirent.h)?  Some with
> >different names (d_reserved?).  And if cygwin is aiming for posix, what
> >would d_fd or d_version be (Open Group Specs v6[1] mention only d_ino
> >and d_name)?
> >
> >[1]
> >http://www.opengroup.org/onlinepubs/009695399/basedefs/dirent.h.html
> 
> Hmm.  On linux, my /usr/include/bits/dirent.h has a d_reclen field in
> dirent.  I know what that is and what it is used for but it's not
> mentioned, that I can see, in SUSv3.  But, since I don't see anything in
> the description of dirent in SUSv3 which says that the must have only
> the fields mentiond, that's ok.

Of course, you don't have to. It all about making an impression

> In any event, we don't claim to be POSIX compatible.  We actually are
> working for linux compatibility but this is one regrettable place where
> Windows doesn't allow that.

The word was "aiming"

> Anyway, I understand why the DT macros would cause problems and I have
> removed them from the current CVS.  I don't see why the existence of
> extra fields in dirent or why other non-default definitions would
> cause any problems other than the "Doctor, doctor, it hurts when I
> do this" variety.

It is not the existance of the extra fields which cause problems. It
is an existance of fields, the names of which imply a functionality
they do not provide which causes problems. Why should I seeing __ino32
in an official header think: "it is never filled anyway, so I
shouldn't use it"?! Or what could "__invalid_d_ino" mean? If it is
invalid (as in "can't be used", why is it there at all?
