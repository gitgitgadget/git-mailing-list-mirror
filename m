Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D02C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 04:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D962C205ED
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 04:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JGjuOEKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKXEY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 23:24:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59914 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKXEY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 23:24:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D49A42A6DD;
        Sat, 23 Nov 2019 23:24:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6LCo5RW63W1hJR+TdKh9p1P9/TU=; b=JGjuOE
        KHLO5mfYaxMDStZGMOY1dAyBH3QSmGS7d4h+o949YIvTAP1AlcAYNsYcF12ZMAlA
        gTmtrowqpoQaZS6289VGxU8JB8kXjYXUugX43Qx4nkBYYTMqHoRKclHlgOa3tIrF
        o5ov15BvskR0eYYZ9QPoiFH7Q1kB4NnVSNVq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZBarfN0oF4N3uBICnNbh2R3ZB3dANRID
        8f+Ua5ZZEWFWPbHNY7RbYxZJGNXpTiiXFn5XsWYkIsBocKfnUsCBTIx0lIDsykyy
        YQ42OByRuv9mexnbPjyq/xupJZw2LtNkd1n/KyuGOzcmJRSZQphP3EUs5kKgDSlj
        oJ6kqZI6hbc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC8A12A6DC;
        Sat, 23 Nov 2019 23:24:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AA2A2A6DB;
        Sat, 23 Nov 2019 23:24:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Report of use of "local" per t0000-basic.sh
References: <03ad01d5a167$a834e580$f89eb080$@nexbridge.com>
        <20191123041616.GD6430@camp.crustytoothpaste.net>
Date:   Sun, 24 Nov 2019 13:24:54 +0900
In-Reply-To: <20191123041616.GD6430@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 23 Nov 2019 04:16:16 +0000")
Message-ID: <xmqqwobp2961.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DE4A2F4-0E72-11EA-B0AC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think it's fine that we restrict the use of local to within a
> function.  In fact, dash (Debian and Ubuntu's default /bin/sh) exits
> unsuccessfully if you use local outside of a function.

All of the above sounds quite sensible.

> Is there some place in particular that you've found we're using it
> outside of a function?  I don't know about others, but I'm certainly
> interested in fixing these.  It looks like we do use it in a function in
> t0000 itself, though.

Yup, we definitely should fix it if there is a use of "local" at the
top-level outside a function that does not make sense.  The one in
the t0000 that tests if "local" behaves the way we expect it to
looks OK to me.
