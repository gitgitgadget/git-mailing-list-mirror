Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC619C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 00:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841E665007
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 00:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCJAkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 19:40:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62310 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCJAkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 19:40:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DACE311C22D;
        Tue,  9 Mar 2021 19:40:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=374Z7PZMJ/rG
        MXud7Uie4r5ebSU=; b=wKhNRHrSthK9LSGIHjBpjJqKgqSPtj7kIcQcM5Wn3Xc3
        9/B3BjnXnk/EoNJte4E5FGp/EUSPYUhxRB6Bg4pgErNosSzzHRtLGAWFmx6690Jy
        OXlvJeWlr4JPCcfVKOdEo0GnnoyhF+a4B7Ke1D/ztzMlua0teuXY89c6uPjzKzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IQszwK
        j8ygyAE3J2A1JupZnEqHQkgi4RuHYnpkemYatkv1o3zdgB0BGdHVNs9hhDMIRbJN
        se64Limznxa80x+zvbqB6CDATurkgrS65LC8EWxsI6KQIonYvsr6YcnuyMcv8zps
        qXLhPN1n6xNGF+2E1MxOzBF1H8JfwAuKpVBzM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CEFAB11C22C;
        Tue,  9 Mar 2021 19:40:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1BAD011C22B;
        Tue,  9 Mar 2021 19:39:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] test-lib: add say_color_tap helper to emit TAP format
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
        <20210309160219.13779-3-avarab@gmail.com>
Date:   Tue, 09 Mar 2021 16:39:56 -0800
In-Reply-To: <20210309160219.13779-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 9 Mar 2021 17:02:14 +0100")
Message-ID: <xmqqy2evyh7n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23F4E050-8139-11EB-9755-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Follow-up 5099b99d25 (test-lib: Adjust output to be valid TAP format,
> 2010-06-24) and make it easy to distinguishing when we're emitting TAP
> directives (with the new "say_color_tap"), and when we just want to
> say something with colored text "say_color".

OK.

> @@ -666,7 +673,7 @@ test_ok_ () {
>  		write_junit_xml_testcase "$*"
>  	fi
>  	test_success=3D$(($test_success + 1))
> -	say_color "" "ok $test_count - $@"
> +	say_color_tap "" "ok $test_count - $@"

Not your fault, but let's not forget that we should clean this up
not to use "$@" here (and instead use $*).

> -	say_color warn "not ok $test_count - $@ # TODO known breakage"
> +	say_color_tap warn "not ok $test_count - $@ # TODO known breakage"

Likewise.

Yes, I know say_color (and hence its heir say_color_tap) accepts
multiple arguments and eventually pastes them into a single string
with "$*", but there is no point in producing multiple arguments out
of "$@" here in this case.



fn0 () {
	cnt=3D0
	for arg
	do
		echo "$cnt: <$arg>"
		cnt=3D$(( cnt+1 ))
	done
}

fn1 () {
	fn0 "not - $@ # TODO"
}

fn1 1 "2 3"

--->=20

0: <not - 1>
1: <2 3 # TODO>
