Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE47C7EE23
	for <git@archiver.kernel.org>; Wed, 31 May 2023 13:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjEaNXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbjEaNXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 09:23:12 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED011BF
        for <git@vger.kernel.org>; Wed, 31 May 2023 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
        :To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=S1XZOWLzc2KxjkKmd0a6XV58TFVsHz5mVdUUtdP7mBo=; b=erL6H6
        l8kPsYLLgEKcOGjnQ+hEQEUnnrt+Oy8mgdbOZZbCqwKGBZQoFyV2cKKg+Pfz+I+FKrhsofC6ns/08
        kz3PW9NelDQB64wZPZfP2hFT1D7SyluTkacVSUZIJ3GbMpz/opgsUJo2CNiJSgsZMQYMEY53B7WdK
        VZ9b+nWUuH4=;
Received: from host-89-242-64-91.as13285.net ([89.242.64.91] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1q4Ln1-000ClP-BR;
        Wed, 31 May 2023 14:22:59 +0100
Message-ID: <30385b42-0c6a-3588-2b13-0552c23727f2@iee.email>
Date:   Wed, 31 May 2023 14:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: not robust inconsistent git 2.40.1 with HEAD -> master,
 origin/main, origin/HEAD, origin/master, main
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     Carlos <kaploceh@gmail.com>, git@vger.kernel.org
References: <lxh4jpacuv5ivqp35w5vpbcjlw67r7ix3yog6cc3cu5ij7yqho@mrtr24xxdstx>
 <319cfa79-a508-127f-c201-9f50d5e6fe6a@iee.email>
In-Reply-To: <319cfa79-a508-127f-c201-9f50d5e6fe6a@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2023 11:57, Philip Oakley wrote:
> On 30/05/2023 19:14, Carlos wrote:
>> Running git 2.40.1 with HEAD -> master, origin/main, origin/HEAD, origin/master, main with initial commit on main does not show all the objects from master
>>
>>
>> ! [main] Initial commit
>>  * [master] Initial commit
>>   ! [origin/master] Initial commit
>> ---
>> +*+ [main] Initial commit
>>
> 
> this is the output of `git show-branch` [1] which has its own special
> display format. It's not often used these days.
> 
> The `!` are column markers, as is `*` for the current branch.
> You have three branches listed
> Then you have the `---` divider
> 
> Finally you has the single commit, showing which branches the commit is
> 'on'.
> 
> Be careful to discriminate between being 'on' a branch (at it's tip, by
> name); 'at' an oid (object id / hash); and `in` a branch (below its
> tip); etc.
> 
> 
> [1] https://git-scm.com/docs/git-show-branch
> 
>> the chunk of objects are on master and not main, and yet it shows
>> nothing once checking out to master. 
>>
>> the git-clone operation is not consistent either. It's a disaster.
>>
>> One would think that by now with the more developed work put on to git, it'd
>> be safe to assume the more sense there's on newer versions. But no. This
>>  is the opposite actually. 
>>
>> Now. If by any chance the git-branch operation were to return:
>>
>>   main
>> * master
>>
>> after git-clone, then objects are indeed in place. That is. On master
>>
>> but not if git-branch returns 
>>
>>   main
>> * master
>>   origin/master
>>

You may have accidentally created a local branch called `origin/master`
which you are now confusing with the (unlisted) remote tracking branches.

What does

	git branch -ra

produce?

It will show the local branches first, and then your
`remotes/repo/branches` list (probably colourised).

This should help confirm what you have.
>>
>>
> Philip
P.
