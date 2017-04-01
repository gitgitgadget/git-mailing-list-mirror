Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E004220958
	for <e@80x24.org>; Sat,  1 Apr 2017 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbdDARQg (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 13:16:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65363 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751726AbdDARQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 13:16:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02A118AE80;
        Sat,  1 Apr 2017 13:16:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3IeXY9p2+qAseop0qXENhyaCRpE=; b=l1K01W
        /bIJpp9J2wly6oJf960Kts67Eklf2VENCqTxzjDlykt65v1SKrsn1ZDZzlBreZ4H
        jVFIKDrUF1Sj7qJBc6cvV1a+KxNexqrNbTLIlpsaVGvIM6U2Y3/EtlT/eIqHxvTr
        hOfY97xlgoWETdNuevABpGeqqLdDmlQL2o5os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rKbNEV+STbqMHp/HI7Vy/orBiPtJUURa
        vZ6wn1g2ruz1sEwURHfpFgOD3GwmYXXAUXibPsKUovs3crae0LQ8LQxLtDZia3rg
        olAlRRQIjjy4nEOn1MYPe3792Xi2ZIgNqiT5sl5SmqWhq2HVLmlY7p6hJpIMqKlh
        u8Th48YEvpA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDACB8AE7F;
        Sat,  1 Apr 2017 13:16:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B0428AE7E;
        Sat,  1 Apr 2017 13:16:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Daniel Ferreira \(theiostream\)" <bnmvco@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
        <1490844730-47634-5-git-send-email-bnmvco@gmail.com>
        <ab7a326c-0189-4542-76e8-649eb6e804c9@alum.mit.edu>
        <CAEA2_RL18TarW6k5keP+ADFDv+VZE+gG3e6EkCmWby7GjG-T_w@mail.gmail.com>
        <20170401090350.t2tlpul2hm55xt6b@sigill.intra.peff.net>
Date:   Sat, 01 Apr 2017 10:16:29 -0700
In-Reply-To: <20170401090350.t2tlpul2hm55xt6b@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 1 Apr 2017 05:03:50 -0400")
Message-ID: <xmqq8tnkvyj6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3029C24-16FE-11E7-A7A2-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we actually prefer just:
>
>   >dir/b
>
> in our tests. The advantages over touch are:
>
>   1. It is clear that the output will be empty afterwards (whereas with
>      touch, it might just update the timestamp on an existing file).
>
>   2. It's faster, since it doesn't require an extra process.
>
> It's equivalent to ": >dir/b". I think you'll find all three forms in
> our test suite, but ">dir/b" is the most common.

Another one.

    3. Avoiding "touch" when we only want to ensure existence of a
       file and sticking to ">dir/b" (with or without ":" no-op)
       lets us reserve "touch" for the intended use of the command.
       When seeing a "touch", the reader is signalled that the
       script cares about the timestamp of the target file updated.

Among the three, this one is the most important reason from the
point of view of making the codebase maintainable in the longer
term.  By forcing the writer to think when choosing between
">target" and "touch target", we reduce the mental load of the
readers.  As is true for most things in computer field, read happens
more often than write while maintaining the code, and that is why
this matters.

