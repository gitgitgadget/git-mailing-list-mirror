Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1658720966
	for <e@80x24.org>; Sun,  9 Apr 2017 10:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdDIKyy (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 06:54:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:63030 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752066AbdDIKyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 06:54:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lqx-1c9b2X2Z9r-00zYvM; Sun, 09
 Apr 2017 12:54:46 +0200
Date:   Sun, 9 Apr 2017 12:54:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Danny Sauer <danny@dannysauer.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
In-Reply-To: <20170409022128.21337-1-danny@dannysauer.com>
Message-ID: <alpine.DEB.2.20.1704091238560.4268@virtualbox>
References: <20170409022128.21337-1-danny@dannysauer.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FQeKXPfQpG1E7R0kjBDgW3pKHprmB0X9vbg4KzH+lq94uvbqiU4
 ul63W43dwPlwhsyFvYjr0zXGljwPn2M1r69Iv4aUdjFJ8pyYYlcajQsnjMBuAUGyCBH4yiz
 3MNn/uifeC0u59FWlBUowjUvsXvarm8yEmnEbZUNolJKpJZ6HOje+dHwq6vUF+LWHnw1MJV
 cK4eGhHeZ+Xy8f8RvuDWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cd3kHT8O55A=:2Necr3Y19bYHvUzF0Aorm9
 14f9uoIbCDTfu6+nM3ERaaYUlnFKrioFNZDGJcNuvXIURWrdff6NttNalt1iAT9O14zF/ur3k
 sLBs4LbB31pGklNYtZvRxmTJjMMvm+fZ6IigVkC0cj6Zh8nunGP3X6xGhVccQOuD+vuqHJBQt
 L3t0JH9lBAAVaUkLU5Hcm7060uTewOaoBQJKmbuK8UASAax1UeF/oMw7REp7LkXvpl+Nd3Nw+
 9fJlyQWkNPMmdAZk+IoFgTI1KLDHvEtD/7syHaQOjX4e0achz990e1ryp8sy9kIRCfmZrFhCX
 ZazFYLxgC/FDWHdoP6/8cbfRs+k9kPd1hHBd/IHZ5gbrHq9lsnvhdslTZvDjpISuRiRRxPznU
 /KMSAWBDb7QuCIIxTZNzCpBeEnyGlVYl2psru/v4Xc3RyYTmUwvSQS2CndqnqwzKG+1vFWzun
 O27KCQ9lcX2niHOyvtOf0jB1xSO98Z9TLLsWJTv7gHDOc5on5tDGyoGC8BH6Z5elZR2Z+EI7L
 3ilkEtxZDTs+owbIWYCM/63gS0JmlKjAeXNHzniuVvtahcbpZ7RS3Vv58KcC+qPLiADY64lYW
 RweNBxpd+kEgZDleSULm5u4605mQPf8m8bmB6/S57TY6zydHNHSf1OVlCQBJF7sEhXtRzbvnG
 qaY3FWW8s2SOjGmYohDA/13VdV+SapBOY7U38QgsqrgsJSbhomwkF2Wzf1vfox3ZTsYyLlbqv
 pGbdNRcdt5CD7kxxFu0tAVTnpu/fKw1PCo6TTGNq2YZesrraFsmATIy6Cs4HxykHEsPHk5kQw
 r1/XcDM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danny,

On Sat, 8 Apr 2017, Danny Sauer wrote:

> Make git log's `--use-mailmap` argument works if the GIT_DIR &
> GIT_WORK_TREE env vars are set and git is run from outside of work tree.
> Without the NEED_WORK_TREE set on the log subcommand, .mailmap is
> silently not found.

A laudable goal. How about adding a test case, say, to t/t4203-mailmap.sh,
to ensure that Git won't regress on your fix?

> diff --git a/git.c b/git.c
> index 8ff44f0..e147f01 100644
> --- a/git.c
> +++ b/git.c
> @@ -440,7 +440,7 @@ static struct cmd_struct commands[] = {
>  	{ "init", cmd_init_db },
>  	{ "init-db", cmd_init_db },
>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
> -	{ "log", cmd_log, RUN_SETUP },
> +	{ "log", cmd_log, RUN_SETUP | NEED_WORK_TREE },
>  	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
>  	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>  	{ "ls-tree", cmd_ls_tree, RUN_SETUP },

This may work for you, but it does not work for me, as I often call `git
log` in a bare repository. And that call works, and it should keep
working.

Instead, I think, you need to figure out why the .mailmap file is not read
correctly when you use the GIT_DIR & GIT_WORK_TREE approach. My vague
hunch is that you need to replace the ".mailmap" in read_mailmap()
(defined in mailmap.c):

        err |= read_mailmap_file(map, ".mailmap", repo_abbrev);

by something like mkpath("%s/%s", get_git_work_tree(), ".mailmap"), but
probably only after testing that we're not in a bare repository (which
would also fix a bug, I suspect, as `git log` in a bare repository
probably heeds a .mailmap file in the current directory, which is
incorrect). I.e. something like:

	if (!is_bare_repository()) {
		const char *path = mkpath("%s/%s",
					  get_git_work_tree(), ".mailmap")
		err |= read_mailmap_file(map, path, repo_abbrev);
	}

But you really want to add the test case first, with
`test_expect_failure`, to demonstrate what is currently broken, and then
triumphantly setting it to `test_expect_success` with your patch.

Ciao,
Johannes
