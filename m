Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA46C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888FA64E6C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhBIREv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:04:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51335 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhBIREg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:04:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28D2910A784;
        Tue,  9 Feb 2021 12:03:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BekwvCqLoGMUU7pyqimHv9z4yoI=; b=xh8Mxu
        drvznGQoSL8WAUNc2pqpCPzl8aOWF51x2HkKXVBOjwSIoQVfwBvqi6Tw3rtGaMM5
        hhr+W3NYWUce/W1zrexS18jwgNDPdA1moiTcdLuUvKcs5QFNr5pZ567wQBL573l1
        vPrXEona8O3fozDmz7UAr4q3LgrMEx0IeItXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EckPD6yvkRnl7W+I23cznAK6XQR5D34R
        srFGgMGnRSVpqmiZmhQCDcLtPMtzDwqrwkf1n0CiIYUihAIFXohmVf/1IBpsXTE2
        SHHahLyHYBtEIyTZ50OpJRvmxsURKPQm4fpzuinMSwP4ND1RZqtGTHPUT9zCZEyU
        HdBFwu3aXbE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FB2E10A783;
        Tue,  9 Feb 2021 12:03:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 518A410A77D;
        Tue,  9 Feb 2021 12:03:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/4] gitdiffcore doc: mention new preliminary step
 for rename detection
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <a0e75d8cd6bd32fb1ab2a209bc2079c30995b257.1612870326.git.gitgitgadget@gmail.com>
        <6aa32f94-9c8c-ad26-09ab-4c2028ef1d67@gmail.com>
Date:   Tue, 09 Feb 2021 09:03:38 -0800
In-Reply-To: <6aa32f94-9c8c-ad26-09ab-4c2028ef1d67@gmail.com> (Derrick
        Stolee's message of "Tue, 9 Feb 2021 07:59:09 -0500")
Message-ID: <xmqqo8gt2mxh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1F6475A-6AF8-11EB-8BAE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +Note that when rename detection is on but both copy and break
>> +detection are off, rename detection adds a preliminary step that first
>> +checks files with the same basename.  If files with the same basename
>
> I find myself wanting a definition of 'basename' here, but perhaps I'm
> just being pedantic. A quick search clarifies this as a standard term [1]
> of which I was just ignorant.
>
> [1] https://man7.org/linux/man-pages/man3/basename.3.html
>
>> +are sufficiently similar, it will mark them as renames and exclude
>> +them from the later quadratic step (the one that pairwise compares all
>> +unmatched files to find the "best" matches, determined by the highest
>> +content similarity).

While I do not think `basename` is unacceptably bad, we should aim
to do better.  For "direc/tory/hello.txt", both "hello.txt" or
"hello" are what would come up to people's mind with the technical
term "basename" (i.e. basename as opposed to dirname, vs basename as
opposed to filename with .extension).

Avoiding this ambiguity and using a word understandable by those not
versed well with UNIX/POSIX lingo may be done at the same time,
hopefully.

For example, can we frame the description around this key sentence:

    The heuristics is based on an observation that a file is often
    moved across directories while keeping its filename the same.

The term "filename" alone can be ambiguous (i.e. both "hello.txt"
and "direc/tory/hello.txt" are valid interpretations in the earlier
example), but in the context of a sentence that talks about "moved
across directories", the former would become the only valid one.  We
can even say just "name" and there is no ambiguity in the above "key
sentence".

Then keeping that in mind, we can rewrite the above you quoted like
so without going technical and without risking ambiguity, like this:

    ... a preliminary step that checks if files are moved across
    directories while keeping their filenames the same.  If there is
    a file added to a directory whose contents is sufficiently
    similar to a file with the same name that got deleted from a
    different directory, ...

