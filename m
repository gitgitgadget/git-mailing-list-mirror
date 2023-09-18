Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D02CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjIRQg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjIRQgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:36:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BD30DD
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:17:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A0BD1BDA15;
        Mon, 18 Sep 2023 12:17:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iZD3DVHfKz3P
        F9lmK6C7kJUlu9cWFZP1HHumVjSww84=; b=ed0LjHsiVJiNaTUwG7EqaGef7x4P
        r8s/fPRS62OMC+5/kPLiX1Xfzl9xJPmogPvr3U5yYRocPP3H3c1uCfSkCF+G/LNb
        iTLK3c/l2iqjat1Q1SpFxSDBeRQvvZPgb10vjo3jC5s7e131Yw00nigKbXgYZVjC
        Cks2nHSemLu/Cl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F2631BDA14;
        Mon, 18 Sep 2023 12:17:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA8521BDA13;
        Mon, 18 Sep 2023 12:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
In-Reply-To: <2349e897-9e0d-4341-86fc-9da117a1eb48@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 18 Sep 2023 11:53:19 +0200")
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
        <ZP4NrVeqMtFTLEuf@nand.local> <xmqq7cowv7pm.fsf@gitster.g>
        <2349e897-9e0d-4341-86fc-9da117a1eb48@web.de>
Date:   Mon, 18 Sep 2023 09:17:55 -0700
Message-ID: <xmqq5y47mp58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED78C18A-563E-11EE-BAC5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> It reduces the memory footprint, but only slightly.  Saving a few bytes
> for objects with less than a hundred instances total doesn't seem worth
> the downsides.

It makes it impossible to use the both at the same time, which is a
bigger (than reduced memory) advantage.  Otherwise, we would be
tempted to consider that having "void *value" and "int value_int"
next to each other and allow them to coexist may be a good solution
for a narrow corner case (please see at the end of the message you
are responding to).

As you said, use of union has its downsides that may contradict the
objective of the larger picture this topic draws.

Thanks.
