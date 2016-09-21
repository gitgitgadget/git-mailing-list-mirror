Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9251F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756065AbcIUQ0U (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:26:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56686 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752360AbcIUQ0T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:26:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 931493EEC8;
        Wed, 21 Sep 2016 12:26:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X4TXna1Usy4APMX2/0Q7egX01EQ=; b=K2vWJf
        3cPlaaCBNIn4Z60vQCg8nG7XUWPmGy8bTfegaI+Y3NApy2nR+3W1hRAbS+m9mb4j
        55kA6Z90N8OsHU8FGXrj2R6U10gzazjZ5PtaJqN/i10VM99vxav6EOssgQL5CH8A
        EIQxun9ee/AjKxm0BakDBp2jjUYfZ3IIkiXrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RrjqFe9dXZZT/bPR17hDnGH6ZWU/luMM
        RVmaQ/3kfThpVles8i+YefF2CQdaE6VZjpEj5C+66D0HzbKRoWMVTO1Y+OWmk9U2
        r63XRtgK78jx2ITh6iPPVcBRjn6GC2roYHLRMvXriJST0By2+kPZ0hvgW0MLxsLp
        D4zdxbIkiEI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A5353EEC7;
        Wed, 21 Sep 2016 12:26:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDB4D3EEC6;
        Wed, 21 Sep 2016 12:26:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Leandro Lucarella <leandro.lucarella@sociomantic.com>,
        Mehul Jain <mehul.jain2029@gmail.com>, git@vger.kernel.org
Subject: Re: 2.10.0: git log --oneline prints gpg signatures in 4 lines
References: <20160920170954.38b24284@labs-064.localdomain>
        <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
Date:   Wed, 21 Sep 2016 09:26:16 -0700
In-Reply-To: <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 20 Sep 2016 19:15:33 -0400")
Message-ID: <xmqqd1jxb4nr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FA58936-8018-11E6-975F-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think anything has changed here in 2.10. Running "git log
> --oneline --show-signature" has _always_ been horribly ugly. However,
> 2.10 did introduce the "log.showsignature" config, which makes "git log
> --oneline" pretty unusable when it is enabled. Ditto for one-liner uses
> of "--format".
>
> I think we should probably ignore the config entirely when using any of
> the one-liner formats (and I'd include --format, too, even though it can
> sometimes be multi-line; it already has %GG to include that information
> as appropriate).
>
> Another option would be to somehow represent the signature information
> in the --oneline output, but I think I'd rather leave that for people to
> experiment with using "--format".

My thinking is that "--oneline --show-signature" and "--oneline"
with log.showsignature set to true without "--no-show-signature" on
the command line should produce identical result.

The current definition of "--oneline" seems to me "the commit object
name and the log message is shown on a single line" (I consider that
the decoration given by "--decorate" is part of "commit object
name"), but there may be other things shown that may not fit on a
single line.

I do not terribly mind changing the definition of "--oneline" to
"what is output is ONLY the commit object name and the log message,
nothing else is shown", though.  After all, the output from "log" is
for human consumption, and it is a bug in the script if it is
depending on parsing the "log" output, so it is OK to change its
output to suit human needs, if necessary.




