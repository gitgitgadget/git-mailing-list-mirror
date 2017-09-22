Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E15202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdIVBtO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:49:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751596AbdIVBtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0740F92A10;
        Thu, 21 Sep 2017 21:49:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=02kymDWesoV76MNEhkQA9IFzKS8=; b=r1O53+
        i4iHvOY7a3ZLdtQKgwor6VTIMZb00s0kG9xXdEymf9qB8xbkFwFcX3v1u4hjoKJI
        KriyP1OeY3Xj1FhHyCsdU7mmcMNp4lUe2PmMZluylEq9481/Nq1KfzpxOCbOi1RA
        XnXmHwDFD/qQ068LiCE4TkSMkJqxKEJ+pG0e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wcy87nL+reAKfFbCfjjUbAM+BL4E0gS+
        GbpKWkA1gTkvNfbZsQ7AXEz4zV84RFZw+3GgzTGzzNyiryi0HZ2fWQFB3xARhfQT
        8CAKA5aZTbWg04t001kQEm5xEkL1aUnfPRUR7aIvMXXd7oC3V10karKzojLgxRbu
        gyI0Dv03mxk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F21C592A0F;
        Thu, 21 Sep 2017 21:49:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5321792A0E;
        Thu, 21 Sep 2017 21:49:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
        <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
        <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
        <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
Date:   Fri, 22 Sep 2017 10:49:11 +0900
In-Reply-To: <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu> (Michael
        J. Gruber's message of "Thu, 21 Sep 2017 11:39:12 +0200")
Message-ID: <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B8D9F5E-9F38-11E7-AE4A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Also, I'm undecided about about your reflog argument above - if we leave
> "--fork-point" to be the current behaviour including Jeff's fix then the
> documentation would need an even bigger overhaul, because it's neither
> "reflog also" (as claimed in the doc) nor "reflog only" (as in the
> original implementation) but "historical tips as inferred from the
> current value and the reflog".

Even though things like "reflog only", "reflog also", may be
something implementors may care about, they are irrelevant
implementation details to the intended audience.  "The bases that
are not in reflogs are ignored" _does_ matter, as it affects the
outcome, and that may be a bit too strict a filter (which this
series takes us in a good direction to fix) but what the readers
need to know is the real-world implications of the choices made at
the implementation detail level, and more importantly, what the
implementation is trying to compute.

It is a documentation bug (with or without these patches) if the
current text gives an impression that the code is trying to do
anything but "guessing the fork point using historical tips".

> In any case, for two modes we need two names for the options. Maybe
> --fork-point and --fork-base because in the loose mode, you may get a
> "base of a strict fork point"?

Perhaps.
