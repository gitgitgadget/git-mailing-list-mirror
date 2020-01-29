Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C6C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90E020702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 21:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uAaIm/6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA2VbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:31:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55917 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2VbD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 16:31:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 169234C22A;
        Wed, 29 Jan 2020 16:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s9DR0gkf3ci15J4Unr7W1bH3DKs=; b=uAaIm/
        6q3oWpTYm9yrYs1Qw8jr1tFdcfTbr5jkIjXgdyIsfIFLvQ1gzYezIrar0GB6CnLZ
        C/L/wFcua9UWgeQNKqqb640ULe68lcEHsESEtSxFUpm6o+CDDiZO39aAHqEQYEb/
        wAJ8B374l/9oO2TC2hd4j4h16hLW9m0wf+0+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XmL0lB4bJuksOabjiaUilP9KrQMOSwcX
        5/x5JhkawxNkKUMhYr5yGPDgWf5DLAx0uFiVTXzJpjpgd6dx5tCqTvEVrr0kf/gM
        MRooiQ6M2CuNd0Yokg4JfQD/ImPlk3V36kV7SWx2DDVJPg0GgW3FA1fYcNknjBB0
        8oLBrYQfXJM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ED0E4C229;
        Wed, 29 Jan 2020 16:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794DA4C228;
        Wed, 29 Jan 2020 16:30:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David =?utf-8?Q?Burstr=C3=B6m?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] sha1-name: mark get_oid() error messages for translation
References: <20200125000542.GA566779@coredump.intra.peff.net>
        <20200125001301.GC567109@coredump.intra.peff.net>
Date:   Wed, 29 Jan 2020 13:30:57 -0800
In-Reply-To: <20200125001301.GC567109@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Jan 2020 19:13:01 -0500")
Message-ID: <xmqqpnf2dk6m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3B780B2-42DE-11EA-A18C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +			die(_("path '%s' exists, but not '%s'\n"
> +			    "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'?"),
> ...

The above is meant to be localizable, but...

> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index f49fc770d6..c2b5125c12 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -9,8 +9,8 @@ exec </dev/null
>  test_did_you_mean ()
>  {
>  	cat >expected <<-EOF &&
> -	fatal: Path '$2$3' $4, but not ${5:-$SQ$3$SQ}.
> -	Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
> +	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
> +	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
>  	EOF
>  	test_cmp expected error

...this obviously would not allow GIT_TEST_GETTEXT_POISON test to
pass.  And ...

>  test_expect_success 'incorrect file in sha1:path' '
>  	test_must_fail git rev-parse HEAD:nothing.txt 2>error &&
> -	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"'"'" error &&
> +	test_i18ngrep "path .nothing.txt. does not exist in .HEAD." error &&
>  	test_must_fail git rev-parse HEAD:index-only.txt 2>error &&
> -	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." error &&
> +	test_i18ngrep "path .index-only.txt. exists on disk, but not in .HEAD." error &&
>  	(cd subdir &&
>  	 test_must_fail git rev-parse HEAD:file2.txt 2>error &&
>  	 test_did_you_mean HEAD subdir/ file2.txt exists )
>  '

... the last step executed in "subdir" does not seem to pass.
