Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EDFC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7878C206CC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+Kh7W6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgEMFFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 01:05:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55225 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMFFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 01:05:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 428BAD6A97;
        Wed, 13 May 2020 01:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SGNlW4mCAyNEPtKpXoWIuAD14oc=; b=E+Kh7W
        6/AopW94b/qTgxjZw0Pg20Lgtld/I9ULKV94s+3pfuk3datqT27WROY7BS1vbkVh
        CVl199yt5qo6uaT/b3p0/jIXqovcpzssg3d/EjPjtMLDu6oR5MfHtDeHkB5E4qUc
        p8QBkNDMsnZM1sXH5z3IcX1fva+Ben1f5G9Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZcZX6ywadtn9DocFldZeHyl2m6tYekAL
        fmu11PZ9Jy77lr9fN1p1pWD2jmsyMhqDplRH9SDtV6dGpo56d6dfMAWKYRT7088a
        Px4Uh0b/qh7oIVefha0eJcTzaN73PIv+BgPuXK+mPHYnYl7k/1kXIRgQzZFBZDXl
        /SpcIgGMRGU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B473D6A96;
        Wed, 13 May 2020 01:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61881D6A95;
        Wed, 13 May 2020 01:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
References: <cover.1589218693.git.jonathantanmy@google.com>
        <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
        <20200512231331.GA6605@camp.crustytoothpaste.net>
        <xmqqwo5gwv7z.fsf@gitster.c.googlers.com>
        <20200513045001.GA65110@coredump.intra.peff.net>
Date:   Tue, 12 May 2020 22:05:23 -0700
In-Reply-To: <20200513045001.GA65110@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 13 May 2020 00:50:01 -0400")
Message-ID: <xmqqk11gwhkc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B050BAA-94D7-11EA-9392-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Hmm, that is a valid concern.  Introducing yet another environment
>> feels a bit yucky, but something like GIT_NO_REDACT that disables
>> any redacting, not limited to curl but in all codepaths, might turn
>> out to be a useful escape hatch.
>> 
>> Opinions?
>
> Having an environment variable was my first thought, as well. I do
> think it's key that the default be to redact. That makes life slightly
> harder for people debugging auth problems, but prevents people from
> accidentally leaking private info.
>
> Regarding the name:
>
>   - should it be under GIT_TRACE_CURL_* to make its impact clear? Or do
>     we imagine it might eventually be applied elsewhere?
>
>   - doing GIT_TRACE_REDACT would get rid of the negative (and it could
>     just default to "true")

I like the latter, and I do expect it to allow the person who debugs
to temporarily disable *any* codepath that redacts its output.

Thanks.
