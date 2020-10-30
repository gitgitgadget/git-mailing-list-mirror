Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059EC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F0820A8B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 23:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/NcgMyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJ3Xpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 19:45:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56701 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3Xpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 19:45:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19B4C1061DF;
        Fri, 30 Oct 2020 19:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0ro3H/4088VBEXo5DxG4/MjT/I=; b=R/NcgM
        yL1Z6EmltHUCDMKRnf6QdIkSXz/4DG3cMctzfYoIuRVR4GSXQtfFiUvKzUb1OfSb
        jcKS0OqaL1VOCnHbQKlbySBKeMBaNgKiNnnVGQGB55W106LjvOu1Y4/R2eEQwi61
        nLyvzfCtQWadR2pAJbYYTYoSpz5otM02unbL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1a7LN58CTT5gC/cZN45gpQ4TVT75+x3
        hbBAhjIh8+7v8Z6k2ei/nwBn9gMZkKll3B1foKGl7XL8BhKQAYMxlf0tvN5zmqTg
        PfV9oWBM1tOZEugsWK8hC7pBpTRQR0jz2CYXRyKrPPM36CASc/1e23yMZHhDWwSO
        IO6k2oeFb68=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 105B81061DE;
        Fri, 30 Oct 2020 19:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 592541061DA;
        Fri, 30 Oct 2020 19:45:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Duvall <dan@mutual.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] upload-pack: allow stateless client EOF just prior
 to haves
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
        <20201030223504.45978-1-dan@mutual.io>
Date:   Fri, 30 Oct 2020 16:45:40 -0700
In-Reply-To: <20201030223504.45978-1-dan@mutual.io> (Daniel Duvall's message
        of "Fri, 30 Oct 2020 15:35:04 -0700")
Message-ID: <xmqqzh4346sb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05AD5FC2-1B0A-11EB-A286-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  t/t5705-upload-pack-stateless-shallow-eof.sh | 24 ++++++++++++++++++++
>  upload-pack.c                                | 13 ++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5705-upload-pack-stateless-shallow-eof.sh

Yuck.  Adding a new test file, only to hold a single test?

I'd rather see it folded in an existing test, if it makes sense.

Of course if we do not have any test for upload-pack, that's a
different story, but I suspect we already do test the command in
existing scripts.

> diff --git a/upload-pack.c b/upload-pack.c
> index 3b858eb457..5dc8e1f844 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1344,7 +1344,18 @@ void upload_pack(struct upload_pack_options *options)
>  				   PACKET_READ_DIE_ON_ERR_PACKET);
>  
>  		receive_needs(&data, &reader);
> -		if (data.want_obj.nr) {
> +
> +		/*
> +		 * An EOF at this exact point in negotiation should be
> +		 * acceptable from stateless clients as they will consume the
> +		 * shallow list before doing subsequent rpc with haves/etc.
> +		 */
> +		if (data.stateless_rpc)
> +			reader.options |= PACKET_READ_GENTLE_ON_EOF;
> +
> +		if (data.want_obj.nr &&
> +		    packet_reader_peek(&reader) != PACKET_READ_EOF) {
> +			reader.options &= ~PACKET_READ_GENTLE_ON_EOF;
>  			get_common_commits(&data, &reader);
>  			create_pack_file(&data, NULL);
>  		}

Thanks.
