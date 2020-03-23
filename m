Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA4C54FCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161A520722
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKftBsY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCWRqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:46:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50130 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCWRqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 13:46:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3BB953BB4;
        Mon, 23 Mar 2020 13:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X/chSHw3Vb6Moka/jbA4iU7+HMc=; b=FKftBs
        Y4+ri2cHypSsKHC01f+bxUcyCjNCOxxsHxwTXYHNbSsg0pF33wdDTGt8J/QR4MLr
        902/NnWdz61eVPNXbVbUtMDTCvTLvPp74tC2BOofkJ0xBvHSxyKDc/mkqd4wEtPC
        ecWg4df3e7m++CB/DnstxqdvPOTR9pihl59JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GS/0pa3+KQRFgWvYACEIrsrUugvLWliR
        bwU9BTE7Yn6DbFTPSb1mIvVWO8fUO839otf+ecTpo12EwRW6AyAlLbspYcco+Xsi
        MaohIL+hIk2pHDwNbyCuWjcbil1Xj5Hl8ipVPP3DSnMIYdGhkRy75HurAQMODYOn
        h/pVNb2LfOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB27253BB3;
        Mon, 23 Mar 2020 13:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27ECD53BB0;
        Mon, 23 Mar 2020 13:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests(gpg): allow the gpg-agent to start on Windows
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 10:46:44 -0700
In-Reply-To: <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 23 Mar 2020
        13:09:49 +0000")
Message-ID: <xmqqd09355h7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4336843E-6D2E-11EA-B54D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In Git for Windows' SDK, we use the MSYS2 version of OpenSSH, meaning
> that the `gpg-agent` will fail horribly when being passed a `--homedir`
> that contains colons.
>
> Previously, we did pass the Windows version of the absolute path,
> though, which starts in the drive letter followed by, you guessed it, a
> colon.
>
> Let's use the same trick found elsewhere in our test suite where `$PWD`
> is used to refer to the pseudo-Unix path (which works only within the
> MSYS2 Bash/OpenSSH/Perl/etc, as opposed to `$(pwd)` which refers to the
> Windows path that `git.exe` understands, too).

Makes sense.  

Do we have a short/concise instruction, e.g. "You should use $(pwd)
in most cases, but for such and such purposes use $PWD instead", in
t/README for test writers, who are not familiar with the distinction
between $(pwd) and $PWD, to help them decide which one to use in
what situation?  I see this kind of fix-ups from time to time, and
am wondering if there is a way to reduce the need for you or J6t to
spot and fix the new ones.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/lib-gpg.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 8d28652b729..11b83b8c24a 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -29,7 +29,7 @@ then
>  		#		> lib-gpg/ownertrust
>  		mkdir ./gpghome &&
>  		chmod 0700 ./gpghome &&
> -		GNUPGHOME="$(pwd)/gpghome" &&
> +		GNUPGHOME="$PWD/gpghome" &&
>  		export GNUPGHOME &&
>  		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
