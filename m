Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC70C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854826117A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhGLTmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:42:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56357 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhGLTmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:42:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82CEB14D8F2;
        Mon, 12 Jul 2021 15:40:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t3eFSSBFtODp
        KPtlXHRihJW2fAGrwdqgEY04vJjPVu4=; b=iRk9gi5rhkxLYx8gnR/ivc7Hj+Yf
        IXTyKWAjUITd5Hvhvbezdwp64Ax61KB5lDguQYrCSFO0IydeaSMJ6eTgevj2Ip1f
        uAAx+/fldEV7lWd8QCIWovUB4OcugwuyGYXGATcHdC9rFWs25G8gKnyPx+38kj2E
        2GtWLXrnngxg8dI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 778C514D8F1;
        Mon, 12 Jul 2021 15:40:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9653414D8EF;
        Mon, 12 Jul 2021 15:39:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] bugreport.c: tweak cmd_bugreport() to use
 __attribute__((printf))
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
        <patch-5.6-daca344a165-20210710T084445Z-avarab@gmail.com>
Date:   Mon, 12 Jul 2021 12:39:55 -0700
In-Reply-To: <patch-5.6-daca344a165-20210710T084445Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 10 Jul
 2021 10:47:31 +0200")
Message-ID: <xmqqczrn48z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F10E2F9E-E348-11EB-80DD-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As noted in the preceding commit we had no __attribute__((format))
> check for strbuf_addftime(), and furthermore had no in-tree user that
> passed it a fixed string.
>
> Let's tweak this codepath added in 238b439d698 (bugreport: add tool to
> generate debugging info, 2020-04-16) to make use of the compile-time
> check.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/bugreport.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 9915a5841de..02edfb9a047 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -127,7 +127,7 @@ int cmd_bugreport(int argc, const char **argv, cons=
t char *prefix)
>  	time_t now =3D time(NULL);
>  	struct tm tm;
>  	char *option_output =3D NULL;
> -	char *option_suffix =3D "%Y-%m-%d-%H%M";
> +	char *option_suffix =3D NULL;
> ...
> +	if (option_suffix)
> +		strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm),=
 0, 0);
> +	else
> +		strbuf_addftime(&report_path, "%Y-%m-%d-%H%M", localtime_r(&now, &tm=
), 0, 0);
>  	strbuf_addstr(&report_path, ".txt");
> =20
>  	switch (safe_create_leading_directories(report_path.buf)) {

The use of "the variable option_suffix whose default value is
'%Y-%m-%d-%H%M'" may happen to be only to generate report_path in
the current code, but there is little reason to expect that will
stay to be true.  With this change, however, future developers has
to know that option_suffix may not have its default value in it and
they need to do the "if it is NULL, then use the default", and
without any benefit of proprocessor macro.

And in exchange of it, we gain what?  Letting some compilers ensure
that "%Y-%m-%d-%H%M" is a valid strftime format string?  That does
not sound all that much interesting.

This step I am not impressed all that much, even though the earlier
clean-up steps all looked sensible.

