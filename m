From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: MinGW port updated to GIT 1.5.0
Date: Thu, 15 Feb 2007 20:41:31 +0100
Organization: Dewire
Message-ID: <200702152041.31220.robin.rosenberg.lists@dewire.com>
References: <45D44FD5.72299A3A@eudaptics.com> <7vire3co5s.fsf@assigned-by-dhcp.cox.net> <7v7iujckmv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 20:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHmUj-0003hP-DR
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 20:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbXBOTl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 14:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbXBOTl5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 14:41:57 -0500
Received: from [83.140.172.130] ([83.140.172.130]:2521 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1161070AbXBOTl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 14:41:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A424A803393;
	Thu, 15 Feb 2007 20:37:00 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08277-06; Thu, 15 Feb 2007 20:37:00 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2CE49803392;
	Thu, 15 Feb 2007 20:36:58 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7v7iujckmv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39845>

torsdag 15 februari 2007 19:59 skrev Junio C Hamano:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Johannes Sixt <J.Sixt@eudaptics.com> writes:
> >
> >> .... The general idea is to extend the meaning of
> >> `core.filemode = false` to check out symbolic links as plain files. Any
> >> hints about where the source code needs changes are welcome.
> 
> I might have misread the above but I do not think linking
> core.filemode and the symlink munging is the right way.  Another
> per-repository core.symlink = yes/no (which defaults to yes for
> others and no on filesystems without symlinks) would be more
> appropriate, as it allows Cygwin to continue using symlinks
> where it can, and UNIX folks to try it out.
> 
> I take by "checking out as plain files" you mean instead of
> calling symlink(2) you would write(2) it out.
> 
> I think that would be Ok from git's side.  Just like we use
> executable bit from the index to "fix" what we read from the
> filesystem (e.g. look for trust_executable_bit in diff-lib.c)
> when core.filemode is set, you would munge st.st_mode and
> pretend as if your lstat() said "RelNotes", which should be a
> symlink but you checked out as a regular file, said it is a
> symlink, using what is in the index.
> 
> However, I am not so sure if we can do better to help Windows
> people.  They have what they call "ShortCut", which to me feels
> like what they use for what symlinks are used for.  I do not
> know if it is possible (I do not even know doing so would make
> life easier for Windows people) but perhaps a symlink can be
> "checked out" as a ShortCut?

Since cygwin used shortcuts for exactly this purpose, why not (in principle). 
In practice it is  not the same however, since shortcuts aren't transparent to 
applications. Only apps that explicitly understand shortcuts can make any use 
of the, like the Explorer, and cygwin application since cygwin hide the 
things. The (presumed) lack of support in Win32 for these makes it harder to 
support them. 

A little feared commercial Git "alternative" uses copies and. You 
cannot "check out" a symbolic link, only the "real" file. Depending on how 
you access the repository the copies get updated automatically (virtual file 
system) or through an explicit update command. This is more compatible with
native applications since alla apps can then "read" the symbolic links just as 
if they are normal files. Checking in could be interesting since one has to 
decide which copy to consider, or only consider the one that is checked in as 
a non-link.

Some extra commands like git-ln and git-chmod could help in overcoming some of 
the cross platform obstacles.

-- robin
