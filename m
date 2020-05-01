Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4BC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB19208D5
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rFM6Eypj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEAFfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 01:35:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54450 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAFfV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 01:35:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83C1663993;
        Fri,  1 May 2020 01:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WDxxp30u2r98
        Cuo+Tzi4/7bAS7g=; b=rFM6EypjN9d93WNcKh08ZehgJRYjv0E0A4qyiOVdxSsp
        xhKDTbLX1x6YCyC2CDDfaJtL0XCAClmDHSZgFeKgjjk3U7btVtCUH6pPiMcw7rwf
        xAe5aGP5BkqqSveUoWm+uiy74M4CaiwiZMbVk94UgQ+S5cJsJkKAD57Jc4IL8ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gR441E
        v2GcPzXasGolYkHUC4f9gUw9m/A2TLs6dBA71EjUVhzFJFz+HN1ajXakqah5V9jN
        rk0M++C0LhGJmKuRZZLSIsDiESFlB3l+buzakv3uKb5dJr7+FbrMexRcWnBrnjtM
        8GY7jbnzEYid/84jtNrmWd+5IUPh5h3LBLcGM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4101D63991;
        Fri,  1 May 2020 01:35:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45EA463990;
        Fri,  1 May 2020 01:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v10 2/1] credential-store: warn also for store and erase
References: <20200501032152.12160-1-carenas@gmail.com>
        <20200501051847.31803-1-carenas@gmail.com>
Date:   Thu, 30 Apr 2020 22:35:17 -0700
In-Reply-To: <20200501051847.31803-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 30 Apr 2020 22:18:47 -0700")
Message-ID: <xmqqa72sp696.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AB5FD64-8B6D-11EA-98C9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> done in a hacky way and only as a POC, but at least works, if we
> are still thinking that warning should be at least comprehensive
> for the first iteration.

...

> @@ -25,7 +23,7 @@ static int parse_credential_file(const char *fn,
>  	struct strbuf line =3D STRBUF_INIT;
>  	struct credential entry =3D CREDENTIAL_INIT;
>  	int found_credential =3D 0;
> -	int lineno =3D 0;
> +	int lineno =3D initial_line;
> =20
>  	fh =3D fopen(fn, "r");
>  	if (!fh) {
> @@ -40,8 +38,7 @@ static int parse_credential_file(const char *fn,
>  		if (strchr(line.buf, '\r') ||
>  			credential_from_url_gently(&entry, line.buf, 1) ||
>  			!valid_credential(&entry)) {
> -			if (flags & PARSE_VERBOSE)
> -				warning(_("%s:%d: ignoring invalid credential"),
> +			warning(_("%s:%d: ignoring invalid credential"),
>  					fn, lineno);
>  		} else if (credential_match(c, &entry)) {
>  			found_credential =3D 1;

I am not sure how this would correctly count when "store" and
"erase" is used.  During "store", the initial_line may let us
correctly count the new line, and as long as we keep copying, our
output line number would stay to be correct, as we increment line by
one every time we read in, but as soon as we see the older version
of the credential record this "store" is updating, i.e. when the
credential_match() reports a match, we will discard the line we read
by hitting the "continue" and not calling other_cb().  We increment
line, but we don't output a line when that happens, so any warning
after that point will be out of sync, no?  And "erase" is the same
deal.  It behaves the same way as "store" except that "erase" does
not emit a replacement record at the beginning.  As soon as the
matching record from the input is dropped, our line number will be
out of sync.

In any case, I think it probably is a good idea to start with a
version that ignores without warning, and I had an impression that
you were on the same page from reading your response to v9 review,
so...
