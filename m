Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24283C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 21:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiFHVBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiFHVBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 17:01:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6240A3C
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 14:01:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 346F219261A;
        Wed,  8 Jun 2022 17:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HWrTk8nkT5l+8QvYBQT52fuliCXAZ/duybkLYN
        RTbB0=; b=ioly3Ne5wm36VYsL73lce82TeOF0xQe1a7C2dnrrNhuPVSvFq4il5t
        3PMYO5nvTRBykRplG6fEhUWrI0U/lrbbx2/9zUJOh9ZLTq3rvQE/XEojISgO4YLm
        JUJatOtQWGJt0zrKI2o9dVZSolw+xr//7XfvlIWwnCt3Eln9tGZxY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AFC3192618;
        Wed,  8 Jun 2022 17:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4583192617;
        Wed,  8 Jun 2022 17:01:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqtu8x1fd4.fsf@gitster.g>
        <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
Date:   Wed, 08 Jun 2022 14:01:35 -0700
In-Reply-To: <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com> (Derrick
        Stolee's message of "Wed, 8 Jun 2022 15:46:50 -0400")
Message-ID: <xmqq5ylarhsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F55F03C-E76E-11EC-97F0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Is it an error if bundle.<id>.list and the contents disagree?
>
> I think this can be flexible. It is not difficult to treat the .list
> value as advisory, so we can ignore disagreements. If we start making
> decisions that hinge on the value of .list, then we can start treating
> it as an error.
>
> Or: maybe the .list value is so "advisory" that it is useless, and I
> should just drop it from the schema.

I was wondering about the same thing ;-)

>>> +Related Work: GVFS Cache Servers
>>> +--------------------------------
>>> ...
>>> +During a `git fetch`, a hook requests the prefetch endpoint using the
>>> +most-recent timestamp from a previously-downloaded prefetch packfile.
>>> +Only the list of packfiles with later timestamps are downloaded.
>> 
>> That sounds quite straight-forward.  Do you envision that their
>> incremental snapshot packfile chains can somehow be shared with the
>> bundle URI implementations?  Doesn't it make it more cumbersome that
>> this proposal uses the bundles as the encapsulation format, rather
>> than packfiles?  As you are sending extra pieces of information on
>> top of the payload in the form of table-of-contents already, I
>> wonder if bundle.<id>.uri should point at a bare packfile (instead
>> of a bundle), while multi-valued bundle.<id>.prerequisite give the
>> prerequisite objects?  The machinery that is already generating the
>> prefetch packfiles already know which packfile has what
>> prerequisites in it, so it rather looks simpler if the solution did
>> not involve bundles.
>
> The prefetch packfiles could be replaced with bundle URIs, if desired.
> ...
> So in this world, the bundle URIs could be used as a replacement for
> downloading these prefetch packfiles (bundles with filter=blob:none)
> but the bundled refs become useless to the client.

That's all understandable, but what I was alluding to was to go in
the other direction.  Since "bundle URI" thing is new, while the
GVFS Cache Servers already use these prefetch packfiles, it could be
beneficial if the new thing can be done without bundle files and
instead with packfiles.  You are already generating these snapshot
packfiles for GVFS Cache Servers.  So if we can reuse them to also
serve "git clone" and "git fetch" clients, we can do so without
doubling the disk footprint.

Even if you scrapped the "bundle URI" and rebuilt it as the
"packfile URI" mechanism, the only change you need is to make
positive and negative refs, which were available in bundle files but
not stored in packfiles, available as a part of the metadata for
each packfile, no?  You'd be keeping track of associated metadata
(like the .timestamp and .requires fields) in addition to what is in
the bundle anyway, so...
