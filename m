Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EF5C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A585206D4
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OKqbKD5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgA2S54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:57:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63962 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgA2S5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:57:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BCDA98840;
        Wed, 29 Jan 2020 13:57:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LKWtIAdlcKdX
        i8RZEONTCRSjjT0=; b=OKqbKD5bZq6GS9td85q1p8yg9C5hkMXbWBj7DP1c5LZ1
        EhmU18qbM27xqv4uGZxdvhBVzNkoOXwDX75PEcjU9ONWM8DGHJWGuMHvQULQOrdv
        rZQTu666YKXCthROt9bZtluRL8ObMRDZYC7SSxLQnjooiGoEQvJ2cN6uBKK1RjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HWNbnS
        Be3YKpOqpxhnmCXnTSJNeTFwIGa6Jo+iyQS5xvwCsdcJAosx91KYFUcohDURApYG
        mqTKCr0gWltrZo4CEsJ1sxMnYjWnuBV1tOEwHZUVDQYFDlnyxlW3rh8+4tS0lKwD
        2/+OWtf8G5PFJ72djsx9xkmdfV1zLWotws6Jk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53BE09883F;
        Wed, 29 Jan 2020 13:57:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8213A9883E;
        Wed, 29 Jan 2020 13:57:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        jrnieder@gmail.com, olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 08/12] grep: allow submodule functions to run in parallel
References: <cover.1579141989.git.matheus.bernardino@usp.br>
        <af8ad95d413aa3d763769eb3ae9544e25ccbe2d1.1579141989.git.matheus.bernardino@usp.br>
        <20200129112613.GE10482@szeder.dev>
Date:   Wed, 29 Jan 2020 10:57:50 -0800
In-Reply-To: <20200129112613.GE10482@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 29 Jan 2020 12:26:13 +0100")
Message-ID: <xmqqy2tqdr9t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 407527A8-42C9-11EA-987C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Junio, Matheus, Philippe,
>
> this patch below and a7f3240877 (grep: ignore --recurse-submodules if
> --no-index is given, 2020-01-26) on topic
> 'pb/do-not-recurse-grep-no-index' don't work well together, and cause
> failure of the test 'grep --recurse-submodules --no-index ignores
> --recurse-submodules' in 't7814-grep-recurse-submodules.sh', i.e. in
> the new test added in a7f3240877.

Hmph, I wonder if "ignore --recurse-submodules if --no-index" should
have been done as a single liner patch, something along the lines of
"after parse_options() returns, drop recurse_submodules if no-index
was given", i.e.

@@ -958,6 +946,8 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
 			/* die the same way as if we did it at the beginning */
 			setup_git_directory();
 	}
+	if (!use_index)
+		recurse_submodules =3D 0; /* ignore */
=20
 	/*
 	 * skip a -- separator; we know it cannot be
