Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC72C35670
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 06:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF15206ED
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 06:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hHp58slh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgBWGSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 01:18:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64513 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWGSb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 01:18:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24AA045B69;
        Sun, 23 Feb 2020 01:18:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6pXCVLj8xBgVOKsq9iO7wgxjO58=; b=hHp58s
        lhMXHOZZA6UmJIgQvrXKkzHsepUVlm6GvdqHNHKI8rcI2004JmX3XDCe7gHvB3id
        CfreQ7qXy3xMgkRuNEov6Msj9Tcn1vI9MKtuQE+vsc0p3DPzLkAny8nuhtQw2Lod
        S8GAawLktLM/LU/Mb7eItNAWUU9lq1B1UpobA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yAdtTCvkCG3bVBAspSRf1+AFbjsuzn9w
        dsGaQ13/Eh2ThrUgdzxAL2FkNsLJiY7lTUCcL6L9kmO+I6PbQ540weFUf5NDYLB0
        cwzXORpYmo140dcr2hi/we5SpDXvqD71vslXbnBnc9YdmMwyTbdurFegRdLkR/rd
        sr8FaNhTbgY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C55B45B67;
        Sun, 23 Feb 2020 01:18:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71FA845B66;
        Sun, 23 Feb 2020 01:18:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 4/4] receive.denyCurrentBranch: respect all worktrees
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
        <61e5f75a6f9a8579271870f6b8b95021055a96ad.1582410908.git.gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:18:24 -0800
In-Reply-To: <61e5f75a6f9a8579271870f6b8b95021055a96ad.1582410908.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Sat, 22 Feb 2020 22:35:07
        +0000")
Message-ID: <xmqqftf1su6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CB23D96-5604-11EA-8B93-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> index c89483fdba2..6270fb7b576 100755
> --- a/t/t5509-fetch-push-namespaces.sh
> +++ b/t/t5509-fetch-push-namespaces.sh
> @@ -152,7 +152,7 @@ test_expect_success 'clone chooses correct HEAD (v2)' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'denyCurrentBranch and unborn branch with ref namespace' '
> +test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
>  	cd original &&
>  	git init unborn &&
>  	git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index c81ca360ac4..49982b0fd90 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1712,4 +1712,15 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
>  	)
>  '
>  
> +test_expect_success 'denyCurrentBranch and worktrees' '
> +	git worktree add new-wt &&
> +	git clone . cloned &&
> +	test_commit -C cloned first &&
> +	test_config receive.denyCurrentBranch refuse &&
> +	test_must_fail git -C cloned push origin HEAD:new-wt &&
> +	test_config receive.denyCurrentBranch updateInstead &&
> +	git -C cloned push origin HEAD:new-wt &&
> +	test_must_fail git -C cloned push --delete origin new-wt
> +'
> +
>  test_done

This adds one new test and also flips a test that was added in a
separate step that expected a failure to expect success, which looks
a bit strange.

For a series this small, having a test that demonstrates that the
updated code works as expected together with the fix to the code in
a single patch is easier to manage.  After applying a single
test+fix patch, you can easily apply the same patch except for the
test part in reverse on top, if you need to see in what way the code
without the change breaks by running the test.

On a truly large fix, sometimes it may make sense to add a failing
test and nothing else and then a separate step that changes the code
and flips the expectation of the test from failure->success, but I
think a change this size is easier to handle without such an artificial
split.

Thanks.
