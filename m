Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4319EC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8D5205CB
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MybWQtR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETOke (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:40:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53152 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETOkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:40:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9785B5D588;
        Wed, 20 May 2020 10:40:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tz4AASZ55tz9
        N+sEN6VwnjaWDN4=; b=MybWQtR2qMY0AUh3K+fJgUtSXlAObgIQnak9tIFk2vsf
        6YSO72Km2ARTil8HLGO+xJLhBLX8rJshSM9yRtiVvJGgVr0dAUmUPdW+Ih7id4bx
        9gkYpNLnEcfaRPCqQ8uGn3bnH3ETcD5t6PGKlRleyXn2tq51464gUKBguNR/STk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=p6qJ1k
        d6M/+rF8RLBK9j6UOQXa0dyUjviOy3sv/JJni73fdS0DdsnK+7cGaVGT9Ba01bZ9
        Kr+qRWIwsBt8SBAMzRFgBjHqc2rQIPRjtL47nQ3ZMV+wPBTt67ZfMpnswKPt+ACL
        6Z/YjsaDMLXAZgFzbHXR+A+0273+asw+i5H1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D08A5D587;
        Wed, 20 May 2020 10:40:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03C995D586;
        Wed, 20 May 2020 10:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v13 06/13] reftable: define version 2 of the spec to accomodate SHA256
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <1e3c8f2d3e8c6c6db8460f29115d2fe898f85012.1589226388.git.gitgitgadget@gmail.com>
        <xmqq5zcrzhc7.fsf@gitster.c.googlers.com>
        <CAFQ2z_PqiziTt-M+hCP4XOwgRMr2m4WEBTjwi6EPkyK6MbBoYg@mail.gmail.com>
Date:   Wed, 20 May 2020 07:40:30 -0700
In-Reply-To: <CAFQ2z_PqiziTt-M+hCP4XOwgRMr2m4WEBTjwi6EPkyK6MbBoYg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 20 May 2020 14:38:24 +0200")
Message-ID: <xmqq4ksay8ip.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DADCB74E-9AA7-11EA-9538-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> This version also adds more
>>
>>
>>         =E2=80=99
>
> curious. I have no idea where they came from. Fixed now.

The version 1 format in 04/13 has the same; it may already be in the
original document, or the conversion process via pandoc transformed
a plain single quote intelligently?

