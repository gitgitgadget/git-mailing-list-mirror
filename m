Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE41C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726BE2067C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5etOidb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbgLAUUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:20:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59567 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgLAUUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:20:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38775A0674;
        Tue,  1 Dec 2020 15:19:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VStXuq7u1kyN
        1+gq8nE3QP+/J84=; b=Q5etOidb8imFS1DI6WDFD3OslCNAqvXUMsanhpBhbe4Y
        RjpNAwE9nXIifYdhDLXrKnfw6cA5Xd1vO2uYdDM6wbiE+Q0ycAs7gJq0n0WBX6zr
        glMVZsUzV/WpBKVhIEKaPOMsYz5AlncIyExh7INHB1eonHMGMAEWcdpveI3fgKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W9g1Hr
        oFe4WNPe4juMtylSJhUxaeoFmstIPXH6m4hXIzXGvayJP9eedYbF7g59RIiCG3zJ
        wwuOzg6NRJUVoqSTE1VH0fGYlor9ER8cbx+ZgN/jkhWbyMUD4iAEafIXx69+7Mg1
        NG1DP/IYxlTkgsNre3QN3asBgQ62Mf0i0aGqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30D27A0673;
        Tue,  1 Dec 2020 15:19:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B142EA0672;
        Tue,  1 Dec 2020 15:19:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 02/10] mktag: use default strbuf_read() hint
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-3-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 12:19:30 -0800
In-Reply-To: <20201126222257.5629-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Nov 2020 23:22:49 +0100")
Message-ID: <xmqq5z5lp9d9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 84D346D8-3412-11EB-A422-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the hardcoded hint of 2^12 to 0. The default strbuf hint is
> perfectly fine here, and the only reason we were hardcoding it is
> because it survived migration from a pre-strbuf fixed-sized buffer.
>
> See fd17f5b5f77 (Replace all read_fd use with strbuf_read, and get rid
> of it., 2007-09-10) for that migration.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/mktag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 4982d3a93e..ff7ac8e0e5 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -161,7 +161,7 @@ int cmd_mktag(int argc, const char **argv, const ch=
ar *prefix)

In the lines beyond the pre-context there is a comment that mentions
<sha1>, but I think it is sensible not to clean it up with this
patch, as it will go away with the main "use fsck machinery" step.

>  	if (argc !=3D 1)
>  		usage("git mktag");
> =20
> -	if (strbuf_read(&buf, 0, 4096) < 0) {
> +	if (strbuf_read(&buf, 0, 0) < 0) {
>  		die_errno("could not read from stdin");
>  	}
