Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04336C2D0F4
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 03:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C024020678
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 03:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uKCtYxwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDFDaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:30:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58048 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFDaE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 23:30:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68717BA42E;
        Sun,  5 Apr 2020 23:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V9LXZMVqe467xlIi4aNSmbYel9M=; b=uKCtYx
        wkZ66UBjv9twdpj3kjeYHxLylJVAkLX2dxOWL6TTAQort3Df+/+Ch9VGf31xjaji
        71KagC5gCH/5LyVPL1rQeS5qyD1Q7W4OEfYUE3Cf9shRKIC+5SMA1j8sz9LJn6ub
        YbZJ2zxUp1Urrhjl3HyR/zkVpVwa2RGymTJj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t86+xoPEc9XAnUXGmXt1AhRyO88MqlTs
        vs6MRfnx6yJs11DZMCzguuYqd079i8RcnaDRBM8QrYgsRxEcyAabK6UBsQr9DxCu
        +in69YmwAI4W8jkpjzpVorK45LiXhmRuW4f836BBc/mPZXam/S5EAVaqyw5XjcEd
        px50s0iXc/w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51AD3BA42D;
        Sun,  5 Apr 2020 23:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60426BA429;
        Sun,  5 Apr 2020 23:29:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
References: <20200405231109.8249-1-me@pluvano.com>
Date:   Sun, 05 Apr 2020 20:29:57 -0700
In-Reply-To: <20200405231109.8249-1-me@pluvano.com> (Emma Brooks's message of
        "Sun, 5 Apr 2020 23:11:09 +0000")
Message-ID: <xmqqd08lwatm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4C53862-77B6-11EA-A531-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> writes:

> When commit subjects or authors have non-ASCII characters, git
> format-patch Q-encodes them so they can be safely sent over email.
> However, if the patch transfer method is something other than email (web
> review tools, sneakernet), this only serves to make the patch metadata
> harder to read without first applying it (unless you can decode RFC 2047
> in your head). git am as well as some email software supports
> non-Q-encoded mail as described in RFC 6531.
>
> Add --[no-]encode-headers and format.encodeHeaders to let the user
> control this behavior.

This would be immensely useful.  I often find the in-body headers
that are Q-encoded too ugly to live.

Is the RFC2047 the only thing we do to message headers?  What I am
trying is to figure out if "encode-headers - yes/no?" would be a
stable (iow, would we be gaining other kinds of encoding over time?)
and well-defined (iow, is there a case where one kind of 'encoding'
is still desirable while disabling other kinds of 'encoding' is
wanted?) question.  If there is any doubt in your answers to the
above question, we may have to make sure the name of the option
makes it clear to users what kind of encoding we're talking about.

> +format.encodeHeaders::
> +	Encode email headers that have non-ASCII characters with
> +	"Q-encoding" for email transmission. Defaults to true.

OK.

>  
> +--[no-]encode-headers::

I think we'd want to standadize on writing these out, i.e.

        --encode-headers::
        --no-encode-headers::

so let's follow that when adding a new option.

> +	Encode email headers that have non-ASCII characters with
> +	"Q-encoding", instead of outputting the headers verbatim. The

I wonder if calling RFC2047 out helps readers here, when they wonder
what Q is and how they can decipher it.

> +	default is `--encode-headers` unless the `format.encodeHeaders`
> +	configuration variable is set.

I am wondering if we can go even shorter, e.g.

	The default is set to the value of `format.encodeHeaders`
	configuration variable.

> -		if (needs_rfc2047_encoding(namebuf, namelen)) {
> +		if (pp->encode_headers &&
> +				needs_rfc2047_encoding(namebuf, namelen)) {

Don't overly indent the second line like this.  The same comment
applies to the next hunk (not quoted).

Thanks.
