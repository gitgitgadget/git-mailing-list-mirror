Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E8EC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 04:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF3220878
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 04:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kIHR5/Gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgJMEq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 00:46:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62396 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJMEq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 00:46:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4B61F5AA3;
        Tue, 13 Oct 2020 00:46:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lZeOtB9J41xJ
        /RDAEEFKC5S9Q4I=; b=kIHR5/GnW41Z+9txT9Q2xX9NZnQZGKGhNL43wniRizO9
        mRc+76DbyqkiUqWSiWc9iUlVlqTNVKbmsPmVWjkQ6Y/jmTdu+JWVMCPpRaCPLGGU
        r5FvufR3W5ZXK3xCZ8ruJyBtsEXFVhrerBvupF9o0FzKVenAtmNwZBNlmwwIw3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kFqLE5
        ogov65iXR/HvxMNDjNFI+xiIGdmyZvDO2VOSqdKI+eZcMKQt43oGmBhBNmz+JJGq
        w9KmVeKhjjqxcDnFsYdZul4PGPnvFC5sP07ClPojf7aTm7PbH1ux2soITN9fRuG0
        JrKeQsGdkO3FsH/EH7H4cGKWasP1EUWU2az4o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D55EF5A9A;
        Tue, 13 Oct 2020 00:46:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1BF8F5A99;
        Tue, 13 Oct 2020 00:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] sequencer: pass explicit --no-gpg-sign to merge
References: <20201012234901.1356948-1-samuel@cavoj.net>
        <20201012234901.1356948-2-samuel@cavoj.net>
Date:   Mon, 12 Oct 2020 21:46:51 -0700
In-Reply-To: <20201012234901.1356948-2-samuel@cavoj.net> ("Samuel
 =?utf-8?Q?=C4=8Cavoj=22's?=
        message of "Tue, 13 Oct 2020 01:49:01 +0200")
Message-ID: <xmqqwnzulolg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D2289D8-0D0F-11EB-A530-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

> The merge subcommand launched for merges with non-default strategy woul=
d
> use its own default behaviour to decide how to sign commits, regardless
> of what opts->gpg_sign was set to. For example the --no-gpg-sign flag
> given to rebase explicitly would get ignored, if commit.gpgsign was set
> to true.
>
> Signed-off-by: Samuel =C4=8Cavoj <samuel@cavoj.net>
> ---
>  sequencer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 88ccff4838..043d606829 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3678,6 +3678,8 @@ static int do_merge(struct repository *r,
>  		strvec_push(&cmd.args, git_path_merge_msg(r));
>  		if (opts->gpg_sign)
>  			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +		else
> +			strvec_push(&cmd.args, "--no-gpg-sign");
> =20
>  		/* Add the tips to be merged */
>  		for (j =3D to_merge; j; j =3D j->next)

A test that passes --no-gpg-sign from the command line (because
commit.gpgsign is set in the repository used in these tests) would
be a good thing to have, next to the test you added in [PATCH 1/2].
You'd want to make sure the command line overrides the configured
default by checking that the resulting history are not signed.

Thanks.

