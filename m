Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D2C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5889423A1C
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbhAUP21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732853AbhAUPZz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 10:25:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AEC06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:25:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c6so2978196ede.0
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=IJ9Y3Ge945uOIkLL7BJPNOIaMTdPaXOQQYmFU9uxns4=;
        b=aT/ezbJwjHpC0DTIZ54Qu47/nXiLJFTGCMZt6it0rVItIyRCX6ZzyktRs99eGZksmM
         c/DdT+pygJJri20Fm4h57c6LGnDpiX14EDVsXY+b57suZTRZ0OcqxKgo1ehacKixeUsh
         1CKROoapSE1QdQAxme7+Fb0wlpNlKWBTfnBglVENIyUZkJdOC5shDtK1W7hCMK1wxXyb
         j6cGH/ti/F+Vjk4CkndPFisXiqJIwKg89Uy+T98vDWv+ZJUFClq6GOSeeWG5wGwuRcsz
         qlI2PAzrvVLe9f/Hk4wBVG5MzilFEId/EjTPgcbId9jqjfzkM7mvpChgAkz0s98w7rUT
         OyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=IJ9Y3Ge945uOIkLL7BJPNOIaMTdPaXOQQYmFU9uxns4=;
        b=KkNEIa8ETAkIv7cD1tzlqTkjjX+0G4eLx2Xiu42z6qr8wtISSTwthEwcejjz0B0KoC
         KsLvMHM4ijSnaV7npAIkxepgkXSW156pQN6ERWdnsPLD6bSSBqTenVGhbk3wwb1nc3VB
         6gCPxuLGPpbFNgSPAczn4mQt6u0k6fNegTbRNruG/V2x1AUsS/IhmpgiNCwbE2A59jD5
         pdfgzhLU4Y4aEaZ+A72Cer/1X/qW6V+w+TGhm/6VvctshYq6B4lnfDfKBp51aCWomy1r
         6q5a6bBnMRvkNjW0mY3BLyXP9bd8COA75G5fNN+zBEUyZ3V4Jcz+ljP7nO6IdR+6Mhin
         wlng==
X-Gm-Message-State: AOAM533EGQcu+sBt07kI10AsKJfWLd4mVLPyk111qDAMfsn/wPRTq4vt
        NSWURveApR90OhEcnJm4jJ0=
X-Google-Smtp-Source: ABdhPJyLVPLpgb0REo1Qhqx+BIbLoK7ABDgMxlcARlt4JCe5qCXOomGNL9eIC55jqAi8KtQBAVo7vA==
X-Received: by 2002:aa7:c308:: with SMTP id l8mr11971931edq.246.1611242708573;
        Thu, 21 Jan 2021 07:25:08 -0800 (PST)
Received: from cpm12071.local ([79.140.115.135])
        by smtp.gmail.com with ESMTPSA id q2sm2867243edv.93.2021.01.21.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:25:07 -0800 (PST)
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
 <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/7] worktree: teach `list --porcelain` to annotate
 locked worktree
Message-ID: <gohp6kv9bq4a32.fsf@gmail.com>
In-reply-to: <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com>
Date:   Thu, 21 Jan 2021 16:25:06 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Phillip,

Phillip Wood writes:

> Hi Rafael
>
> Thanks for reworking this to use c_quote_path(). I have a couple of
> comments below.
>

Thanks for reviewing this patch.

> On 19/01/2021 21:27, Rafael Silva wrote:
>> Commit c57b3367be (worktree: teach `list` to annotate locked worktree,
>> 2020-10-11) taught "git worktree list" to annotate locked worktrees by
>> appending "locked" text to its output, however, this is not listed in
>> the --porcelain format.
>> Teach "list --porcelain" to do the same and add a "locked" attribute
>> followed by its reason, thus making both default and porcelain format
>> consistent. If the locked reason is not available then only "locked"
>> is shown.
>> The output of the "git worktree list --porcelain" becomes like so:
>>      $ git worktree list --porcelain
>>      ...
>>      worktree /path/to/locked
>>      HEAD 123abcdea123abcd123acbd123acbda123abcd12
>>      detached
>>      locked
>>      worktree /path/to/locked-with-reason
>>      HEAD abc123abc123abc123abc123abc123abc123abc1
>>      detached
>>      locked reason why it is locked
>>      ...
>> In porcelain mode, if the lock reason contains special characters
>> such as newlines, they are escaped with backslashes and the entire
>> reason is enclosed in double quotes. For example:
>>     $ git worktree list --porcelain
>>     ...
>>     locked "worktree's path mounted in\nremovable device"
>>     ...
>> Furthermore, let's update the documentation to state that some
>> attributes in the porcelain format might be listed alone or together
>> with its value depending whether the value is available or not. Thus
>> documenting the case of the new "locked" attribute.
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>>   Documentation/git-worktree.txt | 16 ++++++++++++++--
>>   builtin/worktree.c             | 13 +++++++++++++
>>   t/t2402-worktree-list.sh       | 30 ++++++++++++++++++++++++++++++
>>   3 files changed, 57 insertions(+), 2 deletions(-)
>> diff --git a/Documentation/git-worktree.txt
>> b/Documentation/git-worktree.txt
>> index 02a706c4c0..7cb8124f28 100644
>> --- a/Documentation/git-worktree.txt
>> +++ b/Documentation/git-worktree.txt
>> @@ -377,8 +377,10 @@ Porcelain Format
>>   The porcelain format has a line per attribute.  Attributes are listed with a
>>   label and value separated by a single space.  Boolean attributes (like `bare`
>>   and `detached`) are listed as a label only, and are present only
>> -if the value is true.  The first attribute of a working tree is always
>> -`worktree`, an empty line indicates the end of the record.  For example:
>> +if the value is true.  Some attributes (like `locked`) can be listed as a label
>> +only or with a value depending upon whether a reason is available.  The first
>> +attribute of a working tree is always `worktree`, an empty line indicates the
>> +end of the record.  For example:
>
> I think it would be helpful to document that the reasons are quoted
> according core.quotePath.
>

Good point. I'll include this addition on the next revision.

-- 
Thanks
Rafael
