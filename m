Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36325C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiG2Rv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiG2RvY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:51:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1188E10
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:51:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 529C51A4AA5;
        Fri, 29 Jul 2022 13:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/i3uJUXuEvJ82oaxtfDNKh8/EaobX2M3g9C4oo
        Kwx9E=; b=jz5XFHRy5MT/X15gNVItIfMh623t8LLifbjoD1v1OlaRn8+omsqWE/
        vOoF2e6YyqWC9Y7FIQ4cDoQbCC+qfQc2ino1e7NbD6aunnHGpMpDccCDaUkQ+Onb
        9uF4fcO6WHfgqv8MUs78602Wke/JydPUXcTTY39ucnMn31EvF1TPY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4AB011A4AA3;
        Fri, 29 Jul 2022 13:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3CF01A4AA2;
        Fri, 29 Jul 2022 13:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 3/6] protocol-caps: initialization bug fix
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-4-calvinwan@google.com>
Date:   Fri, 29 Jul 2022 10:51:17 -0700
In-Reply-To: <20220728230210.2952731-4-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 23:02:07 +0000")
Message-ID: <xmqqo7x77qp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CD2061A-0F67-11ED-AC82-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Initialize info. If info.size bit was on due to on-stack garbage,
> we would have given our response with "size" attribute prefixed,
> even when the client side never requested it.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  protocol-caps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

OK, this is new in this round and it makes sense.

> diff --git a/protocol-caps.c b/protocol-caps.c
> index bbde91810a..2ad9f45c59 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -77,7 +77,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  
>  int cap_object_info(struct repository *r, struct packet_reader *request)
>  {
> -	struct requested_info info;
> +	struct requested_info info = { 0 };
>  	struct packet_writer writer;
>  	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
