Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A5AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1792020809
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hSv8D1Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgIYRaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:30:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50062 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYRa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:30:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 177CB9A54D;
        Fri, 25 Sep 2020 13:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bx75wn2lHHHw
        rjPP0Z3+Xu/DlMQ=; b=hSv8D1Tn89DyasyKaODrADazvFywm5wcyVx0Dv8a/qqp
        JT3rc4IZKq9e6RfAZj+qThXAXLHKVvcLyX67wV3TdCluO+00CLsb2qpLQktVQHd3
        5/5Bg+kHRXct15o9Qf/xJLuD8eLdeZW5bDjJKV4Ln+S6h9arYRvPjtCC7Uq8rp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZcPlJ5
        wpQS3a+HThclVDsm+OJBoNV7lQfAUreS4u+QnOl8t2eFtx5x0Jd2pHR/vN5Exn3/
        h+SfAsqBKk3WZhdx2UJyRbvmq9qX2OSQfvAWOfzC07ZCTKJPz7d0b+8/ivns7VD8
        N9KjR5MA35vNteVvzarObLK13pnuPnXtGZKmk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 025069A54C;
        Fri, 25 Sep 2020 13:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CE4A9A54B;
        Fri, 25 Sep 2020 13:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=81kos?= Uzonyi <uzonyi.akos@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] completion: complete refs after 'git restore -s'
References: <20200925142552.1656596-1-uzonyi.akos@gmail.com>
Date:   Fri, 25 Sep 2020 10:30:23 -0700
In-Reply-To: <20200925142552.1656596-1-uzonyi.akos@gmail.com>
 (=?utf-8?Q?=22=C3=81kos?= Uzonyi"'s
        message of "Fri, 25 Sep 2020 16:25:52 +0200")
Message-ID: <xmqqlfgxlq6o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC0D942E-FF54-11EA-8EA7-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=81kos Uzonyi <uzonyi.akos@gmail.com> writes:

> From: Uzonyi =C3=81kos <uzonyi.akos@gmail.com>
>
> Currently only the long version (--source=3D) supports completion.
>
> Add completion support to the short (-s) option too.

I am not too familiar with the completion library, but what makes
the "-s" option of restore so special?  I've scanned the entire file
and did not find that many special cases for short options that have
their longer counterpart supported already.

I do not know if the "feature" this wants to bring in is a good
idea---we may want to try to be more systematic (e.g. perhaps it
involves teaching the parse-options subsystem about equivalence of
short and long options, so that we can reuse existing support for
the the long option "--source=3D<TAB>" to complete "-s <TAB>"), if we
were to do something like this.  Singling out "-s" of "restore"
smells not quite right, as the approach would not scale well.

> Signed-off-by: =C3=81kos Uzonyi <uzonyi.akos@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 8be4a0316e..50e6e82157 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2853,6 +2853,18 @@ _git_restore ()
>  	--*)
>  		__gitcomp_builtin restore
>  		;;
> +	*)
> +		local prevword prevword=3D"${words[cword-1]}"

Why duplicated prevword here?  Did you mean=20

	local prevword=3D${words[cword-1]}

instead?

> +
> +		case "$prevword" in
> +			-s)
> +				__git_complete_refs
> +				return
> +				;;
> +			*)
> +				;;
> +		esac
> +		;;

Wrong indentation.  In this file, as can be seen on the line "*)"
you added at the top of this hunk, the case arms like "-s)" and "*)"
must align with "case" and "esac" in this file.

>  	esac
>  }


Thanks.
