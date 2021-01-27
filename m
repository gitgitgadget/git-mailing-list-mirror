Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F25C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB87207E8
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhA0NpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA0NoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 08:44:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B6C06174A
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:43:30 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w124so2157863oia.6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DVDwzKrpH1cu9dw1KB5A9xbNqSuEImupz6yKCmqCErM=;
        b=k7fRAWcK2f44Vj6OSz74l/UJiMNV+tL4I1zHWP+JF4kzvagOOfuzwBajASIkzpPlpB
         coSi1uQ9Po6D2dxxBGnE0y6jLc7NPiF+wN43RBs6J/JQxqyR+jCBH+e9xNs08fEPaBAN
         EZfGW+6m2JFcXS89HbH/6tWMvVMQrkYBK8+bQILMX/SEM7UQ4Jjm8lPiwitubPTmoNPM
         QVn+0OvvqtG3RPle4Fl+WV8S1FIO/3i0tNX+V2XNZh0Pchva2Sznfmo1Z8/hENAdruGM
         epSRqRc5+P33DLmKL/Pct0Gmk1Kfmrf0fnDLNx2ZpoJymGsjxtdevFpJGAO5ppzXCP+f
         xTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DVDwzKrpH1cu9dw1KB5A9xbNqSuEImupz6yKCmqCErM=;
        b=Gq6oKplV1lsfMmVGalyEjhkDyXLCsp+6QwgyFuURsnBGs3WTqjeZG1vgdrSYK8mP2c
         qIhIhVDnZqD3xFk2Sg6maMllQrAHGLmBSME2YHBmbqTe8G8VIw1lUxI8/aOsTPbdjwKH
         ZbYM3nqaM9aPKhZcrViOb1TcLblRBKLFvZPd5ouzlFZGw9UxovwLRRJpyilKAf3jrNVw
         arPOtOIR0xeMKpioJMbGpk4+oe22uG8pX9E6Ia4EayiEzfwitDwuQUpbw3/oCu4p6BaH
         iUo205NHbjkwZ5oGa2WR6cjHa7qbw7+1BZ0JNsdGmKEkH64Mekn8exk3GrpOrMFaOurd
         nQeA==
X-Gm-Message-State: AOAM531Nd7sSppOZx27bTGXgchukwjVZlEtZu2kiFCB1l9c9r3/+d33r
        PXH0ebyWEPACqhQ33EXzqTs=
X-Google-Smtp-Source: ABdhPJyf8P7oGY5cSqxnqUPiWkvCn9HEEBHpzXsZFykAZZjf09ZWpNGG33V4klGcHhNUGU14yXksBA==
X-Received: by 2002:aca:edd3:: with SMTP id l202mr3098061oih.59.1611755009309;
        Wed, 27 Jan 2021 05:43:29 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa? ([2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa])
        by smtp.gmail.com with UTF8SMTPSA id t16sm365245otq.17.2021.01.27.05.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 05:43:28 -0800 (PST)
Subject: Re: [PATCH 02/27] sparse-index: implement ensure_full_index()
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <ebbe8569dcc16f2ae235c4167be0e72a53982982.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BE3tLmfwyncbdTKZUgLYH_8M9zMjH=+LJG4bdGcbYDPMg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef86c7fc-e811-036b-b2e3-221e3bdb624a@gmail.com>
Date:   Wed, 27 Jan 2021 08:43:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE3tLmfwyncbdTKZUgLYH_8M9zMjH=+LJG4bdGcbYDPMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2021 10:05 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> Sparse directory entries have a specific 'ce_mode' value. The macro
>> S_ISSPARSEDIR(ce) can check if a cache_entry 'ce' has this type. This
>> ce_mode is not possible with the existing index formats, so we don't
>> also verify all properties of a sparse-directory entry, which are:
>>
>>  1. ce->ce_mode == 01000755
> 
> This is a weird number.  What's the reason for choosing it?  It looks
> deceptively close to 0100755, normal executable files, but has the
> extra 0, meaning that ce->ce_mode & S_IFMT is 0, suggesting it has no
> file type.
> 
> Since it's a directory, why not use S_IFDIR (040000)?
> 
> (GITLINK does use the weird 0160000 value, but it happens to be
> S_IFLNK | S_IFDIR == 0120000 | 040000, which conveys "it's both a
> directory and a symlink")

I forget how exactly I came up with these magic constants, but then
completely forgot to think of them critically because I haven't had
to look at them in a while. They _are_ important, especially because
these values affect the file format itself.

I'll think harder on this before submitting a series intended for
merging.

>>  2. ce->flags & CE_SKIP_WORKTREE is true
> 
> Makes sense.
> 
>>  3. ce->name[ce->namelen - 1] == '/' (ends in dir separator)
> 
> Is there a particular reason for this?  I'm used to seeing names
> without the trailing slash, both in the index and in tree objects.  I
> don't know enough to be for or against this idea; just curious at this
> point.

It's yet another way to distinguish directories from files, but
there are cases where we do string searches up to a prefix, and
having these directory separators did help, IIRC.

>>  4. ce->oid references a tree object.
> 
> Makes sense...but doesn't that suggest we'd want to use ce->ce_mode = 040000?

...

>> +#define CE_MODE_SPARSE_DIRECTORY 01000755
>> +#define SPARSE_DIR_MODE 0100
> 
> Another magic value.  Feels like the commit message should reference
> this one and why it was picked.  Seems odd to me, and possibly
> problematic to re-use file permission bits that might collide with
> files recorded by really old versions of git.  Maybe that's not a
> concern, though.
> 
>> +#define S_ISSPARSEDIR(m) ((m)->ce_mode == CE_MODE_SPARSE_DIRECTORY)
> 
> Should the special sauce apply to ce_flags rather than ce_mode?  Thus,
> instead of an S_ISSPARSEDIR, perhaps have a ce_sparse_dir macro
> (similar to ce_skip_worktree) based on a CE_SPARSE_DIR value (similar
> to CE_SKIP_WORKTREE)?
>
> Or, alternatively, do we need a single special state here?  Could we
> check for a combination of ce_mode == 040000 && ce_skip_worktree(ce)?

The intention was that ce_mode be a unique value that could only
be assigned to a directory entry, which would then by necessity be
sparse. Checking both ce_mode and ce_flags seemed wasteful with the
given assumptions

...

>> +       /* Copy back into original index. */
>> +       memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
>> +       istate->sparse_index = 0;
>> +       istate->cache = full->cache;
> 
> Haven't you leaked the original istate->cache here?

Yes, seems so. Will fix.

Thanks,
-Stolee
