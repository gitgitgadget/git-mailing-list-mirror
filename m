Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50D9207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 19:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935947AbcIPTUL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 15:20:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65247 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935255AbcIPTTS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 15:19:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A68483F4E8;
        Fri, 16 Sep 2016 15:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2EKNIgDBXZkcDDobJHe924+ru7M=; b=bm5Cpq
        sYQQszAVPoOlTygZjGREEj+cV8ak2lr0aaQK4t3ddUEDQwEOL9aKsCmm9cNUUzX0
        AabT6RIh+jr1KH4FlgpVVY2gWkM2rph5Y4l5sPCeduUkbXTKWhp9AUVLrAklrK0i
        dRYiTWMUmVN3gHyLqIMXucIkHChNz1CpT/HMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PAnbSEhONdAkCik3/XtO1VyxguaTcyyd
        RmzLzGqJTjPD+uHhe7gxAxEU854Q9u3pgOYTuLVFlhupcQrSEna2vDDi76ftL4Zv
        GVkQhgfhHWIEdLA3B5VO8P+K7RYzrdb/2K8WJDRl2WiolDR+9A7cV4ExVFbBlfs2
        vBV8PS+ex00=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DEE73F4E7;
        Fri, 16 Sep 2016 15:19:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26F493F4E6;
        Fri, 16 Sep 2016 15:19:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 2/3] mailinfo: correct malformed test example
References: <cover.1474047135.git.jonathantanmy@google.com>
        <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
        <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
Date:   Fri, 16 Sep 2016 12:19:14 -0700
In-Reply-To: <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 16 Sep 2016 10:37:23 -0700")
Message-ID: <xmqqk2ebk5zh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 757610F8-7C42-11E6-BBCA-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> An existing sample message (0015) in the tests for mailinfo contains an
> indented line immediately after an in-body header (without any
> intervening blank line).

This comes from d25e5159 ("git am/mailinfo: Don't look at in-body
headers when rebasing", 2009-11-20), where we want to make sure that
a "From: bogosity" that isn't meant to be an in-body header is not
identified as such, even when it is immediately followed by a
non-blank line.  "From: bogosity" is for msg0015 but the same
applies to the header-looking block for msg0008.

Adding a blank line there will defeat the whole point of the test,
which is to make sure we don't do anything funky when --no-inbody-headers
is asked for, no?

> diff --git a/t/t5100/info0008--no-inbody-headers b/t/t5100/info0008--no-inbody-headers
> new file mode 100644
> index 0000000..e8a2951
> --- /dev/null
> +++ b/t/t5100/info0008--no-inbody-headers
> @@ -0,0 +1,5 @@
> +Author: Junio C Hamano
> +Email: junio@kernel.org
> +Subject: another patch
> +Date: Fri, 9 Jun 2006 00:44:16 -0700
> +
> diff --git a/t/t5100/msg0008--no-inbody-headers b/t/t5100/msg0008--no-inbody-headers
> new file mode 100644
> index 0000000..d6e950e
> --- /dev/null
> +++ b/t/t5100/msg0008--no-inbody-headers
> @@ -0,0 +1,6 @@
> +From: A U Thor <a.u.thor@example.com>
> +Subject: [PATCH] another patch
> +>Here is an empty patch from A U Thor.
> +
> +Hey you forgot the patch!
> +
> diff --git a/t/t5100/msg0015--no-inbody-headers b/t/t5100/msg0015--no-inbody-headers
> index be5115b..44a6ce7 100644
> --- a/t/t5100/msg0015--no-inbody-headers
> +++ b/t/t5100/msg0015--no-inbody-headers
> @@ -1,3 +1,4 @@
>  From: bogosity
> +
>    - a list
>    - of stuff
> diff --git a/t/t5100/patch0008--no-inbody-headers b/t/t5100/patch0008--no-inbody-headers
> new file mode 100644
> index 0000000..e69de29
> diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
> index 8b2ae06..ba8b208 100644
> --- a/t/t5100/sample.mbox
> +++ b/t/t5100/sample.mbox
> @@ -656,6 +656,7 @@ Subject: check bogus body header (from)
>  Date: Fri, 9 Jun 2006 00:44:16 -0700
>  
>  From: bogosity
> +
>    - a list
>    - of stuff
>  ---
