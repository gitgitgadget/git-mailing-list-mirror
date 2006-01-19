From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 16:28:56 -0500
Message-ID: <20060119212856.GA6317@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net> <20060119161000.GA27888@trixie.casa.cgf.cx> <20060119203428.GA5090@trixie.casa.cgf.cx> <Pine.LNX.4.64.0601191309130.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 22:29:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzhL2-0008BT-W6
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWASV26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWASV26
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:28:58 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:7373 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161312AbWASV25 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 16:28:57 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 0E8444A84D5; Thu, 19 Jan 2006 16:28:57 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601191309130.3240@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14934>

On Thu, Jan 19, 2006 at 01:16:17PM -0800, Linus Torvalds wrote:
>On Thu, 19 Jan 2006, Christopher Faylor wrote:
>>Btw, we're looking to roll out a new release of cygwin which fixes the
>>embarrassing typo in sockaddr_storage.  It is fixed in cygwin
>>snapshots:
>>
>>http://cygwin.com/snapshots/
>
>Quick question for cygwin people (I asked this at an earlier point, but
>I don't think there was any reply): would cygwin prefer using "vfork()"
>over "fork()", or is there no advantage?  With vfork(), I could imagine
>that you might avoid a lot of strange VM games..

Sorry, I missed the earlier question.  I have to get in the habit of
scanning this list more regularly for this type of thing.

Cygwin's vfork implementation currently defaults to fork so it doesn't
matter which is used.

We used to have a vfork which tried to cut down on some of the
substantial overhead that comes with cygwin's fork() but the vfork
implementation eventually grew so complicated that there was eventually
no performance gain and I decided to just yank it and revisit it at
a later point.

So, for now, there is no difference, but, eventually, there might be if
someone masters courage to revisit vfork-on-cygwin.

So, I guess that means that it would be a good idea to switch to vfork
if you were planning for the nebulous future when this made a difference
to cygwin.  Otherwise, I wouldn't bother.

>Alternatively, is there anything else we can do that makes things easier?

I'm really committed to making cygwin as much like linux as possible so
that you won't have to make things easier.  The last release added some
stuff which should make building linux easier, in fact.  Also, the
mmap() implementation should be a littler closer to linux.  It is, of
course, a work in progress, though.

The only thing that would speed up process creation in cygwin now is
the use of the windows spawn* family of function calls.  Those could be
used instead of fork/exec but I have a personal aversion to using them
since they are so non-UNIX.  If performance is an issue, however, that
could be something to investigate.

cgf
