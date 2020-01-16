Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B34C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A522073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I4n5RAXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgAPUXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:23:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56642 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733278AbgAPUXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:23:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9280F44843;
        Thu, 16 Jan 2020 15:23:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6T2V4a4fBhcXUSUyWSC8SIuTYXg=; b=I4n5RA
        Xuep9KfIlkslusRm7u5LyZL2/b+YkOPbADOBV3P7MwYMEiJTfnyGeGKG538K84t/
        lE0Dbxz6ziaHoLH/7QB9pvl4II7WeWxQ0DXRjzxsG2dV7rlBJIyBWjzDdrRo+dzt
        aHdjIfCGjFppsJjdLAiMth18HBlq6VbI/PPvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FubH+3JdvBGtlWKu1y5MUDpiu2hxtP7u
        pkWhloww12coj/dBB6YqEn2NMroI96J4svKNU3ZHShj9mkERY+3LCc9xCZjI3Oq1
        7IQBTxoN6q1gD/wloWThjQIH3yihKAFILkq1gYcvJS5BhkePGrgAwUy/8gN4/cJ2
        NRoaDWUB9ck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89A2444841;
        Thu, 16 Jan 2020 15:23:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E661844840;
        Thu, 16 Jan 2020 15:23:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Yaroslav O Halchenko <debian@onerussian.com>
Subject: Re: [PATCH] submodule add: show 'add --dry-run' stderr when aborting
References: <20200108003121.28034-1-kyle@kyleam.com>
        <nycvar.QRO.7.76.6.2001161711310.46@tvgsbejvaqbjf.bet>
Date:   Thu, 16 Jan 2020 12:23:11 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001161711310.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 16 Jan 2020 17:17:33 +0100 (CET)")
Message-ID: <xmqqftgfgngw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 051791E4-389E-11EA-A956-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I think this got mis-merged when merging down `km/submodule-add-errmsg`:
> it needs to be prefixed with `hint:` because of `hw/advice-add-nothing`,
> i.e.
>
> -- snipsnap --
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 42a00f95b9d..a6973a3003c 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -158,7 +158,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
>  		cat <<-\EOF >expect &&
>  		The following paths are ignored by one of your .gitignore files:
>  		submod
> -		Use -f if you really want to add them.
> +		hint: Use -f if you really want to add them.
>  		EOF
>  		# Does not use test_commit due to the ignore
>  		echo "*" > .gitignore &&

Thanks, will prepare merge-fix material for this.


