Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFBC433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0742098B
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rQKAtqgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgH2Soa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:44:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53776 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2So1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:44:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 560D970126;
        Sat, 29 Aug 2020 14:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BdUtguAFf/sdTynC66KjXa+sOac=; b=rQKAtq
        gHJ9Om89r9SrShJpv2XLNh7cxoyKZd46flkPB+yVAVu6S5sCJNt8UppLp3EXOS0r
        MOqAp5YmOY6w2F/1Hy76P98G3utZOCQk1UpvJD+8Kdc+EaeBIQwEzfeWL2f7eC3/
        50hsh4mdf6tPrvwdbGo0P0oBhu2e860S/bbrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qOb56fMCwmqiXCVTjeJocZ9wrqbFehLd
        MN3WEUg8bs7qmjxxo/89EOYAT34CRlTKUtJ7eqxHdeVX659aPRnpOse+tCgCrmnw
        eFRP8O2MB8a6AgaeaYdl1w51KwZSMzVaTXuHeyNjUY+k8C6HX2ALufA1tfjEZemr
        AKD+pI4pmMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D63570125;
        Sat, 29 Aug 2020 14:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3D7E70124;
        Sat, 29 Aug 2020 14:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/2] sha1-name: replace unsigned int with option struct
References: <20200513004058.34456-1-jonathantanmy@google.com>
        <cover.1598662525.git.jonathantanmy@google.com>
        <1ce44900a08857332ee70b916c3d9e7e76751221.1598662525.git.jonathantanmy@google.com>
Date:   Sat, 29 Aug 2020 11:44:22 -0700
In-Reply-To: <1ce44900a08857332ee70b916c3d9e7e76751221.1598662525.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 28 Aug 2020 18:02:26 -0700")
Message-ID: <xmqqsgc5i96h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7D874DA-EA27-11EA-9175-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In preparation for a future patch adding a boolean parameter to
> repo_interpret_branch_name(), which might be easily confused with an
> existing unsigned int parameter, refactor repo_interpret_branch_name()
> to take an option struct instead of the unsigned int parameter.

Makes sense.

>  #define INTERPRET_BRANCH_LOCAL (1<<0)
>  #define INTERPRET_BRANCH_REMOTE (1<<1)
>  #define INTERPRET_BRANCH_HEAD (1<<2)
> +struct interpret_branch_name_options {
> +	/*
> +	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
> +	 * expansions: local branches ("refs/heads/"), remote branches
> +	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
> +	 * allowed, even ones to refs outside of those namespaces.
> +	 */
> +	unsigned allowed;
> +};
>  int repo_interpret_branch_name(struct repository *r,
>  			       const char *str, int len,
>  			       struct strbuf *buf,
> -			       unsigned allowed);
> -#define interpret_branch_name(str, len, buf, allowed) \
> -	repo_interpret_branch_name(the_repository, str, len, buf, allowed)
> +			       const struct interpret_branch_name_options *options);
> +#define interpret_branch_name(str, len, buf, options) \
> +	repo_interpret_branch_name(the_repository, str, len, buf, options)

I was debating myself if we want to have 

    #define IBN_OPTIONS_INIT { 0 }

or something similar (perhaps "#define IOI(abit) { .allowed = (abit) }"),
but it probably is not worth it given that we have only 3 local
sites that define it, 1 always initializes the field to 0, and the
other just relay the value passed by its caller.

> ...
> diff --git a/sha1-name.c b/sha1-name.c
> index 0b8cb5247a..a7a9de66c4 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1427,9 +1427,12 @@ static int reinterpret(struct repository *r,
>  	struct strbuf tmp = STRBUF_INIT;
>  	int used = buf->len;
>  	int ret;
> +	struct interpret_branch_name_options options = {
> +		.allowed = allowed
> +	};
>  
>  	strbuf_add(buf, name + len, namelen - len);
> -	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, allowed);
> +	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, &options);

> @@ -1557,7 +1561,10 @@ int repo_interpret_branch_name(struct repository *r,
>  void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
>  {
>  	int len = strlen(name);
> -	int used = interpret_branch_name(name, len, sb, allowed);
> +	struct interpret_branch_name_options options = {
> +		.allowed = allowed
> +	};
> +	int used = interpret_branch_name(name, len, sb, &options);

These are quite straight-forward rewrites.  Looking good.

Thanks.
