From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Thu, 23 Feb 2006 23:55:47 +0100
Message-ID: <20060223225547.GB8673@c165.ib.student.liu.se>
References: <11404323692193-git-send-email-ryan@michonline.com> <20060220234054.GA7903@c165.ib.student.liu.se> <20060223221048.GA6423@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 23:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCPNO-0003Do-LF
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 23:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWBWWzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 17:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWBWWzz
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 17:55:55 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:42961 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751803AbWBWWzy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 17:55:54 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C33A64118; Fri, 24 Feb 2006 00:10:33 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FCPND-0002TC-00; Thu, 23 Feb 2006 23:55:47 +0100
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20060223221048.GA6423@mythryan2.michonline.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16673>

On Thu, Feb 23, 2006 at 05:10:49PM -0500, Ryan Anderson wrote:
> (Biased critique since I have the other tool in the tree, but still...)
> 
> > +    FILE* fout = fopen("/tmp/git-blame-tmp1", "w");
> 
> Probably should be using something like mkstemp (mkstmp?) here, so if
> someone is runnign things as root or with a malicous user around, things
> don't collide.
> 
> Hell, so on a multi-user machine this doesn't blow up on you.

Yep, I know. The code is mostly a proof of concept. I didn't submit it
for inclusion.


> 
> But, read down for a related comment.
> 
> > +    if(!fout)
> > +        die("fopen tmp1 failed: %s", strerror(errno));
> > +
> > +    if(fwrite(info_c->buf, info_c->size, 1, fout) != 1)
> > +        die("fwrite 1 failed: %s", strerror(errno));
> > +    fclose(fout);
> > +
> > +    fout = fopen("/tmp/git-blame-tmp2", "w");
> > +    if(!fout)
> > +        die("fopen tmp2 failed: %s", strerror(errno));
> > +
> > +    if(fwrite(info_o->buf, info_o->size, 1, fout) != 1)
> > +        die("fwrite 2 failed: %s", strerror(errno));
> > +    fclose(fout);
> > +
> > +    FILE* fin = popen("diff -u0 /tmp/git-blame-tmp1 /tmp/git-blame-tmp2", "r");
> > +    if(!fin)
> > +        die("popen failed: %s", strerror(errno));
> 
> Can't git-diff-tree do this sufficiently, anyway?  See my Perl script
> for an example, you just need both commit IDs and both filenames and the
> appropriate -M and you get the right results.
> 
> (It's possible that's part of where the performance differences are,
> though, not really sure at the moment.)
> 

Yeah.. maybe. My first thought was to avoid forking and execing diff
and use some C library for doing the diffing instead (libxdiff). But
then I just wanted to get some code working and the simplest solution
I could think of was to fork and exec diff.

> I'm going to stop there for the moment, I'm not really confident in my
> understanding of git-internals to say much more just yet.
> 
> This could probably benefit a *LOT* from the libification project, I
> think, though.

Yes, perhaps. Some of the git-rev-list bits might simplify a couple of
things.

I have found some severe problems with the code I posted, in
particular it doesn't handle parallel development tracks at all. I am
working on fixing it, but it isn't finished yet.

Thanks for the comments.

- Fredrik
