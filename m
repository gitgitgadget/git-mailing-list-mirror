From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Wed, 28 Jun 2006 14:24:37 -0700
Message-ID: <7vbqsdynvu.fsf@assigned-by-dhcp.cox.net>
References: <20060628183557.GA5713@fiberbit.xs4all.nl>
	<7vr719159v.fsf@assigned-by-dhcp.cox.net>
	<20060628190814.GC5713@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Jun 28 23:24:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvhWc-0001pS-Mo
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 23:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWF1VYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWF1VYk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 17:24:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48638 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751549AbWF1VYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 17:24:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628212439.SMYH27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 17:24:39 -0400
To: Marco Roeland <marco.roeland@xs4all.nl>
In-Reply-To: <20060628190814.GC5713@fiberbit.xs4all.nl> (Marco Roeland's
	message of "Wed, 28 Jun 2006 21:08:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22825>

Marco Roeland <marco.roeland@xs4all.nl> writes:

> Even for Linux someone mentioned that probably i386 is the exception in
> _not_ needing the -fPIC linkage. It might even be specific to the Perl
> "xs" implementation specifics?

USE_PIC is for pleasing Perly git and nothing else right now.

> So I should have added "Works for me (TM)"! ;-)

That would have been more explicit way to tell me that this is a
partial solution and I should solicit help from people on other
platforms.

By the way, I had an impression that compiling things with -fPIC
when not necessary was generally a bad idea from performance
point of view.  If that is the case we might want to compile,
under USE_PIC, everything with -fPIC in a separate area to
compile and link with Git.xs, without affecting the C-only core
code.

I suspect this would largely depend on the architecture.  I ran
git-fsck-objects compiled with and without -fPIC (after "make
clean" to rebuild everything) on a fully packed copy of the
linux-2.6 repository on my x86_64 box, and did not see
meaningful differences:

: gitster; /usr/bin/time ../git.junio/git-fsck-objects-no-pic --full
109.71user 5.01system 1:54.89elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (14major+1834967minor)pagefaults 0swaps
: gitster; /usr/bin/time ../git.junio/git-fsck-objects-with-pic --full
109.05user 4.97system 1:54.08elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1834981minor)pagefaults 0swaps
: gitster;
