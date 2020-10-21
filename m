Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA4AC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFAC2145D
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OhQQeoIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506837AbgJUWjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:39:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55689 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506826AbgJUWjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:39:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90E6CFF3D5;
        Wed, 21 Oct 2020 18:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jcYALU1V6r42qWt8kBo4GSxp7Vg=; b=OhQQeo
        IahTXleFM0fqxPfs/b5ffN/mhGcQwfjRiqhklWOcYFyY0fq1D76Kxvv8A5vGC4Tp
        GmepGDsBVLVG6BB5h2+Bsph+ntry3eaamVegIcYMw4kMeK5fTBSdtXnyYy+7TBMS
        4Le9gYZXZvdQHL9rSEGeXCx6Phnt6mzJxEJ7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xEu68wWpM0T20nuzZ1lARV1FZOQFoOf4
        UDeFPKTDw4+Zbr7ZXFTUsiszzPTzo5eW6lGFDJgUMdVtEXv3LZPG9bO/LWLjULu/
        oIlv0hKErGQlnCOl4t/0I4DyufqfxmW8WJUXDZUecd6F8ZMrqlJz7nAItcRLyKRp
        b1Bc+05VzEg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 892CDFF3D4;
        Wed, 21 Oct 2020 18:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1E57FF3D2;
        Wed, 21 Oct 2020 18:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/10] t3200: prepare for `main` being shorter than
 `master`
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <e1740bb7d7d8c90db68ffff443b69894177e36f3.1603135903.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:39:14 -0700
In-Reply-To: <e1740bb7d7d8c90db68ffff443b69894177e36f3.1603135903.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:38 +0000")
Message-ID: <xmqqh7qn431p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FBD4646-13EE-11EB-A1F4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the test case adjusted by this patch, we want to cut just after the
> longest shown ref name. Since `main` is shorter than `master`, we need
> to decrease the number of characters. Since `main2` is shown, too, and
> since that is only one character shorter than `master`, we decrement the
> length by one.

Confused.  I do not see 'main2' (or 'master2' for that matter) in
the test script.

If we rename 'topic' to 'topico', then we'd still show branches, the
longest among which has 6 characters (the same as 'master'), so we
won't have to wonder where 'main2' came from; I guess that is another
way to solve this.



>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3200-branch.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 6efe7a44bc..55b24b76ce 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -375,9 +375,9 @@ test_expect_success 'git branch --column -v should fail' '
>  	test_must_fail git branch --column -v
>  '
>  
> -test_expect_success 'git branch -v with column.ui ignored' '
> +test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
>  	git config column.ui column &&
> -	COLUMNS=80 git branch -v | cut -c -9 | sed "s/ *$//" >actual &&
> +	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
>  	git config --unset column.ui &&
>  	cat >expect <<\EOF &&
>    a/b/c
