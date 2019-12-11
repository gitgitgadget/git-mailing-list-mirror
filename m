Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB9C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7053020409
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hIBKJcwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLKVhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:37:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62382 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKVhb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 16:37:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B776389B1;
        Wed, 11 Dec 2019 16:37:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mYtuBGjjUpaOvjxbT+R0htpoe5w=; b=hIBKJc
        waRI64Ic4LeIUye6uGon2rdBZ5DNkMFqh2Jq05eRpSmDFz5V1CcHaLaW87F0Kqmz
        OuJVpPf2Be6ZO1uoZwIdwRWy/d464CYlhdDlQo+4lwbI2WO1H6Gd/qYcxUaC0vvy
        vFQ9yZ37QZv2VtzaZsu4FyutruL9y1qqa5vdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I8X6xeASqOPnCWZc+dF9niqJ7iv7y4K2
        rED0m/DN1A1buob+rKJbC/g5BjdytT1UKtEOJJaWBh4P918XJ2OSH9ctr1VaoJ4H
        VPsYrWffAWTcyhr1XGk9Pe0n9naeCoTMj4me23LF2+Jal4403ELGrvb/zuynQ6xe
        uo0UmhKgbyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92CD1389B0;
        Wed, 11 Dec 2019 16:37:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB67F389AF;
        Wed, 11 Dec 2019 16:37:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
        <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
        <xmqqtv66og63.fsf@gitster-ct.c.googlers.com>
        <9dbf6d43-ac1e-4790-84e5-4829d21f5fdb@gmail.com>
        <xmqqeexaocos.fsf@gitster-ct.c.googlers.com>
        <3e64b470-93cc-5491-09e1-e499f0a7583d@gmail.com>
Date:   Wed, 11 Dec 2019 13:37:27 -0800
In-Reply-To: <3e64b470-93cc-5491-09e1-e499f0a7583d@gmail.com> (Derrick
        Stolee's message of "Wed, 11 Dec 2019 15:29:38 -0500")
Message-ID: <xmqqa77yo86g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E36D1B4-1C5E-11EA-B72B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The specific example I have in my mind is that the filesystem can have
> "README.TXT" as what it would report by readdir(), but a user can type
>
> 	git add readme.txt
>
> Without core.ignoreCase, the index will store the path as "readme.txt",
> possibly adding a new entry in the index next to "README.TXT". If
> core.ignoreCase is enabled, then the case reported by readdir() is used.
> (This works both for a tracked and untracked path.)

Yes, but which one is "correct"?  readme.txt read from the index or
README.TXT read from the filesystem?  Presumably, when the paths got
first checked out of the index, it would have been in "readme.txt"
on the filesystem, so the user must have done on purpose something
to cause the file to be named in all uppercase since then.

> This is a case that is difficult to control for. We have no source
> of truth (filesystem or index) at the time of the 'git sparse-checkout
> set' command. I cannot think of a solution to this specific issue
> without doing the more-costly approach on every unpack_trees() call.
>
> I believe this case may be narrow enough to "document and don't-fix",
> but please speak up if anyone thinks this _must_ be fixed.

I do not think it "must be" fixed in the sense that "if it hurts,
don't do so" is a sufficient remedy.  But then for exactly the same
reason, I do not think it is worth doing what you do in this patch.

On the other hand, I think runtime case folding, just like what we
do when "git add" is told to handle a path in different case, would
be the only "right" way to match end-user expectations on a case
insensitive system, even though that is a "nice to do so" and
certainly not a "must do so" thing.

> The "git add" behavior made me think there was sufficient precedent
> in Git to try this change.

Since I view that the "git add" behaviour is a "nice to do so"
runtime conversion, I would actually think the approach you
discarded would be more in line with the precedent.

> I'm happy to follow the community's opinion in this matter, including
> a hard "we will not correct for case in this feature" or "if you want
> this then you'll pay for it in performance." In the latter case I'd
> prefer a new config option to toggle the sparse-checkout case
> insensitivity. That way users could have core.ignoreCase behavior without
> the perf hit if they use clean input to the sparse-checkout feature.

I value correctness more---a system that does incorrect thing
quickly is not all that interesting.

Assuming that your users are sensible and feed good data, how much
"performance hit" are we talking about?  Wouldn't this be something
we can make into a "if you have the paths in the correct case, we'll
see the match just as quickly as in the case sensitive system, so
most of the time there is no penalty, but for correctness we would
also fall back to try different cases"?
