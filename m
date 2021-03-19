Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452BEC433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C09B6197B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCSR3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 13:29:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58604 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSR3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 13:29:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17C07116CD0;
        Fri, 19 Mar 2021 13:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EsFRtCmJp/q5PBBtM5xMsa9h7hA=; b=ezhuP2
        5FNbJFHxfZdFL33dtc6lJHaOFCC8zmro7oirCVspoWAGIouQb9uRo4l0fbEdbzSP
        tdkCW0AEtcT+AvZoV1n66jLKsiC9LEgBSmxTJ8owsZX6i5bVGL+mg2wXWQ0RilyW
        ROUH3fftxQPNbQGDt9vIIZj4R/Cnds/k9O8SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c53s7bGkKpokkUV84zD7zbpjKPlJbiF/
        VoQK0Gf0WT6SkNKzxuWVYXlOkoRFnV2uDw9FCeehiPtXWcTBG7BUw1dwXt/uwbPz
        DW92lcCr2KO/nZh085ABP1WFUVep3lDajeBxkk7VnZL20+4c1ppnSmgiTBjnZWtM
        DpCbjfP/WUM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10863116CCF;
        Fri, 19 Mar 2021 13:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05AF3116CCA;
        Fri, 19 Mar 2021 13:28:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v7] format-patch: allow a non-integral version numbers
References: <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com>
        <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 10:28:55 -0700
In-Reply-To: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 19 Mar 2021 11:21:23 +0000")
Message-ID: <xmqq8s6jnjc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95AC6A00-88D8-11EB-B712-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Usually we can only use `format-patch -v<n>` to generate integral
> version numbers patches, but sometimes a same fixup should be

I guess that you meant "a small fixup" here?

> labeled as a non-integral version like `v1.1`, so teach `format-patch`
> to allow a non-integral version which may be helpful to send those
> patches.
>
> `<n>` can be any string, such as `-v1.1`.

I would probably use "such as '3.1' or '4rev2'" (without the leading
"-v", as that is how you introduce <n> in the first sentence)
instead in the proposed log message, and give a pair of examples to
show both fractional numbers and non numbers are accepted in the
documentation, if I were doing this patch.

> In the case where it
> is a non-integral value, the "Range-diff" and "Interdiff"
> headers will not include the previous version.

Which is rather unfortunate, but I do not care strongly enough (I
would rather discurage use of partial rerolls with these fractinal 
bits anyway).

> Range-diff vs v6:
>
>  1:  d5f5e3f073de ! 1:  95cfe75ee7da format-patch: allow a non-integral version numbers
>      @@ builtin/log.c: static void print_bases(struct base_tree_info *bases, FILE *file)
>       +	int v;
>       +
>       +	/* RFC may be v0, so allow -v1 to diff against v0 */
>      -+	if (reroll_count && !strtol_i(reroll_count, 10, &v))
>      ++	if (reroll_count && !strtol_i(reroll_count, 10, &v) &&
>      ++	    v >= 1)
>       +		strbuf_addf(sb, rerolled, v - 1);
>       +	else
>        		strbuf_addstr(sb, generic);

In one of your review responses earlier, you hinted that limiting
the range of v like this was needed for correctness.  There should
be a new test to cover the case that this change makes a difference.
