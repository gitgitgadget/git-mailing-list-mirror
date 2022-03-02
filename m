Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2841C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 23:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiCBX4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCBX4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 18:56:47 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410FBA7
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 15:56:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BD5E17C031;
        Wed,  2 Mar 2022 18:20:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fEMvni8+uMtQ
        Ts/74nnnCV6gg7BEayF3yr8nhJ0bIvQ=; b=BeTKSLr/B5mRjUElOMTxIN6fUJhP
        +IHLn8bFqQ+Upq03Cu7nJ8rEd25EsVjaugQPne4QuenUMOnQw/f/hlqUFjk0ltdn
        shm8lNp0RPkHTSnQtZs8qWn+G3sU3x7wgoae5HF4tLkspDdAiByZNGEAgW9W7tXD
        dc0grR4eXAGZTCA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 741F717C030;
        Wed,  2 Mar 2022 18:20:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A078A17C02E;
        Wed,  2 Mar 2022 18:20:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 12/15] gettext tests: don't ignore "test-tool regex"
 exit code
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        <patch-12.15-f3cc5bc7eb9-20220302T171755Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 15:20:51 -0800
In-Reply-To: <patch-12.15-f3cc5bc7eb9-20220302T171755Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 18:27:21
        +0100")
Message-ID: <xmqq5yowgcvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6753FFE2-9A7F-11EC-BA22-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -test_have_prereq GETTEXT_LOCALE &&
> -test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE &&
> -test_set_prereq REGEX_LOCALE
> +test_expect_success GETTEXT_LOCALE 'setup REGEX_LOCALE prerequisite' '
> +	if test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE
> +	then
> +		test_set_prereq REGEX_LOCALE

This looks sensible but

> +	else
> +		test_must_fail test-tool regex "HALL=C3=93" "Hall=C3=B3" ICASE

this side looks puzzling.  I think this way to avoid counting abort
etc as passing "must fail" test would be the least bad that we can
do.

Nicely done.



> +	fi
> +'



