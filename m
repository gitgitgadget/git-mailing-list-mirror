Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905DC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B98206CA
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wZNg+r7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIPWMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:12:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56291 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgIPWMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:12:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 394957F371;
        Wed, 16 Sep 2020 17:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=meAc2TWbd+b2
        rJUSUkKqsi76uoc=; b=wZNg+r7b2RF/eQP509cx3o6ZsqqqJS9DjaJIfoH2m8OS
        fDYEDgtBobNDcOMnZ7ITuNs2Mlc4whEv+Suzdm/pblZsomezI4mesuvLuOvyvRlT
        x/qtFUL79Kx3CdV7/UPDpTlEsgPyO09dot4QmkV+EMlMvZGAVnc9cz6yIXG8Zkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KZq1gd
        BWTcAEfIXu/IGgmEUKCWi3MqcEmuYTd1PsWbQ98C4KmbDYz40MxLmKhkQ4kQNkk0
        wytMLf9Z31c+u0GWZgjEBPJsbQ1tsdFR8JRu3RIQggsYFCEhg77A2fbPCiOQn2Zy
        yJsAJTIFiEXy9AVj0KVrp5703ExP0EJp2SpeM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 326807F370;
        Wed, 16 Sep 2020 17:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6E2C7F369;
        Wed, 16 Sep 2020 17:13:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with
 test_path_is_file
References: <20200916102918.29805-1-avarab@gmail.com>
        <20200916102918.29805-8-avarab@gmail.com>
        <CAPig+cRg2tuOiQH_CQoHMjkX2gbRPJoV8NPJZnu3=bfo4wk-cQ@mail.gmail.com>
Date:   Wed, 16 Sep 2020 14:13:55 -0700
In-Reply-To: <CAPig+cRg2tuOiQH_CQoHMjkX2gbRPJoV8NPJZnu3=bfo4wk-cQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 16 Sep 2020 12:53:40 -0400")
Message-ID: <xmqq4knxwhkc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8780642A-F861-11EA-A2D7-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 16, 2020 at 8:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Change a test that used a plain test_cmp to first check the file(s)
>> using test_path_is_file. If some of these file(s) don't exist (as
>> happened to me during debugging), test_cmp will emit a way less useful
>> message about the failure.
>
> An alternative would be to update test_cmp() to present a more helpful
> error message so that all test scripts can benefit rather than just
> this script. By the way, were you testing with a reasonably recent
> version of Git? I ask because test_cmp() was updated not long ago to
> provide better diagnostics when one of the files is missing.
>
> [1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)

Yes, you did this with the commit,

test_cmp() {
	test $# -eq 2 || BUG "test_cmp requires two arguments"
	if ! eval "$GIT_TEST_CMP" '"$@"'
	then
		test "x$1" =3D x- || test -e "$1" || BUG "test_cmp '$1' missing"
		test "x$2" =3D x- || test -e "$2" || BUG "test_cmp '$2' missing"
		return 1
	fi
}

and I do not immediately see why "test -e" shouldn't be "test -f".
It should ideally be "stdin is OK, otherwise it must be a readable
regular file".

Thanks.

