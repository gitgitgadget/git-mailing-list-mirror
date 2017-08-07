Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBB22047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdHGRcP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:32:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751426AbdHGRcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:32:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD2669BE2E;
        Mon,  7 Aug 2017 13:32:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GbOHuQNVDXNH
        erdXqpw4IVMveCE=; b=IK3SqwVTibHCQe06bzUTh+Y4ExaLrGKM+HStUQTA7yqG
        JjhkOOp9i5mbqP9KzgULaOPf+crRJH42bCmfMTHt6HvYgBBHnQaWR/7U4X0bF2Gh
        s9c+JDjzKgz7dPhSZ4pp2RNIIKMtrp2LoVqU480Eztsj6/NQXxqOJUTNHsNqgVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RqQK4z
        8KhHStQhTpn0tvaK3LECyWeABkj2srmjN1L56glRT4RsOHt6i/e+2kmJ+SQztsYb
        yvwbd0be/vh7xtgTmqCBoytGd5R4793ubKRpMBninW+EHmtcbZB71QrXk0Z1qKiQ
        xGXakmw/D3TeW0IEZ5l5Qc4J4x1w4Iw76sYxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D42229BE2D;
        Mon,  7 Aug 2017 13:32:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AAD49BE2C;
        Mon,  7 Aug 2017 13:32:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Coppa <dcoppa@openbsd.org>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] tests: don't give unportable ">" to "test" built-in, use -gt
References: <20170806233850.14711-1-avarab@gmail.com>
Date:   Mon, 07 Aug 2017 10:32:07 -0700
In-Reply-To: <20170806233850.14711-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 6 Aug 2017 23:38:50 +0000")
Message-ID: <xmqqk22fqo6g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 566A7C2C-7B96-11E7-B155-9D2B0D78B957-77302942!pb-smtp2.pobox.com
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

I'm tempted to do s/Upstream/Downstream/ while queuing, but please
tell me I am confused.

> about it, I discovered this when reading various Git packaging
> implementations: https://github.com/openbsd/ports/commit/7e48bf88a20
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> David, it would be great to get a quick bug report to
> git@vger.kernel.org if you end up having to monkeypatch something
> we've done. We won't bite, promise :)
>
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
