Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF9DC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 07:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiCMHvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiCMHvd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 03:51:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C9443C8
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 23:50:26 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41DB8119028;
        Sun, 13 Mar 2022 03:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QnsdUDLkMSltwqvtrFjGCLYt8F7pOKiwIIm0Rx
        hAq+0=; b=rCz6xM/7s+617KpB9i+IG+ppFSuT02PbideVNqYk8/4z0FclRb4w6H
        w27P12f6GlyCPIDQM7+mYD37WkiilhuGtu0eEtNXuwqk1F57idMxb1GQb87O8G+v
        JiW/vJkKCS9UGr0E1yGaiGoo8Jy9+o36rYrlr7erYoiCrcyztj5YM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A07E119026;
        Sun, 13 Mar 2022 03:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71B6D119025;
        Sun, 13 Mar 2022 03:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: use test_commit helper in setup
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
        <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
        <f3f084adfa616a7bae7e7c94644f65a36f38652b.1647019492.git.gitgitgadget@gmail.com>
Date:   Sun, 13 Mar 2022 07:50:24 +0000
In-Reply-To: <f3f084adfa616a7bae7e7c94644f65a36f38652b.1647019492.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 11 Mar 2022 17:24:51
        +0000")
Message-ID: <xmqqee36watb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E46BDBC-A2A2-11EC-8A26-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> To prepare for the next commit that will test rebase with oids instead
> of branch names, update the rebase setup test to add a couple of tags we
> can use. This uses the test_commit helper so we can replace some lines
> that add a commit manually.

OK.

>  test_expect_success 'prepare repository with topic branches' '
> -	git config core.logAllRefUpdates true &&

This lossage is not explained.  I do not know if we actually make
use of the reflog in the tests, though.

> -	echo First >A &&
> -	git update-index --add A &&
> -	git commit -m "Add A." &&
> +	test_commit "Add A." A First First &&
>  	git checkout -b force-3way &&
>  	echo Dummy >Y &&
>  	git update-index --add Y &&
> @@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic branches' '
>  	git mv A D/A &&
>  	git commit -m "Move A." &&
>  	git checkout -b my-topic-branch main &&
> -	echo Second >B &&
> -	git update-index --add B &&
> -	git commit -m "Add B." &&
> +	test_commit "Add B." B Second Second &&
>  	git checkout -f main &&
>  	echo Third >>A &&
>  	git update-index A &&
