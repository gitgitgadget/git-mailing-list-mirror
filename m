From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sun, 09 Oct 2011 10:12:22 +0200
Message-ID: <vpqvcry4m8p.fsf@bauges.imag.fr>
References: <1318107488.5865.46.camel@R0b0ty>
	<20111008213741.GA24409@goldbirke>
	<ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Daly Gutierrez <daly.gutierrez@gmail.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 10:12:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCoV3-0002eW-P1
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 10:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab1JIIMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 04:12:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58237 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab1JIIMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 04:12:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9989b0O029282
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Oct 2011 10:09:37 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RCoUg-0003SI-S9; Sun, 09 Oct 2011 10:12:22 +0200
In-Reply-To: <ab706826-75df-4410-941e-6b40ec92713c@email.android.com> (Martin
	Fick's message of "Sat, 08 Oct 2011 16:00:33 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Oct 2011 10:09:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9989b0O029282
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318752579.67082@dIWvYA1CU97LUkZgwz60Uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183188>

Martin Fick <mfick@codeaurora.org> writes:

>>git reflog to the rescue.  For your example above it will output
>>something like this:
>>
>>deadbeef HEAD@{0}: checkout: moving from
>>92aa5381b9f7229523dba42aa94735c30f173451 to New_Branch
>>  92aa5381 HEAD@{1}: commit: Committing this in the Detached Head
>>3a5bb38a HEAD@{2}: checkout: moving from master to
>>3a5bb38a83c00f7acab573f0ec836577143200aa
>>  deafbabe HEAD@{3}: ...
>>  ...
>>
>>There you see the first line of the commit message from your "lost"
>>commit, and you can do
>>
>>  git checkout -b lost_detached_head 92aa5381
>>
>>and you get a branch pointing to that commit you made while on
>>detached head, and you can work with it as usual.
>
> While rflog is cool, I can't help but think that git could be even more helpful for these scenarios.

Git has been showing a big scary warning when entering detached HEAD,
and now has another helpful one when leaving a commit orphan:

$ git checkout HEAD^
Note: checking out 'HEAD^'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

HEAD is now at adcbd2f... foo

$ date > foo.txt; git add foo.txt; git commit -am "commited on detached HEAD"
[detached HEAD 9e9c4ef] commited on detached HEAD
 1 files changed, 1 insertions(+), 1 deletions(-)

$ git checkout master
Warning: you are leaving 1 commit behind, not connected to
any of your branches:

  9e9c4ef commited on detached HEAD

If you want to keep them by creating a new branch, this may be a good time
to do so with:

 git branch new_branch_name 9e9c4efeca049ca559541595c9ca4a3380dee523

Switched to branch 'master'

(since 8e2dc6ac06ae90, Junio C Hamano, Fri Feb 18 16:04:47 2011, commit:
give final warning when reattaching HEAD to leave commits behind)

I think these warnings are (scary and big) enough.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
