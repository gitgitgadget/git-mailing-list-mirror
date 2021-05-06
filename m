Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DAC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FC46101B
	for <git@archiver.kernel.org>; Thu,  6 May 2021 00:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhEFA2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 20:28:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59844 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFA2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 20:28:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D490D3347;
        Wed,  5 May 2021 20:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9WMFfjJdhdOcLUwJPdRG5fHsrfmp8HM+Rqa7tQ
        y0CRw=; b=gJfXaWwzxdbJDPMTkGlC+0j9P7RSGaGMS/er9VRz1FXTADuNZNm6UC
        JIU06CBhY8Tt+qBKgSnluMlwI23M0wuOmoKwgL/JeCkOX2ZjhH52wW+M4vMoSBW4
        dZVYIPkXXJndxSAIRYgROZv9h6y7a0gMUCYDpr1qYuU63uH1XpTfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95D29D3346;
        Wed,  5 May 2021 20:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07418D3345;
        Wed,  5 May 2021 20:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru> <xmqqbl9q7jxf.fsf@gitster.g>
        <87r1imbmzz.fsf@osv.gnss.ru> <xmqqy2cu58vo.fsf@gitster.g>
        <87tunh9tye.fsf@osv.gnss.ru>
Date:   Thu, 06 May 2021 09:27:30 +0900
In-Reply-To: <87tunh9tye.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        05 May 2021 16:43:53 +0300")
Message-ID: <xmqqim3w3dvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8CD06F2-AE01-11EB-A04B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> No, I don't mean it. The idea is to let -m be alias for
> "--diff-merges=on -p",...

Ahhhh, that makes a whole lot of difference.  Thanks.

> If, on the other hand, it's just me who fundamentally misunderstands the
> design, then I need to be corrected fast, before I make significant
> damage.

No, it was I who was confused, as I somehow incorrectly thoguht that
your plan was to make "-m" identical to "--diff-merges=on".

But if your plan is to make

    "git log -m"    (no other option)
    "git log -m -p"

behave identically to "git log --diff-merges=on -p", and similarly
make

    "git log -m --stat"
    "git log -m --raw"

behave identically to "git log --diff-merges=on --stat/--raw", I
think that such a design makes quite a lot of sense.

It will still keep the purity of "--diff-merges=<choice>" (that is,
it only is about if/how a merge is expressed in some form of diff),
while solving the longstanding usability issue of "-m" that led to
Alex's "when a user says -m, diff output is expected", that came
quite early in this thread.
