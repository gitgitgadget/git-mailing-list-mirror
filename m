Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81DC6FD1F
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 00:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCWAGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 20:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCWAGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 20:06:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7582B624
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 17:06:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so13383804plg.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679530013;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN49908h1ro+vyq1ayKOQrFECVOMFdJBXwuYw+4YDNU=;
        b=Bu/8dI1ir28k3TViUaqqjvEv6anlbNjBb3752EX9HkH5H7n9Sd5nVUdtcveJJK9w0q
         nKY/eLWDH9KO4bxv7YlDnQhfMajioT6k2T/mGFl3dslGx6yzVjClKdI7aGJY4Mw0zWZF
         F0h/vcS/gNsj+6MzYu6ggqGzKOE7Q3jdjgBaaXhSsMY2lOQ1mHleyfumvGEb6yvaqVfN
         PqmU1klHIzHEgzDII3YtpN4K9ljp78A2QkxhuiVsrx4TME94LRNHyeTKM+RQn49beJxj
         TQd5oS2I6r7Ww4VtKLVYZS77EsfTibsTDLDEs0deaGeAt00FtbBQvoJfZwOgjUq1CmBA
         jUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679530013;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dN49908h1ro+vyq1ayKOQrFECVOMFdJBXwuYw+4YDNU=;
        b=TxrccLJbtK0/55+vAZzoLAyaBn56I1k14T7mBrFP/e0sSWtsWChHZBGT8Krg5MKjpL
         ho5j6wrnbdKaynftNrKj7/YTamSvi6BeY+n1Oma0Ao0W9khEoJCpEqMgC8taJyHVS/Rx
         XJMSsOy5HO9L0ZDU1L87LJLMe6mIjwXik5fEnh1gkmRsHR903Y5QVidrDysGpQoB/EaP
         b+PQEvC882ZqeoMSclMzoB7QOqfCKbA6Gtdbf2NSeNsT22AKOwcGioZ+FIlET4hWDlbq
         Icrcd+tBpeU3il/KnmneZ0JB4FfuGXFZrIFeRU4ZItb5cWQkhhTRovAXcGe6dCyKAsMM
         +qDQ==
X-Gm-Message-State: AO0yUKXD8gQ8clpHScmoBHCy+SqQ0V8I8hoC0Vq9aVPjSwNe/CBCPe/1
        zLtJwX8Z+kfukM7MV8dVJBBbizgCYTU=
X-Google-Smtp-Source: AK7set/+6K5vTa86QdX+fdt8P6FxxwS8iJsb8QoPp58vPjs+jjZmk/aRwhUK+hhyd+zxg4tiuOlnRg==
X-Received: by 2002:a17:903:74d:b0:1a0:69ba:832e with SMTP id kl13-20020a170903074d00b001a069ba832emr3761679plb.0.1679530013102;
        Wed, 22 Mar 2023 17:06:53 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b0019c92f56983sm11099971pls.120.2023.03.22.17.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:06:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch
 in multiple worktrees
References: <20230119055325.1013-1-carenas@gmail.com>
        <20230120113553.24655-1-carenas@gmail.com>
        <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk>
Date:   Wed, 22 Mar 2023 17:06:52 -0700
In-Reply-To: <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 20 Jan 2023 15:08:02 +0000")
Message-ID: <xmqq355wbaar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Carlo
> ...
> As I said before, it would be much easier for everyone else to
> understand the changes if you wrote out what they were rather than
> saying "look at the tests"....
> ...
>> +	if (!opts->ignore_other_worktrees && !opts->force_detach &&
>> +	    check_branch_path && ref_exists(check_branch_path)) {
>
> I think check_branch_path is NULL if opts->ignore_other_worktrees is
> set so we could maybe lose "!opts->ignore_other_worktrees" here (or
> possibly below where you set check_branch_path).
> ...
>> ...
>> +		if (!opts->ignore_other_worktrees && !check_branch_path && new_branch_info->path)
>> +			check_branch_path = xstrdup(new_branch_info->path);
>
> I'm a bit confused what this is doing.
> ...
>> +test_expect_success 'allow checkout/reset from the conflicted branch' '
>
> I'm not sure what "the conflicted branch" means (it reminds we of
> merge conflicts). Is this just testing that "checkout -b/B <branch>
> <start-point>" works?
> ...
>> +test_expect_success 'and not die on re-checking out current branch even if conflicted' '
>
> I think 'allow re-checking out ...' would be clearer, again I'm not
> sure what's conflicted here.
> ...
>>   -test_expect_success 'not die on re-checking out current branch' '
>> +test_expect_failure 'unless using force without --ignore-other-worktrees' '
>
> This test passes for me - what's the reason for changing from
> test_expect_success to test_expect_failure?
>
> Thanks for working on this

This topic has been dormant for a full two months.  Aside from
comments by Phillip (quoted above), are there remaining things
to be done and issues to be resolved before we can see v5?

Thanks.
