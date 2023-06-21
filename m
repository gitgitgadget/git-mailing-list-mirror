Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68CEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 16:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFUQpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFUQoo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 12:44:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56639D
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 09:44:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DDB127820;
        Wed, 21 Jun 2023 12:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GYu3Hot3hn0UkJCf2KxTbhhTeYu1+okYWr/24u
        oDOGo=; b=r/FGBwVhOpyueWsfXKICLE2kCYmMrswOPjbdPRh0baphHe1Y9OW0Si
        8kll1SIaI4a+kXwBTJw2Vefkm2znlFU4zLmrPxxEnayoC1RI6jy34lwuW/c5lbLd
        n/Q62p0ZlV5GdXrjYOrXl0F5FFGkAY01OJ8idBQN1rxp0CkawquKA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44ECF2781F;
        Wed, 21 Jun 2023 12:44:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 610732781E;
        Wed, 21 Jun 2023 12:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] repack: implement `--filter-to` for storing
 filtered out objects
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-9-christian.couder@gmail.com>
        <ZJLjvhnh0lSRCVzG@nand.local>
        <CAP8UFD388DOTqueok7fRF+=-+s_PNria1oB18AEed3gjdRrqJA@mail.gmail.com>
        <ZJLsMK73ae8Htec4@nand.local>
Date:   Wed, 21 Jun 2023 09:44:39 -0700
In-Reply-To: <ZJLsMK73ae8Htec4@nand.local> (Taylor Blau's message of "Wed, 21
        Jun 2023 08:25:20 -0400")
Message-ID: <xmqqedm4ix3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA96730E-1052-11EE-A1CC-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In other words, I would be fine with something like:
>
> --- 8< ---
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 0541c3ce15..1890f283ee 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -866,6 +866,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>  		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");
>
> +	/* --expire-to implies cruft */
> +	if (expire_to)
> +		pack_everything |= PACK_CRUFT;
> +
>  	if (pack_everything & PACK_CRUFT) {
>  		pack_everything |= ALL_INTO_ONE;
>
> --- >8 ---
>
> But that sounds like a good candidate for some #leftoverbits.

It does.  Thanks.

