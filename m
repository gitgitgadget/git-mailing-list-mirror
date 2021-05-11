Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C9C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C0A61613
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhEKCaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 22:30:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKCaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 22:30:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 501C7BEFC3;
        Mon, 10 May 2021 22:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Rd7nD0Yf5gGySxJk3QMGXujp5dFzNCx8uUtLE
        lv63I=; b=MzJfYF2z+yIjzf9ulIYFwn0/jUAQ7RWHuFZUneJL04WqVLYHG2q0XG
        4leoGDUg4gg8I6eu/kQjI+EhgnwqYclUXTGl99/cqRqIDwZ+XJ66iihJCRhCBEHG
        sQERR8/Xzwj5ubSsSiyikT7inygbu22lkF2x0JtVqIveh3gMelIqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4885ABEFC2;
        Mon, 10 May 2021 22:29:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C2FDDBEFC1;
        Mon, 10 May 2021 22:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
        <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 11:29:00 +0900
In-Reply-To: <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Mon, 10 May 2021 15:01:43 +0000")
Message-ID: <xmqqcztyovf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5E84686-B200-11EB-9070-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Change from last version:
>     Prove that the bug may appear when using %(color) atom. And add
>     corresponding test for it.

>      ++test_expect_success '%(color:#aa22ac) must success' '

s/success/succeed/

But more importantly, I am not sure how this is supposed to
demonstrate existing breakage around the %(push).  Did you mean to
use %(push) instead of %(refname) or something?


>      ++	cat >expect <<-\EOF &&
>      ++	refs/heads/main
>      ++	refs/heads/side
>      ++	refs/odd/spot
>      ++	refs/tags/annotated-tag
>      ++	refs/tags/doubly-annotated-tag
>      ++	refs/tags/doubly-signed-tag
>      ++	refs/tags/four
>      ++	refs/tags/one
>      ++	refs/tags/signed-tag
>      ++	refs/tags/three
>      ++	refs/tags/two
>      ++	EOF
>      ++	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
>      ++	test_cmp expect actual
>      ++'
>      ++
>      + test_expect_success 'left alignment is default' '
>      + 	cat >expect <<-\EOF &&
>      + 	refname is refs/heads/main    |refs/heads/main
>
>
>  ref-filter.c                   |  2 +-
>  t/t6302-for-each-ref-filter.sh | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index a0adb4551d87..213d3773ada3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			else
>  				v->s = xstrdup("");
>  			continue;
> -		} else if (atom->u.remote_ref.push) {
> +		} else if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:")) {
>  			const char *branch_name;
>  			v->s = xstrdup("");
>  			if (!skip_prefix(ref->refname, "refs/heads/",
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 9866b1b57368..38a7d83830aa 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -117,6 +117,24 @@ test_expect_success '%(color) must fail' '
>  	test_must_fail git for-each-ref --format="%(color)%(refname)"
>  '
>  
> +test_expect_success '%(color:#aa22ac) must success' '
> +	cat >expect <<-\EOF &&
> +	refs/heads/main
> +	refs/heads/side
> +	refs/odd/spot
> +	refs/tags/annotated-tag
> +	refs/tags/doubly-annotated-tag
> +	refs/tags/doubly-signed-tag
> +	refs/tags/four
> +	refs/tags/one
> +	refs/tags/signed-tag
> +	refs/tags/three
> +	refs/tags/two
> +	EOF
> +	git for-each-ref --format="%(color:#aa22ac)%(refname)" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'left alignment is default' '
>  	cat >expect <<-\EOF &&
>  	refname is refs/heads/main    |refs/heads/main
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
