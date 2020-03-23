Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5CC4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA58206F8
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 19:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zt7/jQnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCWTVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:21:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59356 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgCWTVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 15:21:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A6A144700;
        Mon, 23 Mar 2020 15:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a4837P+WIweIDlmhpcuBVSsjAbI=; b=Zt7/jQ
        nXfujKLdSfGLjQbUbRNdGTMhrJLTCvfA7RPvGggiHTY5VSeO+w96H6+50xLcMibL
        OSJIMNABkHT7H7GMkjQaLO3jGqdSvZhVNZvC7zP54Kqkc5BbqlL03Lj+/BYyuO4i
        1dT1Vv6PjEEwJssNXq28K7oqxbVSsqbiu/2S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Di2+snL0exJcoWtD5bZeFa0fJ4C4WC2o
        uvsX9OiIwSbnSJ9J6T48bJHjA6bVhfn3mQSnbfnH/YO7UqqKmD+WpsD+k+E4ls+K
        DuPFKab5I0fg++RO/zjTh/gBjy2oZrpncvggAqtBRHp+bEx2jHEum284ajFwZ9hq
        PnUTYcKEo5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20594446FF;
        Mon, 23 Mar 2020 15:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38A2C446FD;
        Mon, 23 Mar 2020 15:21:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
        <20200323173258.GA3977@coredump.intra.peff.net>
        <20200323180445.GA31401@coredump.intra.peff.net>
Date:   Mon, 23 Mar 2020 12:21:08 -0700
In-Reply-To: <20200323180445.GA31401@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 23 Mar 2020 14:04:45 -0400")
Message-ID: <xmqq8sjq6fob.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7343D336-6D3B-11EA-90BC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, it's pretty straight-forward and I think the resulting code is
> cleaner. Note that we do have to use a real expect_success because of
> the side effects. That does increment the test counter. IMHO that's not
> a big deal, but if we're concerned it wouldn't be too hard to add a
> non-lazy prereq block.
>
> Patch is below (I pulled GPGSM into its own block, which involved
> reindenting; view with "-w").

Nice.  Certainly a lot nicer than having to reason about what fd#3
and fd#4 are, which I always have keeping in my head.

> @@ -31,51 +34,51 @@ then
>  		chmod 0700 ./gpghome &&
>  		GNUPGHOME="$PWD/gpghome" &&
>  		export GNUPGHOME &&
> -		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> -		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
> +		(gpgconf --kill gpg-agent || : ) &&
> +		gpg --homedir "${GNUPGHOME}" --import \
>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
> -		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
> +		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
>  			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&

Good to see all "discard output" go.

> -		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
> -			--sign -u committer@example.com &&
> -		test_set_prereq GPG &&

> +		gpg --homedir "${GNUPGHOME}" \
> +			--sign -u committer@example.com >/dev/null &&

We lost input redirection; I am assuming that it was unnecessary as
the standard input of our tests are all redirected from /dev/null
anyway?

We are not interested in seeing the signed output (we have nothing
to compare to validate the correctness anyway), so discarding the
standard output is fine.  We do not want to see it even while we are
debugging, either.

Looking good.
