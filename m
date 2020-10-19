Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89446C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DA62224D
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPJ7QlyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgJSRaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:30:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60420 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRaE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:30:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E820EF505;
        Mon, 19 Oct 2020 13:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/mH2C37AAeC8
        whNV8EwuVeHICzU=; b=gPJ7QlyAYxV1RjZxk/NnNupiy0xHbt6yNuGZVTyi1tik
        5RTu7O88BR47HhPw/z38EaUmZlL+ww/J+7LT+BgKjcXa6ThE2WsfqzME04zBPsWq
        kzqEgwPyeFUT3UwOZyY82aqlcduxtkffU8v+3F1+Ukhpn4hctqDqjMLARvbZ90g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H0HdR5
        9rQZHFLRnFXnDmmwS4rda9CYdVjMCRCXh3rSG2yYtleXe6/pn1GByEy1IrXlt/xz
        9QRVgvJWHtrYhf4FMk0e3JdLP8CP8KAhJwLO+DMZkPgh7WFgOfRjmw++QJDGK9gf
        bWxBQWDvJ6LOVpCTeM2SxhH2lipDLYVdy+J3s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 778C1EF504;
        Mon, 19 Oct 2020 13:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49A19EF500;
        Mon, 19 Oct 2020 13:29:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
References: <20201012091751.19594-1-michal@isc.org>
        <20201015072406.4506-1-michal@isc.org>
        <20201015072406.4506-3-michal@isc.org>
        <xmqqa6wmc9yo.fsf@gitster.c.googlers.com>
        <20201019095554.GC3717@larwa.hq.kempniu.pl>
Date:   Mon, 19 Oct 2020 10:29:56 -0700
In-Reply-To: <20201019095554.GC3717@larwa.hq.kempniu.pl> (=?utf-8?B?Ik1p?=
 =?utf-8?B?Y2hhxYIgS8SZcGllxYQiJ3M=?=
        message of "Mon, 19 Oct 2020 11:55:54 +0200")
Message-ID: <xmqqimb6unsb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B66BAD9C-1230-11EB-BD30-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

>> Cramming unrelated tests into a single one made me puzzled, staring
>> at this line for longer than necessary before realizing that this is
>> an attempt to catch a malformed regexp.  If this were in a separate
>> test with its own title, e.g.
>> 	=09
>> It would have been much easier to follow.
> ... I will try
> to come up with something more balanced in v4.

We want to avoid going overboard and doing a full test matrix. =20

But having it tested fully with one variant while testing just the
basic for other variants may give us a good balance, e.g. "git log
-p -I<regex>" is tested but we do not bother testing interactions
with other options", while we try different combinations when
testing "git diff --no-index -I<regex>", like multiple -I options
etc.

Thanks.


