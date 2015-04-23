From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Rebasing with submodule change causes red herring with --continue
Date: Thu, 23 Apr 2015 13:17:08 -0500
Message-ID: <CAHd499D-UX-0_HhoVWuitN960BdKtB_JonbxgLRqwU3ktFW4Sg@mail.gmail.com>
References: <CAHd499AqCJ5N1GP6mBJZB7-9vWPNjtia1G7PHoSY3d=Zovv7UA@mail.gmail.com>
	<20150410164413.GL21452@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlLgZ-0002JJ-NS
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 20:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbbDWSRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 14:17:11 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33469 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030406AbbDWSRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 14:17:09 -0400
Received: by igbpi8 with SMTP id pi8so15028693igb.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cfMEkBYssOXuhcPvuodzyOc6/r5cRHYbaYkwQg487ak=;
        b=q6/BOcvzXpAZerRhkI3Wzpwy7tToHFm66M4qXpV6CTqonUhylfVMcHdA9xOaz/oHb1
         DS7bls7WWOQHkVGotvjVcpkKI0AkJpPczXCzAv+0w1A8N6bsU80D1HW9rWMOXd8Ls/fe
         XsyWd1RGTA91QYpbgEARTsgcBFb6yMxcpnqVpMltW6AHPKUixqLfHVF+MVuBzL2i0vbA
         CDfonCsJu6Hgk7ocAKIkMZyYA2Tspv4mVeQ/ePUumJxOCeCDiqbnGsZbyhhYQjwUcQgE
         31SBpAM60J4LgCzA4uMN0mH6qFV8+DbUYj/+N9r06lXSTjtcaL3ZZVRXMJNDcRQeLc6L
         REqQ==
X-Received: by 10.50.30.202 with SMTP id u10mr489494igh.28.1429813028694; Thu,
 23 Apr 2015 11:17:08 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Thu, 23 Apr 2015 11:17:08 -0700 (PDT)
In-Reply-To: <20150410164413.GL21452@serenity.lan>
X-Google-Sender-Auth: uw-tkFiOKy2Uxt3mZoxHfsrwvLo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267697>

On Fri, Apr 10, 2015 at 11:44 AM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Apr 10, 2015 at 11:30:20AM -0500, Robert Dailey wrote:
>> I have a branch that contains a commit with a single change: A
>> submodule pointing to a new SHA1.
>>
>> When I rebase this branch onto the tip of its parent branch AND that
>> parent branch had modified that same submodule, the rebase stops at
>> the commit on my branch that modified the submodule and asks me if I
>> want to keep REMOTE or LOCAL. I say LOCAL and notice immediately that
>> the submodule is not staged (normally it would be).
>>
>> I do:
>>
>> $ git add my-submodule
>>
>> Then I do:
>>
>> $ git rebase --continue
>>
>> At this point, it fails asking me if I forgot to stage changes and
>> recommends doing --skip. This is normally what you would see if the
>> staging area was completely empty, however it isn't, since I see the
>> submodule is in there.
>>
>> Is this a bug or am I missing a fundamental here? I'm using Git 2.1.0
>> on Windows through MSYS. I'll provide more concrete examples if my
>> summary of the issue doesn't "ring any bells".
>
> I hit something similar in the past, but it was fixed with commit
> a6754cd (rebase -i continue: don't skip commits that only change
> submodules, 2012-04-07) so I think you must be hitting a slightly
> different problem, although the tests added in that commit look like
> they do test the scenario you describe (specifically 'rebase -i continue
> with only submodule staged').

I am still running into this issue on git 2.3.5 on Windows. Logs
below. One interesting thing to note in the git trace output is that
it is specifying --ignore-submodules option to `git diff-files` during
the rebase continue. Is this due to a configuration option? It seems
like git should not be ignoring submodules when continuing a rebase
(this should only affect direct calls to diff)


|-- Robert@M5536:/e/code/frontend (timeline-ids-develop|REBASE 3/3) --|
$ git status
rebase in progress; onto bb05e7c
You are currently rebasing branch 'timeline-ids-develop' on 'bb05e7c'.
  (all conflicts fixed: run "git rebase --continue")

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   Core

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   Core (new commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        Tools/FontTool/


|-- Robert@M5536:/e/code/frontend (timeline-ids-develop|REBASE 3/3) --|
$ GIT_TRACE=1 git rebase --continue
19:15:33.569945 git.c:557               trace: exec: 'git-rebase' '--continue'
19:15:33.569945 run-command.c:351       trace: run_command:
'git-rebase' '--continue'
19:15:33.775097 git.c:348               trace: built-in: git
'rev-parse' '--parseopt' '--stuck-long' '--' '--continue'
19:15:33.931190 git.c:348               trace: built-in: git
'rev-parse' '--git-dir'
19:15:34.007242 git.c:348               trace: built-in: git
'rev-parse' '--is-bare-repository'
19:15:34.059280 git.c:348               trace: built-in: git
'rev-parse' '--show-toplevel'
19:15:34.148343 git.c:348               trace: built-in: git 'config'
'--bool' 'rebase.stat'
19:15:34.227399 git.c:348               trace: built-in: git 'config'
'--bool' 'rebase.autostash'
19:15:34.280437 git.c:348               trace: built-in: git 'config'
'--bool' 'rebase.autosquash'
19:15:34.335476 git.c:348               trace: built-in: git
'rev-parse' '--verify' 'HEAD'
19:15:34.389515 git.c:348               trace: built-in: git
'update-index' '--ignore-submodules' '--refresh'
19:15:34.554631 git.c:348               trace: built-in: git
'diff-files' '--quiet' '--ignore-submodules'
19:15:34.902879 git.c:557               trace: exec: 'git-am'
'--resolved' '--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
'
19:15:34.902879 run-command.c:351       trace: run_command: 'git-am'
'--resolved' '--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
'
19:15:35.113028 git.c:348               trace: built-in: git
'rev-parse' '--parseopt' '--stuck-long' '--' '--resolved'
'--resolvemsg=
When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
'
19:15:35.290155 git.c:348               trace: built-in: git
'rev-parse' '--git-dir'
19:15:35.387224 git.c:348               trace: built-in: git
'rev-parse' '--show-prefix'
19:15:35.541332 git.c:348               trace: built-in: git
'rev-parse' '--show-toplevel'
19:15:35.598374 git.c:348               trace: built-in: git 'var'
'GIT_COMMITTER_IDENT'
19:15:35.659417 git.c:348               trace: built-in: git
'rev-parse' '--verify' '-q' 'HEAD'
19:15:35.724462 git.c:348               trace: built-in: git 'config'
'--bool' '--get' 'am.messageid'
19:15:35.811524 git.c:348               trace: built-in: git 'config'
'--bool' '--get' 'am.keepcr'
19:15:36.037685 git.c:348               trace: built-in: git
'update-index' '-q' '--refresh'
19:15:37.057409 git.c:557               trace: exec:
'git-sh-i18n--envsubst' '--variables' 'Applying: $FIRSTLINE'
19:15:37.057409 run-command.c:351       trace: run_command:
'git-sh-i18n--envsubst' '--variables' 'Applying: $FIRSTLINE'
19:15:37.178495 git.c:557               trace: exec:
'git-sh-i18n--envsubst' 'Applying: $FIRSTLINE'
19:15:37.178495 run-command.c:351       trace: run_command:
'git-sh-i18n--envsubst' 'Applying: $FIRSTLINE'
Applying: TEMP: Update Core submodule
19:15:37.360624 git.c:348               trace: built-in: git
'diff-index' '--ignore-submodules' '--quiet' '--cached' 'HEAD' '--'
No changes - did you forget to use 'git add'?
If there is nothing left to stage, chances are that something else
already introduced the same changes; you might want to skip this patch.

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

19:15:37.456694 git.c:348               trace: built-in: git
'rev-parse' '--verify' '-q' 'HEAD'
