Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB0C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A48B6137D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDPS4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:56:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53445 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbhDPSzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:55:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 385A6C83AF;
        Fri, 16 Apr 2021 14:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/x8F9YU2WX6A
        tSxP8m3aimBQbnc=; b=lOzSD9Yrnj8BnNT+HrrtuXyaUxcjseLuF8S4RcfU6YLH
        Avy8mhqTgkWUNQRHklGU1y6akA4a7La47Ftlpv5Zz4+4OFddoutYyG+sVttwhXq3
        xW4JLPZX9Qsuz9W0rSP8EBcQwBkRSQR6XPUh6DvXyEduX+LBrAf3Ndd6uorc3Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FuVwmq
        IQh7b9ijoPxKpHg7GKs/APzjMwWeJ1Uw4+wCAag+0oz9oxqAfHjH47AEsrJEtj9e
        3GIlrtmoKZPwqVR1MF5mWSPaU0nnukZl5zMYITaPSioyBvCxID70fGEsnAYb/nkk
        aInx5OlPhblpTk3l8QNtt2/QAB/g2qslC3nAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30391C83AE;
        Fri, 16 Apr 2021 14:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A356C83AD;
        Fri, 16 Apr 2021 14:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] sha1-file: allow hashing objects literally with
 any algorithm
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
        <20210410152140.3525040-2-sandals@crustytoothpaste.net>
        <87tuo6tgmj.fsf@evledraar.gmail.com>
Date:   Fri, 16 Apr 2021 11:55:21 -0700
In-Reply-To: <87tuo6tgmj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 16 Apr 2021 17:04:52 +0200")
Message-ID: <xmqqfszqm546.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C1B6850-9EE5-11EB-AC94-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We only have one user of hash_object_file_literally(),
> builtin/hash-object.c, let's just change the signature of
> hash_object_file_literally() instead of adding a new function. This
> leaves the tree with no direct user of hash_object_file_literally().

Makes sense.
