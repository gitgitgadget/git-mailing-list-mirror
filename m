Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82344C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 20:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiBVUZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVUZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 15:25:28 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C2E119423
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 12:25:00 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nMbiU-0006mH-9t;
        Tue, 22 Feb 2022 20:24:58 +0000
Message-ID: <df47bb75-9684-6896-1e5b-21406c4a549a@iee.email>
Date:   Tue, 22 Feb 2022 20:24:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] Update the die() preserve-merges messages to help
 some users
Content-Language: en-GB
To:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <8b95ac6e-5e9d-38e4-4729-dbbe4b671ea8@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <8b95ac6e-5e9d-38e4-4729-dbbe4b671ea8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 22/02/2022 18:55, Phillip Wood wrote:
> Hi Philip
>
> On 22/02/2022 10:33, Johannes Schindelin via GitGitGadget wrote:
>> This small update to the die() preserve-merges messages is a response
>> to the
>> reported edge case in the Git-for-Windows googlegroups thread
>> [https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM] where
>> even git
>> rebase --continue would die.
>>
>> It is most relevant for Windows because Visual Studio still offers the
>> option to run git pull --preserve, therefore Git for Windows already
>> applied
>> these patches. The improvements are not specific to Windows, though, and
>> should therefore also get into core Git, albeit at a more leisurely
>> pace.
>
> I think the new messages are an improvement, I was wondering how
> difficult it would be to allow the user to run rebase --abort so they
> can at least easily start again with --rebase-merges.

In this case, the user (another Phillip), couldn't run `rebase
--continue` without getting a `fatal:` report. A code inspection showed
that was one of the first tests so I don't believe they could run
`--quit` or `abort` either!

We eventually nailed it down to being an update of Git, after getting
into a bad conflict resolution, so the update refused to do any rebase
commands! Later they tried downgrading and finishing the rebase that way
in the usual 'hack & hope' way. Luckily they had a backup from the time
of the update, which was able to confirm the presence of the indicative
directory (which is an implementation detail).

If the `rebase abort` was moved earlier in the code, then it might work,
but we'd still need to keep the clean-up code for a non-existent option,
which is less than ideal .

Philip

>
> Best Wishes
>
> Phillip
>
>> This is a companion patch series to
>> https://github.com/git-for-windows/git/pull/3708
>>
>> Philip Oakley (2):
>>    rebase: help user when dying with preserve-merges`
>>    rebase: `preserve` is also a pull option, tell dying users
>>
>>   builtin/rebase.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
>> Published-As:
>> https://github.com/gitgitgadget/git/releases/tag/pr-1155%2Fdscho%2Fdie_preserve-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
>> pr-1155/dscho/die_preserve-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1155
>

