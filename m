Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B8CC388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 04:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9654D20791
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 04:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZAtt1OLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJaESB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 00:18:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61918 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgJaESA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 00:18:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52AE8107CE5;
        Sat, 31 Oct 2020 00:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=byKHU5Oudi8J/R76HcW0a9w9o1c=; b=ZAtt1O
        LxhT+3Wq4PKyQW7IYYaaPaJ1k0xETfqN0p3UiyEj7xGwGVbGVLuhyp7VtFek7qOX
        WuXTb3NVmOj/xt9zgGKn/CIuQrb9XxW3jpnTeCCSrAPIf4vPp3tOPNy7o98NXyNH
        +GRhs9ZYDJ2lyMRYeQo0Gi9l78E8iQKPu01p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S4eX0GDzzRMC93iGR2ZjhhRluf78+x7V
        K3GxmLDQduvCXltFTliPXLW1k4nnAhbG2YkjP4EHA+0BT3oJKOnzBnn3aAIpRF1d
        Y8wgNLg0JxRCbXYSc9YhxpHMrk6ULf3lwHNPfkAClvv75YtuU8GigcHYrlvn3H6S
        DxJnyZctXC4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AF34107CE4;
        Sat, 31 Oct 2020 00:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 984FC107CE3;
        Sat, 31 Oct 2020 00:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Duvall <dan@mutual.io>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [PATCH v2] upload-pack: allow stateless client EOF just prior
 to haves
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
        <20201030223504.45978-1-dan@mutual.io>
        <xmqqzh4346sb.fsf@gitster.c.googlers.com>
        <CANo+1guedZiZVbnANsSPCiYbKWpJ_tjJ7vc04Ap7EVZzzp869A@mail.gmail.com>
Date:   Fri, 30 Oct 2020 21:17:54 -0700
In-Reply-To: <CANo+1guedZiZVbnANsSPCiYbKWpJ_tjJ7vc04Ap7EVZzzp869A@mail.gmail.com>
        (Daniel Duvall's message of "Fri, 30 Oct 2020 19:42:27 -0700")
Message-ID: <xmqqv9er3u6l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DA6D976-1B30-11EB-85DB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Duvall <dan@mutual.io> writes:

> On Fri, Oct 30, 2020 at 4:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> >  t/t5705-upload-pack-stateless-shallow-eof.sh | 24 ++++++++++++++++++++
>> >  upload-pack.c                                | 13 ++++++++++-
>> >  2 files changed, 36 insertions(+), 1 deletion(-)
>> >  create mode 100755 t/t5705-upload-pack-stateless-shallow-eof.sh
>>
>> I'd rather see it folded in an existing test, if it makes sense.
>
> With v3 I've moved it into t/t5530-upload-pack-error.sh. That test
> file seemed to mostly contain errant cases, but I thought it might be
> close enough as this was previously an errant case. If there's a
> better place for it I'm happy to move it again.

5530 is good.  It is not too big or full of unrelated tests, and it
is about sanity in the low level protocol exchange.

Thanks.
