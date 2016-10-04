Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0C620986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbcJDNFH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:05:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:58458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbcJDNFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:05:06 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LnxxQ-1bFsii1EQS-00g2zy; Tue, 04 Oct 2016 15:05:00
 +0200
Date:   Tue, 4 Oct 2016 15:04:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/6] Pull out require_clean_work_tree() functionality from
 builtin/pull.c
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yYBYcOIAaRAqbObLFDBpkbrNZ0zu9GKLybayoj3bH5VTxM2c2ew
 X9GBYhCL0sd0sPps+sdBGX0CkP9Bz/UfsJkCK+nLn/HFvVDzzwWmZ17N0vQSVxqr9Zgbz8D
 YN93wu0S5QXKlFvxEmQzmEUyAYFYLJttYWwMa4RGk/Zg75dmPVln/R5SKbEmTIVu6zRVu+Y
 /vR+62LkpGXgYt79jgwWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bJx3bEhe3z4=:eUhWzE6wrpcr8RqSlv8g8Y
 o6/4Hza020FNFRcJZ728sFX7qt/qVBL3bLA3N/T9tnAbcwwpYsqBKQMDC5+6U4mkCVL0iEC0i
 pDXp6D2nDmF3YIZD4YOtNNFPQx+yABBXnQzXpxP+EbdV71yfbLJFUkRkH0im0LqloiOWTNZPj
 IVAQizmDVyH4J6bQHBn5MEHXEDKQWXOeWSSdzB3ZqHZKn/97NebzfgpErG5l5akmxE6xVwuWj
 Xxp1pJBzd5wk2oixNb52WQJXjAjcmICz8HjXT+yBZ51S61qGYm8Yj7vACJhwzEDrGaep0yeq7
 ajXIqhUUqalRsG3gvKTDabZ2eTgZIrmhHdfSIwjgO15+yK+Z1wp49WEv/HXO4YDbkP+Jbgw1c
 eFAysizGtWAuFDg1VYLFtyaTAfdAdVTYjdLdcyiI2JTBwROSi9XWgTHvW/M9Xqqb5NREaFtlZ
 84prIERobs1CPMWt9/3UJQv8FBy4W0Yw1Zx3Gr+JIP9sxqFR8dDvkJyMZBCWDf2ZprRmZljcU
 SoSNd7y7vrQBiJwuvaW91S/dE5zRyMPsyEFBKga6BKo3Fm1UILd+Fp/hNUl7wjAg16M8e+3YG
 J34nmWe3NJcvjEF4xrQVcNQJV6Dp8vwXcC7i7TlZjvtBISaahOzw7bTWDnIu5jSnsfqW7u2EO
 QG0/GeeHZj+lt0Ud3fYTpIGlbzQDVACzhsTH6f1vzzfu4XK177sY3U2MM1xWnhABEnFoNml0+
 YW4EA+4aopGKkSaubENxy20QL6KhLIK0vQjmCofZR1tkeBhVo26RttJwjQILK0ZijlpT3yM5H
 YrAzVcM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the 5th last patch series of my work to accelerate interactive
rebases in particular on Windows.

Basically, all it does is to make reusable some functions that were
ported over from git-pull.sh but made private to builtin/pull.c.

Changes since v2:

- added a hint for translators.

- changed the existing error messages to start with a lower-case, as per
  our current convention (the previous error messages were inherited
  from code written before that convention was in place).

- struck the "truly" adjective from the commit message, as it did not
  get Junio's consent.


Johannes Schindelin (6):
  pull: drop confusing prefix parameter of die_on_unclean_work_tree()
  pull: make code more similar to the shell script again
  Make the require_clean_work_tree() function reusable
  Export also the has_un{staged,committed}_changed() functions
  wt-status: teach has_{unstaged,uncommitted}_changes() about submodules
  wt-status: begin error messages with lower-case

 builtin/pull.c | 71 +++-------------------------------------------------
 wt-status.c    | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  6 +++++
 3 files changed, 87 insertions(+), 68 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/require-clean-work-tree-v3
Fetch-It-Via: git fetch https://github.com/dscho/git require-clean-work-tree-v3

Interdiff vs v2:

 diff --git a/builtin/pull.c b/builtin/pull.c
 index c639167..0bf9802 100644
 --- a/builtin/pull.c
 +++ b/builtin/pull.c
 @@ -810,7 +810,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
  
  		if (!autostash)
  			require_clean_work_tree(N_("pull with rebase"),
 -				"Please commit or stash them.", 1, 0);
 +				"please commit or stash them.", 1, 0);
  
  		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
  			hashclr(rebase_fork_point);
 diff --git a/wt-status.c b/wt-status.c
 index a86918a..010276b 100644
 --- a/wt-status.c
 +++ b/wt-status.c
 @@ -2264,15 +2264,16 @@ int require_clean_work_tree(const char *action, const char *hint, int ignore_sub
  	rollback_lock_file(lock_file);
  
  	if (has_unstaged_changes(ignore_submodules)) {
 -		error(_("Cannot %s: You have unstaged changes."), _(action));
 +		/* TRANSLATORS: the action is e.g. "pull with rebase" */
 +		error(_("cannot %s: You have unstaged changes."), _(action));
  		err = 1;
  	}
  
  	if (has_uncommitted_changes(ignore_submodules)) {
  		if (err)
 -			error(_("Additionally, your index contains uncommitted changes."));
 +			error(_("additionally, your index contains uncommitted changes."));
  		else
 -			error(_("Cannot %s: Your index contains uncommitted changes."),
 +			error(_("cannot %s: Your index contains uncommitted changes."),
  			      _(action));
  		err = 1;
  	}

-- 
2.10.0.windows.1.325.ge6089c1

base-commit: 0cf36115dce7438a0eafad54a81cc57175e8fb54
