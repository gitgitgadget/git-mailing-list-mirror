Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AC01F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933726AbcHaIzA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:58033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933773AbcHaIyF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:05 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAgzj-1bpla22aB1-00BsqM; Wed, 31 Aug 2016 10:53:57
 +0200
Date:   Wed, 31 Aug 2016 10:53:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/34] Teach the sequencer to act as rebase -i's backend
Message-ID: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JT+k5RWy34RZ2z6Gw357EKArNt/RV9hheeAFYFoymxJq0iNEJQT
 HSABcQziKMFwnY8FZLMQtZ4t6V5QJ20Qek+ep53tmzZsv7uJXfOu4aJbI4SyA5uUo2meS6/
 uiBDhrYoTK3fSgcQfyI58Ex2W1THCtk1Nd8qT8+NsSgPRqXLzkJXoVcHmQQfJfts+pxHV5I
 tUCNFPZ55ouqb5zUItlwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7J76gHovxmg=:1pWpMzowrZdoczNb3qeNvT
 kM6kNXnB3pMK5YhLbRcPB17ktZ7/JHbEkSsnde7zEjumIjj2BVsZnQRhMCrAiUP3I+Ik/S71I
 pEharXFksJ8xSLJLLk8UCq7MhzyeBfaIqlhZb/uSM+x9/jiFiQuyycuBTGWAwt7VNueAyI78a
 Ox3L5GjjmX4Q++OO4r8Uxo1d0wwQiLPl1EA2vDfdhX5LDt/rsLtIMtTZBJK2DNMtw6laBs5H9
 /OWQImkPxQX7WVa444JwDVyb7xZ2bfN5aRrwPu4QmbuHrH7MITjaVEGhzXxfucOTPXSpl7jXw
 EM14J4Ans33e+6E4c6HkwTa9PcdFsgEixfWxdMeTqJp58WsWWJBLXI7lCnqFCJvRnlmwTAKMC
 uUA+tM5T5oCN95+KuH2Je9190K8nmcz+oDKG0+XAVjwHasunstwhuhXOcKVUzLt4EeuOgK5UT
 WqW+F2z4NWqsrLHVkkViKWx1Er+j9joI5yeYFZhfq7bojN7qhTMtBzDctbBSP8SJFDgpsia1/
 PoNAwjm4g5Ql7tiElSvGnDYuW9OHjK2Meq/KBHkxPVSmKrfTWy5ccGwxnHs7swXhppsWFdQaG
 rNyuMU+cHFZZgjpxFiBX1JgagCTWq/94PE5ada5U6VmQtHicfYqT5jwUoTNZ0HhfQ/dbtbv2v
 2CiucQtD91dHItD7vbKX7fKkbgpE7vMnDvZ1eN3SDth/vJsUgjVGGa7oRA2DRVZzj/UYa3vyD
 JDWr9bZCXvPwLs9jgM0s2tn8FmNnG+bWcVSvR1zKtSCaGr5lV99fryf49p8fKtR/WfgCGKRux
 y+HbDpn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This marks the count down to '3': two more patch series after this
(really tiny ones) and we have a faster rebase -i.

The idea of this patch series is to teach the sequencer to understand
all of the commands in `git-rebase-todo` scripts, to execute them and to
behave pretty much very the same as `git rebase -i --continue` when
called with the newly-introduced REPLAY_INTERACTIVE_REBASE setting.

Most of these patches should be pretty much straight-forward. When not,
I tried to make a point of describing enough background in the commit
message. Please feel free to point out where my explanations fall short.

Note that even after this patch series is applied, rebase -i is still
unaffected. It will require the next patch series which introduces the
rebase--helper that essentially implements `git rebase -i --continue` by
calling the sequencer with the appropriate options.

The final patch series will move a couple of pre- and post-processing
steps into the rebase--helper/sequencer (such as expanding/shrinking the
SHA-1s, reordering the fixup!/squash! lines, etc). This might sound like
a mere add-on, but it is essential for the speed improvements: those
stupid little processing steps really dominated the execution time in my
tests.

Apart from mostly cosmetic patches (and the occasional odd bug that I
fixed promptly), I used these patches since mid May to perform all of my
interactive rebases. In mid June, I had the idea to teach rebase -i to
run *both* scripted rebase and rebase--helper and to cross-validate the
results. This slowed down all my interactive rebases since, but helped
me catch three rather obscure bugs (e.g. that git commit --fixup unfolds
long onelines and rebase -i still finds the correct original commit).

This is all only to say that I am rather confident that the current code
does the job.

As stated earlier, my plan is to integrate all of these patch series
into Git for Windows v2.10.0. And then be mostly offline during the
second half of September ;-) There are multiple reasons why I want to
pull through with this: I have been working on these patches since mid
February and it is high time that they benefit users other than me.
Also: I got a bit tired of postponing the integration for a couple of
Git for Windows versions already. Originally, I had planned it for
v2.9.0, but then I wanted to give the patches some review, regretting
that idea when it took one of the 14 patch series over a month to
stabilize.

This means that I will not perform any major refactoring at this stage,
but postpone any such work, if necessary at all.

Just to reiterate why I do all this: it speeds up the interactive rebase
substantially. Even with a not yet fully builtin rebase -i, but just the
part after the user edited the `git-rebase-todo` script.

The performance test I introduced to demonstrate this (p3404) shows a
speed-up of +380% here (i.e. roughly 5x), from ~8.8 seconds to ~1.8
seconds. This is on Windows, where the performance impact of avoiding
shell scripting is most noticable.

On MacOSX and on Linux, the speed-up is less pronounced, but still
noticable, at least if you trust Travis CI, which I abused to perform
that test for me. Check for yourself (searching for "3404.2") here:
https://travis-ci.org/git/git/builds/156295227. According to those logs,
p3404 is speeded up from ~0.45 seconds to ~0.12 seconds on Linux (read:
about 3.5x) and from ~1.7 seconds to ~0.5 seconds on MacOSX (read:
almost 4x).


Johannes Schindelin (34):
  sequencer: support a new action: 'interactive rebase'
  sequencer (rebase -i): implement the 'noop' command
  sequencer (rebase -i): implement the 'edit' command
  sequencer (rebase -i): implement the 'exec' command
  sequencer (rebase -i): learn about the 'verbose' mode
  sequencer (rebase -i): write the 'done' file
  sequencer (rebase -i): add support for the 'fixup' and 'squash'
    commands
  sequencer (rebase -i): implement the short commands
  sequencer (rebase -i): write an author-script file
  sequencer (rebase -i): allow continuing with staged changes
  sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
  sequencer (rebase -i): skip some revert/cherry-pick specific code path
  sequencer (rebase -i): the todo can be empty when continuing
  sequencer (rebase -i): update refs after a successful rebase
  sequencer (rebase -i): leave a patch upon error
  sequencer (rebase -i): implement the 'reword' command
  sequencer (rebase -i): allow fast-forwarding for edit/reword
  sequencer (rebase -i): refactor setting the reflog message
  sequencer (rebase -i): set the reflog message consistently
  sequencer (rebase -i): copy commit notes at end
  sequencer (rebase -i): record interrupted commits in rewritten, too
  sequencer (rebase -i): run the post-rewrite hook, if needed
  sequencer (rebase -i): respect the rebase.autostash setting
  sequencer (rebase -i): respect strategy/strategy_opts settings
  sequencer (rebase -i): allow rescheduling commands
  sequencer (rebase -i): implement the 'drop' command
  sequencer (rebase -i): differentiate between comments and 'noop'
  run_command_opt(): optionally hide stderr when the command succeeds
  sequencer (rebase -i): show only failed `git commit`'s output
  sequencer (rebase -i): show only failed cherry-picks' output
  sequencer (rebase -i): suggest --edit-todo upon unknown command
  sequencer (rebase -i): show the progress
  sequencer (rebase -i): write the progress into files
  sequencer (rebase -i): write out the final message

 run-command.c |  23 ++
 run-command.h |   1 +
 sequencer.c   | 990 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 sequencer.h   |   4 +-
 4 files changed, 971 insertions(+), 47 deletions(-)

Based-On: prepare-sequencer-and-wt_status at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git prepare-sequencer-and-wt_status
Published-As: https://github.com/dscho/git/releases/tag/sequencer-i-v1
Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-i-v1

-- 
2.10.0.rc2.102.g5c102ec

base-commit: 45bfeb0c4044dfcf090ad97e839d250d62308fac
