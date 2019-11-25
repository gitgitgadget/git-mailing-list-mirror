Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0BCC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCBB20722
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jlK/+cLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYGg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:36:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYGg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 01:36:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 001132D187;
        Mon, 25 Nov 2019 01:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PegtxSqCdv5K5QRXrkteN+z/xf8=; b=jlK/+c
        LBeA2ftXfO0Hd8IikAIJx+68bVIhr+K7Um8CTkdOmZBBtQazHYC5ofJbfGEAocuQ
        nFMu9/soPbDoYEjYRrtW/zB7lM9CE4BdhIv3oXNn8EKtGbCpFfXaPPLhAbdDbF4o
        9qx8w4I9jQSLTeUGdRZHI1rGcYLgZGX8qzdRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UcPsufw9fimOKx1UAN7i9Fe7Yw/RE3Jy
        MxFp878YX6huKhyqbp8lCSYHKKEg9g8ErEvK5+JmTaJVnFtN3mlO0yQBp9X/P/ge
        p4gsbDtwUI0TlVF8OfC/RXd1D5R+0z+s7vDiB8M6nHMScvWKZngQUZYsoXu4LKij
        j/lW9Xylap8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB8D82D186;
        Mon, 25 Nov 2019 01:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60CF32D185;
        Mon, 25 Nov 2019 01:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
        <20191115180319.113991-1-jonathantanmy@google.com>
        <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 25 Nov 2019 15:36:25 +0900
In-Reply-To: <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 25 Nov 2019 15:30:07 +0900")
Message-ID: <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7CDA908-0F4D-11EA-A5FA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>> It could be a good idea if Peff could answer some of the comments made
>>> by Jonathan Tan about patch 9/9.
>>> 
>>> I have put Peff as the author of all the commits.
>>
>> Thanks. I think the series looks mostly good except for the questions I
>> raised in patch 9/9, so I'll wait for Peff to respond too.
>
> Hmph, the round before this one has been in 'next' for quite a
> while, so should I eject it before waiting for Peff to respond
> before queuing this one?

After rebasing these v3 patches on top of the base of the one in
'next', the only difference seems to be the log message of 3/9 and
the contents of 9/9.  I guess I'll mark the topic as "on hold" for
now before doing anything, as I am officially taking a time-off most
of this week ;-)

Thanks.
