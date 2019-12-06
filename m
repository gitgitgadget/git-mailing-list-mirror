Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA56C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826D2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fjw09eqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFUsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:48:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61487 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFUsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 15:48:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7306A1F842;
        Fri,  6 Dec 2019 15:48:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z+G/T612VcXga8EAUSPDua4CqtM=; b=fjw09e
        qyJbGtVkEQW54VOCS2O7/g1hHkkNHrj5yWUBnEm/9+kp5/IqlUpN6z7ar8IMgHHE
        Iwx4+1m5O3vpyPk0QGU+Ir6VduE2u8X2WJCv0GpHLwnGvzUajRDOSk/cxj9fkBLY
        nIMaRfBmQriQdzDvGz3ofpY2oYwBCeUVeNO4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjMWIQdAlAZawaoFK7vIoSAxHw4BVCGY
        LxFBEExiqju+1uFu0JfqUHw5gLl4PH50fcf1s8q6Zp7Sqgjx+1Nb2uIP9ZY/g/9y
        yaWq09b/OoJZwcakxWKN0O3pguv+jEyfdyEBuGL/EHXA9d+LGOYbyoWVSoOfe9cO
        1iNkD8Q3F+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AED11F841;
        Fri,  6 Dec 2019 15:48:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C832F1F840;
        Fri,  6 Dec 2019 15:48:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/7] git add -p: use non-zero exit code when the diff generation failed
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
        <27c8ceeb1150dafeaf5b83831487f6bd66c04839.1575637705.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 12:48:29 -0800
In-Reply-To: <27c8ceeb1150dafeaf5b83831487f6bd66c04839.1575637705.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 06 Dec 2019
        13:08:24 +0000")
Message-ID: <xmqqh82dw57m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2E0E3EC-1869-11EA-BA4C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index f43634102e..5db6432e33 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -530,7 +530,7 @@ test_expect_success 'diff.algorithm is passed to `git diff-files`' '
>  	>file &&
>  	git add file &&
>  	echo changed >file &&
> -	git -c diff.algorithm=bogus add -p 2>err &&
> +	test_must_fail git -c diff.algorithm=bogus add -p 2>err &&

Makes sense.

>  	test_i18ngrep "error: option diff-algorithm accepts " err
>  '
