Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF53C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 20:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33469613BF
	for <git@archiver.kernel.org>; Wed, 26 May 2021 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhEZUhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 16:37:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:31925 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEZUhP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 16:37:15 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lm0Fh-000CNc-Co; Wed, 26 May 2021 21:35:42 +0100
Subject: Re: fast forward merge overwriting my code
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
 <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
 <60ae947797deb_25ba2089c@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6dcc8557-9df4-9ea2-c348-f4ebf76ff446@iee.email>
Date:   Wed, 26 May 2021 21:35:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60ae947797deb_25ba2089c@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2021 19:33, Felipe Contreras wrote:
> Philip Oakley wrote:
>> On 26/05/2021 03:53, Felipe Contreras wrote:
>>> Andre Ulrich wrote:
>>>> So the last point is where we still want to do some fine tuning. Right  
>>>> now this looks about: my prof fetches my edits and locally checks out  
>>>> a branch to compare the changes with git diff.
>>>> But in this diff view you can't edit the files. So you have to  
>>>> separately open up another window to edit the changes (lets say my  
>>>> prof only wants to keep some of my changes, but not all).
>>> So for example after fetching your changes your professor sees this:
>> Part of Andre's problem was that this diff wasn't stable because the
>> underlying file format is said to be json so items can move around
>> without issue (e.g. key value pairs swapping position) and that they
>> aren't really working on the json file (it may as well be binary..) but
>> on the jupytper notebook display view, so one step removed from the 'diff'.
> Andre said they use the diff view, and he wants to be able to edit it.
> Not sure how else would you interpret "But in this diff view you can't
> edit the files".
>
In
https://lore.kernel.org/git/20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de/
Abdre did say they used the special jupyter notebook diff viewer.

> ..diffing and merging of notebooks is another story (but we can handle
that with nbdime)

[...]

> - my prof reviews the changes and accepts them (if I have done
acceptable work) So the last point is where we still want to do some
fine tuning. Right now this looks about: my prof fetches my edits and
locally checks out a branch to compare the changes with git diff.

> But in this diff view you can't edit the files. So you have to
separately open up another window to edit the changes (lets say my prof
only wants to keep some of my changes, but not all).

So while the notebook format is internally text based json, it's not
suitable for real review and editing *in context*, so a different diff
mechanism is used.

Their other problem is the splitting apart of the changes, so the
worktree needs to hold only the staged part of the changes, but with the
other unstaged changes being restorable.

I'm rather interested in this are as it is a common engineering tool
workflow problem.

Philip
