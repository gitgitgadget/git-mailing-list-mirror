Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E581EE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjHVQ7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHVQ7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 12:59:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903EFD7
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 09:59:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0D37194364;
        Tue, 22 Aug 2023 12:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xoc1Wl2ds/ljYrPEELOKIQBSGvqYUA+AFUc8Ir
        VyHyQ=; b=BboBSWr47hXCYuqXVQrYiR+q9fN7ZzhDdEztp+RQtBTSRHYGTwBpcC
        WsA8/sjCu69DC5w622Bhs++FMWb5QWilJIPUUMRqFSAZhWXVR0rE/OZozbemEjXV
        yhqlXj0CndKGdiHbM5S6SIiwVQOburZT7jcALG3tGS52DFmNx4BUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8FDD194363;
        Tue, 22 Aug 2023 12:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 294CA194362;
        Tue, 22 Aug 2023 12:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     git@vger.kernel.org
Subject: Re: FYI: git issues with libcurl 8.0/1 HTTPS push
References: <qq3252n1-o71-n1r7-281p-npqo6rs5o50@unkk.fr>
        <xmqq7cpnm48k.fsf@gitster.g>
        <4q22785-1qr2-824o-806r-26srs4r8p34@unkk.fr>
Date:   Tue, 22 Aug 2023 09:59:30 -0700
In-Reply-To: <4q22785-1qr2-824o-806r-26srs4r8p34@unkk.fr> (Daniel Stenberg's
        message of "Tue, 22 Aug 2023 18:42:55 +0200 (CEST)")
Message-ID: <xmqq1qfvm2rx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43236794-410D-11EE-B372-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Stenberg <daniel@haxx.se> writes:

> The downside with this approach is that you make it build-time. Since
> libcurl 8.2.x is binary compatible with the previous versions, users
> could easily upgrade to a newer libcurl without rebuilding git and
> then unnecessarily have the avoid-h2 code still used.
>
> The ideal approach would do the check in run-time to avoid that.

True.  I however suspect that the ship has already sailed for our
use of libcurl with how git-curl-compat.h uses LIBCURL_VERSION_NUM
for other things already.  A binary of Git built with older libcurl
versions would have compiled out certain features and would still
work with newer libcurl.

Thanks.
