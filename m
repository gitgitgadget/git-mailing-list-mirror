Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31870C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B3D20725
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IHinM5F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIWRxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:53:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56829 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIWRxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 13:53:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A79589028;
        Wed, 23 Sep 2020 13:53:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AFHpNfeLrKGyFHJml8D4CL+XskE=; b=IHinM5
        F0z816h9gF9QyrTcx5WPVhK1CsJNDQK+Sc15xs5+OrX351T5/DFicag3ljtMgYwG
        I0P6CC282naxca/uD+/nMx+aXTagV4PAT03ppE1OUd7Yn42xODDMyxqYdWjPUdKT
        O7NihSgEGOd3FgSYwvFYXKz0OASu7zKG6sXBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P7I8yDX5FdVmdob1fOQfDHhxRcvlwvBO
        uSBgplPD3DDPvvJ4ymy/Z6lHpTlNUzETNhzVUVArr77IlYZexAKesDGVX6cmtxiB
        +eIa7jqdGCVzRlgtmREKriBf3ofJcPKkm5rGnEY7ybBGgibiBa1Z2Q2KhhC+qAjW
        qiZMFpI1l+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71BA189027;
        Wed, 23 Sep 2020 13:53:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F092A89025;
        Wed, 23 Sep 2020 13:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
        <xmqqsgb8idvv.fsf@gitster.c.googlers.com>
Date:   Wed, 23 Sep 2020 10:53:29 -0700
In-Reply-To: <xmqqsgb8idvv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 23 Sep 2020 10:47:32 -0700")
Message-ID: <xmqqo8lwidly.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0848D9C-FDC5-11EA-85B4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> When using CMake to generate the files required to build Git in Visual
>> Studio, a bunch of files are generated. We will want to prevent them
>> from being tracked in Git.
>
> If we were to go this route, let's
>
>  * update the log message to say that we assume we will use CMake to
>    build in-place.
>
>  * update the comment in the top part of the CMakeList.txt that
>    suggests it is a possibility to use it from subdirectories.

Sorry, sent too soon.  Either s/update/remove/, or to say that
this project assume things are built in-place.

>  * optionally, update the same comment to recommend "clean -xdf"
>    as a way to bring the source tree back to the pristine state.
>
> Will queue with a tentative attempt to do the first bullet point to
> save one roundtip, something like:
>
>     When using CMake to generate the files required to build Git
>     in-place for Visual Studio, ...
>
> Other two points needs help from others (iow, I won't do so myself
> right now).
>
> Thanks.
