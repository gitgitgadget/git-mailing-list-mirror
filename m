Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AC7C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482C761155
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhEWJuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 05:50:25 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:57318 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhEWJuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 05:50:23 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4FnwXR64v1z5tlB;
        Sun, 23 May 2021 11:48:55 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: fast forward merge overwriting my code
To:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
Date:   Sun, 23 May 2021 11:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[resending, as I forgot to include git@vger]

Am 22.05.21 um 17:48 schrieb Andre Ulrich:
> Let's say I have a .txt file on my master branch. I used
> 
> git add .
> 
> and
> 
> git commit -m "blabla"
> 
> so everything is staged and in the history. Now I check out a new branch
> 
> git checkout -b testing
> 
> and edit the .txt file. I add some new lines at the end, but I also
> change some of the already existing lines. Then again I add and commit
> everything. Then I use
> 
> git checkout master
> 
> and
> 
> git merge testing
> 
> I would expect git to tell me "hey, wait, you have changed some of the
> first lines in the .txt file. When you merge, your code on master will
> be altered". But git just merges everything in.
> Just imagine this was working code, and changing some of the first lines
> breaks everything in the following lines.
> I think I have found out what is the problem: git considers this a fast
> forward merge (since there were no commits on master between the
> creation and the merging of the test branch).
> But this is annoying. I want to be able to choose, what changes I want
> to keep, when I do the merge (just as in case of a 3way merge, when you
> can call a graphical merge tool to decide what lines to keep).

But in a 3-way merge, you only get to choose which changes you take if
there is a conflict. If, in your example, you had committed a change to
a different file on master before the merge, you would get a
non-fast-forward (3-way) merge, and still no opportunity to choose which
changes you take because there would be no conflict.

And why do you think we need a general warning "when you merge, your
code on master will be altered"? Why would I want to make a merge into
master if not to change the code on master?

> I know, I could git diff the latest commits hashes of both branches and
> then fix the file on testing branch accordingly. But those are two
> separate steps, and I want everything to happen in one convenient step.

Git encourages good practice, which is to make sure that all commits do
not have known bugs. Your desired workflow is bad practice. If you want
to follow bad practices, then *you* have to do the extra work, e.g., to
fix up a merge that introduced a known-bad commit.

-- Hannes
