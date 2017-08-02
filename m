Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F4B20899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdHBWfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:35:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53828 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751062AbdHBWfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:35:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D40995967;
        Wed,  2 Aug 2017 18:35:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eyRotYkm5KPQ
        ryMCCOw/yyLyMPc=; b=kflXQsAnVrYN51iYXWNpuleBjsuY74cvBATfJmYQD8lS
        nVuxFZcvnYxQDyMwpbmc8bfpClPmog4tZTV0YL4KjE6Jadpfeo9na4nviPHIbWzh
        pjGE9A+7RqGZ8nE88r9gqFhMWBSx57I9dnYWG1off5zDNt/z8IKOtOFsgitgIiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VcLYCB
        BqwvlLKLCWqovziQnv5mBmpGaQwCKFwv07QpDv3OytM+sHZuTBcaCkAdlAapC2mJ
        zzEAmS+47kuAqKk0yTNsNyv+ZsfkBme2eC2TRv8TZ7aMooyqQqEsnHvSSlLXl/rP
        KoIh1LjkxgsgZQMgJfkTsc29NVFfGbBuJ8Hp8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44CCD95966;
        Wed,  2 Aug 2017 18:35:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC4B295965;
        Wed,  2 Aug 2017 18:35:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] handling empty inputs in the revision machinery
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
Date:   Wed, 02 Aug 2017 15:35:45 -0700
In-Reply-To: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 2 Aug 2017 18:24:25 -0400")
Message-ID: <xmqqh8xpr41q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED5C3CA0-77D2-11E7-8463-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I noticed that:
>
>   git log --tags=3Ddoes-not-exist
>
> will show all of HEAD, which is rather confusing. This fixes it, and
> also hits several other cases that were marked as expect_failure for
> rev-list. There is one case it doesn't handle: --stdin. It's not clear
> to me what the right behavior is there. I'll follow up with more
> discussion.

Na=C3=AFvely, I would expect that an empty input from --stdin should
still prevent us from defaulting to "HEAD", just like --glob=3D* and
friends should do.  Perhaps there are conter-example scenarios I
haven't thought of..

Thanks.


>
>   [1/4]: t6018: flesh out empty input/output rev-list tests
>   [2/4]: revision: add rev_input_given flag
>   [3/4]: rev-list: don't show usage when we see empty ref patterns
>   [4/4]: revision: do not fallback to default when rev_input_given is s=
et
>
>  builtin/rev-list.c       |  3 ++-
>  revision.c               |  3 ++-
>  revision.h               |  7 +++++++
>  t/t4202-log.sh           |  6 ++++++
>  t/t6018-rev-list-glob.sh | 20 +++++++++-----------
>  5 files changed, 26 insertions(+), 13 deletions(-)
>
> -Peff
