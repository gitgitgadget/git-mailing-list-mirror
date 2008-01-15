From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Tue, 15 Jan 2008 22:20:22 +0100
Message-ID: <20080115212022.GC3213@steel.home>
References: <20080114202932.GA25130@steel.home> <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com> <20080115054807.GA3694@steel.home> <a5eb9c330801150721t5da85295heacae2c5a5aad47e@mail.gmail.com> <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEtDO-00035D-0X
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 22:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbYAOVU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbYAOVU3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:20:29 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:8783 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYAOVU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 16:20:28 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolErE4=
Received: from tigra.home (Faa76.f.strato-dslnet.de [195.4.170.118])
	by post.webmailer.de (fruni mo42) (RZmta 15.4)
	with ESMTP id J0403dk0FIXMy8 ; Tue, 15 Jan 2008 22:20:26 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3E275277AE;
	Tue, 15 Jan 2008 22:20:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AEEA856D22; Tue, 15 Jan 2008 22:20:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70562>

Paul Umbers, Tue, Jan 15, 2008 21:12:45 +0100:
> >
> > Does the object exists at all? Try
> >
> >     ls -l .git/d9/b06fceac52f6c24357e6a7f85c601088381152
> >
> > Is it possible to get a hold of this repo (just the .git directly
> > after "git add .")? It would be interesting to see the nature of the
> > corruption.
> >
> git ls (see below) returns nothing - it looks like the object doesn't
> exist at all. I've attached a .zip of the entire test directory (one

zip is a bit lying: it does not keep the attributes of the files the
way cygwin programs see them. For instance, it not known whether the
hooks (.git/hooks) where executable at the time.

> text file plus .git). This is after "git init" followed by "git add ."
> 
> What do you think?

I think it has failed already at "git add". From looking at the code
it is hard for the current git-add (builtin-add.c) to fail silently.

Hmm... What "git version" returns for you? (the .git/config contains
filemode=true, which cygwin breaks every time).

Of course, it would be interesting to know if the current git works
for you. Or the MinGW port:

    http://code.google.com/p/msysgit/downloads/list

It used to conflict with cygwin, though.

If the current git fails, I'd suggest to instrument write_sha1_file in
sha1_file.c and see if it really manages to create temporary file and
rename it to sha1 file (that d9/b06fceac52f6c24357e6a7f85c601088381152).
I suspect either rename or link failing silently (IOW, it fails to
create the new name under objects/d9/ but returns 0(no error) anyway).
