Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E06C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAFD20757
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y+4Stoap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgLAWIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:08:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64125 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgLAWIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:08:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FD7911557E;
        Tue,  1 Dec 2020 17:07:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJrdU8sWJeFmcpMH+ydGHQMg4PU=; b=Y+4Sto
        apM8Yw+UiihEWpTd4EF64xaQ0ZC33yhpbrNvTzWns83Lmqxx6FmEe4DbjJvaFwYj
        WbLcsQFrPnWILx7QSEFLO4DMrYB5GwwLN1Tbp68SDx8JKii7eeutmfcUfuL+TCVx
        e/cikN22zpULlErPM/OnZ0+VQHykbcC72bK8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AMRqo3GyIXYwm8lzeUNiOacD0eZpNCzo
        jXxf8AylAiGbTeBE/fTlFgCE5miv6U38Hg5xqKq8kW0/Q1/gZVpbk0Q6Qu+RIRHc
        5N8g77aGnPEdlz8ZTJRjIF+dEISJWGrsKaLHmZxUju2ims50ds2DTG4kQDoJM+Bh
        Ce9ONVKFM+w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9885911557D;
        Tue,  1 Dec 2020 17:07:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD88A11557C;
        Tue,  1 Dec 2020 17:07:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] banned.h: mark ctime_r() and asctime_r() as banned.
References: <X8aMt2LEiCLkdV9/@nand.local>
        <20201201211138.33850-1-gitster@pobox.com>
        <20201201211138.33850-2-gitster@pobox.com>
        <CAPig+cROG5+khWvBWbWgVhNuDyWkCQYBXwte5VeazuCCXMAA_g@mail.gmail.com>
Date:   Tue, 01 Dec 2020 14:07:55 -0800
In-Reply-To: <CAPig+cROG5+khWvBWbWgVhNuDyWkCQYBXwte5VeazuCCXMAA_g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 1 Dec 2020 16:16:11 -0500")
Message-ID: <xmqqzh2xmb7o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAC5548A-3421-11EB-AF11-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Dec 1, 2020 at 4:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>> The ctime_r() and asctime_r() functions are reentrant, but have
>> no check that the buffer we pass in is long enough (the manpage says it
>> "should have room for at least 26 bytes"). Since this is such an
>> easy-to-get-wrong interface, and since we have the much safer stftime()
>> as well as its more conveinent strbuf_addftime() wrapper, let's ban both
>> of those.
>
> This still needs a s/conveinent/convenient/ mentioned earlier[1].

AH, thanks, fixed.
