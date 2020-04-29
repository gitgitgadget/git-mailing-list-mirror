Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4722C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96025208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTIYdL5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2Qqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:46:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51523 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2Qqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 12:46:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9DC4C8548;
        Wed, 29 Apr 2020 12:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9N6zAtkNeEOr
        L1YHZVOAevMA8kQ=; b=pTIYdL5Dj/ADLi1SnBVK90xLu5Hq8F+aRL97UgAIGSHH
        NpZ1I1btWj5T99se4EOgh4VxMin0xgBDvzOLNWUZVqouRWm270gDA4Y/p0nlsr2B
        E+oVvfk2leCV3HelfJYMIxNjbbQdVB2BEgSakQdcBaPMY9tuR5IkV0NRaWw+C4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nGjxMd
        xbPxriu8RkDN279avtfxRlyqguEDyLRL1QZESI6U1TL3xYHD9TwBRBanTYl7KnED
        yGxk4Zz1YiGu0FzHGVpVSA2pZ9Zq/wGI780ez6RmPMdPxFcbPJ2ZFprUiTD1fV+8
        lViYNCTsD8U+QCzOnwICHpKJYNN53cYFJmlm0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2137C8547;
        Wed, 29 Apr 2020 12:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17946C8546;
        Wed, 29 Apr 2020 12:46:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v5] credential-store: warn instead of fatal for bogus lines from store
References: <20200428104858.28573-1-carenas@gmail.com>
        <20200429003303.93583-1-carenas@gmail.com>
        <xmqqd07qzz67.fsf@gitster.c.googlers.com>
        <20200429073116.GA94208@Carlos-MBP>
Date:   Wed, 29 Apr 2020 09:46:38 -0700
In-Reply-To: <20200429073116.GA94208@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 29 Apr 2020 00:31:16 -0700")
Message-ID: <xmqqmu6uxms1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FFB5DACA-8A38-11EA-B34E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> IMHO if we are redacting both might as well not print anything and let
> the user find the offending credential by line number instead ;) after
> all I got a feeling most of those entries are empty lines or "comments"=
.

Very sensible.
