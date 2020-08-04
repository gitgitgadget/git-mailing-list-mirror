Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C81C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E582320842
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D04KFsn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHDWtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:49:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54553 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHDWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:49:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D446D71C2;
        Tue,  4 Aug 2020 18:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JAOzz1NgvM0B6rlBlCuPwr45nn8=; b=D04KFs
        n0kB7n8Ze2AsmiafJCdzprPAqb6ix+Z8TduQyKKV4e/02I/tXBp6ycdumNBy7bVA
        jUgD7MLfp25iBT2/+nuVxGzkBGkp+/F+dAhTAujrS6l7c49nu0A8ZUBGjiJSbIGY
        biNGAUErTpxNdnQy/KuUmcIoTPV6rK5ZI8JzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IkxG1TYIGYV1AoeeK0hjrGnPHy08+eME
        RtBMg6UE+2Ws5eFwI2eYm3lrmo4WdEu321LrJMrg8y0S9aM8yiwWillGTtnvFJRI
        HHWQWszL4kCcRDraEImXkOIpIXr/O6rBma9D2Yp6zVV1ueoNowZK5b54fpEvVj1r
        ZKtaY3k44UE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 260A5D71C1;
        Tue,  4 Aug 2020 18:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 675C0D71BF;
        Tue,  4 Aug 2020 18:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
Date:   Tue, 04 Aug 2020 15:49:17 -0700
In-Reply-To: <20200804221440.GC2022650@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 18:14:40 -0400")
Message-ID: <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB5921D0-D6A4-11EA-8A42-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You might also consider whether "combined" is actually mutually
> exclusive with parent selection. We have focused on which parents you'd
> want to "-m" against. But in the most general case, you could ask for a
> combined-diff between parents 1 and 3 of an octopus merge.

Yeah, we want to specify a possibly empty set of integers
(1..<num-parents>) to combine the diff; if it is empty set, we won't
see any diff.  If it is full set, we'd get the current c/cc behavior.
Anything in between we cannot currently express.  Fun ;-)

> That's just coming from the angle of "what is the most general and
> orthogonal set of features". I think the vast majority of what anyone
> would want to do would be covered by doing a diff against only a single
> parent, and then it would almost always be the first parent. And
> certainly you'd need to add a bunch of code to the combined diff
> machinery to make it support arbitrary sets of parents. So this probably
> isn't that interesting a direction to go, at least for now. 

Yeah, it is mostly for fun--I do not see an immediate practical use
case, either.

> I'm just
> raising the issue now because we'll be locked into the semantics of this
> option, which may not be able to express the full set of what's possible
> (so we'd be stuck adding another option later).

Yeah, but a good thing is that we won't have to worry about this
until much later, as long as we would just be introducing "diff
against no parents" and nothing else (or together with "diff against
all parents", which would make it easier to explain "-m").

