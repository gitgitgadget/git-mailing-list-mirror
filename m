Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E3C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E056B206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fddDw0K5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390683AbgEMT12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:27:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64787 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390681AbgEMT12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 15:27:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 214DA54721;
        Wed, 13 May 2020 15:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eXBHYdezOy23Zf7wjwy/7T/qaLY=; b=fddDw0
        K5e9PG1DgeHFf3FzewsCiyHyGFNJknEz8bNADkkDDJ/4vUtb5TaqUn7u1lj2NBzT
        MH2Ek7mJ707hZYn9aFn7rk2IOQsbCTyPtrW2NIGGX4erYqlPz+aNxkWNOOF4GGvA
        nUAC4+bZdvEdpnE9tl1sAkCu6wM4FYNllHurQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yZXbPW+dT83l/t7dQfI4qDm2fRvSTr5o
        WZ8AbYR0Nr7TQJYx8mk1V8SodQ74gg1qbxjNnrvosu0nfXynEWSpIIF3D7OUZH+S
        EybGzdz0mOx4S9IEt+UFjSQKEryHins/SY9SJOREvF/nqo5wuY+ZyfSHj6P6a0qu
        iJNv4DRcDcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18AE95471E;
        Wed, 13 May 2020 15:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ABDD5471D;
        Wed, 13 May 2020 15:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net
Subject: Re: [PATCH v2 0/3] Safer GIT_CURL_VERBOSE
References: <cover.1589218693.git.jonathantanmy@google.com>
        <cover.1589394456.git.jonathantanmy@google.com>
Date:   Wed, 13 May 2020 12:27:24 -0700
In-Reply-To: <cover.1589394456.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 13 May 2020 12:12:45 -0700")
Message-ID: <xmqqwo5ftz37.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6A498E4-954F-11EA-86BB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks everyone. I went ahead with GIT_REDACT_AUTHORIZATION to match
> GIT_REDACT_COOKIES, with the default being true (i.e. you need to set it
> to "0" to have behavior change).

Hmm, I would actually have expected us to move in the direction of
deprecating specific REDACT_BLAH and consolidate them into one,
instead of adding another one.  Especially as the primary reason why
we redact cookies is to protect those that are used for auth anyway.
