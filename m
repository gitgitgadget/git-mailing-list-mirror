Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05151FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbeARPfb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:35:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:59713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932484AbeARPf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:35:29 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPGI-1fJTO91j3u-00heQN; Thu, 18
 Jan 2018 16:35:23 +0100
Date:   Thu, 18 Jan 2018 16:35:23 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 0/8] rebase -i: offer to recreate merge commits
Message-ID: <cover.1516225925.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/QjLIE7YcTA6MsOxOOS9c4PiARwmCebp2tUOlYqwUiq5jBZ0Pyn
 HCWOcYE2cMUxyvkagShc5p3162dMtjFhRQfZ4YzPIM/ZmdX54DtKolUTWFxlW+4CwCQdJrN
 suUMI2I015Se+WzWnNVY7upE9NACmhSi1THw5h9Q1NY1XcyH61jnqqSZMcJBfWMAO1s1wK7
 QRoOSzzS2stAsJXWBDkAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Iu+n9XP7SE=:9WeLTDNdBwPvGsmqAW5qyu
 4P1HJXuixLTO94Dk8PzDKlKasCFcOGfEnCMNFe995K2VodsAmAg6TwYoLKxEJRRchALkZ+N1R
 7BcZn/N46nvIm+o0Fkhzu+nifufxPxrSNFWrRbknFPMFElsoaoiETE+0awRXSwOPoRXMmZ1lS
 dT284GS1rmMraviabtZluqul4yXZ9W3P+BrkyVCZ/wjrY5sAG3iImxZawVREEWMylA3d0TyHd
 d3ipzC3mQ1OzqjWcIRDIjMdqnjb5lXxqZ8UoB/d8Fq4OHB0pGy5WEPSEEdoiMBoaVrQXCGzrp
 wzxKM50Ty0ewXWf6oRuW/VqICtmMFOUZ2f5VK4nirbN5X9SdGSJN+kpIdrm73H11rcjlYsx1G
 UsXQgumQ5jPVZscSFwVYjnyYvUqrwBHB44FLD8Di9qYggPtNrUBsXUx6vd8NQNcJOyicMAdXF
 l5PMWVm0Tya+GF5kY0KnutjwIkycg9acpmxH6i+Srdby5iLNSOBKO38Hh1KOizmtkkNmPKrQn
 sLRdOpytXRDrESJPKoUpwp+piSfyqKxGcDCoIqMV+DZTL0BNeNKqvtUfqUoNXC6g5TBnrzlUN
 1b8GbeV41hfx8Yy4NBvMnLNnyo9dsm+sh27wwpz1URwPZc+LatkfQmztwaMMfhQLV9HS07dM9
 3filezU1JIH55L2BzZrgMB7AuqHg9n6R8Vv7qij6qCj3tflsuoN7uAErJfJRubNogDtIc9BOW
 fD3MiGkjdCLf1ptbUkBJoxbmOtbsFSRW8O/HqcQ9CMz6586cscblkAWUp0G3N/7FRML/p/3g2
 0d+eQ1mCSBbnC1Du2AGCk5p4xonBHem+qg1b2qtEs44z/wlIW4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, I dreamt of an interactive rebase that would not
flatten branch structure, but instead recreate the commit topology
faithfully.

My original attempt was --preserve-merges, but that design was so
limited that I did not even enable it in interactive mode.

Subsequently, it *was* enabled in interactive mode, with the predictable
consequences: as the --preserve-merges design does not allow for
specifying the parents of merge commits explicitly, all the new commits'
parents are defined *implicitly* by the previous commit history, and
hence it is *not possible to even reorder commits*.

This design flaw cannot be fixed. Not without a complete re-design, at
least. This patch series offers such a re-design.

Think of --recreate-merges as "--preserve-merges done right". It
introduces new verbs for the todo list, `label`, `reset` and `merge`.
For a commit topology like this:

            A - B - C
              \   /
                D

the generated todo list would look like this:

            # branch D
            pick 0123 A
            label branch-point
            pick 1234 D
            label D

            reset branch-point
            pick 2345 B
            merge 3456 D C

There are more patches in the pipeline, based on this patch series, but
left for later in the interest of reviewable patch series: one mini
series to use the sequencer even for `git rebase -i --root`, and another
one to add support for octopus merges to --recreate-merges.


Johannes Schindelin (8):
  sequencer: introduce new commands to reset the revision
  sequencer: introduce the `merge` command
  sequencer: fast-forward merge commits, if possible
  rebase-helper --make-script: introduce a flag to recreate merges
  rebase: introduce the --recreate-merges option
  sequencer: handle autosquash and post-rewrite for merge commands
  pull: accept --rebase=recreate to recreate the branch topology
  rebase -i: introduce --recreate-merges=no-rebase-cousins

 Documentation/config.txt               |   8 +
 Documentation/git-pull.txt             |   5 +-
 Documentation/git-rebase.txt           |  13 +-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |   2 +
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |   6 +
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 697 ++++++++++++++++++++++++++++++++-
 sequencer.h                            |   9 +
 t/t3430-rebase-recreate-merges.sh      | 208 ++++++++++
 13 files changed, 977 insertions(+), 21 deletions(-)
 create mode 100755 t/t3430-rebase-recreate-merges.sh


base-commit: 2512f15446149235156528dafbe75930c712b29e
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v1
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v1
-- 
2.15.1.windows.2.1430.ga56c4f9e2a9

