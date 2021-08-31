Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BDDC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 05:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAAA6101C
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 05:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhHaF4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 01:56:47 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:50526 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhHaF4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 01:56:46 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4GzGdL53Fdz5tlF;
        Tue, 31 Aug 2021 07:55:50 +0200 (CEST)
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <38fef2e3-a78a-c83b-85f8-dae064931703@kdbg.org>
Date:   Tue, 31 Aug 2021 07:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.21 um 05:03 schrieb Elijah Newren via GitGitGadget:
> From: Elijah Newren <newren@gmail.com>
> 
> Allowing rebase, cherry-pick and revert to run from subdirectories
> inevitably leads to eventual user confusion.  For example, if they
> are within a directory that was created by one of the patches being
> rebased, then the rebase operation could hit a conflict before the
> directory is restored leading the user to be running from a directory
> that no longer exists.  Similarly with cherry-pick and revert, those
> operations could result in the directory being removed.
> 
> Similar to bisect, simply require that these commands be run from the
> toplevel to avoid such problems.

I am not a friend of this change. I understand the motivation behind it.
But most of the time, rebase and cherry-pick are operated on own code,
where directories do not disappear and appear at random, and this new
enforced condition becomes awkward.

One of my use-cases is that I operate git-rebase from an untracked build
directory inside the repository. Having to pass -C .. all the time
strikes the wrong balance, IMO.

Things are slightly different for git-bisect (at least for me), because
oftentimes it is operated on foreign code, where you may not know which
directories come and go. But even that is a weak argument to force the
command to the top-level of the repository.

Perhaps it is sufficient to force git-pull to the top-level (if it isn't
already).

-- Hannes
