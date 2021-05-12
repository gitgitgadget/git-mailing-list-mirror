Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E2C4361A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2BE613F7
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhELX0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:26:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59118 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhELXM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:12:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A090CF46C;
        Wed, 12 May 2021 19:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=74V6NvL8aMHvWDivyTh/ZRpEJPkj8KF+/0W3TD
        o/qXE=; b=ScUQLCVGg7f3TSJ0a5e1bpFya9xbg4A49LsUn/DDIaV+1VA/DJehk/
        xT8jnWPlCCgRUfCPBbnY+HlEeRtXzXidXRjC6kC/3P285BgE+Q9AGSxVUN0GgH3h
        bIMon9H5jg+wCX1LLLxgsyfGSIrLpr21oMJIpsoJY/dsCnYKTaIHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FF5DCF46B;
        Wed, 12 May 2021 19:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B63EFCF46A;
        Wed, 12 May 2021 19:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3 1/2] [GSOC] ref-filter: add objectsize to used_atom
References: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
        <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
        <91ca57c9d04a822aa4955dbfe3962a6fb2444e81.1620821464.git.gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 08:11:26 +0900
In-Reply-To: <91ca57c9d04a822aa4955dbfe3962a6fb2444e81.1620821464.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Wed, 12 May 2021 12:11:03
        +0000")
Message-ID: <xmqqpmxveee9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6092E1E0-B377-11EB-AAD5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Since "objectsize:size" is composed of two parts,
> "type:attribute". However, the original implementation

Y is missing in the above "Since X, Y".  Because it is composed of
two parts, what?

Dropping "Since " would make the sentence work better.  Also, I
think it should be "objectsize:disk".

> did not decouple the two parts "type" and "attribute" well,
> we still need to judge separately whether the atom is
> "objectsize" or "objectsize:disk" in `grab_common_values()`.

Perhaps

	When the support for "objectsize:disk" was bolted onto the
	existing support for "objectsize", it didn't follow the
	usual pattern for handling "atomtype:modifier", which reads
	the <modifier> part just once while parsing the format
	string, and store the parsed result in the union in the
	used_atom structure, so that the string form of it does not
	have to be parsed over and over at runtime (e.g. in
	grab_common_values()).

> Add a new member `objectsize` to the union `used_atom.u`,
> so that we can separate the judgment of atom type from the
> judgment of atom attribute, This will bring scalability to
> atom `%(objectsize)`.

OK.

> +		struct {
> +			enum { O_SIZE, O_SIZE_DISK } option;
> +		} objectsize;

OK.

> @@ -967,12 +972,14 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
>  			name++;
>  		if (!strcmp(name, "objecttype"))
>  			v->s = xstrdup(type_name(oi->type));
> +		else if (starts_with(name, "objectsize")) {
> +			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
> +				v->value = oi->disk_size;
> +				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);
> +			} else if (used_atom[i].u.objectsize.option == O_SIZE) {
> +				v->value = oi->size;
> +				v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
> +			}

OK.
