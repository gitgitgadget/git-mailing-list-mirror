Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F33520986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938927AbcJGQIl (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:08:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:56136 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbcJGQIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:08:38 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MUpFU-1bOp3G3B5o-00Y7Ix; Fri, 07 Oct 2016 18:08:26
 +0200
Date:   Fri, 7 Oct 2016 18:08:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/6] Pull out require_clean_work_tree() functionality from
 builtin/pull.c
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KkqIimFA8sepsdSUivVxnN7zXdhB/PItTFNoKOehj1c3YFjQ+/X
 a7GbU6WRzl2Hzy2Q5pcz0wYrH9I8S/4fu/s9iIoj5Oho23dHEXZbzlr0XCo90E3s5RMstPd
 Z4S1Aook7fUhFvBua6WFaV/qgrsSDMzp/1dqayqquR6gqzp7ZrvIMtDCTdfIADHoDgQYyRP
 fuAR8Oc3pTKIndd/posig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P0H5dTli6Vo=:sR/5yZ9kLUcm2BVjyyWYVA
 Daw1T5V4OlrVv5mpFYKrFCt3+VmHn0mS9uCVj2c3xzLazGdd2deCWG7zGP1q1yzarOHKyauP4
 pZVQPFRCrgCvrO+qvyRiCFH1KrqWoUvz7WFMVrM+JxrLgNcUS02wqpAPjnSdiHRuu/77B+8v6
 iiNU74z/bxgeDCVj0sTDsg1NLrPLo3ZLYs7xYtUCER+GqCBY9MYV/OdVYZU8Hvac2nWD2bTff
 RhZcqetcJVnFwyjoUMcIM/QDq7/MhoR8Rxu/o9Hn3nGA8RVMOxzwCbBywyeISOcTQqQXbe73V
 ok/iJlGQHCrzMWhFV5s7YwZODA/oSZlHBfSybU/jZn7sV+DT2X5Pm+aEEyQYKYWc7ebn0L8tu
 BVQdHsB3spiDMqI9bBn+z3iOcgNwpXbRK88P+H3JB4t94i2s/3C49VUrAo114xiI1OHp/8qtK
 Ow3XBdbx3eycd8SHFJO7IUlRpKo+uZjWZBounAy3c1o3Pob5dk51T6wlIykAuD8Z5PxSZ/bXz
 INCiNGPW7so6JrSM4cgm9X1hzDpXtQ3BmiWs+25xThgtUpdkqwsbAwS3PPv+F4vQzIRQdOzL2
 puszqScsTl3+8aJmYBH53xYidol8Jc00Q+4pdW+lwIK1EBg48nmO1LZJYGLmBoYpFDck7+Q8A
 LO5RlhN7DUSqCunqdYPN3lOjHz2MibaE1xyMGv8h6thqea72wugi8eK2bctmO5Y+vmz4cLCPN
 /g7x+8z9wDEsPrhMWNXAMlUUKNNLkAE3dpw9fWA/aaQ8qGeF97l4vPig+LmAr+c5QumTEqNdz
 UlaTdUz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the 5th last patch series of my work to accelerate interactive
rebases in particular on Windows.

Basically, all it does is to make reusable some functions that were
ported over from git-pull.sh but made private to builtin/pull.c.

Changes since v3:

- reworded 3/5's commit message according to Junio's suggestion.

- fixed a tyop in 4/5's commit message, pointed out by Jakub.

- marked the hint "please commit or stash them" (reintroduced from the
  original git-pull.sh script) as translatable.

- changed the exit code to 128 (emulating a die()) if
  require_clean_work-tree() was asked to be non-gentle.

- fixed a tyop in 3/6 (which was replaced in 4/6, but it is good not to
  introduce bugs only to fix them right away).

- prefixed the commit message of 4/6 with the "wt-status:" prefix,
  replicating Junio's commit message in the `pu` branch.


Johannes Schindelin (6):
  pull: drop confusing prefix parameter of die_on_unclean_work_tree()
  pull: make code more similar to the shell script again
  wt-status: make the require_clean_work_tree() function reusable
  wt-status: export also the has_un{staged,committed}_changes()
    functions
  wt-status: teach has_{unstaged,uncommitted}_changes() about submodules
  wt-status: begin error messages with lower-case

 builtin/pull.c | 71 +++-------------------------------------------------
 wt-status.c    | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  6 +++++
 3 files changed, 87 insertions(+), 68 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/require-clean-work-tree-v4
Fetch-It-Via: git fetch https://github.com/dscho/git require-clean-work-tree-v4

Interdiff vs v3:

 diff --git a/builtin/pull.c b/builtin/pull.c
 index 0bf9802..d6e46ee 100644
 --- a/builtin/pull.c
 +++ b/builtin/pull.c
 @@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
  
  		if (!autostash)
  			require_clean_work_tree(N_("pull with rebase"),
 -				"please commit or stash them.", 1, 0);
 +				_("please commit or stash them."), 1, 0);
  
  		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
  			hashclr(rebase_fork_point);
 diff --git a/wt-status.c b/wt-status.c
 index ef67593..e8e5de4 100644
 --- a/wt-status.c
 +++ b/wt-status.c
 @@ -2281,7 +2281,7 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
  		if (hint)
  			error("%s", hint);
  		if (!gently)
 -			exit(err);
 +			exit(128);
  	}
  
  	return err;

-- 
2.10.0.windows.1.325.ge6089c1

base-commit: a23ca1b8dc42ffd4de2ef30d67ce1e21ded29886
