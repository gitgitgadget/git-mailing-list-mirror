Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE9C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51674206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HpZSCXJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEDQGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:06:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51881 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgEDQGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:06:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D445DA09D;
        Mon,  4 May 2020 12:06:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QhAQwT7trCsOT5/DO1OPW+PCwBA=; b=HpZSCX
        JQNBNGtvqkdXFl0edF4ujxbxsjScJRM9eH6Gcc3da/5ia2RlvYegBMcr2Kcg4EU7
        enVMlyVRe9ppnSJWz1wsHMtTjUENSGs0zfjSdpEt7zYuF7V9ytA5Hf0EeuIK6uT7
        5qiV+rKbbhkxht30cJ2Ze7xz6CruaMD1n9i6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KXrGpc2zhrB9gdROq3YXOhseTVikZW1D
        bAZNbIAG8SkvkFsu83DLeXEGR7LS5VzFqHqyBC10gixjrjtAEfZxmYwASuvGyzVd
        rfNxxcR3ra7jZOnc+3sHBeZGSWcqM5xKddVPP8AyxrIMn6EDhvovCSPH1nfvd4RR
        Bqkg8XmB/Pw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34FD4DA09C;
        Mon,  4 May 2020 12:06:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 231ABDA09B;
        Mon,  4 May 2020 12:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        sandals@crustytoothpaste.net, christian.couder@gmail.com,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
        <20200429093811.8475-3-shouryashukla.oo@gmail.com>
        <xmqq7dxyxlpj.fsf@gitster.c.googlers.com>
        <20200502061355.GB5582@konoha>
Date:   Mon, 04 May 2020 09:06:06 -0700
In-Reply-To: <20200502061355.GB5582@konoha> (Shourya Shukla's message of "Sat,
        2 May 2020 11:43:55 +0530")
Message-ID: <xmqqzhanhehd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AD03020-8E21-11EA-9D2D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 29/04 10:09, Junio C Hamano wrote:
>> > ---
>> > I wanted to ask why is there no mention of partial cloning in
>> > the 'git-clone' documentation? Is it because it is an experimental
>> > feature?
>> 
>> If the folks that have been pushing the feature haven't bothered to
>> document it fully, by definition, it must be a work in progress that
>> is not ready for the prime time ;-)
>> 
>> Jokes aside, the --filter=<filter-spec> option is mentioned in the
>> documentation and it says "...is used for the partial clone filter",
>> without even defining what a "partial clone filter" really is.
>> 
>> The topic deserves its own subsection, between the "Git URLs" and
>> the "Examples" sections, in git-clone(1).
>
> May I try to add it? If yes then are there any points to be kept in mind
> while writing this part (for eg., length of the subsection, writing
> style, what all is to be written etc.)?

I am much less qualified to answer these questions than others on
the CC: list.

Who added the mention to --filter and "used for the partial clone filter"
to the page anyway?  Did you run "git blame" to find out?

    ... goes and looks ...

It was added by 4a465443 (clone: document --filter options, 2020-03-22).

Derrick, perhaps you can help Shourya to find a good place to give
a birds-eye description for the partial-clone feature and figure out
what points about the feature are worth covering there?

Thanks.

