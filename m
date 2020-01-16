Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A9C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F7C2073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kWX0SdRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbgAPW6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:58:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52698 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgAPW6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:58:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74FE24583D;
        Thu, 16 Jan 2020 17:58:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X6mkJAVAPdf74UjcxSUKPeNHnvM=; b=kWX0Sd
        RFlRKgCq00pVuqlPa6yS/9WJzux8gY76NwMeme0MnLLeDMgXKDuCltnCRhOw3SAQ
        BqCl9TAo9RPkZoh17BSbu1kUmnwzNPPgAcDH9LEPaSf1qFGxWzakNWHoijF9eDGJ
        +rysNh5Ox8JEhl4uU4DmbQNraJk+ssSD0neuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MxFF+SFlUfvZYdnwLspTalyMv97VCAZu
        rKm0S/CUtwBMlat2ZGISUyJ2yvrowW1kUM8BdyxCsXPqUN+qjPujF97C3qLfTQ0U
        FDqaZdrR0M+CcDPguEINYvSxnt6p9nvKB3Rl91RciMfgK6TpRufmFLktLz669+D6
        OCHSF3pHPM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DE324583C;
        Thu, 16 Jan 2020 17:58:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6D474583B;
        Thu, 16 Jan 2020 17:58:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 3/3] t6025: use helpers to replace test -f <path>
References: <20200116203622.4694-1-shouryashukla.oo@gmail.com>
        <20200116203622.4694-4-shouryashukla.oo@gmail.com>
Date:   Thu, 16 Jan 2020 14:58:12 -0800
In-Reply-To: <20200116203622.4694-4-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Fri, 17 Jan 2020 02:06:22 +0530")
Message-ID: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACE1504E-38B3-11EA-9D26-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Take advantage of helper function 'test_path_is_file()' to
> replace 'test -f' since the function makes the code more
> readable and gives better error messages.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t6025-merge-symlinks.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Makes sense.

> diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
> index 41bae56ea9..ebbbc03f1d 100755
> --- a/t/t6025-merge-symlinks.sh
> +++ b/t/t6025-merge-symlinks.sh
> @@ -38,7 +38,7 @@ test_expect_success 'merge master into b-symlink, which has a different symbolic
>  '
>  
>  test_expect_success 'the merge result must be a file' '
> -	test -f symlink
> +	test_path_is_file symlink
>  '
>  
>  test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
> @@ -48,7 +48,7 @@ test_expect_success 'merge master into b-file, which has a file instead of a sym
>  '
>  
>  test_expect_success 'the merge result must be a file' '
> -	test -f symlink
> +	test_path_is_file symlink
>  '
>  
>  test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
> @@ -58,7 +58,7 @@ test_expect_success 'merge b-file, which has a file instead of a symbolic link,
>  '
>  
>  test_expect_success 'the merge result must be a file' '
> -	test -f symlink
> +	test_path_is_file symlink
>  '
>  
>  test_done
