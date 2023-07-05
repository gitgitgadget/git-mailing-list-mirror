Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2C1EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjGEVXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjGEVW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 17:22:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5951BC0
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 14:22:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C167837DE4;
        Wed,  5 Jul 2023 17:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RsXy9rjL60mj1p/sabiGqaxCH2FdO2LKJskVUF
        8yUeA=; b=oL8kjkqhUlqxzjw0Ld9mFTe/c/rwaNaQk0QCR2oqyOw7j9P4jC2NiZ
        0KxtbLaUlsHSub0NxdxaMcqb+lg+PIHN79RlLJmdbhtxAoOgUwg84XdDSZiS7Y09
        v41mHetGsI7ydMrWAJ49kRf5hLK9dEccMMCLETuBACK4GUMzS29+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8E7637DE3;
        Wed,  5 Jul 2023 17:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5946E37DE2;
        Wed,  5 Jul 2023 17:22:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: Re: [PATCH v2 3/4] t4054: test diff --no-index with stdin
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
        <cover.1688586536.git.phillip.wood@dunelm.org.uk>
        <1c7db4dbe26715912672630c1a5659591931cb2d.1688586536.git.phillip.wood@dunelm.org.uk>
Date:   Wed, 05 Jul 2023 14:22:51 -0700
In-Reply-To: <1c7db4dbe26715912672630c1a5659591931cb2d.1688586536.git.phillip.wood@dunelm.org.uk>
        (Phillip Wood's message of "Wed, 5 Jul 2023 20:49:29 +0100")
Message-ID: <xmqqbkgqxdck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 198ED1BA-1B7A-11EE-8323-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> +	cat >expect <<-EOF &&
> +	diff --git a/- b/a/1
> +	index $ZERO_OID..$(git hash-object --stdin <a/1) 100644
> +	--- a/-
> +	+++ b/a/1
> +	@@ -1 +1 @@
> +	-x
> +	+1
> +	EOF
> +
> +	test_write_lines x | test_expect_code 1 \
> +		git -c core.abbrev=no diff --no-index -- - a/1 >actual &&

Or "git diff --no-index --full-index -- - a/1", which looks somewhat
odd but may be correct and a bit shorter ;-)

Not a suggestion to use --full-index instead of core.abbrev; both
are equally valid.

> +	test_cmp expect actual &&
> +
> +	test_write_lines 1 | git diff --no-index -- a/1 - >actual &&
> +	test_must_be_empty actual
> +'

Good.

>  test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
>  	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
>  	grep "fatal: cannot compare stdin to a directory" err
