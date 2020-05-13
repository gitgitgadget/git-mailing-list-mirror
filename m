Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1C2C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707DA206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CnPbQhPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbgEMTdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:33:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60914 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389808AbgEMTdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 15:33:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0BCF5479A;
        Wed, 13 May 2020 15:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cwXHC7iKN6D1z+wdcGDm5PNDvDg=; b=CnPbQh
        PgadwsZfZmyxYEeyY6xVJArTYkOcUAZ/tkaH6EirUITwJEPjja0oy5RrLWAdFiFc
        unD43I5dfqnys0+D65JNx3JKjHixH+eFAKfdeVIIpetfQ7a5cSQ/snWsbY3cVyBp
        plqG5pf5GN1LUXjwfRKKVziBGG9RZL21/qetM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WJZFdqFVR0C/uIEKECgJLe4gkKaJbawo
        w/YxGGE5taqa+Ed426w30gfqfBFEX/umOczqxZpkGJY8kgq48JQLtPiD9Lm/WcSJ
        tSw4wjLxgutpV78y4wPjaTnaxcFlvMjkW6hyYGcCcBwKw5SCOolzXgda190or7Av
        BOiwVfZOO0U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A72B454799;
        Wed, 13 May 2020 15:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0600A54798;
        Wed, 13 May 2020 15:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net
Subject: Re: [PATCH v2 0/3] Safer GIT_CURL_VERBOSE
References: <cover.1589218693.git.jonathantanmy@google.com>
        <cover.1589394456.git.jonathantanmy@google.com>
        <xmqqwo5ftz37.fsf@gitster.c.googlers.com>
Date:   Wed, 13 May 2020 12:33:37 -0700
In-Reply-To: <xmqqwo5ftz37.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 13 May 2020 12:27:24 -0700")
Message-ID: <xmqqlflvtysu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A53DFDC0-9550-11EA-A490-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Thanks everyone. I went ahead with GIT_REDACT_AUTHORIZATION to match
>> GIT_REDACT_COOKIES, with the default being true (i.e. you need to set it
>> to "0" to have behavior change).
>
> Hmm, I would actually have expected us to move in the direction of
> deprecating specific REDACT_BLAH and consolidate them into one,
> instead of adding another one.  Especially as the primary reason why
> we redact cookies is to protect those that are used for auth anyway.

Also I had forgot to grep for anonymi.e to find transport_anonymize_url(),
which I was hoping that the new environment variable would cover to help
those who debug.

Thanks.
