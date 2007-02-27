From: Junio C Hamano <junkio@cox.net>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 12:22:43 -0800
Message-ID: <7vzm6zcpv0.fsf@assigned-by-dhcp.cox.net>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
	<86odnfr625.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue Feb 27 21:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8qX-0008Mg-Hx
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXB0UWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbXB0UWq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:22:46 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41302 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbXB0UWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:22:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227202243.OXDK6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 15:22:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UkNk1W00A1kojtg0000000; Tue, 27 Feb 2007 15:22:44 -0500
In-Reply-To: <86odnfr625.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Tue, 27 Feb 2007 07:09:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40785>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio> Which is kind of depressing...
>
> Maybe if you looked at who has been reporting the bugs, you'd
> find a different story.  It's quite possible that the "inner
> circle" all used git in a homogeneous way, not performing
> every possible advertised operation, but now that git is being
> used by more people, older bugs are getting revealed because
> people really are using it out there in some nicely unique (or
> perhaps boneheaded :) ways.
>
> Any quick stats on diversity of bug submitters?

I do not know how others noticed them but I am guessing most of
them were found out by hitting a breakage in real life use.
Annotated list of reporters and context of discovery is attached
at the end.

Observations.

 - There are a handful 'missing argument validation and erroring
   out' bugs.  People in the know tend not make such a mistake
   to trigger these bugs, so it is a sign that git is being used
   by wider population that these bugs are surfacing now.

 - A few leaks and hardwired limits are signs that the code was
   not used for heavy-duty settings back when it was written,
   but it is now.

 - Tracking symlinks were added quite early by explicit need to
   support them in the kernel archive, and the bug was there
   ever since and nobody noticed.  Maybe the need for tracking
   symlinks in SCM were real but they never got changed by more
   than one party (not needing merges).

 - There are a few "diff --cc" fixes.  Maybe not as many people
   perform "interesting" merges as the effort spent on writing
   the --cc codde.

 - rerere's skipping adjacent paths were there from the
   beginning of C-rewrite.  It's either rerere is not as widely
   used, or conflicting merges are not so frequent in real life
   to trigger this, or maybe a little bit of both.

----------------------------------------------------------------

20276889 (daemon socksetup() does not set FD_CLOEXEC)
	a87e8be2 Jul 13 2005

Alex Julliard.

f4421325 (blame with missing parameter)
	cee7f245 Oct 19 2006

Tommi Kyntola.

256c3fe6 (rev-list commit encoding)
	52883fbd Dec 25 2006

Fredrik Kuivinen.

8ab40a20 (show-ref --verify)
	26cdd1e7 Dec 17 2006

Dmitry V Levin.

c06d2daa (format-patch filename length)
	0acfc972 Jul  5 2005

Robin Rosenberg, presumaby by noticing breakage while dealing
with a foreign SCM import.

ffa84ffb (pack-object fixed arglen)
	8d1d8f83 Sep 06 2006 

Roland Dreier, by noticing breakage.

4e5104c1 (git-remote command did not like dots in name)
	e194cd1e Jan 03 2007

Many, by noticing breakage in real use.

34fc5cef (mailinfo choke with too long a line)
	c5f7674a Jul 16 2005 (inception)

Linus and Eric Biederman, by noticing breakage.

ee24ee55 (diff --cc int vs size_t)
	4fc970c4 Feb 25 2007

Jim Meyering, code inspection.

de6f0def (no-trivial-merge)
	6ea23343 Mar 18 2006

Me, while working on merge-subtree, by noticing breakage.

185c975f (trust_executable_bit not trusting too much)
	3e09cdfd Oct 11 2005

Johannes Sixt, presumably while working on MinGW port.

75b62b48 (combine-diff broken cast)
	e702496e Aug 23 2006 (memcpy->hashcpy)
	funny thing is that another similar cast is correct.

Johannes Schindelin.


50892777 (diff --git a//etc/inittab)
	65056021 Apr 28 2006 (first built-in diff)

Me, while looking at recent "diff --no-index" series, by noticing breakage.

ab242f80 rerere (find_conflict skips adjacent)
	658f3650 Dec 20 2006 (inception, C rewrite)

Me, while diagnosing 12891727 below, by code inspection.

12891727 rerere (find_conflict uses symlinks)
	658f3650 Dec 20 2006 (inception, C rewrite)
	8389b52b Jan 28 2006 (original Perl version)

Me, while merging 'maint' into 'master', by noticing breakage.

308efc10 (merge-index symlink handling)
	54dd99a1 Dec 02 2005

Me, while merging 'maint' into 'master', by noticing breakage.

17cd29b2 (merge-recursive symlink handling)
	3af244ca Jul 27 2006

Me, while merging 'maint' into 'master', by noticing breakage.

4fc970c4 (diff --cc symlink while merging)
	ea726d02 Jan 28 2006 (teach --cc to diff-files)

Me, while merging 'git-gui' into git.git, by noticing breakage.

63e50d49 (apply fixes whitespace errors of context lines)
	d0c25035 Sep 23 2006 (inception of feature)

Me, while applying clean-up series from Nico last night, by noticing breakage.
