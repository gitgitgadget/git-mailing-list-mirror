Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F3C433E6
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42292399C
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 17:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbhAORYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 12:24:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64139 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbhAORYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 12:24:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C93B117245;
        Fri, 15 Jan 2021 12:23:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vpK1AzfB2Sh5afqMGGB9XKRpe2Q=; b=ndQFtS
        +5k8MPw+KRWLcNcVB4I2AHkE+AEOcqDq62hsNzSWLndTF7e5cQK3J53F6MUqteNX
        TBOh3wxdy/xNQjOdk+rYmXQWAPMomBNaNJ9AGfaTW14mHdlOzqWyBUPaNSVcO1De
        xoSih9I1JnBqzaIEmpNJDuyCeJOPYz+NdtdQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AkLXZ9hDFZfYxH/K7X09GdSRpsApfc+F
        967U6ocv33yJnLxeuOTJdewsW1gkkKUUJCWTAnecHMj43XvlbKC/s1FKc7uz7S85
        XCnvu6eqB3U3OMGbqfT7oovbsvTsyb2jIBcTJuoeYtg125P40H1Yh6bzzprQQg9d
        jXZJlwTlHlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42EA1117244;
        Fri, 15 Jan 2021 12:23:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B8C7117243;
        Fri, 15 Jan 2021 12:23:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: How to implement the "amend!" commit ?
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
        <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
        <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
        <xmqq7dofxnru.fsf@gitster.c.googlers.com>
        <81d3784c-fa64-a18d-9cc8-6ff50bbdd6ac@gmail.com>
Date:   Fri, 15 Jan 2021 09:23:21 -0800
In-Reply-To: <81d3784c-fa64-a18d-9cc8-6ff50bbdd6ac@gmail.com> (Phillip Wood's
        message of "Fri, 15 Jan 2021 10:29:26 +0000")
Message-ID: <xmqq7doet8qe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EE64F76-5756-11EB-BD41-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> "--fixup=:/<text>" will work as it does now and
> "--fixup=amend::/<text>" will create an amend! commit.

OK.  That sounds good.

Thanks.
