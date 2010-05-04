From: Andrew Ruder <andy@aeruder.net>
Subject: Re: Global .git directory
Date: Mon, 3 May 2010 22:40:40 -0700
Message-ID: <20100504054040.GC13139@goomba>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
 <201004271159.34071.trast@student.ethz.ch>
 <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
 <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>
 <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
 <q2k40aa078e1004280550o322dc5b8jca74d401a5eb1abe@mail.gmail.com>
 <alpine.LFD.2.00.1004282211431.29101@bbs.intern>
 <alpine.LFD.2.00.1005040705470.4835@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue May 04 07:43:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Av5-00071D-Oh
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 07:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab0EDFnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 01:43:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50520 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0EDFnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 01:43:40 -0400
Received: by pwj9 with SMTP id 9so1650521pwj.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 22:43:39 -0700 (PDT)
Received: by 10.114.23.15 with SMTP id 15mr5459961waw.45.1272951818482;
        Mon, 03 May 2010 22:43:38 -0700 (PDT)
Received: from localhost (ip70-171-239-196.tc.ph.cox.net [70.171.239.196])
        by mx.google.com with ESMTPS id r20sm27943052wam.5.2010.05.03.22.43.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 22:43:37 -0700 (PDT)
Mail-Followup-To: Gerhard Wiesinger <lists@wiesinger.com>,
	git@vger.kernel.org, kusmabite@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005040705470.4835@bbs.intern>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146292>

On Tue, May 04, 2010 at 07:07:08AM +0200, Gerhard Wiesinger wrote:
> Still got no feedback ...

I'm not really a person that will be doing the reviewing but as a
frequent lurker on the list, I'm going to try to help you out some.
I'll bite, but I think the lack of response is still due to a major case
of RTFM.  Here's the things from SubmittingPatches that appear to still
be wrong and are most likely keeping your patch from being properly
reviewed:

>	Commits:
>
>	- make commits of logical units

Your patches aren't really in logical units.  Patch 1/2 makes changes to
a header file and creates several function declarations which don't even
exist until 2/2.  So in this case you really would just want one patch
there.

Or even better, perhaps separate the EXISTING functionality into the API
you are eventually shooting for and then add your feature into the next
patch.  I'm sure if done cleanly, some of the changes like
get_git_dir_from_environment() could be done entirely separately from
your feature.  Once everybody agrees that it looks good and works the
same as it always has, it makes the task of reviewing your feature patch
even easier as it will be simply adding a feature and not adding a
feature AND adding a new GIT_DIR API simultaneously.


>	- the first line of the commit message should be a short
>	  description and should skip the full stop
>	- the body should provide a meaningful commit message, which:
>		- uses the imperative, present tense: "change",
>		  not "changed" or "changes".
>		- includes motivation for the change, and contrasts
>		  its implementation with previous behaviour

Your commit messages are very under-detailed.  At the very least you
should include at least as much detail as you did in your original
e-mail to the list!  Look through git log some, you'll see that it isn't
uncommon for patches to actually end up much shorter than the patch
itself.  At the very least, the "Subject" of your patch should be much
shorter.

>	- if you want your work included in git.git, add a
>	  "Signed-off-by: Your Name <you@example.com>" line to the
>	  commit message (or just use the option "-s" when
>	  committing) to confirm that you agree to the Developer's
>	  Certificate of Origin

git takes this one pretty seriously.  Put this in your patches now to
avoid headaches down the line.

>	- make sure that you have tests for the bug you are fixing

While you're not exactly fixing a bug, this would benefit from a
testcase.

>	Patch:
>
>	- use "git format-patch -M" to create the patch

You did this, but typically patches are one per e-mail, the subject
being the [PATCH ...] line and the body being the rest rather than
multiple patches all just copy-pasted inline.

>	- if you change, add, or remove a command line option or
>	  make some other user interface change, the associated
>	  documentation should be updated as well.

As the person who added the above to the documentation, it sure is nice
when people edit the appropriate manpages with their proposed changes
:).

I know it all seems nit-picky, but if you want to see your changes make
it into git.git you're best off making it as EASY AS POSSIBLE for the
reviewer to take your patch and apply it and be done with it.  This just
isn't possible without testcases, documentation updates, etc..
Especially for feature additions (vs bug fixes) you really have to make
life as simple (and normal) as possible for reviewers, maintainers,
etc.. After all, it is a lot easier living without a feature than it is
a documented bug-fix!

Just a random lurker trying to help you out here!

Cheers,
Andy

P.S. I'd also double-check the patch, typos (like mkdir_recusive) make
things look sloppy and can turn people off from reviewing (especially
when it is almost the first line of the patch!)

-- 
Andrew Ruder <andy@aeruder.net>
http://www.aeruder.net
