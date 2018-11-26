Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1001F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeKZSqB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 13:46:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65387 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeKZSqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDD7610F1C2;
        Mon, 26 Nov 2018 02:52:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KVeFAknQhWPex4i/shtv8+VgxeY=; b=NYZZN2
        h/w3edPDWXynccaEaeHE9uupwptRo/RrWyhZ3Jz3SjX0IPaUkieDsAdBPlLclXNo
        kdhKiRpzf0oK7nNOwcoeSvSNueTtgar2pS+AjqYkuUGbNATTxtCmePg/Sf8PAA2r
        Maz1UAot6BIsa3yZBpOnjlS9k/yXj3K3c46Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R6zzlM2YxuJDvOQVz/cDScg0pKGxMdJD
        bSpM7voe+sauMUWVBaVm5DhqBydWllb44+4gP+3BoJrJoeJOoMqJgwwfwxH4L5xq
        6DomXHwcrPs7R8Blc8BAvBQTm6VmHiNkhLHPDE99Sla+41kUrs89pG7hg+5Evmpf
        6lRCIFr8lts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B52E010F1BE;
        Mon, 26 Nov 2018 02:52:40 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DD7010F1BD;
        Mon, 26 Nov 2018 02:52:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: allow showing specific trailers
References: <20181104152232.20671-1-anders@0x63.nu>
        <20181118114427.1397-1-anders@0x63.nu>
        <20181118114427.1397-3-anders@0x63.nu>
        <xmqqy39o9tmq.fsf@gitster-ct.c.googlers.com> <87a7lw7oct.fsf@0x63.nu>
        <xmqqva4kzg23.fsf@gitster-ct.c.googlers.com> <878t1g72ee.fsf@0x63.nu>
Date:   Mon, 26 Nov 2018 16:52:39 +0900
In-Reply-To: <878t1g72ee.fsf@0x63.nu> (Anders Waldenborg's message of "Mon, 26
        Nov 2018 07:56:25 +0100")
Message-ID: <xmqq4lc4wa0o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FA13E0A-F150-11E8-8132-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> Would it feel less inconsistent if it did not set the 'only_trailers'
> option?

If %(trailers:key=...) did not automatically imply 'only', it would
be very consistent.

But as I already said, I think it would be less convenient, as I do
suspect that those who want specific keys would want to see only
those trailers with specific keys.

And if we want that convinience, we'd probably want a way to
optionally disable that 'only' bit when the user wants to.

And...

> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -228,9 +228,9 @@ endif::git-rev-list[]
>  ** 'key=<K>': only show trailers with specified key. Matching is done
>     case-insensitively and trailing colon is optional. If option is
>     given multiple times trailer lines matching any of the keys are
> -   shown. Non-trailer lines in the trailer block are also hidden
> -   (i.e. 'key' implies 'only'). E.g., `%(trailers:key=Reviewed-by)`
> -   shows trailer lines with key `Reviewed-by`.
> +   shown. Non-trailer lines in the trailer block are also hidden.
> +   E.g., `%(trailers:key=Reviewed-by)` shows trailer lines with key
> +   `Reviewed-by`.

... I do not think this change reduces the puzzlement felt by
readers who would have wondered how that implied 'only' can be
countermanded with the old text.  It just makes it look even less
explained to them.

If we assume that nobody would ever want to mix non-trailers when
asking specific keywords, then "them" in the above paragraph would
become an empty set, and we do not have to worry about them.  I am
not sure if Git is still such a small project to allow us rely on
such an assumption, though.

>  ** 'only': omit non-trailer lines from the trailer block.
>  ** 'unfold': make it behave as if interpret-trailer's `--unfold`
>     option was given. E.g., `%(trailers:only,unfold)` unfolds and

