Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6A21F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdGYUwu (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:52:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58006 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751540AbdGYUws (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:52:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48D00749DE;
        Tue, 25 Jul 2017 16:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JoD/3jmjcERLxoxuxfdxR2eN/2g=; b=ZVv1qz
        gRakbHIxXhHhhl/cN33IkZ9JFV4I4vkefIgNJ3fSzJOLQVaqTfvstFdTZ1ykxd5t
        Q8pJV9H6uGCg8E2Cv1hRGHqKV0zigEPBPsc0MwYXvfgie1cSd3n6PoezHqmAWxw/
        d/t/vAhqX5NJ8D6saPtlnnsL91z5fqYmRN3EU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MQv+YJdU6p51bxd0EtkXfBzh+cSqeeFt
        ure/sj4fu/jVTpl22/tWXrZJKnELftdtSjClk0t65wKrok+G+QytZjcUxU8lqu0g
        fbHKk99rEij0+312hRVvITYrBSqZquvh0veNoyS9pVflTkPHlbSdA0/5L2ogqa6m
        5JH6GGX9CVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40066749DD;
        Tue, 25 Jul 2017 16:52:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90CD3749DC;
        Tue, 25 Jul 2017 16:52:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        Farshid Zavareh <fhzavareh@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
        <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
        <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
        <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
        <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
        <CAH5451nbY+Xo0Fpe2OdsxwJeRV1ddZmYX7v-bPYgRsbS2kNJSg@mail.gmail.com>
        <20170725191347.e2p7goxho2rcemz4@sigill.intra.peff.net>
Date:   Tue, 25 Jul 2017 13:52:46 -0700
In-Reply-To: <20170725191347.e2p7goxho2rcemz4@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Jul 2017 15:13:47 -0400")
Message-ID: <xmqq7eywutlt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37050B74-717B-11E7-B40B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As you can see, core.bigfilethreshold is a pretty blunt instrument. It
> might be nice if .gitattributes understood other types of patterns
> besides filenames, so you could do something like:
>
>   echo '[size > 500MB] delta -diff' >.gitattributes
>
> or something like that. I don't think it's come up enough for anybody to
> care too much about it or work on it.

But attributes is about paths, at which a blob may or may not exist,
so it is a bad fit to add conditionals that are based on sizes and
types.
