From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Fri, 11 Jul 2008 22:22:15 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112215050.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com> <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:23:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQ5D-0000VG-Je
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbYGKVWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYGKVWR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:22:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:52151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751698AbYGKVWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:22:16 -0400
Received: (qmail invoked by alias); 11 Jul 2008 21:22:14 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp057) with SMTP; 11 Jul 2008 23:22:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vVbULHe+v9d1B3fyQqq9r2xIuHduh6QcVBXB1kI
	sq68UXRY965Bdr
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88176>

Hi,

On Fri, 11 Jul 2008, Sverre Rabbelier wrote:

> I temporarily modified the code to output %04d instead of %4d so that I 
> could do the following:
>
>	 $ stats.py author -a > full_activity_sortable.txt

You might be delighted to read up on the "-n" switch to sort(1).

> A few highlights from the sorted file:
> 
> $ cat full_activity_sortable.txt | sort | tail -n 20

More intuitive would have been "sort -r | head -n 20", I guess.

> 0170:  2721+  1060- = refs.c

I guess that 170 is the total number of commit touching that file, the "+" 
and "-" numbers the changes respectively?

I think quite a lot of our changes do code moves; this should be accounted 
for differently.

> 0172:  4369+  2004- = builtin-pack-objects.c
> 0177:   345+   233- = GIT-VERSION-GEN
> 0178:  2855+  2121- = commit.c
> 0178:  4779+  2227- = fast-import.c
> 0179:  2677+  1400- = read-cache.c
> 0185:  5661+  2056- = builtin-apply.c
> 0186:  3269+  1255- = revision.c
> 0213:  1884+   460- = Documentation/config.txt
> 0232:  2257+  1621- = Documentation/git.txt
> 0236:  3990+  1991- = contrib/fast-import/git-p4
> 0281:  2753+  2220- = git.c
> 0333: 10259+  7150- = git-gui.sh
> 0338: 11337+  6187- = git-svn.perl
> 0338:  5755+  3159- = sha1_file.c
> 0397: 10230+  9599- = diff.c
> 0412: 23248+ 20257- = gitk
> 0432: 10580+  4502- = gitweb/gitweb.perl
> 0490:  1412+   619- = cache.h
> 0977:  4703+  2705- = Makefile
> 
> $ cat Makefile | wc -l
> 1482
> 
> For some reason you people can't seem to make up your mind about a
> file that's not even 1500 lines in size ;).

Heh.  We might need to change it once or twice, in the future.

> A note is in order here, this data was mined with "git log --num-stat"
> so things like moving files and copying files are not accounted for.

In my opinion it would be even more interesting to see code moves (i.e. 
not whole files).  For example, we moved some stuff from builtins into the 
library.  The real change here is not in the lines added and deleted.

> I thought about using git-blame to gather this info before, but it is 
> not the right tool for the job. If anyone else has any idea's on what 
> would be better please let me know and I'll happily dig into it :).

I think that you need to analyze the diff directly.  One possible (quick 
'n dirty) way would be to cut out long consecutive "+" parts of the hunks, 
replace the "-" by "+", and use "git diff --no-index" to do the hard part 
of searching for that code in the "-" part of the original diff.

If that turns out to be useful, we can still think about a proper API 
using xdiff.

Just an idea,
Dscho
