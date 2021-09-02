Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47DC433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36A46023F
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347743AbhIBWnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:43:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65068 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbhIBWna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:43:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FE2115979C;
        Thu,  2 Sep 2021 18:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FbKxKsthO9xhmClDshaWlyK0+kOnB3PJyEWaA+
        5cEdU=; b=SXU3loC1mSHqaTXbegqJEsj6NLcKXa1+yWIlAPY4Kqv7SA/e2hMmFP
        0h1i5Hb2G2R8qFY3FT24JQWdgMeV6UDfQtJyWybPBi1ARgEX3dssyrIymkr56IMF
        kth3c8KWuPmab3/K0qvPo6QdFmDaN/cQTyZsdi/guTVZvt1ze99DI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5869C15979B;
        Thu,  2 Sep 2021 18:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9594815979A;
        Thu,  2 Sep 2021 18:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
        <xmqq5yvik8bc.fsf@gitster.g>
        <CAPUEspj9YPJHcKzjGNR05-FnkzRoZJ0yKC1McA5wM06HgUPVHw@mail.gmail.com>
Date:   Thu, 02 Sep 2021 15:42:27 -0700
In-Reply-To: <CAPUEspj9YPJHcKzjGNR05-FnkzRoZJ0yKC1McA5wM06HgUPVHw@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 2 Sep 2021 14:29:59 -0700")
Message-ID: <xmqq7dfyioq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D3E11C4-0C3F-11EC-9788-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Dropping it now would avoid having to change it to `grep -E` as egrep
> gets obsoleted.

Keeping it would isolate the callers from "grep -E" vs "egrep"
because they do not need to know.  They can keep calling
sane_egrep().

Having said that, I do not think anybody minds losing sane_egrep().
Many helper functions in the shell library are about encapsulating
the knowledge we have on and around Git and making it easier for
third-party script writers to use the knowledge.  The functions like
is_bare_repository(), cd_to_toplevel(), and git_pager() all fall
into that category.  sane_egrep is not that kind of a helper (it
encapusulates our knowledge about GNU grep's quirk we found when we
tried to use it in our scripts---third-party script writers do not
need help from Git experts on their use of egrep).

Thanks.
