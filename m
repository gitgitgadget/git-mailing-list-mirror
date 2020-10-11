Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE2C433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC062207FB
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgJKG6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 02:58:52 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:43544 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgJKG6w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 02:58:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4C8CMZ1W51z5tl9;
        Sun, 11 Oct 2020 08:58:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C578F2AAC;
        Sun, 11 Oct 2020 08:58:48 +0200 (CEST)
Subject: Re: [BUG?] After 'git checkout', files deleted upstream are left in
 the working directory as untracked
To:     Philippe Blain <levraiphilippeblain@gmail.com>
References: <3D3C5F5D-830E-4EC7-A527-DC595D983BB2@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8f88733f-4f20-6215-00a8-de3024b8c4cb@kdbg.org>
Date:   Sun, 11 Oct 2020 08:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3D3C5F5D-830E-4EC7-A527-DC595D983BB2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.20 um 18:43 schrieb Philippe Blain:
> The thing is, I can't reproduce it on a fresh clone. If I could, this would be a reproducer:
> 
> ```
> $ git clone git@github.com:phil-blain/git.git && cd git
> $ git checkout stale-branch
> $ git checkout other-branch
> $ git status # the following is what is shown in my old clone
> On branch other-branch
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
> 	git-legacy-stash
> 	git-remote-testsvn
> 	t/helper/test-line-buffer
> 	t/helper/test-svn-fe
> 
> nothing added to commit but untracked files present (use "git add" to track)
> ```

This is normal. These 4 files are build products and were never
committed files. They had been mentioned in .gitignore in the past, but
are not anymore.

Apparently, your old repository had these build products still lying
around. If you insert `make` in your instructions above after `git
checkout stale-branch`, you should be able to observe the same
un-cleanlyness in a new clone.

-- Hannes
