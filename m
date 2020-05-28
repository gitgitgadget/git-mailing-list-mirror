Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE067C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807E52053B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jp2oEb3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbgE1Pv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:51:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53353 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404518AbgE1Pv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:51:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 737227CA19;
        Thu, 28 May 2020 11:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V/C46EbPVtCy
        IAZsuwvCr2B4Q/s=; b=jp2oEb3hyLx40G/jzxvYl88iNE4/glCVGD3QOxjXWx0Y
        4Zbzp2WTDL4Y31fWyXf4KY4UvmmbnlY7TTYhffS/0ARPZl5YEAUjppdWafM6ul6Y
        DWFW6hiQsszjRrui+OZv32oyzbSfEgoZeh67S4aiP20N5LiumO2KASBLoIvQ7jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ETVGBe
        ECQFKkjkAyRujvgAKwstrRFOWyrX5JA2HoxXt9eMbXa2dzZlChmuGG5gxD8hJKCl
        C6keQD0nR/ycnR7Db1qWgs2LYzJTJisJ7zTlTkmvT54nArFpifqfeu5EA8oZ2C7x
        XJ04N6SZQxmsAnqB8RygnN7JvdCiz6KIgO1U0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B2997CA18;
        Thu, 28 May 2020 11:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9EC87CA17;
        Thu, 28 May 2020 11:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, hji@dyntopia.com
Subject: Re: [PATCH] t: avoid alternation (not POSIX) in grep's BRE
References: <20200528083745.15273-1-carenas@gmail.com>
        <xmqqo8q83x3v.fsf@gitster.c.googlers.com>
        <20200528154349.GA1215380@coredump.intra.peff.net>
Date:   Thu, 28 May 2020 08:51:21 -0700
In-Reply-To: <20200528154349.GA1215380@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 28 May 2020 11:43:49 -0400")
Message-ID: <xmqqh7w03vnq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13ECAD9C-A0FB-11EA-8773-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... However, I would not be at all surprised if people
> use custom readers.

Yes.  I would be surprised if nobody did so.

> I think it may be a good policy to stick to the
> simplest machine-readable formats for trailers. Likewise I'd suggest
> using the full sha1-hex for future-proofing in this context.

Yes, or just roll it into prose like we often do.  Anybody can spot
many examples from "git log --no-merges" ;-)

commit 173cb08d5b38f423b3cae409daa6d414348c3459
Author: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Date:   Wed May 20 10:08:43 2020 -0700

    bisect: avoid tailing CR characters from revision in replay
   =20
    6c722cbe5a (bisect: allow CRLF line endings in "git bisect replay"
    input, 2020-05-07) includes CR as a field separator, but relies on
    it not being included in the last field, which breaks at least when
    running under OpenBSD 6.7's sh.
   =20
    Instead of just assume the CR will get swallowed, read the rest of
    the line into an otherwise unused variable and ignore it everywhere
    except on the call for git bisect start, where it matters.
   =20
    Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


commit e68a5272b1aab46514ae01745be50948ac375146
Author: Derrick Stolee <dstolee@microsoft.com>
Date:   Tue May 19 19:48:45 2020 +0000

    fsck: use ERROR_MULTI_PACK_INDEX
   =20
    The multi-pack-index was added to the data verified by git-fsck in
    ea5ae6c3 "fsck: verify multi-pack-index". This implementation was
    based on the implementation for verifying the commit-graph, and a
    copy-paste error kept the ERROR_COMMIT_GRAPH flag as the bit set
    when an error appears in the multi-pack-index.
   =20
    Add a new flag, ERROR_MULTI_PACK_INDEX, and use that instead.
   =20
    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
