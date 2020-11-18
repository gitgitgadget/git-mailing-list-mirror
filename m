Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1765C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 16:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3583D247CB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 16:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cKqGEi/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKRQCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 11:02:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59124 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKRQCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 11:02:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C1710C003;
        Wed, 18 Nov 2020 11:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yw0BZFl1fdeA
        8nLnIvMhNzJW2ak=; b=cKqGEi/igJkrV86Brzx4SBL3/To6ZF8yQ5b+lDz2w3Nh
        D78ow7yIX0PPFU73nCsxPDtZzY6LCkxJUQxvtR8p621NHEwa5FwEaGKz4a5mR7fE
        DOSzfNc4qaxJG98i5gmZWYFF8KUwSjfe4aY/L2mNgTFAcxTVE15OQSxz7m4NB3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h8+4LS
        Ri/NPWP69FqFrtIjxBXlYg6hfw/BPQgBCttFBUXlQ/Jt63ddH2Jhz4izwj6If2Tf
        EqkzXyNbpgwE7LocBCAWmxICSonXcTd2SPkf8yoV/KOzur1J4R8reJat5ljOQjN0
        /UtTXpDRo48V5r4bIqw9C+JvlUdWYxjCxx6uo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A5C810C002;
        Wed, 18 Nov 2020 11:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 375B210C001;
        Wed, 18 Nov 2020 11:01:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
References: <cover.1605269465.git.ps@pks.im>
        <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
        <87mtzlflw7.fsf@evledraar.gmail.com>
        <xmqqy2j1851k.fsf@gitster.c.googlers.com> <X7NtovvfE7IjWzie@ncase>
        <xmqq4klo7992.fsf@gitster.c.googlers.com>
        <87d00arczw.fsf@evledraar.gmail.com>
Date:   Wed, 18 Nov 2020 08:01:55 -0800
In-Reply-To: <87d00arczw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 18 Nov 2020 14:49:39 +0100")
Message-ID: <xmqqo8ju3b7w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62737FD2-29B7-11EB-89F6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Nobody in this thread has mentioned GIT_PUSH_OPTION_* which works prett=
y
> much like Patrick's suggestion, and it looks like --local-env-vars
> misses those:
>
>     $ GIT_PUSH_OPTION_0=3Dfoo GIT_PUSH_OPTION_COUNT=3D20 git rev-parse =
--local-env-vars | grep GIT_PUSH
>     $
>
> I haven't tested this, but I expect there's a bug where a push hook
> itself does a local push to another repo and that repo has a hook, that
> the push options are erroneously carried forward to the sub-process.

True.

Nobody mentioned the environment variable in the discussion, and
nobody discovered and was motivated enough to report and/or fix it,
may be a good indication that these variables are not much used in
real life and certainly not in combination with hooks that further
push things out.
