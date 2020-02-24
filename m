Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB7C38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7692084E
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rmGEOlP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBXWHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:07:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50115 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXWHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 17:07:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97B9D52660;
        Mon, 24 Feb 2020 17:07:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qcbx6ghn8KAQcojp50+HJx5Wnz0=; b=rmGEOl
        P5uM0hb6U36Bk+CAh3f2zfqI9UQ7sbXcz9715I/+T/kN6nFKLsk2Oh/qX3zhw51V
        2Nrc83CleO65tuteuHOki9QHJXXblgovhvb7Rt3IlOSKkt9YwtHC3+s+uXtGUBNa
        djE0E9ZjcwquvNVGE286aBKXYf+o9dmVW2pQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LzL143h8+4NkSIIaF4wt1kth/zcZ7Bwx
        49DFzquRxxTugysWVHulIFs/HK5VGOv4Ta2J6TSGK6lXQ+4GgRayybU9zG2A/vDS
        m/28o0MI2nAB8pdAA8H4PrpA9XrsKlobnvlC1sGpCTVLELqpVeNfFIgOzT+UR24U
        D57hWTAjNd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E68D5265F;
        Mon, 24 Feb 2020 17:07:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA67F5265E;
        Mon, 24 Feb 2020 17:07:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v4 3/3] tag: use new advice API to check visibility
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
        <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <3cc0a17123dc2575deacb62f762a35fef5f2c185.1582557199.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 14:07:38 -0800
In-Reply-To: <3cc0a17123dc2575deacb62f762a35fef5f2c185.1582557199.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Mon, 24 Feb 2020 15:13:18
        +0000")
Message-ID: <xmqqblpnod05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12A1C9BA-5752-11EA-BA7A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> Following the new helpers added to the advice library,
> replace the global variable check approach by the new
> API calls
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  advice.c       | 2 --
>  advice.h       | 1 -
>  builtin/tag.c  | 5 +++--
>  t/t7004-tag.sh | 1 +
>  4 files changed, 4 insertions(+), 5 deletions(-)

Nice.
