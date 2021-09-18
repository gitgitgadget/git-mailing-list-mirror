Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFFBC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 14:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A14760ED7
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhIROUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 10:20:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:45165 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhIROUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 10:20:16 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mRbB2-00091V-3u
        for git@vger.kernel.org; Sat, 18 Sep 2021 15:18:48 +0100
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.email>
Subject: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
Message-ID: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
Date:   Sat, 18 Sep 2021 15:18:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Is there a method within `git rev-list` to trim side branch merges where
the merge's tree is identical to the first parent's commit-tree?

One back-story: In the Git-for Windows repository, the previous releases
are 'deadheaded' by merging with the upstream git, and simply taking the
upstream's tree unconditionally. The Git-for-Windows `fixes` are then
rebased onto that merge.

This does mean that all the fixes keep repeating down the 2nd parent
line. So, for example, grep'ing for changes can tricky with so much
repeated chaff, but at least all old versions are directly in the history.

Sometimes it's nice to 'pretend' (a simplified history) that there is
only the one latest series of this 'long lived feature branch' (along
with a similar desire for 'gfw/next` and `gfw/seen`). (one method has
been to `git replace` that merge commit `{/"Start the"}` with it's
parent on a temporary basis).

From my reading of the `rev-list` manual this is similar to the <paths>
TREESAME capability, but without specifying any paths (maybe just `.` ?).

* Is there an existing method for specifying that simplified history?
* Is there a proper term for the treesame condition of the commit-tree
(as recorded in the commit object)?
* Thought's on adding an option for `--follow-treesame`?

The desire also came up in my pondering about progressive/partial merges
(how to represent/hold current state/history) of a large tree, whereby
different authors take different 'bites at the melon' of merging a long
lasting feature branch (the 'ball of mud' type), whereby the result
could be an octopus merge of the main/feature/partial commits, which is
repeated until the partial becomes a finalised merge (the book-ending
and octo-merge is still wip, but would also benefit from the 'feature'
merge technique used by GfW.

--
Philip
