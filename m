Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B3C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160FB613C3
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGITRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:17:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58237 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGITRT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 15:17:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93307D428A;
        Fri,  9 Jul 2021 15:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=M/9tQ6+3hRQXDWv+puWA8IQQ2
        QAe4/PJFzKfIkBNWHA=; b=v/B+8NnZapNh8Aqh/wg75EPhejtUt9Gj73mxUra26
        qHO3PQyyJ5EcW+CJ+YnjxSJjQLb0db8oApOlQfOtx3hAcM0ZMLEO/Qdivfi08CTV
        ZwyMYVMHMaU9QxbYVxoIRZddFYEgMLd/kVC6KXFwiVoj2e67e84BkmDez6RDyPFP
        kI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A39ED4289;
        Fri,  9 Jul 2021 15:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04C63D4287;
        Fri,  9 Jul 2021 15:14:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/2] commit: reorganise commit hint strings
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
        <20210709180732.2678818-1-hujialun@comp.nus.edu.sg>
Date:   Fri, 09 Jul 2021 12:14:34 -0700
Message-ID: <xmqqzguv5mg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5AF4C70-E0E9-11EB-BB09-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hu Jialun <hujialun@comp.nus.edu.sg> writes:

> Strings of hint messages inserted into editor on interactive commit was
> scattered in-line, rendering the code harder to understand at first
> glance.
>
> Extract those messages out into separate variables to make the code
> outline easier to follow.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
> ---
>  builtin/commit.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 190d215d43..e68d139dee 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -889,6 +889,14 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
>  		int ident_shown =3D 0;
>  		int saved_color_setting;
>  		struct ident_split ci, ai;
> +		const char *hint_cleanup_all =3D _("Please enter the commit message =
for your changes."
> +						 " Lines starting\nwith '%c' will be ignored,"
> +						 " and an empty message aborts the commit.\n");
> +		const char *hint_cleanup_space =3D _("Please enter the commit messag=
e for your changes."
> +						   " Lines starting\n"
> +						   "with '%c' will be kept; you may remove them"
> +						   " yourself if you want to.\n"
> +						   "An empty message aborts the commit.\n");

That would easily make lines that are overly long.  Perhaps fold
them like so?

		const char *hint_cleanup_all =3D
			_("Please enter the commit message for your changes."
			  " Lines starting\nwith '%c' will be ignored,"
			  " and an empty message aborts the commit.\n");

