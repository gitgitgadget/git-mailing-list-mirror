Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016B3C43381
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D3B64F79
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhCDBPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:15:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55655 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349581AbhCDBNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:13:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7DEF111028;
        Wed,  3 Mar 2021 20:13:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mgwTqO1dLA83q4bRmNCODhwYI+A=; b=t9SEeU
        /haqXU+iFm7BjgPG9AaleuHoNnxF6PqgREkOa5WDyv1x6Rp3krbKcqTUHUpE0M5h
        bmHx1YC5FRda+1Sebi8+hegsqtdZbp5OFu4hB9PGcH1HBX+UTWCNhFM7JQUby8I/
        gpijk6hYC1dMuFAZrs0MIsIvdFPcMDSKCd4UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YGbn/EfvIUSHvdO7KpAONI64NeG8bZID
        V1amAAfc34zHUdfehheda9rHiNXLXGy5w3o9fBr6dDz26ZmHfqLIyZyLaygUXPGA
        Bciz9DAii65nNxjOBvRClaOrW1dYlCOHhSMtCR/UTqNAlriLminc8OJyK1aFtyvq
        2GwJhbS6MJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C174E111027;
        Wed,  3 Mar 2021 20:13:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15D9B111026;
        Wed,  3 Mar 2021 20:13:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Vusich, Joseph" <jvusich@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug: conflicting core.bare setting causes segfault during bare
 clone
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
        <YEAi4OkkNnp+IMJD@camp.crustytoothpaste.net>
Date:   Wed, 03 Mar 2021 17:13:10 -0800
In-Reply-To: <YEAi4OkkNnp+IMJD@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 3 Mar 2021 23:59:28 +0000")
Message-ID: <xmqq4khrg1qx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9FA95A6-7C86-11EB-8685-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I will admit being a bit interested in how this was discovered, since it
> seems like an odd configuration to have, so if you can share, I'd
> appreciate it, if only to satisfy my curiosity.

I had the same reaction.  Forcing everything to be bare is quite
unusual.
