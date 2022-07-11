Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E16C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiGKVhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiGKVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:37:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE413245F
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:37:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 896B412BF98;
        Mon, 11 Jul 2022 17:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qRmtgj9EWK/g
        GADIyjxvXW5DhEKWbc3hYbjbNOdB4H8=; b=yjEM9GcNt5NQZm0H4Lbk+SaNNtIV
        tOr65udVoaxM9KrSelU5QQNWhUTCOWMs8gODzftuuTclsBHVgPa0cID/nMj/WsZc
        N/kEwjNQTldJfictLaLesfE8t4Xx/EUEV9Ds5MXeefLKK3ww5nkTKOF+zoVgeoEL
        0WOxdQW1YOHk+Cw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 795D212BF97;
        Mon, 11 Jul 2022 17:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD5AE12BF96;
        Mon, 11 Jul 2022 17:37:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
        <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
        <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
Date:   Mon, 11 Jul 2022 14:37:35 -0700
In-Reply-To: <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 11 Jul
 2022 13:37:27
        +0200")
Message-ID: <xmqqedyrmiu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE73404C-0161-11ED-AFDF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As with the preceding change what this leaves us with an unresolved
> question though, should we have some stricter version of "make
> style-all" that incorporates "ColumnLimit: 80", or perhaps apply it
> only on "make style", but then what if someone modifies code that
> happens to e.g. search/replace a line running afoul of the limit?

A more important thing to think about is that there is no single
good cut-off point.  When we say "wrap your lines at around 80
columns", we mean that when there is a good place to fold at around
column 65 and the next good place is at column 82, then it is OK to
go slightly over 80 and wrap at 82, which may be better than
wrapping at 65.  If the last good place to wrap is at column 72 and
the long function call at the end of the line makes you go past the
82nd column, wrapping at column 72 might be better.  I wonder if
there is an automated formatter that understands this kind of shades
of gray and lets us express that.

Thanks.

