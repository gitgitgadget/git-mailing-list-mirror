Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695FFC83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjIBWTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjIBWTu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:19:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA12CE0
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:19:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A2B92B07D;
        Sat,  2 Sep 2023 18:19:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TxwLoGHmYURHOHb9SNfaSAv3zudvJAkj1mCqqM
        No+KE=; b=ulf8E6EETZ6gw9T0e374NKaltTlmIPHvmIp73jIhWcLviVXXIJ2qu6
        Fx348IBlKmEWSpW7uW0AoePARDyLwf0rlr6Pc2CCpq7jJsTTQYHAESIlIMSBMKLG
        9s/2TPc9wLU1kcBGy/jSULDPZDdFKDCE4qZ4nUh0pL7LLpocevKPs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32DEE2B07C;
        Sat,  2 Sep 2023 18:19:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D45B82B07B;
        Sat,  2 Sep 2023 18:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ref-filter: sort numerically when ":size" is used
In-Reply-To: <20230902090155.8978-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Sat, 2 Sep 2023 14:30:39 +0530")
References: <20230901142624.12063-1-five231003@gmail.com>
        <20230902090155.8978-1-five231003@gmail.com>
Date:   Sat, 02 Sep 2023 15:19:42 -0700
Message-ID: <xmqqy1hokykh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D158207A-49DE-11EE-BCB8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

>  			} else if (atom->u.raw_data.option == RAW_LENGTH) {
> -				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
> +				v->value = buf_size;
> +				v->s = xstrfmt("%"PRIuMAX, v->value);
>  			}
>  			continue;

Interesting that typeof(.value) happens to be uintmax_t, keeping
this a safe change.

