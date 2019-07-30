Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119D61F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfG3TfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:35:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60096 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfG3TfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:35:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE18D8AE78;
        Tue, 30 Jul 2019 15:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=agHFLdJnY2i2
        wDliorzNJI8qEZI=; b=gEeMGIIqaotkhHCcDicXHu+BpCzynjZEe/zz0XEqrTLr
        U9M1gaBb0RMkAh6+yUzlxHmmBri1G2GMSxxyybLp2j/MhFuJq7WqtLm2ssBUdM2j
        GPL6NtK9fZ5q/HnNwJZkf9J7lCz00AWhk76GX8+WhS2jGtj79Awuc6gMGDldP18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wLn2Vb
        oC53g96Mu4DgDYSYTgnrKNhUnVHqcLcTDqktUAL/rh5bvMmDlmFuJ/ZlIkf1LKwv
        1aV3UtXZyTPMMPAEasikoo+tetzjRxYU6rlz49UFZRH64817sCUhaWsRidxKfoIl
        dWGSLc1P5kg2jN9UJkLoX7h5zqgXo1R4FKI3c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C48FE8AE77;
        Tue, 30 Jul 2019 15:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2EE598AE75;
        Tue, 30 Jul 2019 15:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCHv2] send-email: Ask if a patch should be sent twice
References: <20190730162624.9226-1-dima@arista.com>
        <20190730191907.GQ20404@szeder.dev>
Date:   Tue, 30 Jul 2019 12:35:15 -0700
In-Reply-To: <20190730191907.GQ20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 30 Jul 2019 21:19:07 +0200")
Message-ID: <xmqqy30fs4cs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2960F95A-B301-11E9-9371-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Jul 30, 2019 at 05:26:24PM +0100, Dmitry Safonov wrote:
>> +	if (@dupes) {
>> +		printf(__("Patches specified several times: \n"));
>
> Is this message translated?  (I don't know what __("<str>") does in
> Perl.)  If it is, then ...

That's not "in Perl" per-se, but what our own Git::I18N gives us.

>> +test_expect_success $PREREQ 'ask confirmation for double-send' '
>> +	clean_fake_sendmail &&
>> +	echo y | \
>> +		GIT_SEND_EMAIL_NOTTY=3D1 \
>> +		git send-email --from=3Dauthor@example.com \
>> +			--to=3Dnobody@example.com \
>> +			--smtp-server=3D"$(pwd)/fake.sendmail" \
>> +			--validate \
>> +			$patches $patches $patches \
>> +			>stdout &&
>> +	! grep "Patches specified several times: " stdout
>
> ... this here should be 'test_i18ngrep' instead of plain old 'grep'.

Yup.  Thanks for carefully reading the patch(es), as always.
