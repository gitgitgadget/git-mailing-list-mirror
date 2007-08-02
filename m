From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 02 Aug 2007 19:08:02 +0100
Message-ID: <46B21D82.5020802@ramsay1.demon.co.uk>
References: <200708010216.59750.jnareb@gmail.com>	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>	<20070801092428.GB28106@thunk.org> <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 20:09:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGf7C-0001Ha-Hi
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 20:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbXHBSJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 14:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbXHBSJY
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 14:09:24 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1810 "EHLO
	anchor-post-33.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755108AbXHBSJX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 14:09:23 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1IGf6q-000Epd-C3; Thu, 02 Aug 2007 18:09:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54580>

Junio C Hamano wrote:
> Are you suggesting to make -l the default for local, in other
> words?  I personally do not make local clone often enough that I
> am not disturbed having to type extra " -l" on the command line.
> 
> But giving a way to force "copy not hardlink" while still
> avoiding "the same as the networked case by doing pack transfer"
> overhead may be a good thing to do.
> 
> Perhaps if the destination is local,
> 
>          - if -s is given, just set up alternates, do nothing else;
>          - by default, do "always copy never hardlink";
>          - with -l, do "hardlink if possible";
> 
> Hmmmm...
> 

About six weeks ago, I finally got around to installing Linux (ubuntu 7.04)
on my laptop. Naturally, I cloned my sparse and git repositories over from
the Windows XP partition. Unfortunately, that left me with a sparse repo that
I could not modify; during the clone cpio copied the object directory, with
perhaps a little too much fidelity, which resulted in a .git/objects tree
with 555 permissions (both files and directories). [It also set the file
timestamps with utime(), BTW]. A quick chmod fixed it up without problem,
but still ...

When I cloned the git repo, however, I forgot the -l parameter and git-clone
effectively did a "git-fetch-pack --all -k $repo", leaving me with a
working, and fully repacked, repository. Nice.

So, I was about to suggest that when invoked with -l, if the object database
cannot be linked, due to EXDEV for example, it should fall back to the
"fetch-pack" behaviour. Since I don't have access to a large repo, I can't
compare the filesystem-copy time versus the fetch-pack time for a "realistic"
repo, but I suppose the copy would always be faster. Oh Well.

Just a data point.

ATB,

Ramsay Jones
