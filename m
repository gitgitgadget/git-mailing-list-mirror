Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D484EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 17:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjF1Rcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 13:32:53 -0400
Received: from giraff.fripost.org ([193.234.15.44]:45298 "EHLO
        outgoing.fripost.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjF1Rcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 13:32:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id 5DEAB2AB3CA9;
        Wed, 28 Jun 2023 19:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :from:from:references:content-language:subject:subject
        :user-agent:mime-version:date:date:message-id; s=
        9df9cdc7e101629b5003b587945afa70; t=1687973570; x=1689787971;
         bh=DVxRVUU3aYEi2ymu7dJViVo8fmaTYjuZzYWfEnFHmx4=; b=w45l3l4MpQHh
        m2Xs/6wgRn5lztZ96HN1JcRim+92DHGaJllFU3AV+BqI/JnYDbfJPdZdF/c9CpuJ
        TK8qnbLGa9jNToFjkssaVjFKohEmyE1gihqJvzxGwawUJ4Mj01Nay5gg1qoZU3Od
        8mK4pcFOPXjFa63qOZmLpx+y5UCpyQ66gQrAU0GjWwJ8qJk2E+HICyHoORFXPhUG
        miWKhOieveeRIs8/TVH8pMYbxTkoGiqbo6psRMhsGeO1UYlsSTAHZXkHGsf7+J2B
        q/aTv55ZnuMdnAHa+dQsxH9OpIg8RZdJqqAXHL0bypeQStIOOyy0qROKzKNWNGHH
        6Z2RXqMv/A==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id rXKa8lhHx84k; Wed, 28 Jun 2023 19:32:50 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id 377682AB3CA4;
        Wed, 28 Jun 2023 19:32:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        by smtp.fripost.org (Postfix) with ESMTPSA id 7912C9614AAA;
        Wed, 28 Jun 2023 19:32:45 +0200 (CEST)
Message-ID: <102dabfc-595b-5f85-bc2c-ed9a003cd7bd@lidestrom.se>
Date:   Wed, 28 Jun 2023 19:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/9] gitk: improve keyboard support
Content-Language: en-GB
To:     Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <0cb94aa5-726f-a57f-858c-b29764c63ce7@kdbg.org>
From:   =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
In-Reply-To: <0cb94aa5-726f-a57f-858c-b29764c63ce7@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@Hannes: I choose key combinations with Ctrl+<another-key>.

Another possibility is to use Ctrl+Shift+<another-key>. That is more complicated to press, but it creates a nice distinction between two categories of commands:

Searching and navigation command (existing): Ctrl+<another-key>

Branch modification commands (new): Ctrl+Shift+<another-key>

Do you have any opinion on this? Only Ctrl, or Ctrl+Shift for the new commands?

/Jens



On 2023-06-28 08:09, Johannes Sixt wrote:
> Am 27.06.23 um 16:41 schrieb Jens Lidestrom via GitGitGadget:
>> It is often convenient to use the keyboard to navigate the gitk GUI and
>> there are keyboard shortcut bindings for many operations such as searching
>> and scrolling. There is however no keyboard binding for the most common
>> operations on branches and commits: Check out, reset, cherry-pick, create
>> and delete branches.
>>
>> This PR adds keyboard bindings for these 5 commands. It also adjusts some
>> GUI focus defaults to simplify keyboard navigation.
>>
>> Some refactoring of the command implementation has been necessary.
>> Originally the commands was using the mouse context menu to get info about
>> the head and commit to act on. When using keyboard binds this information
>> isn't available so instead the row that is selected in the GUI is used. By
>> adding procedures for doing this the PR lays the groundwork for more similar
>> keyboard binds in the future.
> I like it when an application can be navigated with the keyboard. These
> changes are very much appreciated.
>
> I've left some comments on individual commits. The important one is that
> I think it makes the Reset dialog way too easy to destroy uncommitted work.
>
> Please note that gitk-git directory is in its own repository that is
> only subtree-merged into the Git repository. You should generate patches
> against git://git.ozlabs.org/~paulus/gitk (I don't know how difficult it
> would be for Paul to integrate patches that were generated by gitgitgadget).
>
> -- Hannes
>
>> I'm including Paul Mackerras because he seems to be the maintainer of gitk.
>> Can you review, Paul?
>>
>> Jens Lidestrom (9):
>>    gitk: add procedures to get commit info from selected row
>>    gitk: use term "current branch" in gui
>>    gitk: add keyboard bind for reset
>>    gitk: show branch name in reset dialog
>>    gitk: add keyboard bind for checkout
>>    gitk: add keyboard bind for create and remove branch
>>    gitk: add keyboard bind to cherry-pick
>>    gitk: focus ok button in reset dialog
>>    gitk: default select reset hard in dialog
>>
>>   gitk-git/gitk | 132 ++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 96 insertions(+), 36 deletions(-)
>>
>>
>> base-commit: 94486b6763c29144c60932829a65fec0597e17b3
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1551%2Fjensli%2Fkeyboard-for-gitk-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1551/jensli/keyboard-for-gitk-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1551

