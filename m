From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 09:12:07 -0600
Message-ID: <851tynz2yg.fsf@stephe-leake.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 16:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJP6w-00030r-3S
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 16:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbaB1PMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 10:12:22 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:49798 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751915AbaB1PMV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 10:12:21 -0500
Received: from [75.87.81.6] ([75.87.81.6:53990] helo=TAKVER)
	by cdptpa-oedge01 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 92/22-10928-947A0135; Fri, 28 Feb 2014 15:12:09 +0000
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242973>

Brandon McCaig <bamccaig@gmail.com> writes:

> On Thu, Feb 27, 2014 at 9:57 PM, Stephen Leake
> <stephen_leake@stephe-leake.org> wrote:
>> You might be adding other files for other reasons. But if you add a file
>> that does resolve a conflict caused by 'git stash pop', it is not
>> guessing.
>
> Staging a file doesn't tell git that you resolved a conflict. Git will
> happily accept a blob full of conflict markers. Git doesn't know the
> difference. Git expects the user to know what is right. The user has
> the freedom to manipulate the index as they see fit, which means both
> adding and removing from it anytime they wish.

But git has a notion of "unresolved conflict". For example, when I have
conflicts from a 'git stash pop', 'git status' shows:

stephe@takver$ git status
# On branch master
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      CommandBasedAutonomous.java
#	both modified:      DriveByInches.java
#
# ...

How does it know those files are "unmerged"? I'm guessing it has
recorded the fact that they had conflicts. Where does it record that?

In fact, at this point, I have edited CommandBasedAutonomous.java to
resolve the conflicts. But git apparently doesn't know that.

So I do 'git add CommandBasedAutonomous.java', then 'git status':

stephe@takver$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   AerialAssist2014/src/org/usfirst/frc1939/AerialAssist2014/commands/CommandBasedAutonomous.java
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      AerialAssist2014/src/org/usfirst/frc1939/AerialAssist2014/commands/DriveByInches.java

And git thinks that file is now "merged".

So it appears that adding a file _does_ tell git that the conflict is
resolved.

Or am I still missing something?


>> So "git add" and "git stash *" are lower level tools; to get the effect
>> we are asking for, we should use a front-end (which is why I'm writing
>> one for Emacs :).
>
> You *can* use a front end, but I would argue that you shouldn't
> necessarily. Most third-party front ends only serve to confuse users.
> In general, they only cause problems and encourage ignorance.

Won't happen here; I'm writing it. It may confuse other people, but
not me :).

> Git is a very pure system.

Hmm. We'll have to disagree on that. git gives the impression of having
grown organically for quite a while, and therefore suffers from changing
and competing design paradigms and conflicting requirements due to
preserving backward compatiblity.

monotone is much cleaner, since it has had very few design paradigm
changes, and they were implemented cleanly, without preserving backward
compatibility. monotone is not as flexible as git, but what I've seen so
far could be added to monotone (I don't think it ever will be; monotone
is dying as a project).

We are probably using different definitions of "pure" here.

> It is up to the user to learn how to assemble those tools for
> good (and many front ends exist to help; sometimes arguably too many
> as it is, such as git-pull(1) for example).

Yes. Which is why we are discussing how much help git should be while
still learning the rules.

>  This isn't a case of the API being wrong. This is a case of PEBKAC,
> IMO.

(wikipedia to the rescue; PEBKAC = "operator error")

Yes, I'm not using it correctly, because I don't understand it yet.
That's the definition of "newbie".

> Dropping the stash after adding all changes to the index after a
> failed pop is not universal.

Not universal, but it appears to be very common; it is certainly what I
expect, as a newbie. So it could be the default as long as there is a
configuration option to have it not do that.

I _did_ "RTFM" (specifically the man page on 'git stash', and before
that the git book at http://git-scm.com/documentation (which did not
mention stash)); it did not explain the full cycle of how to resolve
conflicts after stash pop.

Perhaps there is a different manual that I could read instead?

In particular, one that explains what "unmerged paths" means in the 'git
status' output? The 'git-status' man page does not do that.

--
-- Stephe
