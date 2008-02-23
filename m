From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about your git habits
Date: Fri, 22 Feb 2008 17:42:22 -0800
Message-ID: <7vk5kw4fep.fsf@gitster.siamese.dyndns.org>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:43:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjPz-0000ez-Op
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbYBWBmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbYBWBmg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:42:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYBWBmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:42:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 72125560E;
	Fri, 22 Feb 2008 20:42:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7D6BC560B; Fri, 22 Feb 2008 20:42:29 -0500 (EST)
In-Reply-To: <200802221837.37680.chase.venters@clientec.com> (Chase Venters's
 message of "Fri, 22 Feb 2008 18:37:14 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74781>

Chase Venters <chase.venters@clientec.com> writes:

[jc: kernel-list removed from CC: as this does not have anything
to do with them]

> My question is: If you're working on multiple things at once,
> do you tend to clone the entire repository repeatedly into a
> series of separate working directories and do your work there,
> then pull that work (possibly comprising a series of
> "temporary" commits) back into a separate local master
> respository with --squash, either into "master" or into a
> branch containing the new feature?
>
> Or perhaps you create a temporary topical branch for each
> thing you are working on, and commit arbitrary changes then
> checkout another branch when you need to change gears, finally
> --squashing the intermediate commits when a particular piece
> of work is done?

It is a matter of taste, but in any case, you should not have to
squash that often.  If you find you are always squashing because
you work on one thing and then switch to another thing before
you are done with the former, something is wrong.

	Clarification: I am not saying squashing is wrong.  I am
	just saying you should not have to.

If you want to park what you were working on before switching to
do something else, you can (and probably should) commit and it
is a very valid thing to do (an alternative is "git stash").

When resuming, if that parked commit was half-baked and
something you do not want to go back to later, then the next
commit (be it another commit that merely "parks" before getting
distracted to do something else, or a commit that finally gets
everything "finito") can be made with "commit --amend".  That
way, your sequences of commits will consist of only logically
separate units, without half-baked ones you had to create only
because you switched branches.

Some people prefer to use multiple simultanous work trees.  You
certainly can use "clone" to achieve this.  And local clone is
very cheap as it shares the object database from the origin by
default.

Many people prefer to use topic branches, and working in a
single repository with multiple branches and switching branches
without ever cd'ing around is certainly a possible and very
valid way to work.  As long as your build infrastructure is sane
(e.g. your project does not have a central header file that any
little subsystem change needs to modify and included by
everybody, which tends to screw up make quite badly), switching
branches would not incur too much recompilation either and it
obviously will save disk space not having to leave multiple
checkout around.

You can also work with a single repository, multiple branches
and have multiple simultaneous work trees attached to that
single repository, by using contrib/workdir/git-new-workdir
script.
