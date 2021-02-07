Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4307C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 05:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8917F64E8A
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 05:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBGFq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 00:46:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58038 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGFq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 00:46:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5B6CA2230;
        Sun,  7 Feb 2021 00:45:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gmSzjPtGTGBgDNLOBXjPRVL5yyU=; b=r56v5K
        Hb7X7uP0igbkY7obcTKERDaZHDStqI3ENBtCG69j3dKfVZhTVqq96RXRw8u7NYl2
        2vbBYjpYWCEDXvyOQWpL2mRP5Ec90OJMJv1tIOawb6zaLblI05wN4xovbf85Yldr
        cJhDkaee8uFQMEzm5jpgCxB06WyICec9ZX4Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qpP+EbKVmfbK1eOou7V8nYG8KjYYfZ9P
        RQZ8uKSLLLuPUeyeE6jdco4jDe48kEXoLcvuZt8/tCPMMGFJKt7/6eXsbTzLRxzt
        hYv9g/R1X8G1N1Nd7qOlSsdmOOikRreOA4SWI6IGoDiWs7FTNRgRM5wewJuzFvN/
        UokXbBbc6dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE2DAA222F;
        Sun,  7 Feb 2021 00:45:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 420CFA222D;
        Sun,  7 Feb 2021 00:45:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 21:45:41 -0800
In-Reply-To: <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Sat, 06 Feb 2021 09:15:44
        +0000")
Message-ID: <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B71E92EE-6907-11EB-8F6A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_trailer_option() {
> +	title="$1"
> +	option="$2"
> +	expect="$3"
> +	test_expect_success "$title" '
> +		printf "$expect\n" >expect &&
> +		git for-each-ref --format="%($option)" refs/heads/main >actual &&
> +		test_cmp expect actual &&
> +		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
> +		test_cmp expect actual
> +	'
> +}
> +
> +test_trailer_option '%(trailers:key=foo) shows that trailer' \
> +	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'

This is *not* an issue about the test script and its helper
function, but I just noticed that --format="%(trailers:key=<key>)"
is expected to write the matching trailers *AND* an empty line, and
I wonder if that is a sensible thing to expect.

The "--pretty" side does not give such an extra blank line after the
output, though.

 $ git show -s --pretty=format:"%(trailers:key=Signed-off-by:)" \
   js/range-diff-wo-dotdot
 Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 Signed-off-by: Junio C Hamano <gitster@pobox.com>
 $ git show -s --pretty=format:"%(trailers:key=None:)" \
   js/range-diff-wo-dotdot
 $ exit

Unlike the above, when there is no matching trailer lines, the
"for-each-ref" in this series shows zero lines, and when there is
one matching trailer line, it gives that single line plus an empty
line, two lines in total.  The inconsistency is a bit disturbing.

Is the extra blank line given on purpose?  I don't see why we would
want it.  Or is it a bug we did not catch during the previous two
rounds of reviews?

Thanks.
