Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51546C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133B022D04
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 22:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbhAKWRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 17:17:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59469 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbhAKWRT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 17:17:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7B0B123777;
        Mon, 11 Jan 2021 17:16:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+hLUg/23SpR9eS0QRceqeoaDMbg=; b=u7wNMO
        I4a8P9WtbCrTSOS5Py9cgX/y9xbl56QgJfvwUp53MHVzDao7mJDdoJJo/4diT2+F
        SOSVtS/8ie04szcniAmItSnol+MbsmHyiutBAskF7YV6PhRUhjcRf06gLNVKM6C0
        uCHVkRZT6mJnimf+2F2PfyszfSoCV8VqKpmlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p3lP7R9gR3Toi2IJ5R3faNrnC+vpPyag
        jeMVWmhVMgHXKD6fNt4/4Zh83RzHn4Et+3Gf6fOnMi/QItFLJFDRF5g1LXKKAZMB
        db25feuyT8cPm83GsPtb/rLD7hxwNHaEvYXgL4VxmhOYlTY0B4lsJ9r5afd3xRDq
        GH0+MhNarXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEA3D123776;
        Mon, 11 Jan 2021 17:16:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F048123775;
        Mon, 11 Jan 2021 17:16:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Support for commits signed by multiple algorithms
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
        <20210111035840.2437737-1-sandals@crustytoothpaste.net>
Date:   Mon, 11 Jan 2021 14:16:33 -0800
In-Reply-To: <20210111035840.2437737-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Jan 2021 03:58:35 +0000")
Message-ID: <xmqq5z436rwe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAABA23E-545A-11EB-BE5B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series introduces support for verifying commits and tags signed by
> multiple algorithms.
>
> Originally, we had planned for SHA-256 tags to stuff the signature in a
> header instead of using a trailing signature, and a patch to do that was
> sent out in part 1/3.  Unfortunately, for whatever reason, that patch
> didn't make it into the master branch, and so we use trailing signatures
> there.
>
> We can't change this now, because otherwise it would be ambiguous
> whether the trailing signature on a SHA-256 object was for the SHA-256
> contents or whether the contents were a rewritten SHA-1 object with no
> SHA-256 signature at all.

How widely are SHA-256 tags in use in the real world, though?  Is it
really too late to fix that already?
