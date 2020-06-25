Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F2EC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 16:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1CF2089D
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 16:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcBiuhcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403774AbgFYQWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:22:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62769 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgFYQWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 12:22:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E7BFE10D4;
        Thu, 25 Jun 2020 12:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mAukAgd1L3uW
        3D/HzAzMm9Jckbc=; b=mcBiuhcbnbmxlRGN1kMBW6UmM5OAbLFAfTfyXsZaiP0i
        LysyKK47oA3z4ZvLfp4cHHD6wWqnb3MldyKDNUUP0Hr5k3tvN1Z07zO3jJTdHbop
        8xOA2TgSMxjhY64Di4Hnlmj9cAQ2+dsZECT6jESlUTTothvkxKA1HlvIfABDQzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dsJKE6
        gfu0ln3o99IACuq2OKXSiLsS+qhwVu0UItYZ0MmbFrOXvO91aErOWHsvrVER/5bi
        by6QKj/EULdox3Wm0jOU2DQn/SCI388mfmipdU7mz5L1AzBh6h7/sZVKgDVZSqJU
        YQ8a1rp5AYDYFEyUGeJeUwy6PFt7Wdo1lHAec=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 665AAE10D3;
        Thu, 25 Jun 2020 12:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53D1AE10D2;
        Thu, 25 Jun 2020 12:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/3] Accommodate for pu having been renamed to seen
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
        <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 09:22:12 -0700
In-Reply-To: <pull.668.v3.git.1593087539.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 25 Jun 2020 12:18:56
        +0000")
Message-ID: <xmqq366j5d57.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07998A72-B700-11EA-9591-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series adjusts Git's own source code to reflect that change.
>
> Please note that even with these patches, there are still a couple plac=
es
> where pu is used:
>
>  * In the translations. These are legitimate words in languages that ar=
e not
>    English (as in "gpg n'a pas pu signer les donn=C3=A9es" where "pu" i=
s French
>    for the English "could").
>  * In upload-pack.c, where a variable named pu is short form for
>    "pack-objects updates".
>
> Changes since v2:
>
>  * One accidental quoting change in v1 was reverted.

Thanks for being thorough. =20

You could have just told me that the fixup queued on 'seen' looks
good to you and squash it in the first step instead to save one
roundtrip, but replacing with a new set of three patches is not so
bad, either ;-)

Will replace.

