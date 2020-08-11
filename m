Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CC2C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 03:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF8C2065D
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 03:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XBWu0kmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHKD33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:29:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53756 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgHKD32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 23:29:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 910217ED0C;
        Mon, 10 Aug 2020 23:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XocsI/OsGns0+WBQ0rCI4sUQNAo=; b=XBWu0k
        mrhvd2OO9kSIkcfHyU+U1abz5Ci2EYQjSpI/kMIRsA8DY4P2dSgkLa3P1lSpiLr/
        BT+z0BLgvs+PVNoc265SD6R113U1LlbfZJmYFpPQ9wuP6cdz/+48Geyu8SxlgesQ
        igeKc8/BSBBfkiEDYo4SGTtQeuPTY8kRq6/sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eAV/9tyYM6kSKJJEHlGwp62CpX/IEjP2
        1gTYXKvduDJM/otzLxBurZzIQ26klhlMKjEeevg1C2xugUlHG/7fZfrRx1tLH9WW
        6twk04/QHWFoOY+8nlLFzV+J5A9GQ9bbRShkdgYXkjdS5Q/te/HwiahxDRgGBob7
        oYhU+gZL5nw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 874EC7ED0B;
        Mon, 10 Aug 2020 23:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AD177ED0A;
        Mon, 10 Aug 2020 23:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Git List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
References: <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
        <C4TOW9DJ7JW0.1QXQ173P2ERVN@ziyou.local>
        <CAPig+cSSBbgGZmKfEZ0P=J4a2=97uifHKvWAa3t6xU7B+bE-Pw@mail.gmail.com>
Date:   Mon, 10 Aug 2020 20:29:25 -0700
In-Reply-To: <CAPig+cSSBbgGZmKfEZ0P=J4a2=97uifHKvWAa3t6xU7B+bE-Pw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 10 Aug 2020 19:21:40 -0400")
Message-ID: <xmqqa6z1c12i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB5AE7A6-DB82-11EA-B37B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 10, 2020 at 7:09 PM Raymond E. Pasco <ray@ameretat.dev> wrote:
>> More rigidly, it's nice to confirm that it's a diff from the empty blob
>> and not from some other random blob.
>
> The tests can get access to the correct OID of the empty blob without
> hardcoding it either via $(test_oid empty_blob) or just as
> $EMPTY_BLOB, however, that's the full length hex string, so you'd
> still need to do some tweaking.

If the tests do truly care about these exact objects, then using
"--full-index" would be a good way to compare with $EMPTY_BLOB
and/or $ZERO_OID and such.
