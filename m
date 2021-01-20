Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8445AC4361B
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC1223603
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbhATWdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:33:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63441 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbhATW3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 17:29:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7044FF5F0;
        Wed, 20 Jan 2021 17:28:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VoK8PDZViIlgRTyLjgD7k6fXmxg=; b=yIyfeM
        34XkjpsLjHjPKoZlx3HlsEtrSu3XUVwbk7qCHl2eOyJrxloPoSbADyYl4NeNRK4g
        MvOoV7gqDNHyHix4Q9F0fwSXUvIukKMBfq6gwPMlLwlSdwj9L0jFCyC4Qm9z7y68
        4yiu1Uggg5vbwmLw9XqrwcYVYONHm3X381hHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yTHud0Svn0qu9cIsciQ6Z9ZKzJEzjb/1
        GE3LtrPSGKUTpmSSkvI1bUYUlgzCAbXXwVtuW6XRSJGorGWVZeaQMCIt54RPHsh3
        XkwMsGns9KUkHnqbsSOARjUCGfsmMP5xAoq1W+yl/5yURS7f+Wra5WRWbFM/9KnI
        k2jmW0CQtlY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FD4FFF5EF;
        Wed, 20 Jan 2021 17:28:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6A4AFF5EE;
        Wed, 20 Jan 2021 17:28:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 5/8] config: store "git -c" variables using more
 robust format
References: <cover.1606214397.git.ps@pks.im> <cover.1610453228.git.ps@pks.im>
        <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
        <YAHqHmGOUl53mfPa@coredump.intra.peff.net> <YAfNrX1KNhHRbHmM@ncase>
        <xmqqk0s8gkqz.fsf@gitster.c.googlers.com> <YAfe1laqK+bfHKVm@ncase>
Date:   Wed, 20 Jan 2021 14:28:18 -0800
In-Reply-To: <YAfe1laqK+bfHKVm@ncase> (Patrick Steinhardt's message of "Wed,
        20 Jan 2021 08:42:14 +0100")
Message-ID: <xmqqy2gndz0d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD024ACA-5B6E-11EB-BBA8-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> The 5/8 that needs to come after 6/8 has title "store ... using more
>> rebust format" and that is the 6th patch in the series merged to
>> 'next'.  The 6/8 that needs to come before that one was called
>> "parse more robust format" and it now appears as the 5th patch.
>> 
>> So it seems all is well?
>
> Indeed, I missed your message about the interactive rebase. Thanks!

Thanks for contributing in the first place, and thanks for double
checking.  Very much appreciated.

