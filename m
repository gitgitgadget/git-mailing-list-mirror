Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF3C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F4D613B5
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEFBye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:54:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56389 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFByd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:54:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92CF3BE251;
        Wed,  5 May 2021 21:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tqbor4UMbPZa1pB2FYPJgbpG3p2lBtJ8P8AEeB
        drZ4g=; b=WHLzEn5RqTUYPYkD0zzsd7lce0bOrGV1UzwJIrWaVQ5hUBEFrxySSy
        TY6TPG0oet/MQnRJOG8R0K/Ci1xZqnoipoyrNVCmReuhSJl0Yckd5m2ujXCyJQKO
        NaBL+y09dl8eXkKBqdt6RXAaJOkBWY9CABW/xCURTCo7c92lTHr18=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84245BE250;
        Wed,  5 May 2021 21:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDE30BE24E;
        Wed,  5 May 2021 21:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
Date:   Thu, 06 May 2021 10:53:33 +0900
In-Reply-To: <pull.949.git.1620228664666.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Wed, 05 May 2021 15:31:04 +0000")
Message-ID: <xmqqfsz01vc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD85436A-AE0D-11EB-B1CB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Johannes Schindelin seems to have introduced a bug in
> cc72385f(for-each-ref: let upstream/push optionally
> report the remote name), it use `atom->u.remote_ref.option`
> which is a member of enumeration in the judgment statement.

Sorry but I am not sure if our readers would understand what "a
member of enumeration in the judgment statement" is (I certainly do
not), and even more importantly, "bugs caused by enumeration" on the
title does not hint much about what problem the patch is trying to
solve.

> When we use other members in the enumeration `used_atom.u`,
> and it happened to fill in `remote_ref.push`, this judgment
> may still be established and produces errors. So replace the
> judgment statement with `starts_with(name, "push")` to fix
> the error.

And this paragraph does not enlighten all that much, unfortunately.

Is it that a check refers to one member of a union without making
sure that member is the one in effect in the union?  I am most
puzzled by the mention of "enumeration" when there does not appear
to be any enum involved.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-949%2Fadlternative%2Fref-filter-enum-bug-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-949/adlternative/ref-filter-enum-bug-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/949
>
>  ref-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index a0adb4551d87..f467f2fbbb73 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1730,7 +1730,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  			else
>  				v->s = xstrdup("");
>  			continue;
> -		} else if (atom->u.remote_ref.push) {
> +		} else if (starts_with(name, "push")) {
>  			const char *branch_name;
>  			v->s = xstrdup("");
>  			if (!skip_prefix(ref->refname, "refs/heads/",
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
