Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B236C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C331420897
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z/wMYfuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHSQOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:14:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55814 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHSQOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 12:14:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22B40EF090;
        Wed, 19 Aug 2020 12:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D7bzj5NEqcsMt75EAZDde/5GtYw=; b=Z/wMYf
        uVAVmkaDUNL/ZnA+k1kvtItazusC87EwpoC+ceCKgATe29aX4WKOnzhiOxhkKST+
        fZHT3kNxaGkfBGxIiWzy1FhcWXBr4YdMRS3r2mvxICxfnM3A1j8NmRdQrQzQAP+W
        txGogAQBCFjg8u/PjlfySgzHsxQXoCpwwRqJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H6Oh0kj+NH65IjlaXdOB4x6uCMqHFvL+
        t9AO7tQU8reuV27lteZNEzRUwMjUqMBfb4ZlpqVwQkY9OFEwzBM1iygr50M+fnhZ
        HYWQY7mLokmmQflmsZS+ns6AmT6x8O2BRdKZKYxb9F1MlwMTO4NaDhHB5xPFdAra
        NfpMEwCr+M4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B6BEEF08F;
        Wed, 19 Aug 2020 12:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54F96EF081;
        Wed, 19 Aug 2020 12:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] Treat CHERRY_PICK_HEAD as a pseudo ref
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <06a8e8cbd1370ba3d4ea8a0a9f1e69d27b1d62c4.1597753075.git.gitgitgadget@gmail.com>
        <xmqqsgcjwtpv.fsf@gitster.c.googlers.com>
        <CAFQ2z_PYpP4WdUaaG4=fOQ_7RLLmGLjuBQaE2yQVA9=7j9XcuQ@mail.gmail.com>
Date:   Wed, 19 Aug 2020 09:14:27 -0700
In-Reply-To: <CAFQ2z_PYpP4WdUaaG4=fOQ_7RLLmGLjuBQaE2yQVA9=7j9XcuQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 19 Aug 2020 17:04:22 +0200")
Message-ID: <xmqqa6yqvcik.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F28A3A6-E237-11EA-9B7E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> Does "git cherry-pick --abort" only remove CHERRY_PICK_HEAD without
>> doing any other damage to the working tree files and to the index?
>
> Good catch. I just added cherry-pick --abort without much thinking. I
> reverted to update-ref -d which should be equivalent to what is
> currently recommended.

I think that is a good change, although it is unfortunate that the
command line completion considers "git update-ref -d CHERRY_P<TAB>"
something it should help the user with.

I tried "cherry-pick --abort" to see what happens after

    $ edit A B
    $ git add A
    $ git rev-parse HEAD~200 >.git/CHERRY_PICK_HEAD
    $ git commit

and aborting the last "git commit" step.  As "cherry-pick --abort"
involves running "git reset --merge" internally, of course some
states the user wanted to commit were wiped out and lost.

Thanks.

