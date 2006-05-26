From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory
 leaks
Date: Thu, 25 May 2006 22:20:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605252204590.5623@g5.osdl.org>
References: <11482978883713-git-send-email-martin@catalyst.net.nz> 
 <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
 <46a038f90605251742p2435ae23k8bfbb98409a30c1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Fri May 26 07:21:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjUlg-0006YL-BK
	for gcvg-git@gmane.org; Fri, 26 May 2006 07:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWEZFVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 01:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWEZFVN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 01:21:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030434AbWEZFVN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 01:21:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4Q5Ke2g024252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 May 2006 22:20:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4Q5Kdgw023511;
	Thu, 25 May 2006 22:20:39 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605251742p2435ae23k8bfbb98409a30c1c@mail.gmail.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20793>



On Fri, 26 May 2006, Martin Langhoff wrote:
> 
> Call me slow, but I am still running and rerunning that gentoo import. ;-)

I'm doing it too, just for fun.

Of course, since I'm doing this on a machine that basically has a laptop 
disk, the "just for fun" part is a bit sad. It's waiting for disk about 
25% of the time ;/

And it's slow as hell. I really wish we could do better on the CVS import 
front. 

> The current import has reached ~200K commits, and .git is 450MB, while
> the checked out tree is 230MB (680MB with .git). At this stage, git
> repack -a -d is too memory hungry.

I've got 2GB in that puppy, and "repack -a -d" is fine for me. I'm not 
quite up to 200k commits yet (I'm at 160k), but the repacking is certainly 
faster than the rest of the import.. Gaah. 

It's "git-rev-list --objects" that is the memory sucker for me, the 
packing itself doesn't seem to be too bad.

The biggest cost seems to be git-write-tree, which is about 0.225 seconds 
for me on that tree on that machine. Which _should_ mean that we could do 
4 commits a second, but that sure as hell ain't how it works out. It seems 
to do about 1.71 commits a second for me on that tree, which is pretty 
damn pitiful. Some cvs overhead, and probably some other git overhead too.

(That's a 2GHz Merom, so the fact that you get ~6k commits per hour on 
your 2GHz Opteron is about the same speed - I suspect you're also at least 
partly limited by disk, our numbers seem to match pretty well).

200k commits at 6k commits per hour is about a day and a half (plus the 
occasional packing load). Taking that long to import a CVS archive is 
horrible. But I guess it _is_ several years of work, and I guess you 
really have to do it only once, but still.

			Linus
