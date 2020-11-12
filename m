Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6FDC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9941216FD
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tUM1r0cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgKLV0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:26:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKLV0D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABFE4FB2CD;
        Thu, 12 Nov 2020 16:26:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wSDEKqLRYIh3
        XoHN3yrDIuEIPCo=; b=tUM1r0cBfDiqyQuLw3yYT4PtlDqrrTHl0Dt2g1w3JSnW
        RAjC9OUmrghu1ve9nctjqKl2YS5zK8UFnELejdn89GwhVBRMEG3oeKoO5hS2Apxf
        5qunBoY9BKY8dXz2rcBb8Z4Jqo6rp9OhzKwNfVaUjdaQj6oFgP2CUXMc6RH3hv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GwHd/e
        u975JSYIYNQlzH++beJthLMpXkM7MgCLS0OC+YAkIQKpc4opQ0n5AXIcqx65a8A6
        YFfXlPUnqWfRrPrF7+zUaom18mfat3vKsJpd7RRMvcSMwr+0NSRR0LjzX2Y9Tw9J
        Wusa9HMgrCHUnz4aXe1ePgYFK/V1SAjPk8QcA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5693FB2CA;
        Thu, 12 Nov 2020 16:26:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E914DFB2C8;
        Thu, 12 Nov 2020 16:25:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] Retire git-parse-remote
References: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
        <20201112203155.3342586-1-gitster@pobox.com>
        <20201112204937.GB707750@coredump.intra.peff.net>
Date:   Thu, 12 Nov 2020 13:25:57 -0800
In-Reply-To: <20201112204937.GB707750@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 12 Nov 2020 15:49:37 -0500")
Message-ID: <xmqqa6vmclne.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8251268-252D-11EB-B796-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 12, 2020 at 12:31:53PM -0800, Junio C Hamano wrote:
>
>> This is based on =C3=86var's 5-patch series, which removed unused bits
>> from git-parse-remote one by one, before finally moving the remnant
>> to the only user to remove the file.
>>=20
>> Earlier I suggested an alternative arrangement of the series to just
>> lift what is still in use and then discard the rest without even
>> splitting them out into separate commits---it is easy to see what's
>> not used by grepping for names of the helper functions.
>
> FWIW, this arrangement makes much more sense to me. But I am happy with
> either (as long as the file is fully deleted in the end ;) ).

Yeah, one thing I screwed up was that I moved and not copied the
still-used helper in [1/2].  For that to be a sensible change, we
must know nobody uses the helper from git-parse-remote but the
explanation for it would say that nothing dot-sources it and at that
point there is no point to have these changes in two patches ;-)

But as long as the endgame state is sensible, it does not make too
much of a difference.
