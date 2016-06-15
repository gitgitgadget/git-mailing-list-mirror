From: John Keeping <john@keeping.me.uk>
Subject: Re: Rebasing with submodule change causes red herring with --continue
Date: Thu, 23 Apr 2015 21:35:38 +0100
Message-ID: <20150423203538.GC16113@serenity.lan>
References: <CAHd499AqCJ5N1GP6mBJZB7-9vWPNjtia1G7PHoSY3d=Zovv7UA@mail.gmail.com>
 <20150410164413.GL21452@serenity.lan>
 <CAHd499D-UX-0_HhoVWuitN960BdKtB_JonbxgLRqwU3ktFW4Sg@mail.gmail.com>
 <CAHd499A9k+DZHg-Am_STyRJFwMMT_vi9DtBZqDmNRvsJJ7gxNA@mail.gmail.com>
 <55394B70.4020403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:35:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlNqm-00028F-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 22:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030796AbbDWUfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 16:35:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53100 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030669AbbDWUfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 16:35:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5770DCDA5A8;
	Thu, 23 Apr 2015 21:35:50 +0100 (BST)
X-Quarantine-ID: <e9C9CNKlaIIc>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.778
X-Spam-Level: 
X-Spam-Status: No, score=-1.778 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URI_HEX=1.122] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e9C9CNKlaIIc; Thu, 23 Apr 2015 21:35:49 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2F98E86600A;
	Thu, 23 Apr 2015 21:35:40 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <55394B70.4020403@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267709>

On Thu, Apr 23, 2015 at 09:43:44PM +0200, Jens Lehmann wrote:
> Am 23.04.2015 um 21:07 schrieb Robert Dailey:
> > On Thu, Apr 23, 2015 at 1:17 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> >> On Fri, Apr 10, 2015 at 11:44 AM, John Keeping <john@keeping.me.uk> wrote:
> >>> On Fri, Apr 10, 2015 at 11:30:20AM -0500, Robert Dailey wrote:
> >>>> I have a branch that contains a commit with a single change: A
> >>>> submodule pointing to a new SHA1.
> >>>>
> >>>> When I rebase this branch onto the tip of its parent branch AND that
> >>>> parent branch had modified that same submodule, the rebase stops at
> >>>> the commit on my branch that modified the submodule and asks me if I
> >>>> want to keep REMOTE or LOCAL. I say LOCAL and notice immediately that
> >>>> the submodule is not staged (normally it would be).
> >>>>
> >>>> I do:
> >>>>
> >>>> $ git add my-submodule
> >>>>
> >>>> Then I do:
> >>>>
> >>>> $ git rebase --continue
> >>>>
> >>>> At this point, it fails asking me if I forgot to stage changes and
> >>>> recommends doing --skip. This is normally what you would see if the
> >>>> staging area was completely empty, however it isn't, since I see the
> >>>> submodule is in there.
> >>>>
> >>>> Is this a bug or am I missing a fundamental here? I'm using Git 2.1.0
> >>>> on Windows through MSYS. I'll provide more concrete examples if my
> >>>> summary of the issue doesn't "ring any bells".
> >>>
> >>> I hit something similar in the past, but it was fixed with commit
> >>> a6754cd (rebase -i continue: don't skip commits that only change
> >>> submodules, 2012-04-07) so I think you must be hitting a slightly
> >>> different problem, although the tests added in that commit look like
> >>> they do test the scenario you describe (specifically 'rebase -i continue
> >>> with only submodule staged').
> >>
> >> I am still running into this issue on git 2.3.5 on Windows. Logs
> >> below. One interesting thing to note in the git trace output is that
> >> it is specifying --ignore-submodules option to `git diff-files` during
> >> the rebase continue. Is this due to a configuration option? It seems
> >> like git should not be ignoring submodules when continuing a rebase
> >> (this should only affect direct calls to diff)
> >>
> >>
> >> |-- Robert@M5536:/e/code/frontend (timeline-ids-develop|REBASE 3/3) --|
> >> $ git status
> >> rebase in progress; onto bb05e7c
> >> You are currently rebasing branch 'timeline-ids-develop' on 'bb05e7c'.
> >>    (all conflicts fixed: run "git rebase --continue")
> >>
> >> Changes to be committed:
> >>    (use "git reset HEAD <file>..." to unstage)
> >>
> >>          modified:   Core
> >>
> >> Changes not staged for commit:
> >>    (use "git add <file>..." to update what will be committed)
> >>    (use "git checkout -- <file>..." to discard changes in working directory)
> >>
> >>          modified:   Core (new commits)
> >>
> >> Untracked files:
> >>    (use "git add <file>..." to include in what will be committed)
> >>
> >>          Tools/FontTool/
> >>
> >>
> >> |-- Robert@M5536:/e/code/frontend (timeline-ids-develop|REBASE 3/3) --|
> >> $ GIT_TRACE=1 git rebase --continue
> >> 19:15:33.569945 git.c:557               trace: exec: 'git-rebase' '--continue'
> >> 19:15:33.569945 run-command.c:351       trace: run_command:
> >> 'git-rebase' '--continue'
> >> 19:15:33.775097 git.c:348               trace: built-in: git
> >> 'rev-parse' '--parseopt' '--stuck-long' '--' '--continue'
> >> 19:15:33.931190 git.c:348               trace: built-in: git
> >> 'rev-parse' '--git-dir'
> >> 19:15:34.007242 git.c:348               trace: built-in: git
> >> 'rev-parse' '--is-bare-repository'
> >> 19:15:34.059280 git.c:348               trace: built-in: git
> >> 'rev-parse' '--show-toplevel'
> >> 19:15:34.148343 git.c:348               trace: built-in: git 'config'
> >> '--bool' 'rebase.stat'
> >> 19:15:34.227399 git.c:348               trace: built-in: git 'config'
> >> '--bool' 'rebase.autostash'
> >> 19:15:34.280437 git.c:348               trace: built-in: git 'config'
> >> '--bool' 'rebase.autosquash'
> >> 19:15:34.335476 git.c:348               trace: built-in: git
> >> 'rev-parse' '--verify' 'HEAD'
> >> 19:15:34.389515 git.c:348               trace: built-in: git
> >> 'update-index' '--ignore-submodules' '--refresh'
> >> 19:15:34.554631 git.c:348               trace: built-in: git
> >> 'diff-files' '--quiet' '--ignore-submodules'
> >> 19:15:34.902879 git.c:557               trace: exec: 'git-am'
> >> '--resolved' '--resolvemsg=
> >> When you have resolved this problem, run "git rebase --continue".
> >> If you prefer to skip this patch, run "git rebase --skip" instead.
> >> To check out the original branch and stop rebasing, run "git rebase --abort".
> >> '
> >> 19:15:34.902879 run-command.c:351       trace: run_command: 'git-am'
> >> '--resolved' '--resolvemsg=
> >> When you have resolved this problem, run "git rebase --continue".
> >> If you prefer to skip this patch, run "git rebase --skip" instead.
> >> To check out the original branch and stop rebasing, run "git rebase --abort".
> >> '
> >> 19:15:35.113028 git.c:348               trace: built-in: git
> >> 'rev-parse' '--parseopt' '--stuck-long' '--' '--resolved'
> >> '--resolvemsg=
> >> When you have resolved this problem, run "git rebase --continue".
> >> If you prefer to skip this patch, run "git rebase --skip" instead.
> >> To check out the original branch and stop rebasing, run "git rebase --abort".
> >> '
> >> 19:15:35.290155 git.c:348               trace: built-in: git
> >> 'rev-parse' '--git-dir'
> >> 19:15:35.387224 git.c:348               trace: built-in: git
> >> 'rev-parse' '--show-prefix'
> >> 19:15:35.541332 git.c:348               trace: built-in: git
> >> 'rev-parse' '--show-toplevel'
> >> 19:15:35.598374 git.c:348               trace: built-in: git 'var'
> >> 'GIT_COMMITTER_IDENT'
> >> 19:15:35.659417 git.c:348               trace: built-in: git
> >> 'rev-parse' '--verify' '-q' 'HEAD'
> >> 19:15:35.724462 git.c:348               trace: built-in: git 'config'
> >> '--bool' '--get' 'am.messageid'
> >> 19:15:35.811524 git.c:348               trace: built-in: git 'config'
> >> '--bool' '--get' 'am.keepcr'
> >> 19:15:36.037685 git.c:348               trace: built-in: git
> >> 'update-index' '-q' '--refresh'
> >> 19:15:37.057409 git.c:557               trace: exec:
> >> 'git-sh-i18n--envsubst' '--variables' 'Applying: $FIRSTLINE'
> >> 19:15:37.057409 run-command.c:351       trace: run_command:
> >> 'git-sh-i18n--envsubst' '--variables' 'Applying: $FIRSTLINE'
> >> 19:15:37.178495 git.c:557               trace: exec:
> >> 'git-sh-i18n--envsubst' 'Applying: $FIRSTLINE'
> >> 19:15:37.178495 run-command.c:351       trace: run_command:
> >> 'git-sh-i18n--envsubst' 'Applying: $FIRSTLINE'
> >> Applying: TEMP: Update Core submodule
> >> 19:15:37.360624 git.c:348               trace: built-in: git
> >> 'diff-index' '--ignore-submodules' '--quiet' '--cached' 'HEAD' '--'
> >> No changes - did you forget to use 'git add'?
> >> If there is nothing left to stage, chances are that something else
> >> already introduced the same changes; you might want to skip this patch.
> >>
> >> When you have resolved this problem, run "git rebase --continue".
> >> If you prefer to skip this patch, run "git rebase --skip" instead.
> >> To check out the original branch and stop rebasing, run "git rebase --abort".
> >>
> >> 19:15:37.456694 git.c:348               trace: built-in: git
> >> 'rev-parse' '--verify' '-q' 'HEAD'
> >
> >
> > For reference, I found an existing mailing list discussion on this
> > from a few years ago:
> > http://git.661346.n2.nabble.com/Interactive-rebase-with-submodules-td7197519.html
> >
> > Apparently a patch was proposed, i do not know if it made it in a
> > release of Git. But based on what I'm seeing right now, it seems that
> > it did not.
> 
> Nope, this patch made it in at the a6754cda change John mentioned.
> But while working on recursive submodule update I got the impression
> that possibly some of the '--ignore-submodule' options used in the
> git scripts should be changed to '--ignore-submodule=dirty', but I
> didn't find the time yet to confirm that hypothesis (I'm currently
> concentrating on those builtins that use unpack_trees() directly).

I think the difference is that Robert isn't going through the
interactive codepath.  a6754cda affects git-rebase--interactive.sh which
no longer contains --ignore-submodules at all, but git-rebase.sh does
use it at the beginning of the "rebase --continue" case.

So if you're continuing an interactive rebase you go:

	git update-index --ignore-submodules --refresh &&
	git diff-files --quiet --ignore-submodules || {
		echo "$(gettext "You must edit all merge conflicts and then
mark them as resolved using git add")"
		exit 1
	}
	
and then jump into git-rebase--interactive.sh which checks for any
cached changes (including submodules) before deciding what to do.

But if the rebase isn't interactive it goes to git-am which results in
the message above.

So it seems a change similar to a6754cda is needed in git-am in order to
fix this for non-interactive rebases (and presumably plain "git am
--continue" if only submodule changes are staged).

However, I can't figure out how the code results in the trace above.  On
master (v2.4.0-rc2-43-gfb89636) the "Applying: $FIRSTLINE" comes from
line 843 of git-am.sh so the diff-index invocation should be the one on
line 863, which matches the message printed.  But that invocation
doesn't pass --ignore-submodules and AFAICT never has (at least in
vanilla Git).
