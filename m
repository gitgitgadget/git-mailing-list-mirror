Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C41C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FD02075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 20:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RiXZPbO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgKYUtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 15:49:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56321 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgKYUtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 15:49:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78D7D8D3AF;
        Wed, 25 Nov 2020 15:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=08DKp38DxtIQ
        nhe/x19dGXl2S3Q=; b=RiXZPbO47aqZKCNlO5UXevoTkz3LkwCVzlmt7MKsWo/5
        OzDqh4dQfqilqmVBZFLk+ky8ameoIRkzRZ8jKxyB8CwsWaauLf7zwohXD/1JpBJB
        tJymtHxO102k1I59Xhzlk1A9kB++Ahgmx6mV/i657eYNwTv4QVczarZ1Ug3GMS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=O7PHEa
        W3PqoOUK8OpJFLESg4K1m0bcawIlhUZytUPG5O2xRE7toUxePGyetVaKV3wf/j2/
        LzRH9MpBEuHeMr7rLts11SkW8rrPQ7QzDwQ2ekIbQlyycCfkWwRxUWejBUwpp5wT
        RKA2PV6xGoOGpQ9zOQuwIeBoGkU8hgvWjAsJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70B9C8D3AE;
        Wed, 25 Nov 2020 15:49:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E56FE8D3AD;
        Wed, 25 Nov 2020 15:49:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org,
        lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v4] help.c: expand options for help.autocorrect
References: <20201118172849.24715-1-sir@cmpwn.com>
        <xmqq1rgq35my.fsf@gitster.c.googlers.com>
        <xmqqwnyi1qgs.fsf@gitster.c.googlers.com>
        <20201125183309.GF8396@szeder.dev>
Date:   Wed, 25 Nov 2020 12:49:47 -0800
In-Reply-To: <20201125183309.GF8396@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 25 Nov 2020 19:33:09 +0100")
Message-ID: <xmqqk0u9duvo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C17DED5C-2F5F-11EB-B2DB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +		grep "is not a git command" actual &&
>> +		test_line_count =3D 1 actual
>
> The two branches of this condition are in the wrong order, as it
> doesn't check the expected error message in normal mode, but it does
> grep for the specific translated error message when run with
> GIT_TEST_GETTEXT_POISON=3D1 which then fails the test.

Correct.

> I think we should simply use 'test_i18ngrep' instead of that whole
> if-else block. =20
> ...
> I wonder what that 'test_line_count =3D 1' is supposed to check, and am
> not sure that it's really necessary.

I think it is to make sure that there is no other message emitted.

I prefer not to rely on the current implementation of poison that
makes any message a single line message "# GETTEXT POISON #" that is
an incomplete line.  In other words,

	main() {

	printf(_("%s.\n"), "hello");
	error(_("goodbye"));

	exit(0);
	}

would give you a single line output with the current implementation,
but there is no guarantee we won't improve the poisoning in the
future.

