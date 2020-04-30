Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD99C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402A520731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0nTQD7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3Rbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:31:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63011 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD3Rbg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 13:31:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37522B989F;
        Thu, 30 Apr 2020 13:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7CeldJjL+6y8Hp6AQPi9Qr7q4Us=; b=P0nTQD
        7i5NWtFUL6zqhTVHgy/mwuZo3UqSP0ANkvqWNpNKn9m398vV9iqSTyL64NGnDL7J
        iVewgg9iRfSWw8bziG79pZ/2pNvIqd4maQZtUFP0sGZEPhnmnOdZDHQbSgoattXJ
        ipujRvSUFbfl4JKYbmKC/H2B7sxakfmzopt+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XcD7KKHlSWBK8fRibXXh4hDwMr2tn3/3
        U0sQdbPcNFv0RcdmObEfl7F+MgFacEL2Lh1peRwTLtq08pI+KkVMgd1u8jCquQL5
        XrwSnii7DHORz7rxO1vpFPzbSH4TWhFbx+SipDcpUXUElbvpIXRKW7suJNtJ2wQ8
        fhwbPuAcTq4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FA37B989E;
        Thu, 30 Apr 2020 13:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 68025B989D;
        Thu, 30 Apr 2020 13:31:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ash Holland <ash@sorrel.sh>
Cc:     git@vger.kernel.org, Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v2] userdiff: support Markdown
References: <20200421010035.13915-1-ash@sorrel.sh>
        <20200429230509.31017-1-ash@sorrel.sh>
Date:   Thu, 30 Apr 2020 10:31:29 -0700
In-Reply-To: <20200429230509.31017-1-ash@sorrel.sh> (Ash Holland's message of
        "Thu, 30 Apr 2020 00:05:07 +0100")
Message-ID: <xmqq4kt0ubgu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E47BB32-8B08-11EA-B05C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ash Holland <ash@sorrel.sh> writes:

> It's typical to find Markdown documentation alongside source code, and
> having better context for documentation changes is useful; see also
> commit 69f9c87d4 (userdiff: add support for Fountain documents,
> 2015-07-21).
>
> The pattern is based on the CommonMark specification 0.29, section 4.2:
> https://spec.commonmark.org/
>
> Only ATX headings are supported, as detecting setext headings would
> require printing the line before a pattern matches, or matching a
> multiline pattern. The word-diff pattern is the same as the pattern for
> HTML, because many Markdown parsers accept inline HTML.

> +PATTERNS("markdown",
> +	 "^ {0,3}#{1,6}( .*)?$",

This is "possibly just a bit indented run of up to 6 hashes, either
ending the line by itself or if some text follows, there must be a
SP after the hashes".

If I had a line that has a hash, HT and then "Hello, world", would
everybody's markdown implementation reject it as a header, because
the whitespace after the run of hashes is not a SP?

Also, allowing only the hashes might be spec-compliant, but how
useful would it be to see just a sequence of 4 hashes without any
text after "@@ -100,5, +100,6 @@" in the diff output?

Taking all that together, my suspicion is

	"^ {0,3}#{1,6}[ \t]"

i.e. "possibly slightly indented run of 6 hashes, with a whitespace
to catch the headers with real contents and nothing else" might be
more practically useful.  I dunno.

> +	 "[^<>= \t]+"),

This does match the one for HTML.

In any case, let me queue this v2 as-is and see what happens.

Thanks.


