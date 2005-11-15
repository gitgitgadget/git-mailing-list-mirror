From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 03:13:47 -0500
Message-ID: <1132042427.3512.50.camel@dv>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 09:15:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebvx5-0000jO-6i
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVKOIOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKOIOA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:14:00 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56797 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751372AbVKOIN7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 03:13:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ebvww-00008m-05
	for git@vger.kernel.org; Tue, 15 Nov 2005 03:13:54 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ebvwq-0002dY-4Z; Tue, 15 Nov 2005 03:13:48 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11886>

On Mon, 2005-11-14 at 23:03 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > Applying this patch before 1.0 may be controversial,...
> 
> If I am not mistaken, I thought the last thread on the list
> showed general consensus that symlinks were preferred when
> available.  So applying this patch anytime would be
> controversial...

I must have missed that.  If you mean "Re: Getting rid of symlinks
in .git?", I don't see any such consensus there.  The discussion drifts
to insignificant details, and I see arguments like "I couldn't care
less" and speculations about speed without any hard data at hand.

> > but I think there is a very good reason for that.
> 
> Which is...?  I do not think this paragraph justifies it:
> 
> > There should be exactly one git 1.0 repository format.  Now we
> > have two that are present in the sources and that have
> > received testing from the git users.
> 
> The one format is that .git/HEAD can either be a symlink or
> regular file text symref; both variants are tested -- wouldn't
> that be good enough?

No.  Even if git itself is tested, other tools are not.  What's worse,
the developers of those tools don't even know they are supposed to test
for two HEAD formats unless they track git changes and mailing lists
very carefully.

In particular, StGIT still needs fixing.

> The only thing I can think of that might be inconvenient is if
> you try doing "cp -a" off of a filesystem that supports symlinks
> to another filesystem that does not -- probably that would fail
> copying the symlinked .git/HEAD.  But if that is the problem,
> you could always git-clone, which should do the right thing, I
> think.

I'm talking from my experience now.  If there is an option, there are
users that have it enabled and those who have it disabled (by
definition).  As is often happens, one of the configurations is more
popular with developers.  The other configuration almost inevitably
starts suffering from the "bit rot".

It could have been prevented if the format choice was encapsulated by
git prior to its introduction.  But git-symbolic-ref didn't exist before
symrefs were implemented.  Old code outside git accesses .git/HEAD
manually.  Fixing git alone is not enough if git files are accessed
without git.

Extra complexity of any format discourages third party applications or
makes them more complex and less safe to use.

I can understand if the complexity has a balance of requirements issue
behind it.  For example, coexistence of packed and unpacked files comes
from the conflicting requirements to handle files quickly and not to
consume too much hard disk space and bandwidth.

But there is no strong (compared to portability) reason to have
symlinks, except maybe backward compatibility.  It's a weak argument
before 1.0 release.  Let's not wait until it becomes stronger.

-- 
Regards,
Pavel Roskin
