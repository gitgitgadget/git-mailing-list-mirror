Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4853AC35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5C02080C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIMuUC8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJRtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:49:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57492 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgBJRts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 12:49:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4956397A5;
        Mon, 10 Feb 2020 12:49:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GnUg5dUMbN6e
        g4Q8ihhhqz11P/s=; b=RIMuUC8yw1TKFHA2AW4nq3SSRS0rUIY2jL4Jjb2lLnZ5
        5m9Mjt340kkYzpZc32o+RXo4fm/ip9vHhPNkQMl33uLm6VVUC4BwAHu2uLE0MgcO
        Urfe/z445Ydy5QEkVnZFXbNUKK7EutBdv/lt1MBvF6lftYVkynQEUid4fUH3Dh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=d/s0pL
        w/7VfHYj4psmM+eXW874kvMSpVY0TemaUEjiA9/+C6vbYfBGTbkSV1NQF1Y5M62v
        InbLHkjFaZfyNKvKLCi/qDfXznFa53aXClAZ87vYK/CtrjjhyOgKgxiAOi922Tug
        UoUEDsG0wxbYo1xWudepOjg3hsafEyy3u0AvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCD00397A4;
        Mon, 10 Feb 2020 12:49:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F5E9397A3;
        Mon, 10 Feb 2020 12:49:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] parse-options: simplify parse_options_dup()
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
        <162fb36a-6dd1-c178-9032-d3f4213930a6@web.de>
Date:   Mon, 10 Feb 2020 09:49:45 -0800
In-Reply-To: <162fb36a-6dd1-c178-9032-d3f4213930a6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 9 Feb 2020 16:58:42 +0100")
Message-ID: <xmqqh7zy1gee.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA70DA1C-4C2D-11EA-B11C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Simplify parse_options_dup() by making it a trivial wrapper of
> parse_options_concat() by making use of the facts that the latter
> duplicates its input as well and that appending an empty set is a no-op=
.
> ...
> +	struct option no_options[] =3D { OPT_END() };
> +
> +	return parse_options_concat(o, no_options);

Can't say if this is tricky or cute, but I like it ;-)

Will queue all four.  Thanks.
