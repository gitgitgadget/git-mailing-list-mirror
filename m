Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9633EC433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 13:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356300AbiDLNzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356312AbiDLNzH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 09:55:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E196357494
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 06:52:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b16so22362141ioz.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sJ557UlTeZ0odrarBnjbmd6MSo27ZiqlqvPJeEKiSiM=;
        b=O4dlJrZCI9yfDeIQ2KleG1NdzuclNSMx1JiScmLSE2vBB5tkloo54bCYQzR3ZgG9Wt
         fFG9f/OVb63RZl8lTFToQcCfv+Y0V4ehI24IqTPYoFnpgEM3ameTLJfLU6t9u0Xalku5
         BqNemBQSnlMtPWzQ/3+bqSa1HVnSQ2f3bwf9LGxPBTvZcw+YtyPZywPcDfBnImMHa6Yd
         cJ91BjhF5h7e4vA4syyZb1tQ3NVXx6wt6q2lLf86gOCaf1ZrGE/wJ2qYlehXFGL1+78m
         PECpdsXG1jsLg2XSz77UIndz43iYpatmCAtUk4YW7Y1qje77ev/AiR0auV75J4Cd24ah
         Tmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sJ557UlTeZ0odrarBnjbmd6MSo27ZiqlqvPJeEKiSiM=;
        b=PRpILeDyZJtEfK2P7nr+cwXmGOL+qfzoiHiYXK/iEhkiM4z2ZoLJrbdKK9tI16Stvf
         XESTqSVREcRlzaEejq6dK/Bu31YBKbFDzM91SJuY4L818wgm57CyFX1pWYwlUsCfcdiR
         gZXwozFEaiOQLza3C9e1Dg0SRBH5ulbeYSau7554ecg7a/2FY+9twZTGwxWem9xDheRc
         RVhqG13d7PjSZCNMJXHwJlSr5aImytOLgJFd+b9vaSzGYrr3f8eYh0rtL5EzBvmf9Mon
         MsPy5fMTwif4Gfq8vCUWjMBANB0Y0iciN035ONGvdlW/nB5RLJ9ndg7C7dEuSheeDuVe
         YSSg==
X-Gm-Message-State: AOAM532nTj0QPBwV7sKmKMUXpZooIeA1JvS6o4MxOepByYyNnh9EXbBn
        fNr8n6rBPTyuRwGXeueyemX2
X-Google-Smtp-Source: ABdhPJwFDfF6SqjoXEF2VX1yMqdjGtRq9WYCcltwka1RbijVucnB4RhkOXAbVVS0rmZoscS+qBQUTw==
X-Received: by 2002:a05:6602:134f:b0:63c:a7ba:e8d with SMTP id i15-20020a056602134f00b0063ca7ba0e8dmr16099961iov.180.1649771567165;
        Tue, 12 Apr 2022 06:52:47 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i136-20020a6b3b8e000000b0064faa3ebc96sm2011696ioa.33.2022.04.12.06.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 06:52:46 -0700 (PDT)
Message-ID: <1f027d22-9c5c-7ccf-37e7-611d67de7cfd@github.com>
Date:   Tue, 12 Apr 2022 09:52:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] object-name: diagnose trees in index properly
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
 <xmqqlewaerqd.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqlewaerqd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/2022 2:32 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When running 'git show :<path>' where '<path>' is a directory, then
>> there is a subtle difference between a full checkout and a sparse
>> checkout. The error message from diagnose_invalid_index_path() reports
>> whether the path is on disk or not. The full checkout will have the
>> directory on disk, but the path will not be in the index. The sparse
>> checokut could have the directory not exist, specifically when that
>> directory is outside of the sparse-checkout cone.
>>
>> In the case of a sparse index, we have yet another state: the path can
>> be a sparse directory in the index. In this case, the error message from
>> diagnose_invalid_index_path() would erroneously say "path '<path>' is in
>> the index, but not at stage 0", which is false.
>>
>> Add special casing around sparse directory entries so we get to the
>> correct error message. This requires two checks in order to get parity
>> with the normal sparse-checkout case.
> 
> That all makes sense, but let me ask a more basic (and possibly
> stupid) question and a half.

All of these questions are good thoughts. 

>  - When running 'git cmd :<path>' where '<path>' is a directory,
>    even before the "sparse-index" or "sparse-checkout" world, I
>    sometimes wished that ":<path>" resolved to the object name of
>    the tree recorded in the cache-tree, if we have one.  If we are
>    living in the "sparse-index" world, and the paths underneath
>    '<path>' are not in the index (because we are not interested in
>    them), we should be able answer "git rev-parse :<path>" with the
>    name of the tree object.  It is a "new feature" regardless of
>    sparse-index, but...

I also considered "what if we made this 'just work' for trees in the
index?" The issue I found is that we might need to generate the cache-tree
extension when it does not exist (or is not up-to-date).

For this series, I erred on matching existing behavior before
adding such a feature. It is unfortunate that any work to show
trees this way would essentially revert patches 3 and 4 of the
current series.

>    ...I wonder if it is sensible to add more code to
>    engrave in stone that we would not support it and keep treating
>    the index as if it is a flat list of paths to blobs (and commits,
>    for submodules)?

I don't consider any code change to be "engraved in stone", including
these tests that I am adding. Tests document expected behavior. If we
decide to change that expected behavior, then we can change the tests.
Better to have tests that change when we are making a choice to change
behavior than to not have that evidence of a behavior change at all.

Unfortunately, we did not previously have tests for "git show :dir",
so this is the first time we are documenting the behavior.

>  - When running 'git cmd :<path>' where '<path>' is *not* a
>    directory but is not in the index because of "sparse-index"
>    (i.e. a leading directory of '<path>' is represented as a tree in
>    the index), should ":<path>" index expand the "tree" index entry
>    on-demand, so that <path> has its own entry in the index, as if
>    no "sparse-index" is in effect?

There was one case of test_sparse_match that could have been a
test_all_match: "git show :folder1/a". Since folder1/a is discovered in
the index, Git doesn't check the worktree for the existence of the file to
report any different behavior. Changing the test works without any code
change, so I'll update that in v2.

>    The tests I saw in the series
>    were mostly asserted with test_sparse_match, not test_all_match,
>    so I couldn't tell what the expectations are.

The reason for test_sparse_match instead of test_all_match is because the
error messages change depending on the existence of the path in the
worktree. For example "git show :folder1/" in the test script would have
this output difference:

+ diff -u full-checkout-err sparse-checkout-err
--- full-checkout-err   2022-04-12 13:35:51.430805689 +0000
+++ sparse-checkout-err 2022-04-12 13:35:51.430805689 +0000
@@ -1 +1 @@
-fatal: path 'folder1/' exists on disk, but not in the index
+fatal: path 'folder1/' does not exist (neither on disk nor in the index)

>  - More generally, if <leading> path is represented as a
>    "sparse-dir" entry, should ":<leading>/<lower>" cause the index
>    entry for <leading> path to be expanded on-demand?  I am guessing
>    that the answer is yes, as we wouldn't be able to even tell if
>    such a path <leading>/<lower> would exist in the index if the
>    index were converted to full upfront.

This is what happens, but it happens inside index_name_pos(), so there
isn't any change necessary in the builtin to handle this. Tests such as
"git show :folder1/a" demonstrate this behavior.

Now, there could be a _faster_ way to do this if we did not depend
directly on index_name_pos(). Using index_name_pos() will trigger the
index expansion, which is necessary for some compatibility with the sparse
index.

In this case, we don't really care what _position_ the cache entry is in,
we just want to know if the path exists in the index or not.

For that, we could extract a helper method out of the implementation of
index_name_pos() to be something like index_name_exists(). The common code
between the two implementations is to find a position in the index that
either corresponds to the exact path _or_ is a sparse directory (or the
path definitely doesn't exist in the index). From that point,
index_name_exists() could do a tree walk to find the path inside the tree.

All of this is _possible_, but I also understand that running "git show
:<path>" is not common for users to run directly. Instead, I've seen this
used by IDEs to find the staged version of a file. This is not likely to
be run for paths outside of the sparse-checkout cone.

I think that this is not the only place that could benefit from an
index_name_exists() method, but I'm not ready to focus on improving
performance for queries outside of the sparse-checkout cone.

Thanks,
-Stolee
