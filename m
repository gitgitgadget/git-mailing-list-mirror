Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40114C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiGSQ0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbiGSQ0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:26:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D654AED
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:26:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63F6E14BC22;
        Tue, 19 Jul 2022 12:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dkDiCXh+6VhMiZ9adfD/eCjKxvAmq248fYVXeF
        QY+Q4=; b=JYSNJlfknePQvaiqXyjfrvCWlqNbyHjL3DVdpmL7xmGp8B9x15GPiv
        49fryK0YispMCJgMAPSAxNPN43cqqheESIGrGGQDRIM4TnxGv5CX/wuopb6k+e1G
        if1CTBb64IhmvUlXEkdguUCP07d1MpfmQ+qRzVlFrCHaAS87JBuQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E99314BC21;
        Tue, 19 Jul 2022 12:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E12214BC20;
        Tue, 19 Jul 2022 12:26:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Celeste Liu <coelacanthus@outlook.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>
Subject: Re: [PATCH] contrib/rerere-train: avoid useless gpg sign in training
References: <PH7PR14MB5594D28D5CF94BD30DB9D3C4CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
Date:   Tue, 19 Jul 2022 09:26:02 -0700
In-Reply-To: <PH7PR14MB5594D28D5CF94BD30DB9D3C4CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
        (Celeste Liu's message of "Tue, 19 Jul 2022 19:40:46 +0800")
Message-ID: <xmqq4jzdcbmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BBE35CA-077F-11ED-84E3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Celeste Liu <coelacanthus@outlook.com> writes:

> Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
> ---

Above your sign-off line is a space to explain why this change is
needed.  Write something like 

    The user may have configured "git merge" to always require GPG
    signing the resulting commit.  As we run "git merge" not for the
    recreated merge commits, but merely to trigger merge conflicts,
    and we will discard the resulting commits, signing them is not
    necessary.

    Override such configuration that forces useless signing from the
    command line with the "--no-gpg-sign" optoin.

perhaps?

>  contrib/rerere-train.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 26b724c8c6..bd01e430ef 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -75,7 +75,7 @@ do
>  		continue
>  	fi
>  	git checkout -q "$parent1^0"
> -	if git merge $other_parents >/dev/null 2>&1
> +	if git merge --no-gpg-sign $other_parents >/dev/null 2>&1
>  	then
>  		# Cleanly merges
>  		continue
