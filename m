Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FDE1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754258AbcHXQJK (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:09:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51346 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754129AbcHXQJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:09:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B537838913;
        Wed, 24 Aug 2016 12:09:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eGgKoXEGUoTCqMnoFORmaUq9d0Q=; b=oMdaOI
        jdjuHO/EmfeMPNbfDIbF547TpV0QBBPrS3cmM+TaJ9nKdR2+GfX5MNAQR8K4BhOE
        70szaQwM71K1s2XdgOFb2LEvkynJPSdUoXUcO4QpLmACelZzTgIycyIOP/o4krwm
        zEZ1iRyv8u+0iHtDJ/MU3hzysuXOUyhfu29LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E/qMyCjH+jsJ6n0xj/+lxXgFBl+HQgxU
        /uA3EbUrKuT7TWADCAhGyflU6Ho7KGYcwy2O964sxJfRmcernSOVP/Dt2R2IOjZ5
        UTHRRAoOd6Tgn5B8ydD5d6J6Lvw9bIxydWbR92yT5z2UkouFt6Zy8GSGiBz08HKp
        I4kJUFu6imI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF7F38912;
        Wed, 24 Aug 2016 12:09:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3311C38911;
        Wed, 24 Aug 2016 12:09:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree version
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
Date:   Wed, 24 Aug 2016 09:09:06 -0700
In-Reply-To: <cover.1472041389.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 24 Aug 2016 14:23:30 +0200 (CEST)")
Message-ID: <xmqqk2f6rvx9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 164A71E4-6A15-11E6-9905-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>  index 5f91cf4..f8a3a08 100644
>  --- a/builtin/cat-file.c
>  +++ b/builtin/cat-file.c
>  @@ -61,6 +61,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>   	struct object_info oi = {NULL};
>   	struct strbuf sb = STRBUF_INIT;
>   	unsigned flags = LOOKUP_REPLACE_OBJECT;
>  +	const char *path = force_path;
>   
>   	if (unknown_type)
>   		flags |= LOOKUP_UNKNOWN_OBJECT;
>  @@ -68,6 +69,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>   	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>   		die("Not a valid object name %s", obj_name);
>   
>  +	if (!path)
>  +		path = obj_context.path;
>  +	else if (obj_context.mode == S_IFINVALID)
>  +		obj_context.mode = 0100644;
>  +
>   	buf = NULL;
>   	switch (opt) {
>   	case 't':

The above two hunks make all the difference in the ease of reading
the remainder of the function.  Very good.

>  +test_expect_success '----path=<path> complains without --textconv/--filters' '
>  +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
>  +	test_must_fail git cat-file --path=hello.txt blob $sha1 >actual 2>err &&
>  +	test ! -s actual &&
>  +	grep "path.*needs.*filters" err
>  +'

This will need to become test_i18ngrep once the error message is
made translatable, but it is correct for now.  I personally think
there is no need to check "actual" or "err", though---just running
cat-file under test_must_fail should be sufficient.

Thanks, will queue.
