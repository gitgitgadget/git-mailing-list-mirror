Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B17C433F5
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 21:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356403AbiA3VOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 16:14:00 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:61585 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbiA3VN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 16:13:58 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Jn3pK6JTwz5tl9;
        Sun, 30 Jan 2022 22:13:45 +0100 (CET)
Message-ID: <8db0ee81-c66a-1888-6727-f5ab61cff60f@kdbg.org>
Date:   Sun, 30 Jan 2022 22:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Stage, test, and commit only some changes, then repeat
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=a9ry_Ogam?= <gery.ogam@gmail.com>,
        git@vger.kernel.org
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.22 um 21:17 schrieb Géry Ogam:
> Hello,
> 
> I would like to stage, test, and commit only *some* changes of the working tree, and then repeat this process with the remaining changes.
> 
> My current solution (published at https://stackoverflow.com/a/70914962/2326961):
> 
> 1. Stage some changes:
>    ```
>    git add -p file
>    ```
> 2. Save away the remaining changes:
>    ```
>    git diff >patch
>    git stash push -k
>    ```
> 3. Test the staged changes.
> 4. Commit the staged changes:
>    ```
>    git commit
>    ```
> 5. Restore the remaining changes:
>    ```
>    git apply patch
>    ```
> 6. Go to step 1.>
> It is not ideal because a) it uses a patch file for saving the
> remaining changes; b) it uses the stash only for setting the working
> tree to the index state.
> 
> It would be ideal if I could save *only* the remaining changes in the
> stash instead of resorting to a patch file. How to do it?
For example:

1. Stage some changes
2. Commit
3. git stash
4. Test
4a. git commit --amend if tests show that the commit is not yet perfect
5. git stash pop
6. Goto 1.

Be prepared for conflicts in 5 if 4a was necessary.

-- Hannes
