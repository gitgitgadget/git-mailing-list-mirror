Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5769720A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 04:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdITEAU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 00:00:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63160 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750771AbdITEAT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 00:00:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC38BAA978;
        Wed, 20 Sep 2017 00:00:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ytoX3NFyj9Qz9y1fpy5a0R8tELg=; b=K27+NB
        SXqjsSUP9zBHrcDtJ3/RhDHkxnd/+HQLr7+4r7aIQsgsSszFOR2rVGmi9Ph7DGCE
        +U7UEJqI8udNoEXC4qnX+kOu366FkvYn6e24kT+2sFOeHXY0ocKaryWVrumb8I0v
        w3exPj6TPHLgB7Td2HDa11xTThKXlldLXvP7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BXWZ9qILPlsyaUcyXqtvHiv8N7d2XfwO
        IyJ/5eOyMvDfLwPSv3BQld9rNtsn+mziM1ZEIGY5rPGDDi7zKdDjDQ3IqxBZBU4R
        chex3glhdKmlsG3F5h38nVR4VYGBXjxTx8poDTXGwb7WIy1R/bScwNOZrLdPrfPN
        qCfjvqK859k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2410AA977;
        Wed, 20 Sep 2017 00:00:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29246AA976;
        Wed, 20 Sep 2017 00:00:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] builtin/checkout: avoid usage of  '!!'
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
        <20170919071525.9404-2-kaarticsivaraam91196@gmail.com>
Date:   Wed, 20 Sep 2017 13:00:16 +0900
In-Reply-To: <20170919071525.9404-2-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 19 Sep 2017 12:45:21 +0530")
Message-ID: <xmqq8thaow8f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3715E890-9DB8-11E7-89BF-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> There was a usage for which there's no compelling reason.So, replace
> such a usage as with something else that expresses the intent more
> clearly.

I actually think this is a good example of the exception-rule.  The
function wants to take true or false in "int", and the caller has a
pointer.  And !!ptr is a shorter and more established way than ptr
!= NULL to turn non-NULL ness into an int boolean, without having to
either repeat or introducing an otherwise unnecessary temporary.
