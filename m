From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question: next, master and pu branches
Date: Thu, 01 Feb 2007 22:02:39 -0800
Message-ID: <7v8xfhksg0.fsf@assigned-by-dhcp.cox.net>
References: <200702021142.08975.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrW5-0003At-Da
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423114AbXBBGC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423127AbXBBGC6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:02:58 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:53148 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423114AbXBBGCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:02:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202060240.VUUL1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 01:02:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JW2f1W00E1kojtg0000000; Fri, 02 Feb 2007 01:02:39 -0500
In-Reply-To: <200702021142.08975.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Fri, 2 Feb 2007 11:42:08 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38458>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> Can somebody explain the meaning of next and pu branches and
> some documenation about using topic branches.
>
> My development model use two branches now: stable release and develment 
> branch. All changes in the stable release branch are bug-fix only changes. 
> All (or most) of them must go to development release. Now I do this using 
> cherry-pick but it is not easy to track what was merged especialy when merge 
> pruduce confic resloved by hands. Stable branch live long life, much more 
> than 100 commits. 

I think what you are looking for is how my 'maint' and 'master'
branches are maintained; 'maint' corresponds to your "stable
release" while 'master' corresponds to your "develment branch".

When a stable release is cut, 'maint' is forked from there.

Truly obvious corrections will be applied on top of the tip of
'maint' directly, while if there are any doubt about a proposed
change I might fork a topic off of the tip of 'maint' and cook
the fix for a while until I finally merge it to 'maint'.  This
way, 'maint' will be "bugfix only since the last release".

The tip of 'maint' will be merged into 'master', from time to
time, to make sure that all fixes will be in 'master'.

When it is time for a new release to be cut, I'd make sure that
the tip of 'maint' is merged into 'master' (it usually is) and
then the tip of the 'master' is tagged to be released.  After a
release is made, I could have two maintenance branches (one that
continues on top of the old codebase, another that fixes the new
release).  A fix that can apply to both codebases will be
applied to the maintenance branch for the old release and then
its tip can be pulled into the maintenance branch for the new
release and then its tip can further be merged into the
development branch.

At some point, the codebases for the older release and the
current release become diverged enough that merging could become
inpractical (the same bug may need different fix if the
infrastracture has become different); you would need to bite the
bullet and fix it twice (i.e. differently).
