Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6A31F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeKXNNk (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 08:13:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56550 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKXNNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 08:13:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 828B91267CC;
        Fri, 23 Nov 2018 21:27:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/pCgKCdCVgHQ
        6yRIDbfB5IPDtsE=; b=NGamWBQJEFlq79iD3c1iM45a4/TsDKiHtxrfcSgosA65
        A4Hl+HEslksNkrLc+OIjz4WJv6MXp5BNe8JArpzJQ2kZdYol4WMkkUgXSUJYj98V
        7Nv/PE2KbB+W8dXPBQEx+5wUdiByJT4AiRUw4/2PyBkQBaJyKz1VunRoOUYHG9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=o7kltl
        awjDcqmCnoHmHu4F6L58/xhxRBAHgKA+nqdrgGfCCmGvXFpnRWZzcdwO+JXYHvlX
        Hb7GRjoeAYJUfgqk1kFVlUceVzWpwwe1q/ms4UDvRBYKg0qnSlDqkXvQV7Q4zpcy
        NmOVkzRaGCdXqJ/CB0c2HvcqvYYV1AlpUx/G0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63F101267CB;
        Fri, 23 Nov 2018 21:27:01 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 815691267CA;
        Fri, 23 Nov 2018 21:27:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: don't include --stat with --range-diff output
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
        <20181122211248.24546-3-avarab@gmail.com>
Date:   Sat, 24 Nov 2018 11:26:59 +0900
In-Reply-To: <20181122211248.24546-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 22 Nov 2018 21:12:48 +0000")
Message-ID: <xmqqa7lz43d8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6C429BFA-EF90-11E8-8C96-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	if (rev->rdiff1) {
> +		struct diff_options opts;
> +		memcpy(&opts, &rev->diffopt, sizeof(opts));
> +		opts.output_format &=3D ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY=
);
> +
>  		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
>  		show_range_diff(rev->rdiff1, rev->rdiff2,
> -				rev->creation_factor, 1, &rev->diffopt);
> +				rev->creation_factor, 1, &opts);

I am not quite convinced if this shallow copy is a safe thing to do.
Quite honestly at this late in the release cycle, as a band-aid, I'd
rather see a simpler revert than a change like this that we have to
worry about what happens if/when show_range_diff() _thinks_ it is
done with the opts and ends up discarding resources (e.g. "FILE *")
that are shared with rev->diffopt that would still have to be used
later.

