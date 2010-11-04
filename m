From: Yann Dirson <ydirson@free.fr>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Thu, 4 Nov 2010 22:15:56 +0100
Message-ID: <20101104211556.GB8911@home.lan>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
 <201011030424.33093.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	christian.couder@gmail.com, trast@student.ethz.ch
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7AL-0003py-Ah
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab0KDVQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:16:06 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47428 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab0KDVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:16:04 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 72ABBD48002;
	Thu,  4 Nov 2010 22:15:57 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE7A4-0002KW-9n; Thu, 04 Nov 2010 22:15:56 +0100
Content-Disposition: inline
In-Reply-To: <201011030424.33093.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160769>

Hi Christian,

On Wed, Nov 03, 2010 at 04:24:32AM +0100, Christian Couder wrote:
> Now that GTAC (http://www.gtac.biz) is over, I plan to work on options 
> --continue, --abort and --skip for git cherry-pick/revert. After that I hope 
> to be able to refactor the code so that in the end common code is used by 
> cherry-pick/revert and rebase.

Sounds like "sequencer is coming back", great news :)

I don't know if you would like the idea enough, but something I often
think would be good to have (and which could be useful for cherry-pick
and other commands in need of a sequencer), would be more flexibility.
The thing I find myself lacking most often, is the possibility to
change my mind on an already-edited commit (ie, go back after
--continue), the alternatives I can see today being:

- keeping a note on what to do on next pass (but may be more work in case
  of conflicts with further commits)
- fast-forward --continue'ing to keep curent changes and add new ones in
  next pass (same restriction)
- --abort'ing the rebase and starting it again, possibly fetching the
  changes from previous run via HEAD's reflog (not very handy either)
- checkout back to where you want to re-amend and cherry-pick those you
  already passed, essentially redoing an interactive rebase by hand

If we could go back to previous commit, while keeping changes done to
the current one (say, --previous), or reverting to the original one
(say, --revert).  In the same way, continuing until another
previously-unforeseen commit without the need to edit the todo file
would be nice to have (eg. --next).

While I'm at it, another somewhat loosely option I have thought of
would be to seed the todo file with "edit" commands instead of "pick",
to make it possible to validate a series of patches one by one before
sending.  That could be generalized for running a test script
automatically, that is inserting "x whatever" between all pick's - and
my 1st idea would boil down to inserting arg-less "edit" or "x false"
instead.  Maybe some --stepcmd=<command> flag ?

-- 
Yann
