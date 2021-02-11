Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEDDC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C69864E25
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhBKH42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:56:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51823 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhBKHy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:54:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84021119B80;
        Thu, 11 Feb 2021 02:54:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4uswDVBFjWpjHwuZuLVy85PA61w=; b=p8F4PM
        oc7Jw3fP8xLwUATJEH1qwtH6Jh9jXH6geVhQEhMrlmgNDU47Cih7Sq78hfRNcCIC
        SCaTxmP70DxFE7VJNq+0u4SZt1M1GIQoq5d3k87PYltRDQjsH5z6JqODuiJeHa2o
        XR6uCoQRqgqZqS9m25IdDGfoWziaVUSbdS2Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b5ehFyL9Vjb5aSjpufyTViMQnsZj1Al8
        ZSqMXGmQZgz9jA575EumotbILgTc/KESju5SM13J0PiznkRXZg+wZgnFL4R20Iue
        jBy1RsQmORxz6RQHIkmm/Mg3u3T74qBPj8b72YB5IqU6Gsj+xBP7Y4ZGnUmkT5Q9
        T7YGkvRUEGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C420119B7F;
        Thu, 11 Feb 2021 02:54:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE840119B7E;
        Thu, 11 Feb 2021 02:54:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 7/9] pack-revindex: read multi-pack reverse indexes
References: <cover.1612998106.git.me@ttaylorr.com>
        <4c5e64c5fcb2948a0598d6e0c70097a9561716a9.1612998106.git.me@ttaylorr.com>
Date:   Wed, 10 Feb 2021 23:54:23 -0800
In-Reply-To: <4c5e64c5fcb2948a0598d6e0c70097a9561716a9.1612998106.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 10 Feb 2021 18:03:20 -0500")
Message-ID: <xmqqpn17xcnk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BC93112-6C3E-11EB-BC80-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/pack-revindex.c b/pack-revindex.c
> index 83fe4de773..da4101f4b2 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -3,6 +3,7 @@
>  #include "object-store.h"
>  #include "packfile.h"
>  #include "config.h"
> +#include "midx.h"

This seems to assume that the topic tb/pack-revindex-on-disk is
already there?

Just trying to establish what dependencies the bunch of topics have
among themselves.

Thanks.
