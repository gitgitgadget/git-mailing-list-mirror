From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: Requesting `git stash --cached` or something similar
Date: Mon, 13 Apr 2015 23:39:42 -0400
Message-ID: <20150414033942.GD8601@tsaunders-iceball.corp.tor1.mozilla.com>
References: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com>
 <20150414014435.GC8601@tsaunders-iceball.corp.tor1.mozilla.com>
 <CANUGeEbRyG4A2UdTYOBgtjDtqi_A1WnbkOBjH_h2AcEZT741jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quinn Taylor <quinntaylor@mac.com>, git@vger.kernel.org
To: Brandon McCaig <bamccaig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 05:42:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhrkI-0002r7-FG
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 05:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbbDNDjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 23:39:48 -0400
Received: from tbsaunde.org ([66.228.47.254]:58685 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbDNDjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 23:39:46 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 202E4C07C;
	Tue, 14 Apr 2015 03:39:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CANUGeEbRyG4A2UdTYOBgtjDtqi_A1WnbkOBjH_h2AcEZT741jQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267111>

On Mon, Apr 13, 2015 at 10:05:02PM -0400, Brandon McCaig wrote:
> Trevor:
> 
> On Mon, Apr 13, 2015 at 9:44 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> > I would expect the answers to be it sets the working directories state
> > to the state in HEAD, and leaves untracked files alone.  If that's what
> > you want you can do git commit -m <message>; git reset --hard; git reset
> > --soft; git stash save to get the effect you want I believe. That said
> > it seems like a kind of odd thing to want to do, what are you actually
> > trying to do?
> 
> That looks like a bad solution. git reset --hard is going to throw
> away any remaining changes to the working tree. The previous commit

 git reset --hard is there to do *exactly* that, which I'm assuming is
 the desired thing for a hypothetical git stash save --cached to do
 because its consistant with what git stash save does.

> would have committed the staged changes, albeit, you should connect
> the commands with && instead of ; to account for errors. After a `git

it should be clear this is not actual code to run exactly as written.

> reset --hard' there's no point in doing a `git reset --soft' because
> hard does *everything*. --soft would try to reset the HEAD without
> touching the index or working tree, but both have already been reset
> with --hard.

yes, that was supposed to be git reset --soft HEAD~ in which case it
does do something, and it is there exactly to just reset HEAD so that
git stash can then pick up the changes from the temporary commit.

> The motivation is most likely stashing a few changes away so that you
> can commit others that are ready to be committed while keeping others
> around to continue working on them. This too is a good observation. It

yes, it could be they are looking for something like git stash --patch,
but maybe not we don't know.

> could mean that the OP is inexperienced with a commit-often workflow.
> You can use git -add -i or -p to commit the good stuff and keep the
> bad stuff out to work on it more. The great thing about Git is that
> the history is very malleable. You can also commit the bad and fix it
> after, rebase the history to clean it up, and end up with perfect
> history while still keeping your changes safely in history.

git stash also stores changes in the git database.  However if you
really like the stack / queue type workflow you might want to consider
stgit or stacked git or something (I personally really dislike that work
flow so I'm not really familiar with those tools).

> The OP should experiment with workflows because Git is already very
> good at this. Stash isn't really needed. That said, I had forgotten
> that --patch was added to stash some time ago so if that is what you
> want then it already exists. It's not quite as easy as --cached, but
> it still gives you some control. It's still not nearly as good as
> using the full power of Git with a regular commit on a branch though.

good is subjective and depends on what you need to do.  There are
certainly times where the stash is a good way to solve problems, and if
people have ideas for things they think it can do better that's great.

Trev

> 
> Regards,
> 
> -- 
> Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
> Castopulence Software <https://www.castopulence.org/>
> Blog <http://www.bambams.ca/>
> perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
> q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
> tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
