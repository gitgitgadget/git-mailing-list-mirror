Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5101F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbcJTWp0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:45:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60350 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932105AbcJTWpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:45:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B999448509;
        Thu, 20 Oct 2016 18:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7C+23AZfIjPTuAA6mwkOPvC2lF4=; b=umFIO5
        lm23NDf3UMXufoeabQSObxLh1sLaGoDPBf+nGfIkN9FqPFlAaT+morYp/HII5o//
        /lnDUYnegzPlLROHDgT7716bX88k0Ou9mTahAw2R4DbX5+Fdhtmx3QAwbJ8goeqS
        iPYRxbcXBPskXMAOrbZX4gQyQU+u0QSyM8ego=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yJKvH3PhhlcZftKYeABvNVNIJswgMqGp
        tUSuCNOAmyN46CEHVHf9eIhGlGzaSKxQC7tiWwMvbL5vJzotkfSypz6sWOYVVZHU
        oyu078MXadl/W9ENWV84wQLgNTrT2GSfROiPNfeCcu+oAYD91zK++6+N22Io4JyB
        zOgcigA0oWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADCAD48507;
        Thu, 20 Oct 2016 18:45:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EC4B48506;
        Thu, 20 Oct 2016 18:45:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476998988.git.jonathantanmy@google.com>
        <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
        <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
        <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
        <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
Date:   Thu, 20 Oct 2016 15:45:21 -0700
In-Reply-To: <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com> (Jonathan Tan's
        message of "Thu, 20 Oct 2016 15:40:09 -0700")
Message-ID: <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2CB37F2-9716-11E6-BD6B-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> If we do that, there is also the necessity of creating a string that
> combines the separators and '=' (I guess '\n' is not necessary now,
> since all the lines are null terminated). I'm OK either way.
>
> (We could cache that string, although I would think that if we did
> that, we might as well write the loop manually, like in this patch.)

I wonder if there is a legit reason to look for '=' in the first
place.  "Signed-off-by= Jonathan Tan <jt@my.home>" does not look
like a valid trailer line to me.

Isn't that a remnant of lazy coding in the original that tried to
share a single parser for contents and command line options or
something?
