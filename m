Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52975C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1B2077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3LD2iMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAXVKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:10:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44360 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgAXVKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:10:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so3461569qkb.11
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUQ3znXJO64xzsn/cuI/8bkC4gCJ/EAam40RLv4U5n8=;
        b=n3LD2iMTsp/pM3rgSfdfXjH8R8JP115tG+BxFGKFcQJQg6uGQHEaovMgQYaZKnLjKo
         pozT0BtOqYHKasfD/CpWObqeSBAt49/Rrm2VE0yw9MCdNrhI5flO2TlSEYKT0BgBxy2a
         mWJNQr3FKzl5ZJw1P3nWrF13UWa/3ypLc0hOb77AutAZXxsEUNwMc8Ucjk9L6RvxDz/M
         sQRc0k7Syt+q9mtbYiWT9lGzpYf5oddXEmbptzDcf4o1u/x1zZdZgHVlnU/Iw2ZNdaQK
         7mclWPfIcsxu6jRyOjeJUqnynjn7m9gobAKEsEbIKmWpZZXkaEHAbrvPxtpSX0Lh9SES
         i8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUQ3znXJO64xzsn/cuI/8bkC4gCJ/EAam40RLv4U5n8=;
        b=Zy9waaeyVGleu58uPSHejJ4aqdzzgXc/2xViVm6DEdfLSwaOqulLCnV38LQklR6zuy
         bk+hbaWgV0cMqodPugKQZ8tILSXQKNHfC8BKzcNG3O0EraOcRoVKgbIMIYgMvAXncpa8
         /yFkdbRAgngiw5LaWWyPEM5yl4tef6UCUsMZw+I9M6w13ww5mDrjllDiZ2+mVf5iKnHs
         C816tQQptYoRLqehZThtSKjss80muDZTpqRu4C1f8W7NXcjTEQJ8Z0U1vRi7Z4V1SR5V
         0Q3NdrqPPpfhvC0qRrFBZNu+Zrh0MEtdW5IiKAaROnFE6QX7CmH3yxSmfcK50HPTt5bu
         TtHw==
X-Gm-Message-State: APjAAAUQA1OJrTIm1cjonVNWEDO0jdzoalOWqkUqEfQ/6VRvlRsFzPM3
        FtnUeA4qc3+Q8d9/LAV1GMB5tJVQ1GE=
X-Google-Smtp-Source: APXvYqzOJu28Hu1IWMHm8IS3AuwyhCnPdxa5zDzJ7ull64t2Wt5+oKcTOuGrN3tSEaWITdJ6a+CpJg==
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr4440682qkj.99.1579900222306;
        Fri, 24 Jan 2020 13:10:22 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a0e6:7d5:ea31:352? ([2001:4898:a800:1012:521a:7d5:ea31:352])
        by smtp.gmail.com with ESMTPSA id f28sm2180063qkk.130.2020.01.24.13.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 13:10:21 -0800 (PST)
Subject: Re: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
 <20200114212548.GD3949560@coredump.intra.peff.net>
 <e325daa4-5a26-3652-5f46-06203403e51d@gmail.com>
 <20200114224818.GD3957260@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d4fe0b4a-9e3f-6669-9068-d7b4b8934d1b@gmail.com>
Date:   Fri, 24 Jan 2020 16:10:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200114224818.GD3957260@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2020 5:48 PM, Jeff King wrote:
> On Tue, Jan 14, 2020 at 05:11:03PM -0500, Derrick Stolee wrote:
> 
>>> Do we need to document these rules somewhere? Naively I'd expect
>>> "--stdin" to take in literal pathnames. But of course it can't represent
>>> a path with a newline. So perhaps it makes sense to take quoted names by
>>> default, and allow literal NUL-separated input with "-z" if anybody
>>> wants it.
>>
>> This is worth thinking about the right way to describe the rules:
>>
>> 1. You don't _need_ quotes. They happen to come along for the ride in
>>   'git ls-tree' so it doesn't mess up shell scripts that iterate on
>>   those entries. At least, that's why I think they are quoted.
> 
> It's not just shell scripts. Without quoting, the syntax becomes
> ambiguous (e.g., imagine a file with a newline in it). So most Git
> output that shows a filename will quote it if necessary, unless
> NUL separators are being used.

Good to know.

>> 2. If you use quotes, the first layer of quotes will be removed.
> 
> I take this to mean that anything starting with a double-quote will have
> the outer layer removed, and backslash escapes inside expanded. And
> anything without a starting double quote (even if it has internal
> backslash escapes!) will be taken literally.

Hm. Perhaps you are right! The ls-tree output for the test example
is:

	deep
	folder1
	folder2
	"zbad\\dir"
	zdoes*exist

so the "zdoes*exist" value is not escaped. I believe the current
logic does something extra: consider supplying this input to
'git sparse-checkout set --stdin':

	deep
	folder1
	folder2
	"zbad\\dir"
	zdoes\*exist

then should we un-escape "\*" to "*"? Or is this not a valid input
because a backslash should have been quoted into C-style quotes?

The behavior in the current series allows this output that would
never be written by "git ls-tree".

> That would match how things like "update-index --index-info" work.
> 
> As far as implementation, I know you're trying to keep some of the
> escaping, but I think it might make more sense to do use
> unquote_c_style() to parse the input (see update-index's use for some
> prior art), and then re-quote as necessary to put things into the
> sparse-checkout file (I guess quoting more than just quote_c_style()
> would do, since you need to quote glob metacharacters like '*' and
> probably "!"). But as much as possible, I think you'd want literal
> strings inside the program, and just quoting/unquoting at the edges.

I was playing around with this, and I think that quote_c_style() is
necessary for the output, but we have a strange in-memory situation
for the other escaping: we both fill the hashsets with the un-escaped
data and fill the pattern list with the escaped patterns.

I'll add a commit with the quote_c_style() calls during the 'list'
subcommand.

>> How much of this needs to be documented explicitly, or how much should
>> we say "The input format matches what we would expect from 'git ls-tree
>> --name-only'"?
> 
> I think it's fine to say that, and maybe call attention to the quoting.
> Like:
> 
>   The input format matches the output of `git ls-tree --name-only`. This
>   includes interpreting pathnames that begin with a double quote (") as
>   C-style quoted strings.
> 
> Disappointingly, update-index does not seem to explain the rules
> anywhere. fast-import does cover it. Maybe it's something that ought to
> be hoisted out into gitcli(7) or similar (or maybe it has been and I
> just can't find it).

I'll start the process by using your recommended language. I noticed
also that the 'set' command doesn't actually document what happens
when in cone mode, so I will correct that, too.

Thanks,
-Stolee

