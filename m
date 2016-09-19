Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A370F2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 22:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbcISWEF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 18:04:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64749 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752717AbcISWEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 18:04:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E38C13F242;
        Mon, 19 Sep 2016 18:04:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WAd0C5VVskknFBDgs7LnziX/ALE=; b=feX1rd
        Bqz+v9dn1ailk187bXG3lKRBfiSO+w00zLNmGJBhqW++lY1REITIeNMATTP8HZ1T
        cTH2b/6iY78L9czQgWigYC9fl/GfkfO0on/n6O1Df4iQm/H+2dayo+hkqlD43u46
        ufORjxQG5iHf6Pjllub6WZt20LaemOk33+R4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFVUHY4xe5JULDljFai7frW+KXowTcOU
        umLVN+/HkLDWdIi8tESb5geX8pN5vwPUChpV5O2Cj5lHecxNCO8zBKszMYTskeyi
        tazGMo6dukY4nkAVJ7heYxQNyPG0I5+LBwQ+CrZIGewdqmIIKYAFvnM2RanIHUPN
        F3JbPGwZnn4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC23B3F241;
        Mon, 19 Sep 2016 18:04:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AD033F23F;
        Mon, 19 Sep 2016 18:04:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
References: <20160919185440.18234-1-me@ikke.info>
        <20160916210204.31282-1-me@ikke.info>
        <20160919185440.18234-3-me@ikke.info>
        <xmqqvaxrd1ml.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 19 Sep 2016 15:04:00 -0700
In-Reply-To: <xmqqvaxrd1ml.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 19 Sep 2016 14:24:18 -0700")
Message-ID: <xmqqmvj3czsf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F961E008-7EB4-11E6-9173-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Kevin Daudt <me@ikke.info> writes:
>
>> +static void unquote_quoted_string(struct strbuf *line)
>> +{
>> +	const char *in = strbuf_detach(line, NULL);
>> +	int c, take_next_literally = 0;
>> +	int found_error = 0;
> ...
>> +	}
>> +}
>
> The additional comment makes it very clear what is going on.
>
> Is it an event unusual enough that is worth warning() about if we
> have either take_next_literally or escape_context set to non-NUL
> upon leaving the loop, I wonder?
>
> Will queue.  Thanks.

It turns out that found_error is not used anywhere and tripped the
-Werror=unused-variable check.  I've removed that line while
queuing.

Thanks.
