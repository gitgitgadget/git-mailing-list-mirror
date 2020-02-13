Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F70C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 05:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A702168B
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 05:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olXpQ/VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgBMFOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:14:54 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38670 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgBMFOx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 00:14:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so1881740pjz.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 21:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PydtcV01+Cl4hCDrEoSIz0tiagSNrM6/Hj6WHNO63rs=;
        b=olXpQ/VZMtHDnpaxHnPljPuBKfaFs20dGuqpDGUDgna6iFA4m13GGXNRg3/AETVHX8
         wt3QJo7VJGgFZA/u7tg0Tk6blA/5Ntb5ukv3v48VC9rHjhavhjuWGw37MLTxkUhezYJK
         M5xQc/pUFN5uAFCCkE0KupVDMwM+Wz65YYekPcQg2Bo3iT+IspvDjsw6OJ9ik1vZVPsA
         kTzQ+diUTGhj7hJLYsh6YJCXZySUg8yw8shhKk70y6SMhVaI+u409cG0oSz3kV5VQV4D
         NkCcUgiKusYOhNeEclpF042kZwbUsMBuoDk2qY5RcbtrObbplyCeOPaFFigwwIFQngxk
         G6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PydtcV01+Cl4hCDrEoSIz0tiagSNrM6/Hj6WHNO63rs=;
        b=WiZcYr8veJkiMzq4WWxCoU3wGoVamVHw4OeP1PBGPqNV5a7qq3+s5REP6L6j/fmmcu
         Ep+t9FypQeX90OH6CQXv6vE1AotQJfqNI1oYdtKHP5wrxxg4YcFFWT7YTZKU6OsdjUVi
         1vF8pT6AE6eyIaAuFefmy23BFV0dMAH3ohKKZTZmcVSZBh79Lt8RRmk4jtNsIak/D3aH
         z8dyyn11qSzL8lrUMVgf/9WnVsQVyBOuG7/HE0rs59f7NNiaCRpIoe7h08jUKteNZw2d
         rYa66NdhILOa3iJl4FjWuJDqeZNyCci9EV3e8yPAwKOMUJF5yI+YXk0EwMjyhjOB2d5o
         VoCQ==
X-Gm-Message-State: APjAAAVv8WQEjENRSJ6+KVNL0nUwxRvjSItu/D66pP+BZ/+TmSx4tgOr
        vXt/TiZ/lswrNhsbikdhLjU9Xn05
X-Google-Smtp-Source: APXvYqwa98k1bte5GK/wEwIOxFhBvKiouhx8guvrlYBPSafJUhU19W5Vl6zTKIuW6tkXjmO8IdN1SQ==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id x12mr3143473pja.27.1581570892761;
        Wed, 12 Feb 2020 21:14:52 -0800 (PST)
Received: from [192.168.0.113] ([27.106.79.123])
        by smtp.gmail.com with ESMTPSA id w26sm1038393pfj.119.2020.02.12.21.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 21:14:51 -0800 (PST)
Subject: Re: [PATCH 0/5] object.c: localize global the_repository variable
 into r
To:     Taylor Blau <me@ttaylorr.com>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <20200212201810.GB4364@syl.local>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   parth gala <parthpgala@gmail.com>
Message-ID: <f1e4da02-9411-8a93-ca62-6d7ae7bf4ae8@gmail.com>
Date:   Thu, 13 Feb 2020 10:44:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212201810.GB4364@syl.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 13/02/20 1:48 am, Taylor Blau wrote:
> Hi Parth,
>
> On Wed, Feb 12, 2020 at 07:19:06PM +0000, Parth Gala via GitGitGadget wrote:
>> I have created this commit in response to
>> https://github.com/gitgitgadget/git/issues/379#issue-503866117.
> Fantastic! Thank you for working on this.
>
>> All the functions in object.c which relied on 'the_repository' have
>> been modified.  The functions calling these functions in object.c
>> consisted calls to other functions using 'the_repository' as well, and
>> although I intended to use 'r' at all those instances, I thought it
>> would make more sense when we would deal with their callee functions
>> in another similar patch. What do you think ?
> That makes sense, and follows the conventions that other similar
> refactorings have done in the past.
>
> Any reason why you decided to start with 'object.c'? Not that any such
> reason is necessary, I'm just curious about how you came to this
> decision.

I am new to the git community and while searching for issues to solve I
found the issue linked above. I figured solving it would give me a good
experience navigating between functions and exploring the huge repository.

Initially I grepped to find all functions using `the_repository` but
randomly chose object.c since the refactoring had to start somewhere.
Special thanks to Johannes Schindelin for this.

>> Signed-off-by: Parth Gala parthpgala@gmail.com [parthpgala@gmail.com]
> Even though you *do* need a 'Signed-off-by' in each of your patches,
> adding it in the cover letter is not necessary.

I probably did not check the preview I sent to myself carefully for
this. Will make note of it.

>> Parth Gala (5):
>>    object.c: get_max_object_index and get_indexed_object accept 'r'
>>      parameter
>>    object.c: lookup_unknown_object() accept 'r' as parameter
>>    object.c: parse_object_or_die() accept 'r' as parameter
>>    object.c: clear_object_flags() accept 'r' as parameter
>>    object.c: clear_commit_marks_all() accept 'r' as parameter
>>
>>   builtin/checkout.c               |  3 ++-
>>   builtin/fsck.c                   |  8 +++++---
>>   builtin/grep.c                   |  6 ++++--
>>   builtin/index-pack.c             |  5 +++--
>>   builtin/log.c                    |  3 ++-
>>   builtin/name-rev.c               |  5 +++--
>>   builtin/pack-objects.c           |  3 ++-
>>   builtin/prune.c                  |  3 ++-
>>   bundle.c                         |  8 +++++---
>>   http-push.c                      |  3 ++-
>>   object.c                         | 32 ++++++++++++++++----------------
>>   object.h                         | 12 ++++++------
>>   pack-bitmap.c                    |  5 +++--
>>   reachable.c                      |  6 ++++--
>>   refs.c                           |  3 ++-
>>   revision.c                       |  3 ++-
>>   shallow.c                        | 13 ++++++++-----
>>   t/helper/test-example-decorate.c |  7 ++++---
>>   upload-pack.c                    | 19 ++++++++++++-------
>>   walker.c                         |  3 ++-
>>   20 files changed, 89 insertions(+), 61 deletions(-)
>>
>>
>> base-commit: 0ad714499976290d9a0229230cbe4efae930b8dc
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-545%2FParthGala2k%2Flocalize-the_repository-variable-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-545/ParthGala2k/localize-the_repository-variable-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/545
>> --
>> gitgitgadget
> Thanks,
> Taylor
