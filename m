Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85483C433E1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2F7619A5
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 11:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCWLQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhCWLQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 07:16:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E8C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 04:16:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so19054420otn.10
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GuqGpu4qfHMIXtaDxGF4zmxKMQaZWAokyZZE6stmCX4=;
        b=C77iaZzlV0emTpOg9e3rNFa9DPt9h4zidxOMjQVPoPxLII2UMxzhATmuyqMbEFplil
         98e4E27vCbM19WhHBKPTUzMyPxuKGcVKf7Re/Iv+dq1sHhwuu6I0fFfiC4w5Waii6f70
         nuHE+34IeUmpAJ5IMxMT9AmjXMres5RCpR5mzM8ROV3/7Fa63/hGuV+8IbNtTbY/YLik
         z2pD320Zv/9ee52uTQ1WAPpID6pnIBovyfIGXob0kHTHyB4g6QFHxjKrwStqLpDE0Z67
         pds3YlcUiesv+ZRi5eZBT0un6IXKrOd7WDVaXiVjnNlhKm3U9bWHp/76dRh31JMTM1Xo
         jI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GuqGpu4qfHMIXtaDxGF4zmxKMQaZWAokyZZE6stmCX4=;
        b=FmCMJMusP0lNqA/2Jm7ZC8Vo56YuF8bK1Tb2WHKcXovYWiSkwPxuFP2zKK/vRcPnro
         3koHIRbU9JbUWkQVzUTTlOSabGOw8mpi3f3ETJz1ZUvFmkT7EOjsNEdJxNCjcrQCs06y
         fYrXOz7fdAEXcA2H7IrrxvcUUluvpWarL/DXNIQy+tNhsQq/1+Nlyh0Bw41hXbvtd2nN
         f4HLKh2tmlCijFTJhVwmYanpxSIXBQYDzCvZtHa3hNQeNXuV2nBRrPdu/C22v2v3uX6d
         imnxXR+JCjLjj+z9XjbtKirzC6/lbxAVIYjvH0VuBWMVRgreTm2LN+7KpQ07kvojO1C9
         rjGA==
X-Gm-Message-State: AOAM533e9wmmWJJZF5DfYpwDSHz8KPnYRi8UlF54v0c4lcyGU1Vvzse3
        1BclCBpaRI0Sgj4Yf8raJTg=
X-Google-Smtp-Source: ABdhPJzjAoAPGoh8qJZLH7x4coX8PD0yK/j3Rt0+CA5FNO1yhHD+Syjwext7tGD5YUyVM0wCbtNL/Q==
X-Received: by 2002:a9d:6555:: with SMTP id q21mr3801877otl.301.1616498194823;
        Tue, 23 Mar 2021 04:16:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id s4sm3809098oic.3.2021.03.23.04.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:16:34 -0700 (PDT)
Subject: Re: [PATCH v3 01/20] sparse-index: design doc and format update
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <62ac13945bec13270e0898126756c3f947ae264b.1615912983.git.gitgitgadget@gmail.com>
 <xmqqczvulnfn.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <97d57947-dd5f-bb06-cc40-37a23f1db5d9@gmail.com>
Date:   Tue, 23 Mar 2021 07:16:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqczvulnfn.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2021 7:43 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> This begins a long effort to update the index format to allow sparse
>> directory entries. This should result in a significant improvement to
>> Git commands when HEAD contains millions of files, but the user has
>> selected many fewer files to keep in their sparse-checkout definition.
> 
> This compromise makes sense.
> 
> In the past, we often dreamed of recording trees in the index
> (instead of using a bolted on extension like cache-tree, treating
> trees as first-class citizens) and lazily expanding it only when the
> user starts modifying the paths within the subdirectory.
> 
> But such an optimization never materialized, as the dual and
> conflicting nature of the index to keep track of the contents for
> the "next" commit (for which it is sufficient to just record trees
> for parts that have not been modified) and to cache stat information
> to detect which working tree paths may possibly have modifications
> (for which, we used the one-entry-per-path nature of the cache
> entries so far) was never resolved.
> 
> But if we limit the use of trees-in-index for sparse/cone checkout
> case, we do not even have to worry about having to cache the stat
> information for those paths that we are not going to populate in the
> working tree at all.  It is a great simplification of the problem.

Thanks. I appreciate your input here.
 
>> +  These entries have mode `0040000`, include the `SKIP_WORKTREE` bit, and
>> +  the path ends in a directory separator.
>> +
> 
> Why leading two 0's?  At the tree object level, we do not 0-pad blob
> mode word, and if you are writing for C programmers, you need only
> one '0' prefix to signal that it is in octal (in the on-disk index
> file, the blob mode word is stored in a be16 word).

Fixed.

>> diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
>> new file mode 100644
>> index 000000000000..aa116406a016
>> --- /dev/null
>> +++ b/Documentation/technical/sparse-index.txt
>> @@ -0,0 +1,173 @@
>> +Git Sparse-Index Design Document
>> +================================
>> +
>> +The sparse-checkout feature allows users to focus a working directory on
>> +a subset of the files at HEAD. The cone mode patterns, enabled by
>> +`core.sparseCheckoutCone`, allow for very fast pattern matching to
>> +discover which files at HEAD belong in the sparse-checkout cone.
>> +
>> +Three important scale dimensions for a Git worktree are:
> 
> s/worktree/working tree/; The former is the thing the "git worktree"
> command deals with.  The latter is relevant even when "git worktree"
> is not used (the traditional "git clone and you get a working tree
> to work in").

I guess I'm distracted by using SKIP_WORKTREE a lot, but "working
directory" is more specific and hence better.

>> +These dimensions are also ordered by how expensive they are per item: it
>> +is expensive to detect a modified file than it is to write one that we
>> +know must be populated; changing `HEAD` only really requires updating the
>> +index.
> 
> This is a bit too dense to grok.  Among Populated, there are some
> Modified but it takes lstat(2) per path or fsmonitor listening to
> inotify to know which ones are in the Modified set.  Is that the
> "expensive" you are referring to here?  I am not sure how you
> compared the cost to know if a path is modified or merely populated
> with the cost of "write one that we know must be populated" (which I
> take as "given a populated file, make modification to it"). 

I could rearrange things here. The important things to note are:

1. Updating index entries is very fast, but adds up at large scale.

2. It is faster to write a file to disk from Git's object database
   than it is to compare a file on disk to the copy in the database,
   which is frequently necessary when the mtime on disk doesn't match
   the mtime in the index.

> Also it
> is unclear what you mean by "changing HEAD only require updating the
> index".  Certainly when "git switch" flips HEAD from one commit to
> another, you'd update the index and update the files in the working
> tree (in the Populated part that is in the sparse-checkout cone) to
> match, no?

This is unclear of me. I was thinking more on the lines of "git reset"
(soft mode) which updates HEAD without changing the files on disk.

After all of this postulating, I think that the offending sentences
are better off deleted. They don't add clarity over what can be
inferred by an interested reader.

>> In addition, they expect to see all files at `HEAD`.
> 
> It is not clear to me what this means.  After "git add", "git
> ls-files" would expect to see a file that may not even in HEAD.
> After "git rm", it would expect to see some file missing from the
> set of paths in HEAD.  While I do not think that is what you meant
> here, it is hard to guess what you wanted to say.

I'm mixing terms incorrectly. I think what I really mean is

  In fact, these loops expect to see a reference to every
  staged file.

>> One
>> +way to handle this is to parse trees to replace a sparse-directory entry
>> +with all of the files within that tree as the index is loaded. However,
>> +parsing trees is slower than parsing the index format, so that is a slower
>> +operation than if we left the index alone.
> 
> Besides, that would leave in-core index fully populated, so I would
> suspect that you'd lose a lot of benefit that comes from having to
> keep much fewer entries in the in-core index than what is in HEAD.
> It would be nice for "git diff-index --cached" (which is part of
> "git status") to be able to skip a single "tree" entry in the sparse
> index as "known to be untouched", than skipping thousands of paths
> in that single subdirectory (in a mega monorepo project) as "these
> are marked with SKIP_WORKTREE so ignore what is in the working tree".

Absolutely! I'm burying the lead here, so I should get to the real
point by adding this to the end:

 The plan is to make all of these integrations "sparse aware" so
 this expansion through tree parsing is unnecessary and they use
 fewer resources than when using a full index.

>> +Phase I: Format and initial speedups
>> +------------------------------------
>> +
>> +During this phase, Git learns to enable the sparse-index and safely parse
>> +one. Protections are put in place so that every consumer of the in-memory
>> +data structure can operate with its current assumption of every file at
>> +`HEAD`.
> 
> IOW, before they iterate over the in-core index, tree entries are expanded
> into bunch of individual entries with SKIP_WORKTREE bit?  Makes sense.
> 
>> +At first, every index parse will expand the sparse-directory entries into
>> +the full list of paths at `HEAD`. This will be slower in all cases. The
>> +only noticable change in behavior will be that the serialized index file
>> +contains sparse-directory entries.
> 
> Hmph, do you mean that the expansion is done by not replacing each
> "tree" entry with blob entries for the contents of the directory,
> but the original "tree" entry is still left in the in-core index?

I meant by "serialized index file" is that the file written to disk has
the sparse directory entries, but the in-core copy will not (except for
a very brief moment in time, during do_read_index()).

The intention at this point in time is that all code behaves identically
to the full index case, except that the index file itself is smaller due
to these sparse directory entries.

> It is not immediately clear what we are trying to gain by leaving it
> in, but let's read on.  Perhaps we can get rid of cache-tree
> extension and replace its use with these "tree" entries whose
> content paths are populated in the index?

This is an interesting idea, but not one I plan to pursue with this work.

>> +Next, consumers of the index will be guarded against operating on a
>> +sparse-index by inserting calls to `ensure_full_index()` or
>> +`expand_index_to_path()`. After these guards are in place, we can begin
>> +leaving sparse-directory entries in the in-memory index structure.
> 
> It is unclear why "we can begin leaving"; an iterator that only
> expects to see blobs would need to be updated to skip them, too, no?
> They would probably be already skipping blob entries that are marked
> with the SKIP_WORKTREE bit, so it may be just a matter of skipping
> more things than the current code.
> 
> Or did I misread the design presented earlier, and when a directory
> that is outside the cone is expanded into the paths of blobs in the
> directory, the "tree" entry is removed from the in-core index?

I will make this more explicit.
 
Thanks for your help improving this doc! Hopefully the plan is a
little more clear, now.

-Stolee
