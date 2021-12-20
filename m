Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C04DC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhLTWZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:25:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhLTWZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:25:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 761E41706B7;
        Mon, 20 Dec 2021 17:25:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4mAdEBFdq3xg
        qPJEM3zYZac8kYrHrYqT380Xv7wa0Iw=; b=uKPeKVBWeyUhDF8riAdFWd2wCqL3
        38/F8iGANRZZILanlMiAM+GNsYveoOLK9EzjI0WmVwNa5zCFm1pfGtrKeN2Co5wQ
        dMwYsBysSUYxEQduBUanTR3Gh+W2eLvW7R2PdZIGJ2Yrl2Lb+yQqr2IJeyiA7saj
        DAtMTgo+jm5Y5OI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EB2D1706B6;
        Mon, 20 Dec 2021 17:25:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CECAE1706B5;
        Mon, 20 Dec 2021 17:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH] object-file API: add a format_loose_header() function
References: <20211217112629.12334-3-chiyutianyi@gmail.com>
        <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
Date:   Mon, 20 Dec 2021 14:25:13 -0800
In-Reply-To: <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 20 Dec
 2021 13:10:02
        +0100")
Message-ID: <xmqqilviud6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4185AA0-61E3-11EC-A00C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a convenience function to wrap the xsnprintf() command that
> generates loose object headers. This code was copy/pasted in various
> parts of the codebase, let's define it in one place and re-use it from
> there.
> ...
> +/**
> + * format_loose_header() is a thin wrapper around s xsnprintf() that

The name should have "object" somewhere in it.  Not all readers can
be expected to know that you meant "loose" to be an acceptable short
hand for "loose object".

That nit aside, I think it is a good idea to give people a common
helper function to call.  I am undecided if it is a good idea to
make it take enum or "const char *"; most everybody should be able
to say

	format_object_header(type_name(OBJ_COMMIT), ...)

just fine, so two variants might be overkill, just to allow=20

	format_object_header(OBJ_COMMIT, ...)

and to forbid

	format_object_header("connit", ...)

I dunno.
