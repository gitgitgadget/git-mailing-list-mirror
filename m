Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA3C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FEC61152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhJNR1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJNR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:27:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67791C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so7808717yba.20
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0jxNJ2pRyR5f/z800rio/+kWW3pOUgmvmrExlV4X+xU=;
        b=b5hQAPFMmXt2zO3HDII0+FS2/4gS0txPyFhAhnIe7z+FfzwldmSAHEDphC9RXnh+3G
         xEayn7tQOaPLgXK9gQM5e2tZvoGy8PyajUhXXUZZzue1gYR17PAs+sAEAPwJudy/Y+or
         IdII2brkLpOHN00/9dYEWtY6/dofx3e+n4vw00zlHtSPK0nWHrKQOHj/IAfiQp8EWNNP
         S2wYIzm6D2PUgwNJIgG4pF1IC6c7PSzGir90qngMCyG04y1FjR7vkntVctHjAcOcAKSZ
         Ah1OG5WkEY0r8OhiSvSaBtC7nBSDKs3xVpJtrih0skeTCuCpgCiWYVoj1X2G3S6yrOpO
         Svpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0jxNJ2pRyR5f/z800rio/+kWW3pOUgmvmrExlV4X+xU=;
        b=DOsu5Kj6wwUHqgtqow9dpet6MyNtWO4PYRiVOW4CVlIk5Xb66UmgzffqBZgk0FkKXE
         0dvfkCzprcYoaRPRT15VjfXGWX8l7In2OhEv3fQ8t7mTy90E/Xf31Trm0M7CDlPw66kW
         grulawyxxvezF+1fBEJ5eZ1A7WBBUX0BZsEF1uukUSWtnZiEU5sizNnHuA7qmergBqHq
         1ZHNR/3kjhog/X0JnfedV0IGLmLTopRT/m9UdM9gZ5I/8yDzoh56zSiqb/Ej19qzsqxE
         5oI0tsAgo+8qSxxUTMmrabeVSvM2Gmc1UOlmACvaMx0x/HifqCAVYSogPmhiszCrygjF
         xFaQ==
X-Gm-Message-State: AOAM533rMKn8GWGM418Seob5OFQRYv3k0vnV97lIoqxUV0hJiopyhMJt
        7Jet65R5tGYGEgBDHb+mTf2Mx3SQ5XF/OA==
X-Google-Smtp-Source: ABdhPJzmOGZG5GOvyiRxCxOS3nFOSW02ljHuk6Xn25ZA2UNfAB528axGzZz/Td2tzBts6ywMGIvAbmI1XJ0eow==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:b3ce:: with SMTP id
 x14mr7688345ybf.358.1634232346707; Thu, 14 Oct 2021 10:25:46 -0700 (PDT)
Date:   Thu, 14 Oct 2021 10:25:44 -0700
In-Reply-To: <xmqqlf2wfzfz.fsf@gitster.g>
Message-Id: <kl6lk0if1pt3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
 <20211013193127.76537-1-chooglen@google.com> <20211013193127.76537-2-chooglen@google.com>
 <xmqqlf2wfzfz.fsf@gitster.g>
Subject: Re: [PATCH v2 1/3] remote: move static variables into per-repository struct
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +struct rewrite {
>> +	const char *base;
>> +	size_t baselen;
>> +	struct counted_string *instead_of;
>> +	int instead_of_nr;
>> +	int instead_of_alloc;
>> +};
>> +struct rewrites {
>
> Missing a blank line between two type decls.

Thanks!
>
>> +	struct rewrite **rewrite;
>> +	int rewrite_alloc;
>> +	int rewrite_nr;
>> +};
>
> It is a bit sad that we still have to keep "struct rewrites"; if we
> see how .remotes and .branches are handled, we probably should have
> left the <array, alloc, nr> 3-tuple for "struct rewrite" without an
> extra layer.

I considered doing this, but I found it non-trivial because some
functions use "struct rewrites" without consideration for whether it is
remote_state->rewrites or remote_state->rewrites_push i.e. the "struct
rewrites" abstraction is doing its job.

> ...such a restructuring would not belong here.  OK.

By "here", I assume you mean "the restructuring doesn't belong in
this topic" vs "the restructuring belongs in this topic but not this
patch".

>> +struct remote_state {
>> +	int config_loaded;
>> +
>> +	struct remote **remotes;
>> +	int remotes_alloc;
>> +	int remotes_nr;
>> +	struct hashmap remotes_hash;
>> +
>> +	struct branch **branches;
>> +	int branches_alloc;
>> +	int branches_nr;
>> +
>> +	struct branch *current_branch;
>> +	const char *pushremote_name;
>> +
>> +	struct rewrites rewrites;
>> +	struct rewrites rewrites_push;
>> +};
>> +void remote_state_clear(struct remote_state *remote_state);
>
> Missing a blank line after "struct" decl.

Thanks!
