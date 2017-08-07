Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CB31F991
	for <e@80x24.org>; Mon,  7 Aug 2017 01:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdHGBdY (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 21:33:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59607 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdHGBdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 21:33:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD928F9E0;
        Sun,  6 Aug 2017 21:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OiZqz6QdRa0L
        8L1je1XVqc57690=; b=opn0RZsiiHL97N2SEuhdJJWWDzfBMGJbhK/nD1XWZ9f1
        QD1lQkWa1s0tt60pfU+h9EN0VQtloOob0weaZ25A1erbZJJLOODlppDaSQ/R4DxH
        EwKbS56g+HaMAN6ZsGny7Wk6Cj/w63/9v/oIcs5MhrgBtbWLR16lj15Z+afsVeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FBuhnY
        Ce6lHHDyY3FEfriATf1Qe36mDN9iyLLlVqTlUT3bt43pqQuvNg8A7z1mLSGEcHuD
        QBKRU2tnBRIRdENiwlxJ5360DkXT+AkKOik98Ed76fKkB6/OP9JnynfNHY9R1i/i
        NbRwvcK7+xSHjpDQts+NtPRoKD6N4zutDaT+U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 636388F9DF;
        Sun,  6 Aug 2017 21:33:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B03B98F9DD;
        Sun,  6 Aug 2017 21:33:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Coppa <dcoppa@openbsd.org>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] tests: don't give unportable ">" to "test" built-in, use -gt
References: <20170806233850.14711-1-avarab@gmail.com>
Date:   Sun, 06 Aug 2017 18:33:15 -0700
In-Reply-To: <20170806233850.14711-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 6 Aug 2017 23:38:50 +0000")
Message-ID: <xmqq4ltkrwkk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 62EBC52C-7B10-11E7-AF5D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change an argument to test_line_count (which'll ultimately be turned
> into a "test" expression) to use "-gt" instead of ">" for an
> arithmetic test.
>
> This broken on e.g. OpenBSD as of v2.13.0 with my commit
> ac3f5a3468 ("ref-filter: add --no-contains option to
> tag/branch/for-each-ref", 2017-03-24).
>
> Upstream just worked around it by patching git and didn't tell us
> about it, I discovered this when reading various Git packaging
> implementations: https://github.com/openbsd/ports/commit/7e48bf88a20

Thanks for finding and relaying this.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> David, it would be great to get a quick bug report to
> git@vger.kernel.org if you end up having to monkeypatch something
> we've done. We won't bite, promise :)

Yeah.  I was hoping that your new list for platform porters would
help communicate these issues easier for those who are a bit shy to
be on this general development list ;-)

> As shown in that linked Github commit OpenBSD has another recent
> workaround in turning on DIR_HAS_BSD_GROUP_SEMANTICS and skipping a
> related test, maybe Ren=C3=A9 can make more sense of that?
>
> There's more patches in their ports which indicate possible bugs of
> ours: https://github.com/openbsd/ports/tree/master/devel/git/patches/
>
>  t/t7004-tag.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 0ef7b94394..0e2e57aa3d 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1887,7 +1887,7 @@ EOF"
>  	run_with_limited_stack git tag --contains HEAD >actual &&
>  	test_cmp expect actual &&
>  	run_with_limited_stack git tag --no-contains HEAD >actual &&
> -	test_line_count ">" 10 actual
> +	test_line_count "-gt" 10 actual
>  '
> =20
>  test_expect_success '--format should list tags as per format given' '
