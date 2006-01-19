From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 13:31:43 -0500
Message-ID: <20060119183143.GB27888@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <81b0412b0601190242m4792e73bg181172e478b6e0c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 19:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeZd-0003z2-L6
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWASSbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWASSbo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:31:44 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:64747 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1030314AbWASSbn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 13:31:43 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 0BC8A5A8007; Thu, 19 Jan 2006 13:31:43 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0601190242m4792e73bg181172e478b6e0c2@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14927>

On Thu, Jan 19, 2006 at 11:42:46AM +0100, Alex Riesen wrote:
>On 1/19/06, Christopher Faylor <me@cgf.cx> wrote:
>>"They" probably don't like it when people treat an open source project
>>as if it was some unresponsive proprietary enterprise which does not
>>listen to or accept patches.
>
>Please, accept my appologies for the sarcasm in the original post.
>Sometimes I get an impression of cygwin being not maintained at all,
>and that, if not justifies my behavior, but at least is an attempt to
>explain it.

Hmm.  I thought we'd already dispelled the myth that cygwin is
unsupported in this very mailing list.  That is an odd impression given
the fact that you were complaining about behavior in a version of cygwin
which was released on Monday but, apology accepted.

If you want to see evidence of continual cygwin development, you can always
visit this page:  http://cygwin.com/snapshots/ .  This page has snapshots
of cygwin built from cvs.  We make these available so that people will check
things out prior to an actual release.

>>>And on top of that, they removed dirent->d_ino (or probably replaced it
>>>by __ino32, if at all).  BTW, can we somehow avoid using d_ino?  It is
>>>referenced only in fsck-objects.c Anyway, to workaround this I put
>>>
>>>COMPAT_CFLAGS += -Dd_ino=__ino32
>>>
>>>It helps, but surely is not the solution.
>>
>>I don't see how it could help since __ino32 is not actually filled in
>>with anything.  In fact, I'll rename the field to __invalid_ino32 to
>>make that clear.
>
>But why keep the DT_-macros?! And why there is two fields hinting at
>d_ino, and why there is 3 (!)

The default entry (i.e., the one you get without defining
__INSIDE_CYGWIN__ or __CYGWIN_USE_BIG_TYPES__) in dirent.h is the
correct one.

>"struct dirent" definitions in dirent.h (sys/dirent.h)?  Some with
>different names (d_reserved?).  And if cygwin is aiming for posix, what
>would d_fd or d_version be (Open Group Specs v6[1] mention only d_ino
>and d_name)?
>
>[1]
>http://www.opengroup.org/onlinepubs/009695399/basedefs/dirent.h.html

Hmm.  On linux, my /usr/include/bits/dirent.h has a d_reclen field in
dirent.  I know what that is and what it is used for but it's not
mentioned, that I can see, in SUSv3.  But, since I don't see anything in
the description of dirent in SUSv3 which says that the must have only
the fields mentiond, that's ok.

In any event, we don't claim to be POSIX compatible.  We actually are
working for linux compatibility but this is one regrettable place where
Windows doesn't allow that.

I explained about the DT macros and why we dropped d_ino support in
another message.

Anyway, I understand why the DT macros would cause problems and I have
removed them from the current CVS.  I don't see why the existence of
extra fields in dirent or why other non-default definitions would
cause any problems other than the "Doctor, doctor, it hurts when I
do this" variety.

cgf
