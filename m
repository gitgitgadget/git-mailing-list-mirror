From: Joe Brenner <doom@kzsu.stanford.edu>
Subject: Re: Advice on choosing git
Date: Wed, 12 May 2010 17:18:07 -0700
Message-ID: <201005130018.o4D0I7iI079145@kzsu.stanford.edu>
References: <4BEA4B46.6010009@smartmediacorp.com>
Cc: git@vger.kernel.org
To: Noah Silverman <noah@smartmediacorp.com>
X-From: git-owner@vger.kernel.org Thu May 13 02:18:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCM84-0000fr-GU
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 02:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab0EMASP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 20:18:15 -0400
Received: from smtp3.Stanford.EDU ([171.67.219.83]:49516 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755902Ab0EMASO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 20:18:14 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 422A11A071F;
	Wed, 12 May 2010 17:18:14 -0700 (PDT)
Received: from kzsu.stanford.edu (KZSU.Stanford.EDU [171.66.118.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 752621A0717;
	Wed, 12 May 2010 17:18:12 -0700 (PDT)
Received: from kzsu.stanford.edu (localhost.stanford.edu [127.0.0.1])
	by kzsu.stanford.edu (8.13.4/8.13.7) with ESMTP id o4D0I7iI079145;
	Wed, 12 May 2010 17:18:12 -0700 (PDT)
	(envelope-from doom@kzsu.stanford.edu)
In-reply-to: <4BEA4B46.6010009@smartmediacorp.com>
Comments: In-reply-to Noah Silverman <noah@smartmediacorp.com>
   message dated "Tue, 11 May 2010 23:31:34 -0700."
X-Mailer: MH-E 8.2; nmh 1.2; GNU Emacs 24.0.50
X-Scanned-By: MIMEDefang 2.56 on 171.66.118.47
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (kzsu.stanford.edu [127.0.0.1]); Wed, 12 May 2010 17:18:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146970>


Noah Silverman <noah@smartmediacorp.com> wrote:

> I'm looking for both a version control system and backup system.

I had a similar thought some time ago.  I thought that putting my life
inside of a distributed version control system (my first thought back
then was Monotone) would also be a convienient way to handle the
laptop-workstation sync problem.

But:

> 1) Size.  THIS IS MY MAIN CONCERN - If I want to sync my home, office,
> and server Document directories.  From what I have read, I will
> effectively have multiple copies of each item on my hard drive, thus
> eating up a lot of space

Pretty much any version control system is going to have this problem,
and it gets really bad if you've got any files that aren't straight text.

You won't get any benefit out of things like "git diff" either.  The
diffs we have (these days at least) don't work well on anything but plain
text.

I suggest you stick to using git down on the project level, where a
project should be limited to things like code development (or writing
projects where you stick to text formats), and give up on any ideas like
putting your entire home directory into a single repository.

As far as mirroring machines go, rsync based solutions actually aren't
that bad, though in addition to the annoying syntax gotchas, I've had
problems with an unreliable laptop clock.  Lately I've been using the
"--size-only" option of rsync, which assumes that if a file is bigger
it must be newer.

I tend to use a perl script something like this, which copies newer
stuff from a given directory to an analogous directory on a remote
machine:

  use File::Basename qw( dirname );
  my $this  = shift;   # e.g. '/home/doom/dev/code
  my $there = shift;   # e.g. 'doom@192.168.1.3'
  my $this_loc = dirname( $this );
  $cmd = "rsync -avz --size-only -e ssh $this $there:$this_loc";
  system( $cmd );
