Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F2C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D7620720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 14:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKwIR5nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2OQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:16:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36655 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2OQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 09:16:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so11437111qki.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 06:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0AguKTnizCzZa5zLQpVHh0bkfyNlGCuM4MEfmfCl28=;
        b=PKwIR5nDPafNdIf2xqlEwI94UhFaBMwnJ9KWHWshtqdm3JQO/8nDTK7spYJAusbjbx
         MZu7z23IACQ4NrHWAeLKQ8E7ADdDjkj4YcSmSnjDDWHnFW/DSyQ8ADLGTmxKTC96pK4+
         PmgXvIzZVnH35cTl0JZyDnV9mFAKqKcZ0WyJAIBAhXGQMO+P7UWaFo7SVz/kynKLjAID
         btDYOtd6vh6LTTw6WLOPRI7feZy/IvKnNDpiktbu4ECg8lMM8LByxBZo7UVIqQd/7i0n
         I/GFpS13QlmidjMIHD/nWyqlAlhG8LObTOm4HJ6dLP0gBwxWzbXjH1/Lkxn3rCRHajmp
         jHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0AguKTnizCzZa5zLQpVHh0bkfyNlGCuM4MEfmfCl28=;
        b=TVNYmfBsNFcx4ryCKwI6lo+8U+i2sSqQtQ07qtLwAgr4zYgaVvKV1ce/v2b189hkxp
         qQUFuVFhtxkikqUPngVPIISCTqXbepE9uiM3aSamdyYhrWY5F4xuAfY5NKHFkPKrufIQ
         meP7Hf8doT8TX4UQJVxFLE1nOkx+wDy6hqzj39BO/x36tDhDIVB+i6Mdfw9/KvH7B312
         Krktw29EHAMjSuZKmO4iYUQHYj7RRFxrB8qnxi1Vok66Gr8AKN+f7/6rJ2paMxIn78Ry
         JpPTY4t9qyHo9qPP0d3T7BpJDjULpp+idZABJkwUm/gwdBofxZfseII01IYZ6lp6cWzk
         HdyQ==
X-Gm-Message-State: APjAAAWrXZ3oHdVKBaMEYGka8L/vnrjgy1gqYVVgPlt5AbMqhhnSIKN0
        9BRHASRPVvxGvKVWgRBL+m9HqTgECUE=
X-Google-Smtp-Source: APXvYqx2WZCoSafGzKVbIj7/Ihty0i4GwLSvgP+UGWMUErLoGbPekQNE7V46ZyeHEnqDiO0e8+NKrA==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr28435407qkg.152.1580307372041;
        Wed, 29 Jan 2020 06:16:12 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:90b6:a0a:46b8:addb? ([2001:4898:a800:1010:41ec:a0a:46b8:addb])
        by smtp.gmail.com with ESMTPSA id r13sm1097238qtt.70.2020.01.29.06.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:16:11 -0800 (PST)
Subject: Re: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone
 mode
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
 <20200129101713.GB4218@coredump.intra.peff.net>
 <20200129103352.GD4218@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a85cded-eccf-9f33-4056-08b2923b2861@gmail.com>
Date:   Wed, 29 Jan 2020 09:16:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200129103352.GD4218@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 5:33 AM, Jeff King wrote:
> On Wed, Jan 29, 2020 at 05:17:13AM -0500, Jeff King wrote:
> 
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> If a user somehow creates a directory with an asterisk (*) or backslash
>>> (\), then the "git sparse-checkout set" command will struggle to provide
>>> the correct pattern in the sparse-checkout file. When not in cone mode,
>>> the provided pattern is written directly into the sparse-checkout file.
>>> However, in cone mode we expect a list of paths to directories and then
>>> we convert those into patterns.
>>
>> Is this really about cone mode? It seems more like it is about --stdin.
>> I.e., what are the rules for when the input is a filename and when it is
>> a pattern? In our earlier discussion, I had assumed that command-line
>> arguments to "sparse-checkout set" were actual filenames, and "--stdin"
>> just read them from stdin.
>>
>> But looking at the documentation, they are always called "patterns" on
>> the command-line. Should the "--stdin" documentation make it clear that
>> we are no longer taking patterns, but instead actual filenames?
>>
>> Or am I confused, and in non-cone-mode the "ls-tree | sparse-checkout"
>> pipeline is not supposed to work at all? (I.e., they really are always
>> patterns)?
> 
> Hmph, sorry, I _was_ just confused. I was reading a copy of the manpage
> without your final patch, which made things much clearer.
> 
> So OK, I think the resulting documentation does make things clear. And
> this is just about cone mode, not --stdin. Please ignore my ramblings in
> the rest of the replied-to message. But...
> 
>>> Even more specifically, the goal is to always allow the following from
>>> the root of a repo:
>>>
>>>   git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin
>>>
>>> The ls-tree command provides directory names with an unescaped asterisk.
>>> It also quotes the directories that contain an escaped backslash. We
>>> must remove these quotes, then keep the escaped backslashes.
>>>
>>> However, there is some care needed for the timing of these escapes. The
>>> in-memory pattern list is used to update the working directory before
>>> writing the patterns to disk. Thus, we need the command to have the
>>> unescaped names in the hashsets for the cone comparisons, then escape
>>> the patterns later.
>>
>> OK, this part make sense.
> 
> You could also demonstrate this even without --stdin with something
> like:
> 
>   git config core.sparsecheckoutcone true
>   git sparse-checkout set 'foo*bar'
> 
> which should take that as a literal filename and put the pattern
> 'foo\*bar' in the sparse-checkout file. And your tests do cover that.
> 
> So really there are two separate bugs here, and it might be a little
> easier to explain the "timing of these escapes" thing by doing them
> separately. I.e., the case above needs escaping and we could demonstrate
> the bug with a command-line "set".  And then follow up by fixing the
> problem with correctly de-quoting --stdin.

I've locally split the commit into two parts. That makes things much
simpler to read.

>>> +static char *escaped_pattern(char *pattern)
>> [...]
>> Do we need to catch other metacharacters here (using is_glob_special()
>> perhaps)?
> 
> After de-confusing myself, I think the individual code comments I wrote
> still apply though (especially this one).

I've applied the smaller comments and am now investigating the right
thing to do with other is_glob_special() characters. There is a small
chance that I can replace any "c == '*' || c == '\'" with is_glob_special(),
but we shall see. At the very least, I'll need to expand my tests.

Thanks,
-Stolee
