Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9D2203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbdGXT3M (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:29:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753655AbdGXT3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:29:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD86999E81;
        Mon, 24 Jul 2017 15:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hM25nIpX1GtLfsRPnr4QQPwqQAg=; b=cTHJXZ
        mRXT+CfwbHHPZwF3MBRfa18m7eDVwkNpajD2yiBFWSInKzz3mdUkJXVaYJFN1Im+
        fA/5MiGtm9AAOVSTZgknjlvTqU2UCNId1p9aZhBXkHRC3trBAr+kqU9iSz+oNUJh
        sNNzIFuTNcp+prg4KBax1d/cOjwcjC4y5a5ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Id7gKfayIQuhGHpwIrYYQJGcbe0heoDs
        E57CyXufRA4kHdc44yKnrCkEXznEghRR+BEPpBvMsUhR/vhLN+uOgBrs3GuEXbc3
        EOu5abVEsbHAsUNgW3hNdHjk+omDhZxCRPvmqgCpluKCcU3ru2nN59Ih6QyH8bsE
        za76Fwd4CO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4B6C99E80;
        Mon, 24 Jul 2017 15:29:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44CC299E7F;
        Mon, 24 Jul 2017 15:29:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Blake <eblake@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
References: <20170721141530.25907-1-eblake@redhat.com>
        <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
        <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
        <xmqqwp71hj5n.fsf@gitster.mtv.corp.google.com>
        <20170724183103.b4vbr5xkijj7s7z3@sigill.intra.peff.net>
Date:   Mon, 24 Jul 2017 12:29:04 -0700
In-Reply-To: <20170724183103.b4vbr5xkijj7s7z3@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Jul 2017 14:31:03 -0400")
Message-ID: <xmqqzibtd473.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B12CB80-70A6-11E7-93FA-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I also should have mentioned the need for a way to say "remove all
>> hardcoded default and start from scratch".
>
> There's already some prior art around trailers in the trailer.* config.
> I wonder if it would make sense to claim a new key there, like:
>
>   git config trailer.Reported-by.autocc true
>
> If "Reported-by" is a trailer that your project uses, then there may be
> some benefit to setting up other config related to it, and this would
> mesh nicely. And then potentially other programs besides git-contacts
> would want to respect that flag (perhaps send-email would even want to
> do it itself; I think it already respects cc and s-o-b headers).

Sounds like a good suggestion.  But...

If I understand your proposal, the trailer stuff would still not
care what value .autocc is set to while doing its own thing, but the
programs that read the text file that the trailer can work on would
pay attention to it, and they individually have to do so?  Perhaps
there is a need for another mode "interpret-trailers" is told to run
in, where it is given a text file with trailers in it and is told to
show only the value that has .autocc bit on?  Alternatively, yield
<key, value> pairs so that the user of the tool can further process
the value differently depending on the key, or something?
