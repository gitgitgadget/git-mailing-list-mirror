Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C629C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 19:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbiGaTKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiGaTKL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 15:10:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081E1A4
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 12:10:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A3E81B7962;
        Sun, 31 Jul 2022 15:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TpKw7KCRi7lQZsc402S/bbRkz/prubk+bDnGFM
        1elks=; b=ADjbAdePapMOMxwlCA6xYMCDJ90MbVCQx+ByogDfAh4PESoNMDICp9
        yfi5a/a7iqatIBm2JP1ovALikaX7ZUZLrgzvvkO2e/yymwMPckbgmtCaVSafJo2b
        UKgex07D+oToFfn6/fPYLPIHr+0TG5TP7hZON3ZterKfPD59zY3Tg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 529071B7961;
        Sun, 31 Jul 2022 15:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 092D11B795A;
        Sun, 31 Jul 2022 15:10:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
        <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
        <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
Date:   Sun, 31 Jul 2022 12:10:01 -0700
In-Reply-To: <YuXKaLXhnR3mVlWk@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 30 Jul 2022 20:18:48 -0400")
Message-ID: <xmqqzggpyu7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 616E6634-1104-11ED-9937-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm tempted to say that the symref-reading code should
> actually complain about following something outside of "refs/", but that
> carries an even higher possibility of breaking somebody. But it seems
> like we should be consistent between what we allow to be read, and what
> we allow to be written.
>
> At any rate, with the code as you have it above, I think the "make sure
> HEAD starts with refs/" code is now redundant.

Isn't the rule these days "HEAD must be either detached or point
into refs/heads/"?  I thought "checkout" ensures that, and I am
tempted to think that "symbolic-ref" that works on HEAD should be
consistent with "checkout".  So "make sure HEAD is within refs/"
would certainly be "not wrong per-se" but not sufficiently tight,
I suspect.

