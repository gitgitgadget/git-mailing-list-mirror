Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CC61201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 00:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbdKJAwT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 19:52:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64186 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752494AbdKJAwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 19:52:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 203E9B26F6;
        Thu,  9 Nov 2017 19:52:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gcnrCxdP46TKc3rAJknYcrdSPno=; b=rYl6+C
        dNeDW1uo3ro3tVuiUh8fd6uICYx4bhO9LtXh1R8qn3pP0oNd/0oKok+miZN32+Zh
        kun20K3dePF6/Doa/HBNZaUvWiROjkv9KrEX2ar9AA73lsTw/AkXjtujq3L4nqvL
        NTTMMUJhgnZFAk5ZggcHX3NSYc4398RG7MqSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lTv3g2xANzNAehwz1oI9ULlkv3AMT3RH
        mdit/bA14Iq2c4XxfLXC+Fi9Cw81zN9mZyngIpqUdmwJZ+dNNWR68rjusGHHM93k
        b0sj98OtVRJb75Co3s6MKqVJQcoMePp2ukU4//DUszfdg4jPLmx36/b3QCEKlRpE
        EphoTkodFo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1888DB26F5;
        Thu,  9 Nov 2017 19:52:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89407B26F3;
        Thu,  9 Nov 2017 19:52:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Joseph Strauss <josephst@bhphoto.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug - Status - Space in Filename
References: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
        <xmqqvaikjfoj.fsf@gitster.mtv.corp.google.com>
        <20171109132939.3v2z6sf22b4tnwpq@sigill.intra.peff.net>
Date:   Fri, 10 Nov 2017 09:52:16 +0900
In-Reply-To: <20171109132939.3v2z6sf22b4tnwpq@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 9 Nov 2017 08:29:39 -0500")
Message-ID: <xmqqvaijhs5b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66638CBC-C5B1-11E7-AAC4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I think the original sin is using " -> " in the --porcelain output
> (which just got it from --short). That should have been a HT all along
> to match the rest of the diff code. The --porcelain=v2 format gets this
> right.

So we at lesat did something right, which is a consolation.

>> Perhaps a better approach is to refactor the extra quoting I moved
>> to this emit_with_optional_dq() helper into quote_path() which
>> currently is just aliased to quote_path_relative().  It also is
>> possible that we may want to extend the "no_dq" parameter that is
>> given to quote_c_style() helper from a boolean to a set of flag
>> bits, and allow callers to request "I want SP added to the set of
>> bytes that triggers the quoting".
>
> Yeah, I had the same thought upon digging into the code.
>
> That said, if this is the only place that has this funny quoting, it may
> not be worth polluting the rest of the code with the idea that quoting
> spaces is a good thing to do.

Sounds sane.  We can probably use a helper like this:

static char *quote_path_with_sp(const char *in, const char *prefix, struct strbuf *out)
{
	const char dq = '"';

	quote_path(in, prefix, out);
	if (out->buf[0] != dq && strchr(out->buf, ' ') != NULL) {
		strbuf_insert(out, 0, &dq, 1);
		strbuf_addch(out, dq);
	}
	return out->buf;
}

which allows the current users like shortstatus_status() to become a
lot shorter.
