From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Tue, 6 Nov 2007 22:09:25 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106210925.GJ6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de> <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVgD-0003Fz-Ek
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXKFVJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbXKFVJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:09:28 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:52301 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbXKFVJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:09:28 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id EE9B940000482;
	Tue,  6 Nov 2007 22:09:26 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63728>

Hello Junio,

* Junio C Hamano wrote on Tue, Nov 06, 2007 at 09:46:35PM CET:
> All missing Signed-off-by: lines.

Oops.  Sorry.

> [1/5] In addition to take advantage of the fact that the RHS of
>       assignment is not split, I'd prefer replacing `` with $()
>       with these cases.	 Much easier to read if your shell
>       supports it (and all the modern ones do).

OK.

> [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
>       would want to get Yays from people with non GNU sed.  Is
>       busybox sed good enough to grok our scripts these days?
>       Please ask help and collect Acks at least from folks on
>       Solaris, MacOS, FBSD, and OBSD.

FWIW, I have little experience with busybox sed, but for the others here
you go:  With

echo axbyc | sed 's,x,\n,; s,y,\
,'

I get on OpenBSD, FreeBSD, Solaris, and Darwin (minus indentation):
  anb
  c

GNU sed gives
  a
  b
  c

> [3/5] Arithmetic expansion.  Have you caught _all_ of them, or
>       is this patch about only the ones you noticed?

I have grepped *.sh.  But let's drop that, I see that it goes backwards.

> [4/5] I wonder if use of fgrep would be easier to read and more
>       portable with this one:
> 
> 	name=$( GIT_CONFIG=.gitmodules \
> 		git config --get-regexp '^submodule\..*\.path$' |
> 		fgrep "submodule.$1.path" |
> 		sed -e 's/^submodule\.\(.*\)\.path$/\1/'
> 	)

Certainly easier to read.  But fgrep itself is not portable (it could be
grep -F).  Also, isn't the $1 to be matched at the end, after a "="
here?  FWIW the pattern I posted has survived a few years in Automake,
so there is some hope that it works.

> [5/5] Again, have you covered all of them?

No, oops again.  As I searched for `test.*-[oa]' I have missed line
wraps and [ ... -o ... ].

>       I am not opposed to
>       this one, although I am a bit curious who lacks -a/-o in
>       practice.

Hmm, good question.  I actually don't know whether there is a shell
that isn't ruled out by $() anyway.  Let's drop that one, too, then.

Cheers,
Ralf
