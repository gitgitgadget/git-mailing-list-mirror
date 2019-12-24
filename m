Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F3C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE2F2063A
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z81h05FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXTDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:03:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56298 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXTDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:03:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81BBD3269A;
        Tue, 24 Dec 2019 14:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H6qk6w/1o+hmGMvsJN11sEQpP2c=; b=Z81h05
        FP7Wn5tKMk2gJJ4WLi+Luczaa9K1mMbPPIoLUb/d4dIK/kAe8X2lNeNwkxko7kdv
        CgY0zZClOju+NMUwsLAOtVAEkH7F0xS380aNni1p0GENb44wR5AY2+2NdyL/BL80
        xSEN/jyaJI3q+PP2qN8x6SmQSLSfxIO1WVcc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XWV5nwQqnq1bO86OIzxJ+hZI3G3l3a3B
        cDuHf73irs2NSDpdBZ0tv+xo0Q0W6sFeLgZUGxlpU1331D7YLKJ44aLrA4cTBS1T
        ZIxA1/qRxYIUiZAcz2EHpi0NK8pu5pOalZlrOUFJipboi4NDUaQJUDYUt3F9oCfR
        C1fKjWJk/HY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77A5632699;
        Tue, 24 Dec 2019 14:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE3C632698;
        Tue, 24 Dec 2019 14:02:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gpg-interface: add minTrustLevel as a configuration option
References: <20191219000140.9056-1-hji@dyntopia.com>
        <20191222003123.10555-1-hji@dyntopia.com>
        <20191222003123.10555-2-hji@dyntopia.com>
Date:   Tue, 24 Dec 2019 11:02:53 -0800
In-Reply-To: <20191222003123.10555-2-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sun, 22 Dec 2019 00:31:23 +0000")
Message-ID: <xmqqblrx5yxu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDD0C660-267F-11EA-B065-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> +				/* Do we have trust level? */
> +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_TRUST_LEVEL) {
> +					/*
> +					 * GPG v1 and v2 differs in how the
> +					 * TRUST_ lines are written.  Some
> +					 * trust lines contain no additional
> +					 * space-separated information for v1.
> +					 */
> +					next = strchr(line, ' ');
> +					if (!next)
> +						next = strchrnul(line, '\n');
> +					trust = xmemdupz(line, next - line);

I wonder if telling strcspn() to stop at either SP or LF is more in
line with the existing codebase [*1*] and/or more readable.  It
would make this part to:

		size_t trust_size = strcspn(line, " \n");
		trust = xmemdupz(line, trust_size);

without the need to use or update the 'next' variable, if I am not
mistaken?

By the way, while we are looking at this patch, I notice that,
throughout the function, the use of variable 'next' feels rather
misleading, at least to me.

When I see a loop that iterates over a block of lines, and a
variable 'line' is used to point at the beginning of the current
line at the beginning of each iteration and the code in the
iteration updates a pointer 'next', I'd expect 'next' (or perhaps
'next+1') to become the new value of 'line' when the current round
of the iteration ends (i.e. the name 'next' would stand for 'here is
where we expect the next line to start').  But the code we see in
this function uses it for 'here is the end of the current _token_ on
the line', primarily so that it can do something to the byte range
(line,<end-of-token>) and it never gets used as 'now we are done
with the line, let's move on to the next line'.

This matters because it makes it unclear to decide if the above two
lines I gave as a counter-proposal is sufficient, or if it also
needs to say "next = line + trust_size" to keep 'next' up-to-date.
The name of the varirable implies it should be, but the way the
code uses 'next' says it is a throw-away variable whose value does
not matter once we have done with the end of the current token.

I wonder if the code becomes less misleading if we either (1)
renamed 'next' to a name that hints more strongly that it is not the
'next' line but the end of the current token we are interested in,
or (2) get rid of the pointer and instead counted size of the
current token we are interested in, or perhaps both?  

This is not the fault of this patch, but I just mention it before I
forget.

Thanks.
