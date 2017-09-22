Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A8D202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 12:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbdIVMEX (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 08:04:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:61641 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbdIVMEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 08:04:22 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LxO7W-1dKFmj3QB0-016xQm; Fri, 22
 Sep 2017 14:04:19 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] pre-merge hook
Date:   Fri, 22 Sep 2017 14:04:11 +0200
Message-Id: <cover.1506081120.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.909.g0fa57a0913
X-Provags-ID: V03:K0:qfGROaOxGpulhqMYThuXsRw5PqaVW9IzUoT2gQsPFRXVffEH2pi
 /gdO9+RCMZ0TtvVhwXZRZXvrgjonICtQr6ucR0h2snIu18qOfuDn5P1HpUNcZBOCKMWMkIG
 M1RgulQImPF8nauQYANoGowFsSaZvrKc0dWeC+v+R2IpF1ruRWoixQwA8e8sZIBTo+NVtqR
 Bgx76CNyrMXswLi2XmQgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jt84LBhou78=:g1PjOtILulRuWBLeBE//6Q
 SPre9YpUZM8vZ3JmIG9yiSSWeNxpmULU3p1GUs3/W1p6F3xa92p6ek03XupUCSIRvyf8TglLo
 sJTWmtGECUGNxc4I5pW0sA1Pg5+rUeBzPFKWDXPsUkinrrHAMSdAcdx84q9Z5MxHEF2e6K19N
 +CSPvx7H+A7Tc9G8om+7//4fivf5HRukBfxi3kCGeYPsgVmmPS7MhV3+LUvd53ivZuTx+3s9b
 3aSVdchxVaI88o3kJqo3NAg6pF2aCiKif/OCyMY08nvjSkVIUKUowIJEzL/1H3r98P3jql3uB
 rZ6eaB6GJYw4vBTIUK8/SSBGBNxmSkfB2M5406l62ESsooeJYdgYmpYj0+UGyyTPZR/HRuS0c
 J8l350jg+YPvs/WIKSPf2eBXDwB8dYlREFJ3+6Y+n9gdbWaRlcQnnSmzK+K1BMOHWofZFoOQb
 +JKJX5ydMRG0dVuZyrodeLwIZBGEtrSqyh9GyXExLErSzMzsauy7biJIuYIruqBxQ6zR7I4BI
 6/2u7wg/N7xUkKu8d2a+CIzu1v05jXciSolGJUQ1NNLnT0ppNoLmd7mJdhF8PLJXP9epFjXHL
 iH8wym5hQku+zmoTtXBx8Ct4eaZRx1lUh3bBBnUjsZvJYpng2byTS2N2fNWBn4XsUycl1BgZo
 DXPQtuR2YkYhZGFVB9hoUMcyemTuEe6CCiK4jHHDNcq3j9mRhZDWk7VrE0GWIIz4GCSfgI09W
 3l8tO/cdtGvlEaxV9sEgVlhUvGJWAZpPCRmkZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that f8b863598c ("builtin/merge: honor commit-msg hook for merges",
2017-09-07) has landed, merge is getting closer to behaving like commit,
which is important because both are used to complete merges (automatic
vs. non-automatic).

This series revives an old suggestion of mine to make merge honor
pre-commit hook or a separate pre-merge hook. Since pre-commit does not
receive any arguments (which the hook could use tell between commit and
merge) and in order to keep existing behaviour (as opposed to the other
patch) this series introduces a pre-merge hook, with a sample hook that
simply calls the pre-commit hook.

commit and merge have very similar code paths. f8b863598c implemented
"--no-verify" for merge differently from the existing implementation in
commit. 2/4 changes that and could be first in this series, with the
remaining 3 squashed into 2 commits or 1. I've been rebasing and using
this series for years now, 2/4 is the new-comer which fixed the breakage
from f8b863598c that I encountered because of the no-verify
implementation. 

Michael J Gruber (4):
  git-merge: Honor pre-merge hook
  merge: do no-verify like commit
  merge: --no-verify to bypass pre-merge hook
  t7503: add tests for pre-merge-hook

 Documentation/git-merge.txt       |  2 +-
 Documentation/githooks.txt        |  7 +++++
 Documentation/merge-options.txt   |  4 +++
 builtin/merge.c                   | 17 ++++++++--
 t/t7503-pre-commit-hook.sh        | 66 ++++++++++++++++++++++++++++++++++++++-
 templates/hooks--pre-merge.sample | 13 ++++++++
 6 files changed, 104 insertions(+), 5 deletions(-)
 create mode 100755 templates/hooks--pre-merge.sample

-- 
2.14.1.909.g0fa57a0913

