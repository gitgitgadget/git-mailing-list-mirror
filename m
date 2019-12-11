Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82378C00454
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32105222C4
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m83StIeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfLKUAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:00:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62860 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKUAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 15:00:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 963A92D3C5;
        Wed, 11 Dec 2019 15:00:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zVn2E6BkXaV26BylPT0Tu3Ejyv4=; b=m83StI
        eKGPqquVkVfjTRw60Bb0Ibi3xwClW4Hb+ncFrH+Io2IXJ1oEvaE8nMlSJ+GyeSgt
        +R6qk6yJrvjR/v+BDnL8Mj767eduRFfRvL3Ly50aucsgGXmY2cxqbV8rWxQjoh19
        EQsUWgEuyqRAK17f3VowAZUh8giPK5QuLdRcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqSrda+Z7EmG8jMXpXjePil40PAeT6qC
        JrUIlisN2m30iVzgF1bYT/IPZLR8pOJxDlD/6xbFXCV7sLQqALW18IgxJdXmQH+n
        hoaTPwjPvp7fHtCIQVHgIs4M6D/5YmAoQ1AvXCILT7syTSZK1t+Yiy6EAInHNWUh
        csUSi6LIYcQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3651F2D3C4;
        Wed, 11 Dec 2019 15:00:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABDD72D3BD;
        Wed, 11 Dec 2019 15:00:06 -0500 (EST)
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
Date:   Wed, 11 Dec 2019 12:00:03 -0800
In-Reply-To: <9dbf6d43-ac1e-4790-84e5-4829d21f5fdb@gmail.com> (Derrick
        Stolee's message of "Wed, 11 Dec 2019 14:11:32 -0500")
Message-ID: <xmqqeexaocos.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3F545DE-1C50-11EA-8145-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I'm trying to find a way around these two ideas:
>
> 1. The index is case-sensitive, and the sparse-checkout patterns are
>    case-sensitive.

OK.  The latter is local to the repository and not shared to the
world where people with case sensitive systems would live, right?

> 2. If a filesystem is case-insensitive, most index-change operations
>    already succeed with incorrect case, especially with core.ignoreCase
>    enabled.

I am not sure about "incorrect", though.  

My understanding is that modern case-insensitive systems are not
information-destroying [*1*].  A new file you create as "ReadMe.txt"
on your filesystem would be seen in that mixed case spelling via
readdir() or equivalent, so adding it to the index as-is would
likely be in the "correct" case, no?  If, after adding that path to
the index, you did "rm ReadMe.txt" and created "README.TXT", surely
we won't have both ReadMe.txt and README.TXT in the index with
ignoreCase set, and keep using ReadMe.txt that matches what you
added to the index.  I am not sure which one is the "incorrect" case
in such a scenario.

> The approach I have is to allow a user to provide a case that does not
> match the index, and then we store the pattern in the sparse-checkout
> that matches the case in the index.

Yes, I understood that from your proposed log message and cover
letter.  They were very clearly written.

But imagine that your user writes ABC in the sparse pattern file,
and there is no abc anything in the index in any case permutations.

When you check out a branch that has Abc, shouldn't the pattern ABC
affect the operation just like a pattern Abc would on a case
insensitive system?

Or are end users perfectly aware that the thing in that branch is
spelled "Abc" and not "ABC" (the data in Git does---it comes from a
tree object that is case sensitive)?  If so, then the pattern ABC
should not affect the subtree whose name is "Abc" even on a case
insensitive system.

I am not sure what the design of this part of the system expects out
of the end user.  Perhaps keeping the patterns case insensitive and
tell the end users to spell them correctly is the right way to go, I
guess, if it is just the filesystem that cannot represente the cases
correctly at times and the users are perfectly capable of telling
the right and wrong cases apart.

But then I am not sure why correcting misspelled names by comparing
them with the index entries is a good idea, either.

> It sounds like you are preferring this second option, despite the
> performance costs. It is possible to use a case-insensitive hashing
> algorithm when in the cone mode, but I'm not sure about how to do
> a similar concept for the normal mode.

I have no strong preference, other than that I prefer to see things
being done consistently.  Don't we already use case folding hash
function to ensure that we won't add duplicate to the index on
case-insensitive system?  I suspect that we would need to do the
same, whether in cone mode or just a normal sparse-checkout mode
consistently.

Thanks.


[Footnote]

*1* ... unlike HFS+ where everything is forced to NKD and a bit of
information---whether the original was in NKC or NKD---is discarded
forever.
