Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1022036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdJEJOz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:14:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50360 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751278AbdJEJOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:14:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 265D6AE9EE;
        Thu,  5 Oct 2017 05:14:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=deQf2fwV+FAVIQf9GaELubead+I=; b=jPZ4uf
        VU37rsRajxVRYr7fEV/6WQ7EXvgDKJKF0BuP8mF6l9CF1rxodTAV/HydONPbvG1K
        XtYev15L2xW3ZzoOfVjkzFfvgfvTWLt5L844kGFIWvMT+okWxHf4CMixKv0TFrA0
        W9DQarrEdjzeykh3UJTVeVGCmsWbqIB0FEVkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bmXZA3QamklfimsgatTI2Eqqx8jkSAqM
        QrZrdIwyQQvFvdZEawO4p34y28xRRAh4bHOaBLImCgljquhar18H7P4VDH6113IK
        r9YXqTM1vzS+3qN1xZxJjV1S9xlclCkhvPJ+pmlPHVRzSCzCfNHvL25b0Uhtyy2C
        8Zxt2tq3/uk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 083B6AE9ED;
        Thu,  5 Oct 2017 05:14:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C9C5AE9E8;
        Thu,  5 Oct 2017 05:14:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH 2/3] for-each-ref: let upstream/push optionally report merge name.
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <f615fcc05fa358b4c7e3531cbdbd91661be321aa.1506952571.git.johannes.schindelin@gmx.de>
        <xmqq4lrfb7jk.fsf@gitster.mtv.corp.google.com>
        <xmqqvajv9m2k.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 05 Oct 2017 18:14:50 +0900
In-Reply-To: <xmqqvajv9m2k.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 04 Oct 2017 20:41:55 +0900")
Message-ID: <xmqqzi966jn9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4ABAE16-A9AD-11E7-86E8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think the remaining points from my reviews are:
>
>  - It would be better to compute precomputable stuff when used atoms
>    are parsed, instead of running starts_with() in these functions;

After reading the original (before these three patches) code for
populate_value(), I think reverting this mess back to how the thing
was originally envisioned to be would be outside the scope of this
addition.  It was way too messy before your series than I expected.

So, unless you or your collaborator feel like helping us to clean up
the codebase for better future, let's forget about that point, and
leave the cleaning up for now.

For those who want to help with the #leftoverbits, the first step of
cleaning up would be to introduce an enum field that sits next to
used_atom[i].name, and have the if/else if/... cascades use that
instead of these starts_with(name) to choose what value to grab from
the given ref.

