Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87691C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BD961941
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 13:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCUN5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 09:57:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61126 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCUN5I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 09:57:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB4CBC3465;
        Sun, 21 Mar 2021 09:57:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rKbnycmsJ5woXSqo2wGoDyxx1as=; b=IVq1yODMHp+eKpZ/+JKr
        f+9Aqhn7b292Jy0cBfaemk5nf6hHpxclevt+R30k7/MvwfFVvXPlOYuqMThxMWN0
        RbGAf9uda2HXkqCOtzIBWMl9DMQpY3J1hmrTBhN/X029k4DJnfeo31UWLSdAJ5Hz
        3KU/5l+EVLzxtdTi3v0V1r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=CqzhARSNahY7u1Fs60AX75pt3RkLLCGIclmQv5i4iWckbv
        284ej8GXLoycJ1gAjavmEY9ORXqgjMxuade/3DuwjtdkGd7Vln6WxfUKo9AWGaRw
        cJi6cj1gOsiUT/reHbCgfLFMtVlVCBU+LUhfuYeq8gAaFVa5mOB+HeFDUpT4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEE2BC3464;
        Sun, 21 Mar 2021 09:57:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38FDFC3463;
        Sun, 21 Mar 2021 09:57:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqn?= =?utf-8?B?biBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] interpret-trailer: easy parse trailer value
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <ca521d3c01d652e09e716fb447b0b26da1a014e8.1616251299.git.gitgitgadget@gmail.com>
        <xmqqft0pk018.fsf@gitster.g>
        <CAOLTT8Q7yNscYrYHWJQcsGn67MjWe15nd7SnCEd5QVUG0A6dRg@mail.gmail.com>
Date:   Sun, 21 Mar 2021 06:57:06 -0700
Message-ID: <xmqq5z1kd2z1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52E1C03C-8A4D-11EB-9D4B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Do you think this is appropriate?
>
> @@ -370,5 +370,15 @@ int parse_buffer_signed_by_header(const char *buffer,
>                                   struct strbuf *payload,
>                                   struct strbuf *signature,
>                                   const struct git_hash_algo *algop);
> +/*
> + * Calling `find_author_by_nickname` to find the "author <email>" pair
> + * in the most recent commit which matches "--author=name".
> + *
> + * Note that `find_author_by_nickname` is not reusable, because it haven't
> + * reset flags for parsed objects. The only safe way to use
> `find_author_by_nickname`
> + * (without rewriting the revision traversal machinery) is to spawn a
> + * subprocess and do find_author_by_nickname() in it.
> + */

Telling people not to add any new caller is good, but everything
after "because" does not make sense to me.

I do not think calling find_author_by_nickname() in a subprocess
alone would not help somebody who wants to do this, either.  We'd be
doing a moral equivalent of that call, but the result has to be
communicated back to the parent process,

In the longer term, we'd probably want to have a pre-computed table
of contributors, like we have precomputed files for reachability
bitmaps, commit DAG topology, and such, but that is obviously far
outside of the scope of this series.

> +const char *find_author_by_nickname(const char *name);
