Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE607C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D5A611F2
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhDLTcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:32:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60611 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhDLTcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:32:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17FF112F7DA;
        Mon, 12 Apr 2021 15:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8A9lbuZyiJeO
        bcIjUfJo861kzYY=; b=WcbpVpqrAWcz13nbuwf9HhPf6mIEiA0/MktOrI5UW6fr
        UoOx1b5TW6nOA2293bVcpEzL9hWF8J1VXS5NnKVA9pOfwe3lcmBSL4Im9J+xZBX7
        u47XkfnPOQ9TeP2QiUTOrJnI5F8u/yBzwz+FM9biEia3S/wsIvQG0PGgu+iAjkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hqQa9/
        ghOy0IscZVBFxwBfDnZLzdD9NLmGNcZ5H75/e94N2yZ/i/uuSr83fxNtVh3gpSRD
        M+oiNMNuc/vzWcY3fG6mGQMj5tW3xxeiRGc0WOcRCEaTZp1HqyTFSLQT7H+oPqCr
        zH8gSj1V3bUZDLLKrIAwoQZFHrYPCqdKX+oYg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FA5B12F7D9;
        Mon, 12 Apr 2021 15:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 490D812F7D7;
        Mon, 12 Apr 2021 15:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/16] test-lib-functions: use "return 1" instead of
 "false"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-14.16-b6e9d971b40-20210412T110456Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 12:31:47 -0700
In-Reply-To: <patch-14.16-b6e9d971b40-20210412T110456Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:09:03
        +0200")
Message-ID: <xmqqfszvcna4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9CEF8BC-9BC5-11EB-A4C2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change a few functions that relied on a "false" being the last
> statement in the function to use an explicit "return 1" like the other
> functions in this file.

While not wrong per-se, this and a few other changes in this series
are typical of your multi-patch series that unnecessarily consume
reviewer bandwidth that could be better spent on other more
important and correctness sensitive steps (like 07/16) in the same
series.

You should find a good balance to avoid wearing out and distracting
your reviewers---they are the most scarce resource around here that
must be shared by other people, not just with other topics of your
own.

Thanks.

