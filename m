Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B9C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0965619CE
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCWUKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:10:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58254 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhCWUKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:10:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55887BB68D;
        Tue, 23 Mar 2021 16:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dvlfkcneF8atpdtNMz8kK3DzfrI=; b=njzLD4
        qvYMRSalsvF3eKwx40Js6VmkL6bibC6K69KQfi7u7ktKecKuWE7PcRIfpb9iS1ZC
        Al9wM6l57pmxqadPsUlnpgXMekZwCFD6yIDLLRR43lvcN/rcfydbmTSJ8GI93f9l
        vJRg5GDBOOvfqRQSjj0NNLSIMHxvmgKhmIiWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ykMfr5zIha1Y2DLSnCKSr+iFPAuFj9IK
        8bTt/UNyUvsYsaGqXrBBmG3ky1L1S4KI1a7CFBxeoxdmjykYe+AYnoo25rMulVm0
        GwgYfzub1IBVEXN/kRl6nXHlILUCZnVF/FcNxgztGClPQgcA/NhNVVZbZhuTKk8V
        tebv+uP3crU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D74FBB68C;
        Tue, 23 Mar 2021 16:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA0BCBB68B;
        Tue, 23 Mar 2021 16:10:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 01/20] sparse-index: design doc and format update
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <62ac13945bec13270e0898126756c3f947ae264b.1615912983.git.gitgitgadget@gmail.com>
        <xmqqczvulnfn.fsf@gitster.g>
        <97d57947-dd5f-bb06-cc40-37a23f1db5d9@gmail.com>
Date:   Tue, 23 Mar 2021 13:10:18 -0700
In-Reply-To: <97d57947-dd5f-bb06-cc40-37a23f1db5d9@gmail.com> (Derrick
        Stolee's message of "Tue, 23 Mar 2021 07:16:33 -0400")
Message-ID: <xmqq8s6d3a39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA22D902-8C13-11EB-A405-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> +Three important scale dimensions for a Git worktree are:
>> 
>> s/worktree/working tree/; The former is the thing the "git worktree"
>> command deals with.  The latter is relevant even when "git worktree"
>> is not used (the traditional "git clone and you get a working tree
>> to work in").
>
> I guess I'm distracted by using SKIP_WORKTREE a lot, but "working
> directory" is more specific and hence better.

Since the user's current working directory can be outside any
working tree that is governed by any git repository, "working
directory" is a term I try to avoid when describing the directory
where a checkout of a revision lives.

Documentation/glossary-content.txt is where the suggestion for
"working tree" comes from.

> I could rearrange things here. The important things to note are:
>
> 1. Updating index entries is very fast, but adds up at large scale.

This is the "checkout to match the index to the tree of HEAD" part,
ignoring the cost of writing working tree files out?

> 2. It is faster to write a file to disk from Git's object database
>    than it is to compare a file on disk to the copy in the database,
>    which is frequently necessary when the mtime on disk doesn't match
>    the mtime in the index.

True.  But of course, not having to do either (i.e. having a fresh
cached stat info) would be even faster ;-).

>> Also it
>> is unclear what you mean by "changing HEAD only require updating the
>> index".  Certainly when "git switch" flips HEAD from one commit to
>> another, you'd update the index and update the files in the working
>> tree (in the Populated part that is in the sparse-checkout cone) to
>> match, no?
>
> This is unclear of me. I was thinking more on the lines of "git reset"
> (soft mode) which updates HEAD without changing the files on disk.

OK, and that is in line with your "updating index entries is very
fast (but adds up)".

> After all of this postulating, I think that the offending sentences
> are better off deleted. They don't add clarity over what can be
> inferred by an interested reader.

OK.

> I'm mixing terms incorrectly. I think what I really mean is
>
>   In fact, these loops expect to see a reference to every
>   staged file.

OK.

>  The plan is to make all of these integrations "sparse aware" so
>  this expansion through tree parsing is unnecessary and they use
>  fewer resources than when using a full index.

;-)

> I meant by "serialized index file" is that the file written to disk has
> the sparse directory entries, but the in-core copy will not (except for
> a very brief moment in time, during do_read_index()).

Nice.  That would probably mean cache-tree extension on-disk can go
away, because we can populate in-core cache-tree from these entries.
I've always hated the on-disk encoding of that extension.

Or we are not doing this "extra tree" everywhere (i.e. limited only
to the parts that are marked for "sparse checkout")?

Thanks.
