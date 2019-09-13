Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB6E1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 17:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfIMRi1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 13:38:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54232 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfIMRi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 13:38:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EC032F058;
        Fri, 13 Sep 2019 13:38:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PYHfxkrVr5rB
        6Km7F2Ny3UAcWGg=; b=lWh/ifwINh4+TaLTV6zBHk3NZjXYAveCGdLHryRddJmU
        oG+yoJvCrVx3YiTX0K+d0AyMcD+uLuYeIaAKXTraGNtLtfRJvU2K+uukJeMO5HUx
        Y8cNRirlh21kYRSCmrf+4d/EtUu780cG7LHCiO0XcN5pv11wRcfEKXSmlPLwlYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=J8F8qz
        2cxisbTWE7tbI/ELsEBHLjdx00iWxasNJZplKf1KfqYpZZ0yVny2pQCNKzGYDx0c
        dqdXzYmOzY/f1gLvhl3ZO4/NSTcpbbyipkoSpFhOUgcnXwrE1UTg9MuT/PeC4rAv
        dUVFxvioxIiH85Wqr+rrVnlS/k7CMWVFX11Dk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 875022F057;
        Fri, 13 Sep 2019 13:38:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E47992F056;
        Fri, 13 Sep 2019 13:38:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Makefile: run coccicheck on more source files
In-Reply-To: <20190913114952.GO32087@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 13 Sep 2019 13:49:52 +0200")
References: <cover.1568101393.git.liu.denton@gmail.com>
        <cover.1568309119.git.liu.denton@gmail.com>
        <89b7e17469e19c9dca8afa729ec1a70f4e06a2b7.1568309119.git.liu.denton@gmail.com>
        <xmqqtv9hfjdn.fsf@gitster-ct.c.googlers.com>
        <20190913114952.GO32087@szeder.dev>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date:   Fri, 13 Sep 2019 10:38:22 -0700
Message-ID: <xmqqo8zodrld.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49255B40-D64D-11E9-B5A6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> Using a procedure whose output is fed to xargs has an advantage that
>> a platform with very short command line limit can still work with
>> many source files, but the way you create and use COCCI_SOURCES in
>> this patch would defeat that advantage anyway,
>
> COCCI_SOURCES is only used as an input to 'xargs', so that advantage
> is not defeated.

It is passed as a command line argument to "echo", that pipes to
xargs; I would not say it is taking advantage of "xargs" to lift the
command line length limit, as it first needs to convince the shell
to feed all of them to the "echo" that is upstream of "xargs".

As you mentioned elsewhere, LIB_H already uses the same approach as
I outlined in the message you are responding to (i.e. "don't define
a procedure to produce lines to the standard output in a $(MAKE)
variable--instead make the variable to hold the list itself"), so I
suspect that we are almost on the same page?


