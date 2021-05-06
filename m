Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365DFC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A2F61289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhEFUad (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 16:30:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50342 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhEFUac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 16:30:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFE5CA9CC9;
        Thu,  6 May 2021 16:29:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Q2jy+Tka8MJMo2/rhbXyPJP+lhwx+b1VXQG1f
        CBwoM=; b=FRNZ1TUS/eAIlOj3kV16OnRqgwZDq5E/ab4GSHH3EiZR32V3dM09r6
        8FTipBbxJ0p37FjDXFRnslPIsd+UEup+TNLOuAEQkRzKgnS6P1In+ZKSs/yoN8yE
        dOJckb5zOI4+9+i8l3s/TcXHnEGFl6Lhq4BCTsmSoHyg5WAk3Si7g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7CCDA9CC8;
        Thu,  6 May 2021 16:29:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21C12A9CC7;
        Thu,  6 May 2021 16:29:33 -0400 (EDT)
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
        <87tunh9tye.fsf@osv.gnss.ru> <xmqqim3w3dvx.fsf@gitster.g>
        <87wnscuif9.fsf@osv.gnss.ru>
Date:   Fri, 07 May 2021 05:29:32 +0900
In-Reply-To: <87wnscuif9.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        06 May 2021 15:59:38 +0300")
Message-ID: <xmqqpmy3y5ar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C454EFF2-AEA9-11EB-B9AA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> It's nice we've reached mutual understanding!

Yes, and thanks for correcting me.

> The only remaining issue then is if we just go and do the change of -m
> semantics, or do we need to take some backward compatibility measures?
> Looks like we are rather safe to just go, as it's unlikely there will be
> any real breakage. What do you think?

I still wish I could come up with the usual backward compatibility
transition dance for this case, but I do not think there is one.

However.

If "-m" were doing a more useful thing than "compare with each
parent separately", people may have aliased "log -m" to something so
that their "git aliased-log" and "git aliased-log -p" would work
better for them than "git log" and "git log -p", but quite honestly,
I do not think "git log -m -p" output is readable by humans (after
all, that is why we invented -c and --cc), so the population that
get hit by this incompatible change may be very tiny minority in
relative terms.
