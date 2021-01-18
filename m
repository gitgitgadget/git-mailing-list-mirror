Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13371C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 22:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44D522E02
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 22:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbhARWza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 17:55:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53872 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731543AbhARWz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 17:55:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDF8911E1A6;
        Mon, 18 Jan 2021 17:54:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g33WpqvQqvH7J3kWKBY24YMqYbU=; b=KBMtni
        +dp0yaZF1gS/SM9KoPf6c7aQGCd25l5gqSrScRGm0VvTxGmW4E+ALSQZjcWrLg+7
        s8xZFtzaFXb/Qetc69BopUAwLXEpxPMO3aZYe1W3rb/MucFtf4CR0yN/J7curlji
        CWd/xTs6JmxIVk8T55/Tzo87L3FMcIbzpr9To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vDFhdIdLZO7od/P2gJRo4GrKcKAeVt3g
        Zl5I8Fk+mpu8vdmFPtuEC77/ex+rdrNu/v1Z2pmO7aCodLwJ6+wBN6Youjae4aaM
        Pswbewk2TwhYM483d8XjDSaXqXtDho2KUkEkv3x1BpM0WVwQ4PDQiLZWZnzsxhmT
        vYBPnlihAg8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B71B711E1A5;
        Mon, 18 Jan 2021 17:54:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 087CF11E1A2;
        Mon, 18 Jan 2021 17:54:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aiyee Bee" <shane.880088.supw@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: DEVEL: Help with feature implementation
References: <C8MIWAN0N50F.235740W7QGT05@localhost>
Date:   Mon, 18 Jan 2021 14:54:42 -0800
In-Reply-To: <C8MIWAN0N50F.235740W7QGT05@localhost> (Aiyee Bee's message of
        "Mon, 18 Jan 2021 19:15:43 +0000")
Message-ID: <xmqqzh15j1ot.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27D0CF8E-59E0-11EB-AFB9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aiyee Bee" <shane.880088.supw@gmail.com> writes:

> Maybe a more practical (but still pretty unusual) solution would be adding
> counters to each commit that tell us how many times they have been traversed
> Through various histories?

The "--show-forkpoints" output shown there at http://ix.io/2Ms6
looks interesting.  I think you'd need only 1 bit counter
(i.e. "have we visited it only once, or more than once" bit) for
your purpose?  You traverse from F and Z and the first time you
reach C (probably through the F->E->D->C path), you see no SEEN flag
on the object so leave the new bit alone, and then when the traverse
reaches C again (this time through the Z->Y->C path), while stopping
further traversal because you notice C is already SEEN, you mark it
with the new bit so record that it has been visited at least twice.

