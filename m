Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B3C207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934368AbcI2RtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:49:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64413 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934123AbcI2RtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:49:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A2E340EE9;
        Thu, 29 Sep 2016 13:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3loC9irl0WXAYUV1sceXLRfk48s=; b=biw8z6
        cYJsHqX9Q6soqA17j6IMJ1VKW/nwg3R6W1NWcmSfUWgc4KsVHuOaaLIPorgbUM+U
        bmAK3U63W1oDQmsjPbEVuPRNxGs/BE8XtxCbqdbt8o86559gqGTYcujACuNy+L+y
        YLkH3SS+9gpdN0KMtTDESqf2/qjvPw/Y5ckz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PkN4qWbxPs+mDdXOsJ0jt1w01yPU8Txr
        Nr0Gx5/gmtS7jVIaxmpTebKiBXi0t8+cZ8dGApf0Q6yFuLdeRK1zaB1cOGHa+e/i
        hJSQ7I20s8Y5p1noCjlapdZ2dRnui0Mj9VjaBwAUQrRtJyLWZXdcHjPgUVQi6inw
        1hsiR3HFIvg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2284840EE8;
        Thu, 29 Sep 2016 13:49:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A1A940EE7;
        Thu, 29 Sep 2016 13:49:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] log: add --commit-header option
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
        <20160929083851.kx6itvrh4n2rttrx@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 10:49:04 -0700
In-Reply-To: <20160929083851.kx6itvrh4n2rttrx@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 04:38:51 -0400")
Message-ID: <xmqqtwcyfvfz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04803E02-866D-11E6-8EBA-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This lets you stick a header right before a commit, but
> suppresses headers that are duplicates. This means you can
> do something like:
>
>   git log --graph --author-date-order --commit-header='== %as =='
>
> to get a marker in the graph whenever the day changes.

That's interesting.  So it is not really "commit" header, but a
header for groups of commits.  Credits for realizing the usefulness
of such grouping may go to Kyle, but the implementation is also
brilliant ;-).

> This probably needs some refactoring around the setup of the
> pretty-print context.

